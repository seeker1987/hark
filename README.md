# hark: absorption drift experiments run by Hark

Behavioural replication kit for testing **absorption drift**, a hypothesised recall–behaviour dissociation in which a model keeps executing a task after the condition that made the task valid has failed, even though it can still recall that condition. Part of the *Context-Persistent Alignment* framework (Interpretation / Persistence / Authority layers).

Claims are labelled Established / Proposed / Hypothesis / Open. Absorption drift is a **hypothesis**; it has not been demonstrated.

## Contents
- `experiment-v0.1/`: first kit (8 scenarios; cues control / quiet / loud / decoy; depths 1, 6, 15). Never run on a real model.
- `experiment-v0.2/`: preregistered revision (`PREREG.md`, frozen before any run; `FREEZE.sha256`). Adds an idle-history control, task length 40, `near` and `gradual` cues, a same-thread dissociation probe, and framework arms 1–5.
- `experiment-v0.2/results/`: interim run (861 trials on NVIDIA's free API; gpt-oss-20b and nemotron-3-super-120b; GLM-5.3 was throttled out). Raw results are gzipped JSONL. Read `summary_interim.md` first.

## Interim result (v0.2)
H1 (drift grows with task momentum) is **not supported**: drift was near zero and showed no depth dependence. The few drifts were shallow (depth 1), on cues that needed inference, and the same-thread probe usually showed the model knew the condition had failed. Next (v0.3): a lag between cue and decision, self-generated steps, longer horizons.

## Running
Python 3.10+. Set `NVIDIA_API_KEY` or `OPENROUTER_API_KEY`, then see the header of `experiment-v0.2/run_experiment.py`; analyse with `analyze.py`.
