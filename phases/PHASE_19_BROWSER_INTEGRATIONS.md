# Phase 19 — Browser Integrations, Autofill, Biometrics and PWA Hardening

**Covers:** S27, A03 (PWA hardening), S04 (WebAuthn security), S34
**Depends on:** 03, 06, 18
**Unlocks:** 20

## Objective
Implement only what browsers genuinely support and what can be done securely. Biometrics must not replace the cryptographic vault architecture.

## Requirements

### Evaluate, then implement (ADR for each)
- **WebAuthn / passkeys**: (a) passkey as second factor / sign-in to the account; (b) optional **convenient unlock** using the WebAuthn **PRF extension** (where supported) or a device-bound wrapped key, so a platform authenticator (fingerprint/face/PIN handled by the OS) can unlock the vault *without replacing* the master-key design — the master password / recovery key remains the root of recovery. Document feature detection, fallbacks, and exact limitations (no PRF support → feature hidden). Never claim universal biometric support; never implement fake "biometrics" in-page.
- **Credential Management API** (`navigator.credentials`): evaluate for saving/using the vault's own login on the app; assess `PasswordCredential` support limits.
- **Browser autofill**: ensure the app's own forms have correct `autocomplete` attributes and password-manager-friendly markup; evaluate whether a web app can legitimately integrate with OS/browser autofill (generally it cannot act as a system autofill provider) — **document honestly**; provide practical alternatives (copy buttons, quick-search + paste flow, optional bookmarklet/extension **only** if evaluated as secure; extension out of scope unless ADR). Do not claim autofill support that doesn't exist.
- **Other platform authentication integrations** evaluated and recorded (e.g. Web Share Target for receiving shared text/files into the vault as a PWA feature; File Handling API; Badging API for reminders) — implement only the secure, supported, useful ones.

### PWA hardening (A03)
- Installability verified (manifest, icons, SW, HTTPS, scope), install prompt flow, offline fallback page, update flow (user-controlled), `display_override`, app shortcuts for quick actions, share target if adopted, iOS meta tags / Add-to-Home-Screen guidance, theme-colour per scheme, splash handling.
- Validate with Lighthouse/DevTools/Playwright; **no Android Studio or native tooling**. Document what could not be verified without a physical device (e.g. real Android install prompt UX) as a limitation, with the programmatic evidence collected.

### Security of integrations
Threat-model delta for each integration; re-auth policy; WebAuthn RP ID/origin checks, challenge handling, replay protection, credential management UI (list/remove passkeys); fallback to password always available.

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| A | WebAuthn/passkey evaluation + implementation | `core/auth/webauthn` | Lead/Builder (strong) |
| B | Credential Management + autofill evaluation & form markup | `features/credentials`, docs | Builder |
| C | PWA hardening + share target/shortcuts | `pwa/`, `public/` | Builder |
| D | UI for passkeys/unlock preferences | `features/settings` | UI builder |
| E | Tests (virtual authenticator via CDP) | `tests/`, `e2e/` | Test agent |

## Acceptance criteria
- Passkey registration/authentication verified with Playwright/CDP virtual authenticator; unlock-with-passkey works only where PRF/wrapping supported; fallbacks verified.
- Honest capability matrix in `docs/BROWSER_INTEGRATIONS.md` (supported / partially / not supported / not implemented and why).
- PWA installability checks pass programmatically; limitations documented.

## Testing requirements
E2E with virtual authenticator, feature-detection tests (unsupported browsers), unit tests for key wrapping with PRF output, security tests (challenge replay, wrong origin), PWA manifest/SW audits, responsive/a11y of settings screens.

## Independent review (mandatory)
Different agent reviews WebAuthn/PRF-based unlock and re-auth policy → `docs/reviews/PHASE_19_integrations.md`.

## Checkpoint
Standard.
