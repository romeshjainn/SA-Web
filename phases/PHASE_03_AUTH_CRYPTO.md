# Phase 03 — Authentication, Threat Model and Cryptography

**Covers:** S04, S34 (browser-based crypto benchmarking), S25/S26 (design hooks), S27 (design hooks)
**Depends on:** 01 (02 for UI screens)
**Unlocks:** 04

**Strongest reasoning applies to this entire phase.** Design and document before implementing sensitive storage.

## Objective
Deliver a documented, reviewed cryptographic architecture, threat model and authentication system, with vault unlocking separate from account authentication.

## Requirements

### Documents first (parallel-safe)
- `docs/security/THREAT_MODEL.md`: malicious actors; database compromise; backend compromise; unauthorized account access; session compromise; XSS; CSRF; malicious browser extensions; phishing; weak master passwords; brute force; data leakage; backup compromise; sharing abuse; device compromise; clipboard exposure; browser storage exposure; supply chain; third-party dependency vulnerabilities. State what the app **can and cannot** protect against.
- `docs/security/CRYPTO_ARCHITECTURE.md`: password-based KDF (Argon2id via audited WASM, or a justified alternative), Web Crypto usage, AES-GCM (96-bit random nonce policy / counter policy, key-usage limits), CSPRNG, key hierarchy (master key → key-encryption key → per-vault/per-item data-encryption keys; HKDF subkeys for purposes), key separation, key rotation, recovery mechanism (e.g. recovery key / secret key; honest "forgotten master password = data loss unless recovery key" statement), AAD usage to bind ciphertext to record id/type/version, integrity verification, versioned envelope format with algorithm/params identifiers, crypto agility plan.
- `docs/security/KDF_BENCHMARKS.md`: **browser-based** benchmarks (WASM Argon2id in Chromium via Playwright; CPU throttling to emulate slower devices). Label every figure **measured on <hardware>** or **simulated (throttle Nx)**. **Do not invent mobile benchmarks. Do not require Android emulators/devices.** Pick parameters with documented assumptions (target unlock time and memory ceiling), record as ADR.
- `docs/security/AUTH_DESIGN.md`: account authentication (Supabase Auth or justified alternative), vault unlock, session management (short-lived sessions, idle auto-lock, absolute expiry), re-authentication for sensitive actions, logout (wipe keys and caches), session expiry, account recovery vs vault recovery, device/session management, brute-force/rate-limit strategy, CSRF stance, cookie settings.
- Document hooks for later phases: encrypted search index (04/05), sharing key wrapping (17), encrypted backups (17), WebAuthn/passkeys (19) — WebAuthn may wrap/unlock but **never replace** the master-key architecture.

### Implementation
- `core/crypto`: KDF wrapper, AES-GCM encrypt/decrypt with envelope format, HKDF, random utilities, constant-time compare, key wrapping/unwrapping, key rotation primitives, memory hygiene (non-extractable `CryptoKey` where possible, zero buffers where feasible). **No custom algorithms. No nonce reuse. No hardcoded secrets.**
- Registration/login via auth provider; **master password never sent to the server**; server stores only wrapped keys, KDF params, salts and verifiers that cannot decrypt data. Auth token or DB password is never a vault key.
- Vault create/unlock/lock/auto-lock (idle timer, tab hide, manual), wrong-password fails closed with tamper-evident verification, rate-limited attempts (client UX + server rate limits on auth endpoints).
- Master-password change (re-wrap DEKs), recovery-key generation and recovery flow, session list and revoke, re-auth gate for sensitive actions (export, change password, delete account, reveal highest-sensitivity items).
- Password-strength guidance at master-password creation (zxcvbn-style, offline), with honest weak-password risk messaging.
- Supabase: tables for profiles/key material with RLS tests; **Next.js Route Handlers** (Node runtime) with zod validation, rate limiting, secure cookies, CSRF protections.
- UI: signup, login, unlock, lock screen, recovery key, session management, re-auth dialogs (use Phase 02 components; light/dark; responsive).
- Safe logging verified: no master password, keys, plaintext in logs/URLs/storage.

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| A | Threat model | `docs/security/THREAT_MODEL.md` | Security-strong agent |
| B | Crypto architecture + benchmarks | `docs/security/`, `core/crypto` | Lead (strongest) |
| C | Auth design + implementation | `core/auth`, `app/(auth)`, `app/api/auth` | Builder |
| D | DB schema, RLS, tests | `supabase/migrations` | Builder |
| E | Auth/lock UI | `features/auth-ui` | UI builder |
| F | Crypto/known-answer/tamper/security tests | `tests/security` | Test agent |
A and B first; C–F follow the accepted design. A **different** agent reviews B and C.

## Acceptance criteria
- Threat model, crypto architecture, auth design and KDF ADR committed.
- Known-answer vectors pass; tampered ciphertext fails; wrong password fails closed; nonces unique over a large sample.
- Plaintext never reaches the server or DB (verified with canary secrets).
- RLS prevents cross-account reads/writes (tested with two synthetic users).
- Auto-lock and logout wipe in-memory keys; recovery-key flow tested end to end.
- Benchmarks labelled measured vs simulated; limitations documented.

## Testing requirements
Unit (KDF/AEAD/HKDF/envelope/rotation), integration (register → unlock → lock → change password → recover), authorization tests, E2E auth flows, a11y/responsive for auth screens, canary leak scans (logs/URLs/storage/network).

## Independent review (mandatory)
Different agent reviews crypto, auth, session, RLS with "find flaws" brief → `docs/reviews/PHASE_03_crypto_auth.md`. Critical/High fixed. Residual risks documented. Do not claim the product is secure.

## Checkpoint
Standard; ADRs linked in PROGRESS.md.
