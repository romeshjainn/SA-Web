# Phase 17 — Secure Sharing, Backup and Recovery

**Covers:** S25, S26, S04 (backup/sharing review)
**Depends on:** 03, 04, and all data modules (05–16)
**Unlocks:** 18

**Strongest reasoning and mandatory independent review.** Sharing is optional and must never compromise foundational security; if it cannot be made safe within the architecture, ship backup/recovery and document sharing as deferred with an ADR rather than weakening security.

## Objective
Encrypted backups with verified restore, user-understandable recovery, and (if safe) tightly scoped expiring shares.

## Requirements

### Secure sharing (S25)
- Scoped access to selected items/fields only (minimal exposed data); **client-side encryption of the shared payload** with a one-time share key delivered in the URL fragment (never sent to the server) and optionally an extra passphrase.
- **Expiring links** (12 h or 24 h options; configurable shorter), **server-enforced expiry** (checked on every read; expired payloads purged), **revocation** (immediate), **unpredictable tokens** (≥128-bit CSPRNG), view-count limits, access controls, **audit information** (created, accessed counts/timestamps, revoked — no plaintext), **abuse prevention** (rate limiting, size limits, no enumeration, generic errors, CAPTCHA-free approaches first), `noindex`, `Referrer-Policy: no-referrer`, strict CSP on the share page.
- Never rely only on frontend expiry. No share of recovery secrets or master keys. Sensitive-field sharing requires re-auth and an explicit warning.
- Share-management UI: list, status, revoke, extend (new link), minimal.

### Backup (S26)
- **Encrypted backups** (client-side; backup key derived/wrapped from vault keys or a separate backup passphrase — documented in the crypto architecture), **backup export** (single file with versioned header, KDF params, per-chunk AEAD, manifest hash), **restore** (full and selective, into empty or existing vault with conflict policy, dry-run preview), **integrity verification** (verify without restoring), **versioning** where appropriate (format version + optional multiple server-side encrypted snapshots with retention), attachments included (encrypted blobs).
- Backups must not casually expose plaintext vault data; no plaintext temp files; memory hygiene.
- Scheduled reminders to back up (via Phase 15 reminder service).

### Recovery (S26, S04)
- Recovery workflows: recovery-key based vault recovery, master-password change, lost-device scenarios, restore from backup; **honest limitation statements** in-product and in `docs/RECOVERY_GUIDE.md` (e.g. forgotten master password + lost recovery key = unrecoverable).
- Recovery drills as automated tests (create vault → destroy local state → recover).
- Recovery documentation understandable by non-experts.

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| 0 | Share/backup/recovery design addendum to crypto architecture | `docs/security/` | Lead (strongest) |
| A | Backup format + export/restore/verify | `core/backup` | Lead/Builder (strong) |
| B | Share service (server + client) | `core/sharing`, `app/api/share`, `app/s/[token]` | Builder (strong) |
| C | Recovery flows | `core/recovery` | Builder |
| D | UI (backup, restore, share management, recovery) | `features/backup`, `features/sharing` | UI builder |
| E | Tests (incl. recovery drills, abuse tests) | `tests/`, `e2e/` | Test agent |

## Acceptance criteria
- Backup → wipe → restore reproduces every synthetic record and attachment byte-for-byte (hash check); tampered backup rejected.
- Share link: works before expiry, fails after (server clock control), fails after revoke, token not guessable, server never has plaintext or key; rate limits trigger.
- Recovery drills pass; documentation matches behaviour.

## Testing requirements
Unit (format, chunk AEAD, token generation), integration (backup/restore, share lifecycle, RLS/authorization), E2E (create share, open in a clean context, expire/revoke; backup/restore), security tests (enumeration, replay after expiry, header checks, canary scans), data-integrity tests (partial restore failure leaves vault consistent).

## Independent review (mandatory)
Different agent, adversarial brief → `docs/reviews/PHASE_17_sharing_backup_recovery.md`; Critical/High fixed; residual risks documented.

## Checkpoint
Standard.
