# Independent Review Reports

Each phase that requires an independent review stores its report here, named in the phase file (for example `PHASE_03_crypto_auth.md`). The authoring agent must not write the review of its own code. The full list of expected reports is in `docs/GENERATED_ARTIFACTS.md`.

## Report template

```
# Review — Phase NN: <topic>
- Reviewer (agent/role) and date:
- Author(s) of the reviewed code:
- Scope (paths, commits):
- Brief given to the reviewer ("find flaws, do not confirm"):

## Findings
| ID | Severity (Critical/High/Medium/Low) | Area | Description | Evidence (file:line / test) | Status (fixed / accepted / open) | Resolution |
|---|---|---|---|---|---|---|

## What was checked and how
## What was NOT checked (limits of the review)
## Residual risks
## Re-verification of fixes (reviewer, date)
```

Critical and High findings must be fixed and re-verified before the phase gate. Medium/Low findings are fixed or explicitly accepted with a reason.
