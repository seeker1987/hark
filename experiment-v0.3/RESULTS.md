# v0.3 results (interim): CARA closed-loop benchmark

Run 2026-10-09, NVIDIA free API. Preregistration: `PREREG.md` (hashes and two logged deviations in `FREEZE.sha256`).

## Status
- openai/gpt-oss-20b: complete, 480 episodes, 0 errors. Full tables: `results/summary_gpt-oss-20b.md`.
- nvidia/nemotron-3-super-120b-a12b and nvidia/nemotron-3-ultra-550b-a55b: running in background windows; the free tier rate-limits (429/503) larger models to about one episode a minute. moonshotai/kimi-k3 was dropped (about 18 s per call).

## Headline (gpt-oss-20b)
1. **No absorption drift in a real agent loop.** The baseline agent continued after an invalidating shift in 1 of 49 episodes (2%, 95% CI 0-11%). k=4 vs k=16: 4% vs 0%. CARA's motivating figure (> 60% baseline continuation) is not supported here, and depth did not increase drift (H1 and H2 not supported). Detection was immediate (mean SDL 0.02 steps). On gradual cues the baseline often halted at the early warning, before the crossing.
2. **The binding layer is the failure mode.** False interruptions on benign episodes: baseline 7%, Stage 1 binding record 36%, full CARA governor 65% (cara minus baseline +57 pts, 95% CI +27 to +88). Even with no change at all (control), CARA halted 50% of runs. H3 (ICR < 5% with FIR < 8%) fails on FIR.
3. **Why: assumption hallucination at compile time.** The LLM that compiles the Goal-Context Binding Record adds validity conditions the operator never set ("installed version must be 2.4.1", "carrier status must read in transit"), or names telemetry fields that do not exist. The agent then halts because it "cannot verify" them. Per-scenario FIR concentrates where this happened: dependency_upgrade 10/10, refund_batch 9/9 (stage1); db_migration 10/10, spinach_markdown 11/11 (cara).
4. **Cost.** Calls per mutating step: baseline 1.08, stage1 1.26, cara 1.71 (TLO about +58%, above CARA's < 20% target). The governor's deterministic validator SUSPENDed only 5 times; most CARA halts came from the agent after a REVISE.
5. **Decoys are the baseline's weak spot.** An unrelated "CRITICAL ALARM" line stopped the baseline in 22% of decoy runs (mostly orchard pump vibration).

## What this means for the framework
- For capable current models, the bottleneck is not persistence (MTA's target) but **calibrated interpretation**: knowing which conditions actually matter. The Interpretation layer (ICA) needs to be grounded, not generative.
- A binding record should only contain conditions traceable to the operator's text or to an observed telemetry field, with provenance on each one. Unverifiable conditions should be marked as U_t (uncertainty), never as V_t.

## Suggested v0.4
- Grounded binding: each validity condition must cite its source span; a checker rejects unsupported ones. Test whether FIR returns to baseline while ICR stays at 0.
- Harder persistence tests that can actually separate arms: cue only visible in a tool output the agent must request, conflicting stakeholder instructions, and 100+ step horizons with summarised (compressed) context, where dilution is real.
- Second and third model families once the free-tier capacity allows.
