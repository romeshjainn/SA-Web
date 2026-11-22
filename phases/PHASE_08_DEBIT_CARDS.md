# Phase 08 — Debit Cards

**Covers:** S12, S09 (hand-off), S23 (card ↔ account), S24, A02
**Depends on:** 06, 07 (10 for linked-account picker; use relation contract if 10 is not done)
**Unlocks:** 09, 14 (indirect)

## Objective
Premium debit-card management with a realistic, beautiful card renderer and careful secret handling.

## Requirements
- Fields: bank name, cardholder name, card number, expiry, network, card type, linked account, custom fields, notes. Favorites, archive/restore, reveal/hide, copy, secure access (reveal gated by unlocked vault and optional re-auth).
- **CVV handling**: do not expose CVV unnecessarily; recommended default is **not storing CVV at all**; if the user opts to store it, keep it as a separately encrypted field, hidden by default, shown only on explicit reveal, never logged, never indexed, never in search/recents. Never persist card images or details insecurely.
- **Card visual renderer**: front and back; flip animation (reduced-motion aware); masking (•••• 1234); reveal controls; network visual distinctions (Visa, Mastercard, RuPay, Amex, Maestro, Discover, others/custom — use original, license-safe network marks/wordmarks as simple SVG, no copied trademark artwork beyond recognised network logos permitted for identification); bank branding where appropriate (accent colours/initial monogram; avoid copying bank logo assets); customisable appearance (colour theme, texture) where practical; chip/contactless glyphs; works in light and dark themes; scales fluidly 320–1440.
- Scan hand-off from Phase 07 with mandatory verification; Luhn validation; network auto-detect from BIN; expiry validation.
- Linked account via relationship service (Phase 16 formalises relationships; implement through the core relation contract now).
- Saved email/phone suggestions on relevant fields (A02) if present.
- Register search provider (bank name, holder, network, last 4 only), quick action "Add card", favorites, archive.
- Minimal list: card carousel on mobile (swipe), compact list on desktop; details sheet.

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| 0 | Debit-card schema/contract (shared base with credit cards) | `features/cards/types` | Lead |
| A | Data layer + encryption + relations | `features/debit-cards/data` | Builder |
| B | Card renderer (front/back, networks, themes) | `shared/ui/payment-card` | UI builder (design-focused) |
| C | List/detail/forms + scan hand-off | `features/debit-cards/ui` | UI builder |
| D | Tests | `tests/`, `e2e/` | Test agent |
Phase 09 reuses the shared renderer and base types.

## Acceptance criteria
- CRUD/archive/favorite/reveal/copy work offline and online.
- Card renders correctly for each network, both faces, both themes, at all five viewports.
- CVV is not stored by default; no sensitive data in logs/search index/recents; canary scans clean.

## Testing requirements
Unit (Luhn, network detection, masking), component (renderer states/flip/reduced motion), integration (encrypted CRUD + relation to account), E2E (add via scan fixture → verify → save → reveal → copy), responsive/a11y (flip control keyboard + announced state, contrast on card faces).

## Independent review
Reviewer checks secret handling and visual quality (screenshots) → `docs/reviews/PHASE_08_debit.md`.

## Checkpoint
Standard.
