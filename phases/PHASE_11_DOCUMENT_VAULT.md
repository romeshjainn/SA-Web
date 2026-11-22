# Phase 11 — Document Vault

**Covers:** S15, S10 (hand-off), S20 (expiry reminders hooks), S23, S24, A02
**Depends on:** 07, 04 (10 for account links)
**Unlocks:** 12, 15, 17

## Objective
A secure document vault where documents and every attachment are encrypted and treated as highly sensitive.

## Requirements
- Document types: PAN, Aadhaar, Passport, Driving licence, Insurance, Certificates, Employment documents, Financial documents, Personal documents, and **custom document types** (user-defined fields).
- Metadata: document number, issue date, expiry date, issuing authority, holder, notes; type-specific templates with format validation (e.g. PAN/Aadhaar patterns — synthetic test values only; Aadhaar numbers masked by default).
- **Attachments**: images and PDFs, multiple per document, encrypted client-side via Phase 04 blob storage (unique key/nonce per file, encrypted filenames), size/type validation (content sniffing, not just extension), thumbnails generated client-side and stored encrypted.
- **Secure preview**: decrypt in memory, render in sandboxed viewer (PDF.js / image canvas), no persistent decrypted copies, revoke object URLs, blur on app-switch/idle, watermark-free but with auto-hide.
- **Secure export**: explicit action, reauth setting, filename sanitisation, warning that exported files are unencrypted.
- Search (metadata only by default; OCR text opt-in, local encrypted index), categories, tags, favorites, archive/restore.
- **Relationships**: documents ↔ bank accounts, vehicles, cards, notes, investments (relation contract; Phase 16 UI polish).
- **Expiry reminders**: configurable lead times (e.g. 90/30/7 days) registered with the reminder service (Phase 15 consumes; contract-tested now). Dashboard "nearing expiry" data.
- Scanner hand-off from Phase 07 (multi-page PDF + OCR) with verification of extracted metadata.
- Minimal UI: grouped by type, expiry badges, one-tap open; details sheet; mobile camera-first add flow.

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| 0 | Document + attachment contracts | `features/documents/types` | Lead |
| A | Data layer + encrypted attachments | `features/documents/data` | Builder (security-aware) |
| B | Viewer/preview/export | `features/documents/viewer` | Builder |
| C | UI (list, forms, type templates) | `features/documents/ui` | UI builder |
| D | Expiry/reminder hooks + relations | `features/documents/integration` | Builder |
| E | Tests | `tests/`, `e2e/` | Test agent |

## Acceptance criteria
- Upload/scan → encrypted → preview → export → delete round trip works offline/online per sync rules.
- Storage objects and DB rows contain no plaintext (inspected with canaries); previews leave no residual decrypted data.
- Expiry badges and reminder registrations correct; custom types usable.

## Testing requirements
Unit (validators, type templates), integration (encrypted blob round trip, relations, tamper detection), E2E (add document with image + PDF, preview, export, archive), responsive/a11y (viewer focus management), memory check for large PDFs, canary scans.

## Independent review (mandatory)
Reviewer examines attachment encryption, preview/export handling and MIME validation → `docs/reviews/PHASE_11_documents.md`.

## Checkpoint
Standard.
