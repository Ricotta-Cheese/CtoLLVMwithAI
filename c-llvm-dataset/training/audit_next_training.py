"""Read-only evidence audit for the next-training proposal; no new data or model training."""
from pathlib import Path
from collections import Counter
import hashlib
import json
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT/'src'))
from c_llvm_dataset.corpus import verify_corpus


def sha(path): return hashlib.sha256(path.read_bytes()).hexdigest()


def coarse_shape(value):
    # Exploratory shape key: deliberately coarser than the production structure_id.
    if isinstance(value, dict):
        if value.get('kind') in ('const','var'): return {'kind':value['kind']}
        return {k:coarse_shape(v) for k,v in value.items() if k not in ('id','name','op')}
    if isinstance(value,list):return [coarse_shape(x) for x in value]
    return value


def main():
    corpus=ROOT/'corpus-1100-v001'
    integrity=verify_corpus(corpus)
    rows=[json.loads(l) for l in (corpus/'dataset.jsonl').read_text().splitlines()]
    config=json.loads((corpus/'config.json').read_text())
    groups={};features=Counter();feature_lists=Counter();total_chars=attribute_chars=0
    per_category={}
    for row in rows:
        origin=ROOT/config['inputs'][row['source_dataset']]['path']
        program=json.loads((origin/row['sample_path']/'ast.json').read_text())
        shape=coarse_shape(program)
        family=hashlib.sha256(json.dumps(shape,sort_keys=True,separators=(',',':')).encode()).hexdigest()
        groups[row['id']]={'coarse_shape_id':family,'split':row['split'],'category':row['category']}
        for f in re.findall(r'"target-features"="([^"]+)"',row['completion']):
            features.update(f.split(','));feature_lists[f]+=1
        total_chars+=len(row['completion'])
        attribute_chars+=sum(len(m[0]) for m in re.finditer(r'"target-(?:cpu|features)"="[^"]*"',row['completion']))
    for cat in sorted({r['category'] for r in rows}):
        selected=[g for g in groups.values() if g['category']==cat]
        train={g['coarse_shape_id'] for g in selected if g['split']=='train'}
        held=[g for g in selected if g['split']=='test']
        per_category[cat]={'test_count':len(held),'test_samples_sharing_coarse_shape_with_train':sum(g['coarse_shape_id'] in train for g in held)}
    train_groups={g['coarse_shape_id'] for g in groups.values() if g['split']=='train'}
    test_groups={g['coarse_shape_id'] for g in groups.values() if g['split']=='test'}
    audit={'status':'passed','scope':'read-only proposal evidence; no training or new performance evaluation',
        'corpus_integrity':integrity,'coarse_shape_definition':'AST const/var values, identifiers and operators erased; statement nesting and expression topology retained',
        'coarse_shape_caveat':'Exploratory post-hoc grouping, not evidence of production split leakage or memorization',
        'unique_coarse_shapes':len({g['coarse_shape_id'] for g in groups.values()}),
        'train_test_shared_coarse_groups':len(train_groups&test_groups),'coarse_shape_by_category':per_category,
        'unique_target_feature_lists':len(feature_lists),'exact_plus_sha_count':features['+sha'],
        'plus_sha2_count':features['+sha2'],'plus_sha3_count':features['+sha3'],
        'completion_characters':total_chars,'target_cpu_and_features_characters':attribute_chars,
        'attribute_character_fraction':attribute_chars/total_chars,
        'attribute_fraction_caveat':'Character ratio only; token savings and latency change not measured',
        'sources':{str(p.relative_to(ROOT)):sha(p) for p in (corpus/'dataset.jsonl',corpus/'splits.json',ROOT/'training/evaluations/qwen3-test-002/analysis.json',ROOT/'docs/reviews/20261116_external_review.txt',Path(__file__))}}
    out=ROOT/'training/proposals/v002';out.mkdir(parents=True,exist_ok=True)
    (out/'evidence.json').write_text(json.dumps(audit,ensure_ascii=False,indent=2)+'\n')
    (out/'coarse-shape-groups.json').write_text(json.dumps(groups,indent=2)+'\n')
    print(json.dumps(audit,ensure_ascii=False,indent=2))


if __name__=='__main__':main()
