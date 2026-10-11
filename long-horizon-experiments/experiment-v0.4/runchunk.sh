#!/bin/bash
cd "$(dirname "$0")"
python3 run_cara.py --models openai/gpt-oss-20b --arms stage1,cara --n 2 --workers ${1:-8} --time-budget 420 --deadline 540 --out results/episodes_gpt-oss-20b.jsonl >> results/run.log 2>&1
python3 -c "
import json
b=json.load(open('results/bindings.json'))
for k,v in b.items():
  bb=v['binding'] or {}; print(k.split('|')[1],'kept',len(bb.get('validity_conditions',[])),'dropped',[d['why'] for d in v.get('dropped',[])])"
echo ok=$(grep -c '"error": null' results/episodes_gpt-oss-20b.jsonl) total=$(wc -l < results/episodes_gpt-oss-20b.jsonl)
