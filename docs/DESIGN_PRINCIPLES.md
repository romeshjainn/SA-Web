# Design Principles

Covers spec §28–§30 and the addendum: **minimal, clean, uncluttered; modern; distinctive fonts; light and dark themes; design/UX is the main USP.**

## Direction

- **Calm, premium, editorial-meets-instrument.** Quiet surfaces, confident typography, generous whitespace, restraint. Think "well-made personal tool", not "SaaS template".
- Avoid the generic AI look: no purple-to-blue gradient heroes, no glassmorphism everywhere, no emoji as icons, no stock card-grid-of-three layouts, no oversized rounded blobs, no gratuitous shadows, no default Tailwind palette untouched, no decorative clutter.
- Establish a **distinct identity** in Phase 02 via the design brief (`docs/design/BRIEF.md`, seeded by the kit with fixed requirements and three directions to explore) — Phase 02 builds the directions, chooses one and records it as an ADR. Show it in real components, not mock images.

## Minimalism rules

- One primary action per screen. Secondary actions grouped; advanced options behind progressive disclosure ("More").
- Default views show only the essentials; details open in a side sheet/dialog.
- ≤ 5 primary navigation destinations on mobile (bottom bar) — the rest in a "More" sheet and the command palette.
- Dashboard shows few, well-chosen widgets by default; extra widgets are opt-in.
- Empty states are helpful and short. Copy is plain, calm, and specific.

## Typography

- Choose a **modern, characterful pairing** (self-hosted, `font-display: swap`, subset, variable where possible; no third-party font CDN at runtime). Candidates to evaluate: a refined grotesk or geometric sans for UI (e.g. Geist, Inter Tight, General Sans, Instrument Sans, Bricolage Grotesque for headings) plus a mono for secrets (e.g. Geist Mono, JetBrains Mono, IBM Plex Mono). Pick after a quick visual comparison; record in ADR. Verify licences allow self-hosting.
- Fluid type scale; tabular numerals for money; mono with clear 0/O and 1/l/I distinction for passwords.

## Colour and themes

- Semantic design tokens (CSS variables) for surface, text, border, accent, success/warn/danger, focus; **light and dark** are first-class, each hand-tuned (not auto-inverted). System preference by default with manual override persisted.
- Contrast: WCAG AA minimum (AAA for body text where feasible). Test both themes.
- One restrained accent colour (plus semantic colours); card-network visuals are the main colourful elements.
- Theme-flash prevention (set theme before first paint).

## Layout and responsiveness

- Mobile-first. Breakpoints verified at 360, 390, 768, 1024, 1440 (+320/1920 sanity).
- Mobile: bottom navigation + floating quick-action; sheets instead of centered modals; large touch targets (≥ 44px); safe-area insets; no hover-only affordances.
- Desktop: sidebar or compact rail, command palette (`Ctrl/Cmd+K`), split list/detail.
- Tables become stacked cards or horizontally-scrollable regions *within a container* (never page-level overflow).

## Motion

Purposeful, short (120–240ms), ease-out; used for state change, reveal/hide, card flip, sheet transitions. Honour `prefers-reduced-motion` (replace with fades/instant).

## Components (design-system checklist)

Typography, colour, spacing, layout, grid, navigation, buttons, inputs, selects/dropdowns, forms, cards, tables, dialogs/sheets, tooltips, toasts, loading/skeletons, empty states, error states, badges, tabs, charts, focus states. Each with documented states and a11y behaviour. A living style page at `/design` (dev-only) shows everything in both themes.

## Accessibility

Semantic HTML, keyboard navigation, screen-reader labels, focus management and traps in dialogs, visible focus rings, colour contrast, text scaling to 200%, reduced motion, ≥ 44px touch targets, accessible errors/loading/charts/tables (text alternatives, data tables for charts).
