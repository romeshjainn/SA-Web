# Requirements Traceability

Every section of `docs/spec/MASTER_SPEC.md` (verbatim original) and every addendum item is mapped to one or more phases. **Primary** = phase that implements it; **Also** = phases that extend, consume or verify it. Cross-cutting rows apply to every phase.

At each phase gate, fill the Evidence column (file paths, test names, review reports). `scripts/validate-kit.sh` checks every ID below appears in at least one phase file.

| ID | Spec § | Requirement | Primary | Also | Evidence |
|---|---|---|---|---|---|
| S01 | 1 | Product vision, modules, Find → Reveal → Use, real functionality | 00 | all, 21 | |
| S02 | 2 | Stack (Next.js + API routes, TS, Tailwind, Supabase, Playwright); web-only; no Android | 01 | 00, 20 | |
| S03 | 3 | Modular architecture, shared services, boundaries | 01 | all | |
| S04 | 4 | Security & privacy (objectives, crypto, threat model, auth, logging, verification) | 03 | 04, 17, 19, 20 | |
| S05 | 5 | Offline-first, encrypted cache, sync, conflicts, states | 04 | 18, 20 | |
| S06 | 6 | Password manager, service groups, generator | 06 | 05, 19 | |
| S07 | 7 | Global search | 05 | 06–16, 18 | |
| S08 | 8 | Quick actions | 05 | 06–16 (each module registers its action), 07 | |
| S09 | 9 | Card scanning | 07 | 08, 09 | |
| S10 | 10 | Document scanner | 07 | 11 | |
| S11 | 11 | QR / barcode scanner | 07 | 06, 16 | |
| S12 | 12 | Debit cards + visual renderer | 08 | 10 | |
| S13 | 13 | Credit cards and liabilities | 09 | 14, 15 | |
| S14 | 14 | Bank accounts | 10 | 14 | |
| S15 | 15 | Document vault | 11 | 15, 17 | |
| S16 | 16 | Vehicles | 12 | 15 | |
| S17 | 17 | Investments | 13 | 14 | |
| S18 | 18 | Financial overview / net worth engine | 14 | 09, 10, 13 | |
| S19 | 19 | Customizable dashboard | 14 | 02 | |
| S20 | 20 | Reminders and calendar | 15 | 09, 11, 12 | |
| S21 | 21 | Subscriptions and recurring expenses | 15 | 14 | |
| S22 | 22 | Secure notes | 16 | 05 | |
| S23 | 23 | Relationships and personal organisation | 16 | 08–13, 15 | |
| S24 | 24 | Archive, trash, activity | 16 | all modules | |
| S25 | 25 | Secure sharing | 17 | 03 | |
| S26 | 26 | Backup and recovery | 17 | 03, 04 | |
| S27 | 27 | Biometrics and autofill (passkeys/WebAuthn/Credential Mgmt) | 19 | 03 | |
| S28 | 28 | UI/UX and design system | 02 | all | |
| S29 | 29 | Mandatory responsive design (360/390/768/1024/1440) | 02 | **every UI phase**, 20 | |
| S30 | 30 | Accessibility | 02 | **every UI phase**, 20 | |
| S31 | 31 | Performance | 18 | 03 (KDF), 04, 20 | |
| S32 | 32 | State and UI reliability (all UI states) | 02 | 04, 18, **every phase** | |
| S33 | 33 | Testing strategy, synthetic data | 20 | **every phase**, `docs/TESTING_STRATEGY.md` | |
| S34 | 34 | Web-only dev/testing; browser-based benchmarks; no invented mobile numbers | 03 | 00, 18, 20 | |
| S35 | 35 | Roadmap Phases 00–21 | 00 | ROADMAP.md | |
| S36 | 36 | Phase gates; environmental limitations ≠ deadlock | 00 | `docs/PHASE_GATES.md` | |
| S37 | 37 | Autonomous execution, agents, worktrees | 00 | `docs/MULTI_AGENT_COORDINATION.md` | |
| S38 | 38 | Model and resource strategy | 00 | `docs/MULTI_AGENT_COORDINATION.md` | |
| S39 | 39 | Git and checkpoints | 00 | `docs/CHECKPOINTING_AND_RECOVERY.md`, all | |
| S40 | 40 | Interruption/usage-limit recovery; PROGRESS/STATUS/PHASE_LOG | 00 | `docs/CHECKPOINTING_AND_RECOVERY.md`, all | |
| S41 | 41 | Definition of done | 21 | 20, `docs/DEFINITION_OF_DONE.md` | |
| SFD | Final directive | Inspect repo, reconcile kit, establish AGENTS.md, execute 00→21, no Android, no routine approval | 00 | all | |
| A01 | Addendum | Option to save email addresses and mobile numbers (saved contacts store) | 06 | 04, 17 | |
| A02 | Addendum | Suggest saved emails/phones in relevant email/phone fields (shared field component) | 06 | 08–13, 15, 16 | |
| A03 | Addendum | Installable PWA on phones, no native tooling | 02 | 04, 19, 20 | |
| A04 | Addendum | Minimal, clean, uncluttered interface | 02 | **every UI phase**, 14 | |
| A05 | Addendum | Aesthetic modern fonts; non-generic design; design/UX is the USP | 02 | **every UI phase**, 20 | |
| A06 | Addendum | Light and dark themes | 02 | **every UI phase**, 20 | |
| A07 | Addendum | Notes: save and organise ideas | 16 | 05 | |

## Detailed sub-requirement checklist (feature bullets)

Phase files restate each bullet from the spec. Use this index to find where each feature group lives.

| Spec feature group | Phase file |
|---|---|
| Credentials CRUD/archive/favorites/history/custom fields/clipboard/auto-hide/strength/generator/service groups | 06 |
| Global search categories/filters/keyboard/highlighting/recents/offline/shortcuts | 05 |
| Quick-action list (add password/card/bank/document/note/investment/vehicle/subscription; scan document/card/QR) | 05 (framework), 06–16 and 07 (actions) |
| Card OCR (number/name/expiry; never CVV; discard images) | 07 |
| Document scanner (edges, perspective, crop, enhance, rotate, multi-page, PDF, OCR) | 07, 11 |
| QR formats (URL, Wi-Fi, contacts, vCard, payment) with verification | 07 |
| Card renderer (flip, mask, network visuals, bank branding, customise) | 08 |
| Credit limit/available/outstanding/utilisation/cycle/statement/due/payments/charts | 09 |
| Bank fields, manual balance, history, linked cards/documents, manual vs synced | 10 |
| Document types (PAN, Aadhaar, passport, DL, insurance, certificates, employment, financial) | 11 |
| Vehicle fields, insurance, PUC, service history, maintenance, doc links | 12 |
| Investment types and calculations; manual vs verified valuation | 13 |
| Net-worth engine, dashboard widgets, trends, manual adjustments, inclusion toggles | 14 |
| Reminders (recurrence, snooze, reschedule, history, notifications, calendar) | 15 |
| Subscriptions (frequency, renewal, summaries, payment method) | 15 |
| Notes (+ideas), relationships, archive/trash/activity/retention | 16 |
| Sharing (expiry 12/24h, server-enforced, revoke, audit, abuse prevention) | 17 |
| Encrypted backup/export/restore/integrity/versioning/recovery docs | 17 |
| Passkeys / WebAuthn / Credential Management / autofill | 19 |
