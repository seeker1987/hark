#!/bin/bash
# usage: runchunk.sh OUTSUFFIX "model:workers:rpm ..." [extra args]
cd "$(dirname "$0")"
exec 9>results/.lock; flock -n 9 || { echo "another chunk is running"; exit 0; }
suf=$1; specs=$2; shift 2
for spec in $specs; do
  m=$(echo $spec | cut -d: -f1); w=$(echo $spec | cut -d: -f2); r=$(echo $spec | cut -d: -f3)
  t=$(echo $m | cut -d/ -f2)
  python3 run_v05.py --models $m --workers $w --rpm $r --time-budget 400 --deadline 530 --out results/${suf}_$t.jsonl "$@" >> results/run_${suf}_$t.log 2>&1 &
done
wait
for f in results/${suf}_*.jsonl; do echo "$f ok=$(grep -c '"error": null' $f) total=$(wc -l < $f)"; done
