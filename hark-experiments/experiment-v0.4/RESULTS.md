# v0.4 results: grounded binding (gpt-oss-20b)

320 episodes (stage1 and cara, grounded), 0 errors used; compared with v0.3 (same protocol, same evening). Preregistration: `PREREG.md`.

| Arm | ICR (continued after real invalidation) | FIR (false stops, benign) | Calls per mutating step |
|---|---|---|---|
| Baseline (v0.3) | 2% (1/49) | 7% | 1.08 |
| Stage 1, v0.3 ungrounded | 0% | 36% | 1.26 |
| Stage 1, v0.4 grounded | 0% (0/43) | 17% | 1.12 |
| CARA, v0.3 ungrounded | 0% | 65% | 1.71 |
| CARA, v0.4 grounded | 0% (0/44) | 14% | 1.35 |

## Hypotheses
- G1 (FIR drops >= 15 pts with CI excluding 0): **supported for CARA** (-51 pts, 95% CI -76 to -27); **not supported for Stage 1** (-20 pts, CI -48 to +4).
- G2 (grounded CARA FIR <= 15%): met on the point estimate (14%, Wilson CI 8-22%). CARA's own < 8% target is not met.
- G3 (no loss of detection, ICR <= 5%): **supported**, 0/87 continuations, no premature halts on invalidating runs.
- Grounded CARA vs baseline FIR: +6 pts (CI -4 to +17), no longer clearly worse than having no binding.

## Details
- The grounding checker rejected 0 conditions: once told to quote the operator, the compiler simply stopped inventing (1-2 conditions per scenario instead of 3-6). Prompt-level grounding did most of the work; the checker is a backstop.
- Remaining false stops are mostly decoys (unrelated "CRITICAL ALARM" line): 28% CARA, 31% Stage 1 (baseline 22%), plus orchard, refund and spinach near-misses.
- Cost: the deterministic predicate often could not parse the field and fell back to the LLM monitor (448 monitor calls), so overhead is +25% vs baseline, close to CARA's < 20% target but above it.

## Takeaway
Binding works when it is grounded: grounded CARA keeps perfect detection and cuts false stops from 65% to 14%. The open problem is salience calibration (ignoring alarms unrelated to the validity conditions), not persistence.

## Next
- Decoy discrimination: governor checks whether an alarm touches any V_t field before escalating.
- Robust field matching to cut monitor calls (overhead).
- Replicate on the Nemotron models (v0.3 runs continuing overnight).
