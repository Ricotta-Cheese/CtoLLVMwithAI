"""Pure uint32/local-stack IR scope checker, shared in origin with the project evaluator."""
import re

NAME = r'%[-a-zA-Z$._0-9]+'
VALUE = rf'(?:{NAME}|-?\d+)'


def contract_error(ir, target, layout):
    """Restrict executable candidates to the dataset's pure integer, local-stack subset."""
    triples = re.findall(r'^target triple\s*=\s*"([^"]+)"', ir, re.M)
    layouts = re.findall(r'^target datalayout\s*=\s*"([^"]+)"', ir, re.M)
    if len(triples) > 1 or (triples and triples[0] != target):
        return 'target_triple_mismatch'
    if len(layouts) > 1 or (layouts and layouts[0] != layout):
        return 'target_datalayout_mismatch'
    definitions = re.findall(r'^define\b[^\{]*\{', ir, re.M)
    if len(definitions) != 1:
        return 'expected_one_function_definition'
    header = definitions[0]
    if not re.search(r'\bi32\s+@compute\s*\(', header):
        return 'expected_compute_i32_return'
    parameters = re.search(r'@compute\s*\((.*?)\)', header, re.S)
    if not parameters:
        return 'invalid_function_parameters'
    values = parameters[1].split(',')
    if len(values) != 2 or any(not re.fullmatch(rf'\s*i32\s+(?:noundef\s+)?{NAME}\s*', value) for value in values):
        return 'expected_two_i32_parameters'
    active = False
    done = False
    allocated = set()
    integer_ops = {'add','sub','mul','and','or','xor','shl','lshr','ashr','udiv','sdiv','urem','srem',
                   'icmp','zext','sext','trunc','select','phi','freeze'}
    for raw_line in ir.splitlines():
        line = raw_line.split(';', 1)[0].strip()
        if not line:
            continue
        if not active:
            if line.startswith('define '):
                active = True
                if '{' not in line or line.rsplit('{', 1)[1].strip():
                    return 'multiline_or_inline_function_body_not_supported'
                continue
            if line.startswith(('source_filename ', 'target ', 'attributes ', '!')):
                continue
            return 'external_or_global_or_unsupported_module_directive'
        if line == '}':
            active = False
            done = True
            continue
        if done:
            return 'unexpected_second_function'
        if re.fullmatch(r'[-a-zA-Z$._0-9]+:', line):
            continue
        if '@' in line or 'asm' in line:
            return 'external_reference_or_assembly'
        # Ignore instruction metadata attachments, which cannot introduce executable calls here.
        instruction = re.split(r',\s*!', line, maxsplit=1)[0]
        assigned = re.fullmatch(rf'({NAME})\s*=\s*(.+)', instruction)
        operation = assigned[2] if assigned else instruction
        opcode = operation.split()[0]
        if any(int(bits) not in (1, 8, 16, 32, 64) for bits in re.findall(r'(?<![%\w.])i(\d+)\b', operation)):
            return 'unsupported_integer_width'
        if opcode == 'alloca':
            if not assigned or not re.fullmatch(r'alloca i32(?:, align (?:1|2|4|8|16|32|64))?', operation):
                return 'only_fixed_i32_stack_allocation_supported'
            allocated.add(assigned[1])
        elif opcode == 'load':
            match = re.fullmatch(rf'load i32, ptr ({NAME})(?:, align (?:1|2|4))?', operation)
            if not assigned or not match or match[1] not in allocated:
                return 'load_must_reference_local_i32_allocation'
        elif opcode == 'store':
            match = re.fullmatch(rf'store i32 {VALUE}, ptr ({NAME})(?:, align (?:1|2|4))?', operation)
            if assigned or not match or match[1] not in allocated:
                return 'store_must_reference_local_i32_allocation'
        elif opcode in integer_ops:
            if not assigned or re.search(r'(?<![%\w.])ptr\b|\b(?:undef|poison)\b', operation):
                return 'only_defined_integer_operations_supported'
        elif opcode == 'ret':
            if assigned or not re.fullmatch(rf'ret i32 {VALUE}', operation):
                return 'expected_i32_return_value'
        elif opcode in {'br', 'unreachable'}:
            if assigned:
                return 'invalid_terminator'
        else:
            return 'unsupported_instruction_' + opcode
    return None if done and not active else 'incomplete_function'

