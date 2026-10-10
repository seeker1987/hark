# Alignment-Laboratory: absorption drift experiments

Behavioural replication kits and results for testing **absorption drift**, a hypothesised recall-behaviour dissociation in which a model keeps executing a task after the condition that made the task valid has failed, even though it can still recall that condition. Part of the *Context-Persistent Alignment* framework (Interpretation / Persistence / Authority layers) and the CARA proposal.

Claims are labelled Established / Proposed / Hypothesis / Open. **Absorption drift is a hypothesis and has not been demonstrated.** In the runs below it was largely not observed.

## Status at a glance (10 October 2026, evening)

| Experiment | What it tests | Model(s) with usable results | Headline |
| --- | --- | --- | --- |
| `experiment-v0.1/` | First kit: 8 scenarios, cues control / quiet / loud / decoy, depths 1, 6, 15 | None (never run on a real model) | Superseded by v0.2 |
| `experiment-v0.2/` | Preregistered revision: scripted transcripts, one decision per trial; idle-history control, near and gradual cues, same-thread dissociation probe, mitigation arms 1-5 | gpt-oss-20b, nemotron-3-super-120b | Drift near zero, no depth dependence. Momentum hypothesis not supported |
| `experiment-v0.3/` | Closed-loop agent: the model picks every action; baseline vs Stage 1 binding vs full CARA governor | gpt-oss-20b (480 episodes) | Baseline continued after invalidation in 1 of 49 episodes. Ungrounded binding caused 36% (Stage 1) and 65% (CARA) false interruptions vs 7% for baseline |
| `experiment-v0.4/` | Grounded binding: each validity condition must quote the operator's text | gpt-oss-20b (320 episodes) | False interruptions fell to 17% (Stage 1) and 14% (CARA); 0 of 87 continuations after invalidation |
| `experiment-v0.5/` | Long-horizon stress test: 40-unit tasks, early vs late shift, self-written summaries, passive vs active telemetry, deadline pressure; baseline vs grounded CARA | gpt-oss-20b (240), gemma-4-31b-it (140 of 240), nemotron-3-super (65 of 240); GLM-5.3 none | Continuation after invalidation appeared under stress (up to 94%), mostly unaware; CARA cut it to 0-7%. Provisional. Kit will be added later |

This README is updated after each experiment completes.

## Results in brief

- **v0.2** (861 usable records, 88 error records skipped): drift on invalidating cues was near zero at every depth. The few drifts were at depth 1, on cues that needed inference, and the same-thread probe usually showed the model knew the condition had failed. Read `experiment-v0.2/results/summary_interim.md` first.
- **v0.3:** baseline ICR (continued after an invalidating shift) was 2% (1/49, 95% CI 0-11%); shift position (step 4 vs 16) made no difference. Cause of the binding problem: the LLM that compiles the binding record invented conditions the operator never set. Overhead was about +58% calls per mutating step.
- **v0.4:** prompt-level grounding did most of the work (the checker rejected 0 conditions). Grounded CARA false interruptions were 14% (95% CI 8-22%) against 7% for baseline (difference +6 points, CI -4 to +17, inconclusive). Unrelated alarm lines still halted 28-31% of runs. Overhead was about +25%.
- **v0.5 (provisional, incomplete for two models):** pooled baseline continuation on the quiet cue was 0% with passive telemetry, 64% (35-85%) with active telemetry, 94% (72-99%) with self-summary plus active telemetry, 94% (73-99%) under stress. Late vs early shift made no clear difference (+10 points, CI -10 to +27). CARA contrast -82 points (CI -95 to -67); false-stop difference about 0 (CI -8 to +9). Exploratory split: most continuations (41 of 50) were unaware, i.e. the shifted reading was seen late, though end probes later showed the models knew. Absorption drift remains a Hypothesis.

**Reading these results:** the bottleneck found so far is calibrated interpretation (knowing which conditions matter), not persistence. CARA's benefit on continuation cannot be measured while the baseline barely drifts.

## Limits and open items

- One complete model for v0.3 and v0.4. Nemotron runs for those experiments are not in this repository yet, so the preregistered "at least 2 of 3 models" rules cannot be evaluated.
- 8 synthetic scenarios, n=2 per cell, temperature 0.7, NVIDIA free-tier hosts that may add hidden system prompts.
- v0.4 compares against v0.3 baseline data from an earlier session, not a baseline rerun.
- v0.2: `results/results_glm.jsonl.gz` (161 records, 16 errors, GLM-5.3) is included but not part of the interim summary.
- v0.5: n=1 per cell, gemma and nemotron incomplete, GLM-5.3 produced no usable episodes, 209 error episodes excluded, aware/unaware split is coarse and exploratory. Kit and results will be added later.
- MTA (arm 6) is not tested. It needs training access and is out of scope for these kits.

## Repository layout

```
docs/                  CARA white paper, Context-Persistent Alignment v2, MTA working paper rev 0.3, diagrams
experiment-v0.1/       First kit (unrun)
experiment-v0.2/       PREREG.md, FREEZE.sha256, run_experiment.py, analyze.py, scenarios.json, results/
experiment-v0.3/       PREREG.md, RESULTS.md, FREEZE.sha256, run_cara.py, analyze_cara.py, runchunk.sh, results/
experiment-v0.4/       PREREG.md, RESULTS.md, FREEZE.sha256, run_cara.py, analyze_cara.py, runchunk.sh, results/
```

Raw results are gzipped JSONL. Each experiment's `results/` folder has a summary markdown file: start there.

## Preregistration and integrity

Each experiment's `PREREG.md` was frozen before its main run, with SHA-256 hashes in `FREEZE.sha256`. Post-freeze changes are logged:
- v0.2: infrastructure-only change to `run_experiment.py` (HTTP via urllib, request-rate limiter). Hash of the post-change file is listed; `PREREG.md` carries the note, so its own hash no longer matches the frozen one.
- v0.3: a `--deadline` flag added to `run_cara.py`, and a model substitution (moonshotai/kimi-k3 replaced by nvidia/nemotron-3-ultra-550b-a55b because kimi was too slow to get usable episodes).
- v0.4: no post-freeze changes.

To check: `cd experiment-v0.4 && sha256sum -c FREEZE.sha256`. For v0.2 and v0.3, the first listed hash of the runner is the pre-change version and is expected to fail; the later one should pass.

## Running

Python 3.10+, standard library only for the runners. Set `NVIDIA_API_KEY` (or `OPENROUTER_API_KEY` for v0.1/v0.2).

```bash
# v0.2 (see the header of run_experiment.py for flags)
python3 experiment-v0.2/run_experiment.py ...
python3 experiment-v0.2/analyze.py ...

# v0.3 / v0.4
cd experiment-v0.4
python3 run_cara.py --models openai/gpt-oss-20b --n 2 --out results/episodes_gpt-oss-20b.jsonl
python3 analyze_cara.py results/episodes_gpt-oss-20b.jsonl > results/summary.md
```

`runchunk.sh "model:workers:rpm ..."` runs several models in parallel in time-limited chunks for rate-limited free tiers.

## Related

- [seeker1987/Alignment](https://github.com/seeker1987/Alignment): CARA proposal and reference engine. Its `results.jsonl` and `summary.md` are mock output, not evidence.
