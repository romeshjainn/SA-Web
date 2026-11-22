# Phase 07 — Scanners, OCR, Documents and QR

**Covers:** S09, S10, S11, S08 (scan actions), S29 (mobile camera), S31 (document processing)
**Depends on:** 02, 04
**Unlocks:** 08, 11

## Objective
Browser-based card scanning, document scanning and QR/barcode scanning with mandatory user verification and secure handling. No native APIs.

## Requirements

### Shared camera/image foundation
`getUserMedia` wrapper (permission handling, facing mode, torch/zoom when supported, graceful fallbacks to file upload/`capture` input), image pipeline in Web Workers/OffscreenCanvas, memory limits, immediate disposal of frames, Permissions-Policy limited to camera. Workers/WASM are bundled by Next.js (no second bundler); OCR/WASM assets self-hosted from `public/`. All processing **on-device**; no images sent to third-party services; self-host OCR assets (no runtime CDN).

### Card scanning (S09)
Camera access when available; card image capture; OCR (e.g. Tesseract.js WASM or comparable, evaluated in ADR); extract card number (Luhn validation), cardholder name, expiry; **never extract or save CVV**; manual correction; mandatory verification screen before saving; secure processing; captured images **discarded by default** unless explicitly retained (and then stored encrypted). OCR is never assumed correct — show confidence cues and editable fields.

### Document scanner (S10)
Camera capture; image import; boundary/edge detection where available (OpenCV.js or lightweight alternative; manual corner adjustment fallback); perspective correction; crop; enhancement (contrast/threshold/greyscale/colour); rotation; multi-page documents with reorder/delete; PDF generation (client-side); OCR for searchable text; preview; metadata; **encrypted storage** (via Phase 04 blobs); secure export; categorisation; searchable (OCR text indexed only locally in the encrypted index, opt-in). No native Android APIs.

### QR / barcode scanner (S11)
Browser scanning (`BarcodeDetector` where supported with a WASM fallback); formats: URLs, Wi-Fi, contacts/vCard/MECARD, digital business cards, payment/informational QR (e.g. UPI URI) parsed as structured data; **preview parsed content; require verification before saving sensitive data; never auto-trust scanned content** (no auto-open links, show full URL and warn on suspicious schemes/punycode); other structured data shown as plain text.

### Integration
Scan actions registered as quick actions (Scan card / Scan document / Scan QR). Scanner outputs hand off to module forms (card → Phase 08/09; document → Phase 11; contact QR → saved contacts, Phase 06). Until target modules exist, hand-off interfaces are contract-tested with synthetic consumers.

### Responsive
Camera UI full-screen on mobile, safe-area aware, orientation changes handled, large touch controls; desktop webcam and file-upload paths.

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| 0 | Camera/image pipeline contracts, ADR for OCR/CV libraries | `core/media` | Lead |
| A | Card scanner + OCR + parser | `features/scan-card` | Builder |
| B | Document scanner (edges, perspective, enhance, PDF) | `features/scan-document` | Builder |
| C | QR/barcode scanner + parsers + safety checks | `features/scan-qr` | Builder |
| D | Scanner UI shells (camera view, verification forms) | `shared/ui/camera` | UI builder |
| E | Fixtures (synthetic card/doc/QR images), tests | `tests/fixtures`, `e2e/` | Test agent |

## Acceptance criteria
- Synthetic test card images yield editable extracted fields; CVV never extracted or stored; images discarded by default.
- Document pipeline produces corrected, multi-page, OCR'd, encrypted PDFs from synthetic fixtures; export works.
- QR parsers handle URL/Wi-Fi/vCard/UPI fixtures; unsafe URLs flagged; nothing auto-saved or auto-opened.
- Fallbacks function when camera is denied/unavailable.

## Testing requirements
Unit (Luhn, expiry parse, vCard/WIFI/UPI parsers, geometry/perspective math), integration (pipeline with fixtures), E2E using Chromium fake media stream (`--use-fake-device-for-media-stream --use-file-for-fake-video-capture`), responsive/orientation emulation, a11y (camera controls, announcements), performance (OCR time measured; label hardware), security (no image persistence by default; canary scan).
Note limitations honestly: real-device camera quality is not tested without a device; **do not block** on devices.

## Independent review
Reviewer checks privacy handling (image disposal), URL-safety logic and CVV exclusion → `docs/reviews/PHASE_07_scanners.md`.

## Checkpoint
Standard.
