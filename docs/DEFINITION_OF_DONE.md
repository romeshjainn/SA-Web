# Definition of Done (project level)

Covers spec §41. The project is **not** complete merely because it compiles. Completion requires, to the extent the environment supports:

- [ ] All roadmap phases (00–21) addressed and gated
- [ ] Core modules implemented and working: credentials (with service groups), saved emails/phones, cards (debit/credit), bank accounts, documents, vehicles, investments, notes (incl. ideas), subscriptions, reminders, net worth, dashboard, global search, quick actions
- [ ] Scanners: card OCR, document scanner, QR/barcode
- [ ] Security architecture documented (threat model, key hierarchy, recovery limits)
- [ ] Security-sensitive implementations independently reviewed; findings resolved or documented
- [ ] Responsive across mobile, tablet, desktop; verified at 360/390/768/1024/1440
- [ ] Accessible interface (keyboard, screen reader semantics, contrast, reduced motion)
- [ ] Light and dark themes polished
- [ ] Installable PWA (manifest, service worker, icons) verified with web tooling
- [ ] Functional core workflows verified by E2E tests
- [ ] Offline support: encrypted local persistence, queue, sync, conflict handling
- [ ] Data integrity: no silent data loss; backups restorable (restore test)
- [ ] Comprehensive tests (unit, integration, component, E2E, responsive, a11y, security, performance, data-integrity)
- [ ] Independent review/audits completed
- [ ] Performance evaluation (measured vs simulated clearly distinguished)
- [ ] Documentation: architecture, security, user guide, ops/deployment, recovery
- [ ] Deployment readiness and release procedure
- [ ] Honest limitations and residual-risk register

Do **not** claim perfection, complete security, or tests that were not performed.
