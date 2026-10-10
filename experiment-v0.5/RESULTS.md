# v0.5 results (provisional; stopped at the 22:00 IST deadline, 10 Oct 2026)

Usable episodes: gpt-oss-20b 240/240; gemma-4-31b-it 140/240; nemotron-3-super 65/240; GLM-5.3-flash 0 (dropped, see Deviations). Full tables: results/summary.md.

## Headline
Continuation after an invalidating shift appeared under the stressors (Established for these scenarios and models, n=1 per cell). Pooled baseline quiet-cue ICR: 0% with passive telemetry at k5 and k32 full history; 64% (CI 35-85%) with active telemetry; 94% (72-99%) with self-summary plus active telemetry; 94% (73-99%) under stress. CARA cut ICR to 0-7% (pooled contrast -82 points, CI -95 to -67) with no measurable false-stop cost on benign episodes (-0 points, CI -8 to +9). Gemma shows continuation only where active telemetry was on.

## Hypotheses (pooled, baseline, quiet cue)
- H1 late vs early: +10 points (CI -10 to +27). Not supported.
- H2 self-summary vs full history: +44 (CI +28 to +62). Supported. Summaries kept the condition in 77% of notes, but continuation did not depend clearly on dropped notes (73% vs 79%).
- H3 active vs passive: +72 (CI +50 to +86). Supported, in the opposite direction to the vigilance hypothesis: active telemetry was associated with more continuation. Proposed explanation: it was associated with more mutating steps and lets the agent keep working; not tested.
- H4 stress: +67 (CI +38 to +92) against k5 active. Supported.
- H5 CARA: large ICR reduction; false-stop cost not distinguishable from zero.
- Dissociation: 34/47 continuations saw the shifted reading and the end probe said the condition no longer held, so the knowledge was present but not acted on.

## Exploratory (not preregistered): aware vs unaware
Crude rule: unaware if the shifted reading was first seen after unit k (or never). gpt-oss 21 unaware / 4 aware; gemma 15 / 0; nemotron 5 / 0. Mostly unaware, so vigilance lapse rather than absorption proper, but the rule is coarse (it does not use per-mutation timing) and the end probes show the models later knew. Absorption drift remains a Hypothesis.

## Limitations
n=1 per cell, 8 scenarios, free-tier timing and errors (209 error episodes excluded), gemma and nemotron incomplete, GLM absent, no per-mutation aware split, comparison with v0.3/v0.4 (baseline 2%, grounded CARA false stops 14%) is across sessions.
