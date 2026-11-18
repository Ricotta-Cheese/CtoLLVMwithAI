from pathlib import Path
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
import json
import re
import shutil
import subprocess
import sys
import tempfile
import threading
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pipeline import Config, PipelineError, Ollama, run_pipeline, run_command, IGNORED_SHA_DIAGNOSTIC
from run import choose_file

GOOD = 'define i32 @compute(i32 %x, i32 %y) {\nentry:\n  %sum = add i32 %x, %y\n  ret i32 %sum\n}\n'
BAD_VALUE = 'define i32 @compute(i32 %x, i32 %y) {\nentry:\n  ret i32 0\n}\n'


class MockOllama:
    def __init__(self, ir=GOOD, mode='normal'):
        state = self
        self.ir, self.mode = ir, mode
        self.loaded, self.unloads, self.chats = False, 0, 0
        self.requests = []
        self.first_chunk_seen = threading.Event()
        class Handler(BaseHTTPRequestHandler):
            def log_message(self, *args): pass
            def send_json(self, value, code=200):
                self.send_response(code); self.send_header('Content-Type', 'application/json'); self.end_headers()
                self.wfile.write(json.dumps(value).encode())
            def do_GET(self):
                if self.path == '/api/ps':
                    self.send_json({'models': [{'name':'unit-model:latest'}] if state.loaded else []})
                else: self.send_json({'error':'not found'},404)
            def do_POST(self):
                body = json.loads(self.rfile.read(int(self.headers['Content-Length'])))
                state.requests.append((self.path,body))
                if self.path == '/api/show':
                    if state.mode == 'missing': self.send_json({'error':'model not found'},404)
                    else: self.send_json({'details':{'family':'mock'}})
                elif self.path == '/api/generate':
                    state.unloads += 1
                    if state.mode != 'unload_stuck': state.loaded = False
                    self.send_json({'done':True,'done_reason':'unload'})
                elif self.path == '/api/chat':
                    state.chats += 1; state.loaded = True
                    self.send_response(200); self.send_header('Content-Type','application/x-ndjson'); self.end_headers()
                    events = [{'message':{'content':state.ir[:len(state.ir)//2]},'done':False}]
                    if state.mode == 'stream_error': events.append({'error':'simulated generation failure'})
                    elif state.mode != 'truncated':
                        events.append({'message':{'content':state.ir[len(state.ir)//2:]},'done':True,
                                       'done_reason':'length' if state.mode == 'length' else 'stop','eval_count':30})
                    for index, event in enumerate(events):
                        self.wfile.write(json.dumps(event).encode()+b'\n'); self.wfile.flush()
                        if state.mode == 'gated' and index == 0:
                            if not state.first_chunk_seen.wait(3): return
                else: self.send_json({'error':'not found'},404)
        self.server = ThreadingHTTPServer(('127.0.0.1',0),Handler)
        self.host = f'http://127.0.0.1:{self.server.server_port}'
        self.thread = threading.Thread(target=self.server.serve_forever,daemon=True)
    def __enter__(self): self.thread.start(); return self
    def __exit__(self,*args): self.server.shutdown(); self.server.server_close(); self.thread.join()


@unittest.skipUnless(shutil.which('clang'), 'Clang is required for native integration checks')
class PipelineIntegrationTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        probe = subprocess.run(['clang','-S','-emit-llvm','-x','c','-','-o','-'],input='unsigned int f(unsigned int x) {return x;}\n',capture_output=True,text=True,check=True).stdout
        cls.target = re.search(r'^target triple = "([^"]+)"',probe,re.M)[1]
    def run_case(self, mock, directory, source='unsigned int compute(unsigned int x, unsigned int y) { return x+y; }\n', ir_file=None, allow_ignored_sha=False):
        file = directory/'source.c'; file.write_text(source)
        config = Config(model='unit-model',host=mock.host,target=self.target,output_root=directory/'outputs',tool_timeout=20,ai_timeout=10,live_output=False,allow_ignored_sha=allow_ignored_sha)
        return run_pipeline(file,config,ir_file=ir_file,emit=lambda _:None)
    def test_real_compilation_matches_and_model_is_unloaded(self):
        with tempfile.TemporaryDirectory() as tmp, MockOllama() as mock:
            result = self.run_case(mock,Path(tmp))
            self.assertTrue(result['success'],result)
            self.assertEqual(result['comparison']['matching_inputs'],256)
            self.assertTrue(result['memory_release']['confirmed'])
            self.assertEqual(mock.unloads,1); self.assertFalse(mock.loaded)
            chat = next(body for path,body in mock.requests if path=='/api/chat')
            self.assertEqual(chat['keep_alive'],0)
            self.assertEqual(chat['options']['temperature'],0)
            self.assertTrue((Path(result['output_directory'])/'reference.ll').exists())
    def test_semantic_mismatch_reports_counterexample(self):
        with tempfile.TemporaryDirectory() as tmp, MockOllama(BAD_VALUE) as mock:
            result = self.run_case(mock,Path(tmp))
            self.assertFalse(result['success'])
            self.assertGreater(result['comparison']['mismatch_count'],0)
            self.assertIsNotNone(result['comparison']['first_mismatch'])
            self.assertTrue(result['memory_release']['confirmed'])
    def test_invalid_ir_is_rejected_after_unloading(self):
        with tempfile.TemporaryDirectory() as tmp, MockOllama('this is not LLVM IR') as mock:
            result = self.run_case(mock,Path(tmp))
            self.assertFalse(result['success']); self.assertIn('실패',result['error'])
            self.assertTrue(result['memory_release']['confirmed'])
    def test_external_reference_is_not_executed(self):
        ir = 'declare i32 @other()\ndefine i32 @compute(i32 %x, i32 %y) {\nentry:\n  %v = call i32 @other()\n  ret i32 %v\n}\n'
        with tempfile.TemporaryDirectory() as tmp, MockOllama(ir) as mock:
            result = self.run_case(mock,Path(tmp))
            self.assertIn('지원 범위 거부',result['error'])
            self.assertFalse((Path(result['output_directory'])/'generated').exists())
    def test_stream_failure_length_and_truncation_all_unload(self):
        for mode in ('stream_error','truncated','length'):
            with self.subTest(mode=mode), tempfile.TemporaryDirectory() as tmp, MockOllama(mode=mode) as mock:
                result = self.run_case(mock,Path(tmp))
                self.assertFalse(result['success']); self.assertEqual(mock.unloads,1)
                self.assertTrue(result['memory_release']['confirmed'])
                self.assertTrue((Path(result['output_directory'])/'generated.ll').exists())
    def test_keyboard_interrupt_also_unloads_and_saves_report(self):
        with tempfile.TemporaryDirectory() as tmp, MockOllama() as mock:
            with patch.object(Ollama,'generate',side_effect=KeyboardInterrupt):
                result = self.run_case(mock,Path(tmp))
            self.assertEqual(result['status'],'interrupted'); self.assertEqual(mock.unloads,1)
            self.assertTrue((Path(result['output_directory'])/'report.json').exists())
    def test_missing_model_does_not_download_or_generate(self):
        with tempfile.TemporaryDirectory() as tmp, MockOllama(mode='missing') as mock:
            result = self.run_case(mock,Path(tmp))
            self.assertIn('ollama list',result['error']); self.assertEqual(mock.chats,0)
            self.assertEqual([p for p,_ in mock.requests],['/api/show'])
    def test_original_undefined_shift_fails_before_ai(self):
        source='unsigned int compute(unsigned int x, unsigned int y) { return x << y; }\n'
        with tempfile.TemporaryDirectory() as tmp, MockOllama() as mock:
            result = self.run_case(mock,Path(tmp),source)
            self.assertFalse(result['success']); self.assertEqual(mock.chats,0)
            self.assertEqual(result['stage'],'reference_execute')
    def test_existing_ir_mode_works_without_ollama(self):
        with tempfile.TemporaryDirectory() as tmp, MockOllama() as mock:
            path=Path(tmp)/'input.ll'; path.write_text(GOOD)
            result=self.run_case(mock,Path(tmp),ir_file=path)
            self.assertTrue(result['success']); self.assertEqual(mock.requests,[])
    def test_sha_warning_opt_in_preserves_raw_ir_and_separates_strict_result(self):
        if not self.target.startswith(('arm64','aarch64')): self.skipTest('AArch64 diagnostic')
        ir = GOOD.replace(') {', ') #0 {') + '\nattributes #0 = { "target-features"="+sha" }\n'
        with tempfile.TemporaryDirectory() as tmp, MockOllama() as mock:
            root=Path(tmp); path=root/'input.ll';path.write_text(ir)
            strict=self.run_case(mock,root,ir_file=path)
            self.assertFalse(strict['success']);self.assertIn('엄격 검증 중단',strict['error'])
            allowed=self.run_case(mock,root,ir_file=path,allow_ignored_sha=True)
            self.assertTrue(allowed['success'],allowed)
            self.assertFalse(allowed['strict_success'])
            self.assertEqual(allowed['status'],'passed_with_warnings')
            self.assertTrue(allowed['accepted_warnings'])
            self.assertEqual((Path(allowed['output_directory'])/'generated.ll').read_text(),ir)
    def test_sha_warning_permission_does_not_hide_wrong_calculation(self):
        if not self.target.startswith(('arm64','aarch64')): self.skipTest('AArch64 diagnostic')
        ir=BAD_VALUE.replace(') {', ') #0 {') + '\nattributes #0 = { "target-features"="+sha" }\n'
        with tempfile.TemporaryDirectory() as tmp, MockOllama() as mock:
            root=Path(tmp);path=root/'input.ll';path.write_text(ir)
            result=self.run_case(mock,root,ir_file=path,allow_ignored_sha=True)
            self.assertFalse(result['success']);self.assertGreater(result['comparison']['mismatch_count'],0)

    def test_unload_confirmation_failure_is_not_success(self):
        with tempfile.TemporaryDirectory() as tmp, MockOllama(mode='unload_stuck') as mock:
            result=self.run_case(mock,Path(tmp))
            self.assertTrue(result['comparison']['all_equal']); self.assertFalse(result['success'])
            self.assertFalse(result['memory_release']['confirmed'])


class StreamingTests(unittest.TestCase):
    def test_chunk_is_delivered_before_server_can_finish(self):
        # The server cannot send the final event until the client displays the first chunk.
        # This fails if the implementation buffers the response until generation ends.
        with tempfile.TemporaryDirectory() as tmp, MockOllama(mode='gated') as mock:
            root = Path(tmp)
            client = Ollama(Config(model='unit-model', host=mock.host, ai_timeout=5))
            chunks = []
            def receive(content):
                chunks.append(content)
                mock.first_chunk_seen.set()
            result = client.generate('C source', root/'out.ll', root/'events.jsonl', {'characters':0}, on_chunk=receive)
            self.assertEqual(result['done_reason'], 'stop')
            self.assertEqual(''.join(chunks), GOOD)
            self.assertEqual((root/'out.ll').read_text(), GOOD)
            client.unload()


class DiagnosticPolicyTests(unittest.TestCase):
    def test_other_diagnostics_and_nonzero_exit_are_never_accepted(self):
        with tempfile.TemporaryDirectory() as tmp:
            work=Path(tmp)
            for text,code in ((IGNORED_SHA_DIAGNOSTIC+'\nother warning',0),(IGNORED_SHA_DIAGNOSTIC,1)):
                command=[sys.executable,'-c',f'import sys; sys.stderr.write({text!r}); sys.exit({code})']
                with self.assertRaises(PipelineError):
                    run_command(command,work,Config(),allow_ignored_sha=True)


class SelectionTests(unittest.TestCase):
    def test_nested_c_selection_and_outside_rejection(self):
        with tempfile.TemporaryDirectory() as tmp:
            folder=Path(tmp)/'inputs'; (folder/'nested').mkdir(parents=True)
            source=folder/'nested/example.c'; source.write_text('example')
            self.assertEqual(choose_file(folder,'nested/example.c'),source.resolve())
            with self.assertRaises(ValueError): choose_file(folder,'../outside.c')


if __name__=='__main__': unittest.main()
