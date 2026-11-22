# Design Brief — Personal Vault

Status: **seeded by the kit; finalised in Phase 02.** Design and UX are the product's main USP (spec addendum A04–A06, S28). Read with `docs/DESIGN_PRINCIPLES.md`.

## Fixed requirements (not up for debate)

- Minimal, clean, uncluttered; the interface must never feel overloaded with options. One primary action per screen; advanced options behind progressive disclosure.
- Genuinely modern and distinctive. **Not** a generic AI/SaaS look.
- Aesthetically pleasing, characterful fonts (self-hosted; no runtime CDN).
- **Light and dark themes**, each hand-tuned; system preference by default, manual override persisted, no flash on load.
- Mobile-first and fully responsive (360/390/768/1024/1440); installable PWA feel (standalone display, safe areas, theme colours).
- Find → Reveal → Use: search is always one gesture away; secrets are masked until deliberately revealed; copy/use is one tap.
- Accessible: WCAG AA contrast minimum, keyboard complete, reduced-motion respected, touch targets ≥ 44 px.

## Anti-patterns to avoid

Purple-to-blue gradient heroes; glassmorphism everywhere; emoji as icons; three-card feature grids; oversized rounded blobs; heavy drop shadows; untouched default Tailwind palette; decorative clutter; dashboards crowded with widgets; modal-on-modal flows.

## Personality

Calm, private, precise, quietly premium — a well-made personal instrument, not a corporate tool. Confident typography and whitespace do the work that ornament usually does. Copy is plain, specific and reassuring ("Locked. Your vault is encrypted on this device.").

## Directions to explore (Phase 02 builds each as real components, then chooses one)

| Direction | Idea | Type | Colour | Signature detail |
|---|---|---|---|---|
| **A. Quiet Ledger** | Editorial, like a private notebook/ledger | Characterful serif or soft grotesk for headings + clean sans UI + mono for secrets | Warm paper neutrals (light); deep ink with warm greys (dark); one muted accent | Hairline rules, generous margins, tabular numerals for money |
| **B. Instrument** | Precision tool, like a good watch face | Sharp grotesk (e.g. Geist / Instrument Sans class) + crisp mono | Cool graphite and bone; one saturated accent used sparingly | Fine grid alignment, subtle state indicators, compact density options |
| **C. Atelier** | Soft, spacious, tactile | Rounded-but-refined sans with a display face for numbers | Off-white and charcoal; a single warm accent | Large calm numerals, soft but not blobby shapes, tactile card flips |

Evaluate each on: distinctiveness, calm/minimal feel, legibility of secrets (0/O, 1/l/I), money readability, both themes, small-screen density, and how well the payment-card visuals sit inside it. Pick one (or a deliberate hybrid) and record the choice in an ADR.

## Typography requirements

- Pairing: UI sans + display/numeric face (optional) + monospace for passwords/numbers. Variable fonts, subset, `font-display: swap`, loaded with `next/font/local` from self-hosted files.
- Candidates to compare visually (verify licences allow self-hosting): Geist / Geist Mono, Instrument Sans, Inter Tight, General Sans, Bricolage Grotesque, Fraunces or a similar soft serif, JetBrains Mono, IBM Plex Mono.
- Fluid scale; tabular numerals for money; clear glyph distinction in mono.

## Colour requirements

- Semantic tokens only (surface, surface-raised, text, text-muted, border, accent, success, warning, danger, focus, overlay). Light and dark authored separately; never auto-inverted.
- Verify contrast for text, borders and focus rings in both themes. Card-network visuals are the main saturated colour on screen.

## Layout and navigation

- Mobile: bottom bar (≤ 5 destinations) + floating quick action; sheets instead of centred modals; safe-area insets.
- Desktop: compact sidebar/rail, `Ctrl/Cmd+K` palette, split list/detail.
- Dashboard: few well-chosen widgets by default, everything else opt-in.

## Motion

120–240 ms ease-out for reveal/hide, sheets, card flip and state changes. Replace with fades/instant under `prefers-reduced-motion`.

## Deliverables of Phase 02 for this brief

1. Each direction built as real tokens + 5–6 core components (button, input, list row, card, sheet, payment card) in both themes.
2. Screenshots at 360/390/768/1024/1440 in `docs/design/exploration/`.
3. The chosen direction recorded in an ADR (e.g. ADR-0003) with reasons, rejected alternatives, final font and colour choices and licences.
4. This brief updated with a **"Decision"** section at the top stating the final direction.
5. The living style page `/design` reflecting the decision.
