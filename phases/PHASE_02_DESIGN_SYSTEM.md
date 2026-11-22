# Phase 02 — Design System, Responsive UX, Accessibility, Themes and PWA Shell

**Covers:** S19 (dashboard shell), S28, S29, S30, S32, A03, A04, A05, A06
**Depends on:** 01
**Unlocks:** 05, 07 (and all UI work). May run in parallel with the design/spec portion of Phase 03.

## Objective
Create a premium, modern, minimal, accessible design system and responsive app shell that make design/UX the product's main USP. Include light and dark themes and PWA installability foundations.

## Requirements
- **Design brief** (`docs/design/BRIEF.md`, seeded by the kit): build the listed directions as real components, compare them, choose one (ADR-0003), and add the "Decision" section to the brief. Follow `docs/DESIGN_PRINCIPLES.md`: calm/premium, avoid generic AI aesthetics, minimal, uncluttered.
- **Typography**: select a characterful, modern, self-hosted font pairing (UI sans + mono for secrets), fluid scale, tabular numerals; verify licences; no runtime font CDN.
- **Colour tokens**: semantic CSS variables; hand-tuned **light and dark** themes; system default + persisted manual override; no flash of wrong theme; WCAG AA contrast verified.
- **Spacing, layout, grid, motion** (120–240 ms, reduced-motion aware), focus states.
- **Components**: buttons, inputs (incl. password input with reveal, **email and phone fields built to accept suggestions — see A02 in Phase 06**), selects/dropdowns, forms, cards, tables (responsive: stacked or contained scroll), dialogs and bottom sheets, tabs, badges, tooltips, toasts, skeletons, empty states, error states, loading indicators, charts wrapper with accessible data-table fallback, command palette shell.
- **Navigation**: mobile bottom bar (≤5 destinations) + "More" sheet + floating quick-action; desktop sidebar/rail + `Ctrl/Cmd+K` palette; safe-area insets.
- **Common UI-state components** covering: loading, empty, error, success, saving/saved, offline, pending sync, sync failure, partial failure, conflict, validation error, unauthorized, expired session.
- **PWA shell (A03)**: web app manifest (name, icons incl. maskable, theme/background colours for both schemes, `display: standalone`, shortcuts for quick actions), icon set, install prompt UX (`beforeinstallprompt` where supported; iOS "Add to Home Screen" guidance), basic service worker registration scaffold (full offline caching is Phase 04; hardening Phase 19). **Web tooling only — do not install Android Studio or any native tooling.**
- Living style page `/design` (dev-only) showing every component and state in both themes.
- Accessibility utilities: focus trap, live regions, skip links, visually-hidden, roving tabindex, reduced-motion hook.
- Minimalism audit: default screens show only essentials; progressive disclosure pattern documented.

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| 0 | Token + theme contract | `design-system/tokens`, theme provider | Lead |
| A | Primitives (buttons, inputs, forms, badges) | `design-system/primitives` | UI builder |
| B | Overlays (dialog, sheet, tooltip, toast, dropdown, palette) | `design-system/overlays` | UI builder |
| C | App shell + navigation + responsive layout | `shared/ui/shell`, `app/(shell)` | UI builder |
| D | PWA manifest, icons, SW scaffold, install UX | `public/`, `app/manifest`, `pwa/` | Builder |
| E | State components, a11y utilities, style page | `design-system/states`, `design-system/a11y` | UI builder |
| F | Component/axe/visual-responsive tests | `e2e/`, `tests/` | Test agent |

## Acceptance criteria
- Both themes polished; theme switch persists; no flash.
- Shell works at 360/390/768/1024/1440 with no horizontal overflow; touch targets ≥ 44 px; keyboard complete.
- Manifest valid; installability criteria verified using browser tooling (Lighthouse/DevTools/Playwright manifest checks). If an install prompt cannot be exercised headlessly, record that as a limitation and verify manifest/SW/icons programmatically.
- axe clean on style page in both themes.
- `/design` page displays every component and state.

## Testing requirements
Component tests for each component state; Playwright viewport matrix; axe in both themes; keyboard-only navigation tests; reduced-motion test; manifest/PWA checks.

## Independent review
A reviewer evaluates visual quality against the brief (screenshots at all viewports, both themes) and flags clutter or generic-looking patterns.

## Checkpoint
Standard.
