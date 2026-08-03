# muon_interpretation

Notebooks for interpreting the Muon optimizer against SGD: staged two-layer trade-offs, tau-scheduling, and Jacobian-guided spectral schedules on deeper linear nets.

## Repository layout

- `Chinese/` — Chinese notebooks
- `English/` — English notebooks

Both folders contain the same notebook set. Each experiment has a source notebook and an executed twin with outputs:

| Notebook | Topic |
|---|---|
| `demo_muon_tradeoff.ipynb` | Staged two-layer linear network: Phase 1 trains W1 (SGD vs Muon), Phase 2 freezes W1 and recovers with SGD. Extensions cover black-box Jacobian downstreams, sample / CE losses, and **multi-layer MLP adjacent-scheme alternation**. |
| `demo_muon_tradeoff.executed.ipynb` | Executed version of the above |
| `demo_muon_tradeoff_tau.ipynb` | tau-scheduling on the composition loss: joint updates (tau = 0) vs alternating segments (tau ≥ 1); Muon on W1 vs all-SGD |
| `demo_muon_tradeoff_tau.executed.ipynb` | Executed version of the above |
| `demo_muon_tradeoff_dp.ipynb` | Three-layer linear net with spectral update exponents p in {1, 0.5, 0}; compares fixed SGD, rollout-based DP, and Jacobian-guided schedule selection |
| `demo_muon_tradeoff_dp.executed.ipynb` | Executed version of the above |

## Notes

- English and Chinese notebooks share the same code, outputs, and figures; only the explanatory Markdown differs.
- Start with `demo_muon_tradeoff.ipynb` for the core Phase-1 / Phase-2 story; use the `_tau` and `_dp` notebooks for scheduling variants.
