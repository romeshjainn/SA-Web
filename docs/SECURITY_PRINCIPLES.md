# Security Principles (non-negotiable, spec §4 and cross-cutting)

Treat this as a security-sensitive product holding extremely sensitive personal data.

## Objectives
Protect data at rest and in transit; minimize plaintext exposure; keep cryptographic operations client-side where appropriate; never casually expose sensitive info to the backend; prevent unauthorized and cross-account access; prevent leaks through logs, error reporting, browser storage, URLs, debugging tools; avoid unnecessary permissions and external services; **no telemetry or tracking**.

## Crypto requirements (design and document before storing anything sensitive)
- Password-based KDF: Argon2id (or a justified alternative, documented with measured browser benchmarks).
- Web Crypto where appropriate; AES-GCM (or equivalent AEAD); CSPRNG; correct unique nonces/IVs.
- Key hierarchy and key separation: master key → wrapped data-encryption keys; per-purpose subkeys (HKDF).
- Key rotation, recovery mechanisms, integrity/authentication verification.
- Do not invent algorithms. Do not reuse keys/nonces incorrectly. Do not hardcode secrets.
- A DB password or auth token is never the vault key. Supabase, HTTPS or auth alone does not protect vault data.

## Threat model must cover
Malicious actors; DB compromise; backend compromise; unauthorized account access; session compromise; XSS; CSRF; malicious browser extensions; phishing; weak master passwords; brute force; data leakage; backup compromise; sharing abuse; device compromise; clipboard exposure; browser storage exposure; supply chain; third-party vulnerabilities. Document what the app **can and cannot** protect against.

## Authentication
Account authentication, vault unlocking, session management, reauthentication for sensitive actions, logout, session expiry, account recovery, vault recovery, device/session management. Separate authentication from vault encryption.

## Logging (never log)
Passwords, master passwords, keys, decrypted contents, CVVs, full card details, document contents, private financial records, recovery secrets. Logs must be safe and useful.

## UX-level security
Auto-hide revealed secrets; clipboard auto-clear where possible; privacy blur on app-switch/idle; auto-lock; masked-by-default values; reveal requires an unlocked vault (and reauth for the most sensitive items where designed).

## Verification
Independently review crypto, authentication, authorization, DB policies (RLS), storage, data access, sharing, recovery, backup, session handling, XSS protection, dependency vulnerabilities. Passing tests ≠ secure. Document residual risks honestly.

## Web hardening baseline
Strict CSP (no inline scripts; nonces), `Referrer-Policy: no-referrer`, `X-Content-Type-Options`, `frame-ancestors 'none'`, `Permissions-Policy` limited to camera as needed, HSTS, SameSite cookies, input validation (zod) on every route handler, rate limiting on auth/share endpoints, dependency pinning and audit, SRI/self-hosted assets (no third-party CDNs for runtime code), no analytics.
