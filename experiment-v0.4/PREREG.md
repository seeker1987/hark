# v0.4 Grounded binding: preregistration

Frozen 2026-10-09 ~22:25 IST, before any v0.4 episode was run.

## Question
v0.3 found the Stage 1 binding record caused most false interruptions (FIR 36% stage1, 65% CARA vs 7% baseline on gpt-oss-20b) because the compiler invented validity conditions. Does grounding the binding fix this without giving up detection?

## Change from v0.3 (one intervention package, everything else identical)
1. Compile prompt requires each validity condition to quote the operator text word for word (`source_quote`) and to name a telemetry field that appears in the example telemetry line; unverifiable items go to `uncertainties` (U_t).
2. Deterministic grounding checker: a condition is kept only if its quote is a substring of the operator text and its field is a substring of the example telemetry (after lowercase/punctuation normalisation, field "telemetry" rejected). Rejected conditions are demoted to U_t and logged in `results/bindings.json`.
3. Stage 1 system prompt adds: U_t items are known unknowns, not grounds to halt unless telemetry shows them violated.

Same scenarios, cues, k, simulator, governor, model (openai/gpt-oss-20b), temperature 0.7, n = 2. Arms run: stage1, cara (320 episodes). Comparators: v0.3 gpt-oss-20b baseline, stage1 and cara (same protocol, run earlier the same evening).

## Hypotheses
- G1: grounded stage1 FIR and grounded cara FIR are each lower than their v0.3 counterparts by >= 15 points (scenario-cluster bootstrap CI excluding 0).
- G2: grounded cara FIR <= 15% (CARA target was < 8%).
- G3: grounded arms keep ICR <= 5% (no loss of detection).
- Report how many conditions the checker rejected per scenario.

Caveat stated in advance: v0.3 and v0.4 episodes were run at different times on a shared free API; model version is the same endpoint.
