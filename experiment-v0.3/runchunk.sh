#!/bin/bash
# usage: runchunk.sh "model1:workers:rpm model2:workers:rpm"
cd "$(dirname "$0")"
for spec in $1; do
  m=$(echo $spec | cut -d: -f1); w=$(echo $spec | cut -d: -f2); r=$(echo $spec | cut -d: -f3)
  t=$(echo $m | cut -d/ -f2)
  python3 run_cara.py --models $m --n 2 --workers $w --rpm $r --time-budget 420 --deadline 540 --out results/episodes_$t.jsonl >> results/run_$t.log 2>&1 &
done
wait
for f in results/episodes_*.jsonl; do echo "$f ok=$(grep -c '"error": null' $f) total=$(wc -l < $f)"; done
