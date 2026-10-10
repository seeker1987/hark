#!/bin/bash
cd "$(dirname "$0")"
for f in results/main_*.jsonl; do echo "$f ok=$(grep -c '"error": null' $f)"; done; echo "pending=$(ls results/pending 2>/dev/null | wc -l)"
