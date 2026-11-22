# Dependencies Policy

Single Next.js project; one `package.json` and lockfile. Install only what a phase needs, when it needs it. Pin exact versions (lockfile committed; `npm ci` in CI). Record the resolved versions in the ADR or `PROGRESS.md` when installed — **the kit deliberately does not state version numbers, which must be taken from the registry at install time.** If package installs are unavailable (network off), record the limitation and continue with what is possible.

## Forbidden

| Item | Why |
|---|---|
| `vite`, `vitest`, `@vitejs/*`, `vite-*` plugins | Next.js only (ADR-0001); Jest replaces Vitest |
| Separate backend frameworks/servers (`express`, `fastify`, `koa`, `@nestjs/*`, standalone Node API) | Backend = Next.js Route Handlers/Server Actions |
| Monorepo tooling (turborepo, nx, workspaces) | Single project |
| Analytics/telemetry/error-reporting SaaS SDKs (Sentry, GA, etc.) | No telemetry/tracking |
| Runtime third-party CDNs for scripts/fonts | Self-host; strict CSP |
| Android Studio/SDK, emulators, Capacitor/Cordova/React Native, iOS simulators | Web-only |
| Home-grown cryptographic primitives | Use vetted primitives only |

## Core (Phase 01)

| Package | Purpose |
|---|---|
| `next`, `react`, `react-dom` | Framework (App Router) |
| `typescript`, `@types/*` | Strict TypeScript |
| `tailwindcss` (+ `postcss`/`autoprefixer` as the installed Tailwind version requires) | Styling via design tokens |
| `@supabase/supabase-js`, `@supabase/ssr` | Supabase access (server and browser, RLS-first) |
| `zod` | Validation shared by client and Route Handlers |
| `server-only`, `client-only` | Enforce runtime boundaries |
| `eslint`, `eslint-config-next`, boundary-rule plugin (e.g. `eslint-plugin-boundaries` or import restrictions), `prettier` | Lint/format |
| `supabase` (CLI, dev) | Local DB, migrations |

## Testing (Phase 01 onward)

| Package | Purpose |
|---|---|
| `jest`, `jest-environment-jsdom`, `@types/jest` (via `next/jest`) | Unit/integration/component runner (SWC transform, no Babel/Vite) |
| `@testing-library/react`, `@testing-library/user-event`, `@testing-library/jest-dom` | Component tests |
| `jest-axe` | Component-level a11y |
| `@playwright/test` (+ browsers) | E2E, responsive, PWA, offline, virtual authenticator |
| `@axe-core/playwright` | Page-level a11y |

## Security/crypto (Phase 03–04, 17, 19)

| Candidate | Purpose | Notes |
|---|---|---|
| Web Crypto (built-in) | AES-GCM, HKDF, CSPRNG, key wrapping | Preferred |
| Argon2id WASM (e.g. `hash-wasm` or `argon2-browser`) | Password KDF | Choose via ADR with licence/maintenance/audit review and measured browser benchmarks |
| `@simplewebauthn/server` + `@simplewebauthn/browser` (or direct WebAuthn) | Passkeys (Phase 19) | ADR; verify maintenance |
| `@zxcvbn-ts/core` (+ language packs) | Offline password strength | Self-hosted dictionaries |

## Data, finance, time

| Candidate | Purpose |
|---|---|
| `idb` | IndexedDB wrapper (encrypted store) |
| `decimal.js` or `big.js` | Money arithmetic — never floats |
| `date-fns` (+ `date-fns-tz`) or Temporal polyfill | Date/recurrence logic (ADR) |
| `rrule` or an in-house recurrence subset | Reminders recurrence (ADR) |

## Scanning, documents, media (Phase 07, 11)

| Candidate | Purpose |
|---|---|
| `tesseract.js` (self-hosted worker/core/language data) | On-device OCR |
| OpenCV.js build or a lightweight edge-detection alternative | Document boundary/perspective (ADR; mind bundle size, lazy-load) |
| `jscanify` or custom | Optional document-scan helper (evaluate) |
| `pdf-lib` | PDF generation |
| `pdfjs-dist` | PDF preview |
| `BarcodeDetector` (native) + `zxing-wasm`/`barcode-detector` polyfill | QR/barcode |

## UI

| Candidate | Purpose |
|---|---|
| Headless primitives (e.g. Radix UI / React Aria) | Accessible dialogs, menus, comboboxes — evaluate vs custom, ADR |
| `clsx`/`tailwind-merge`, `class-variance-authority` | Class composition |
| Chart library (e.g. Recharts or visx) | Charts with accessible table fallback (ADR) |
| `next/font/local` + self-hosted font files | Fonts, no CDN |
| PWA: hand-written `public/sw.js` or `serwist` (Next.js integration) | Service worker (ADR in Phase 02/04) |

## Rules

1. Every new dependency: purpose, licence check, maintenance/security review (`npm audit`), bundle-size impact, and (for security-relevant libs) an ADR.
2. Prefer built-in browser/Next.js capabilities over packages.
3. Lazy-load heavy libraries (OCR, OpenCV, PDF) with dynamic `import()`.
4. Run `npm audit` at each phase gate; review supply-chain risk for WASM/crypto/OCR packages in Phase 20.
5. A forbidden item discovered in `package.json`, configs or lockfile is a defect — remove it (`validate-kit.sh` and Phase 01 include a grep check).
