# PERSONAL VAULT — PERSONAL LIFE OS
## Master Product, Engineering, Security & Autonomous Execution Specification

Build a premium, secure, modular, offline-capable personal web application that serves as a personal digital vault and financial/life organizer.

This is a long-term project. The goal is not to create a basic CRUD application, but a polished, dependable and extensible personal platform.

---

# 1. PRODUCT VISION

Build a Personal Vault / Life OS where a person can securely manage:

- Passwords and credentials
- Multiple accounts for the same service
- Debit and credit cards
- Bank accounts
- Financial information
- Investments
- Documents and identity records
- Vehicles
- Secure notes
- Subscriptions
- Reminders
- Personal records
- Assets, liabilities and net worth
- Future modules without rebuilding the core

The product should feel like a premium, modern personal application with exceptional usability, security, performance and maintainability.

The core philosophy:

**Find → Reveal → Use**

Users should be able to find information quickly, securely reveal it when necessary, and use it with minimal friction.

This must be a real, functional application. Do not substitute working features with mockups, placeholders or fake implementations.

---

# 2. TECHNOLOGY STACK

Use the following preferred stack unless the existing repository or a compelling engineering reason requires an informed adjustment.

- Next JS (use NextJS api also for backend)
- TypeScript
- Vite
- Tailwind CSS
- Supabase
- PostgreSQL
- Supabase Auth or an appropriately designed authentication architecture
- Supabase Storage where appropriate, with encrypted file-storage considerations
- Playwright for browser-based end-to-end testing
- Appropriate unit and integration testing tools
- Modern browser APIs where appropriate

Build a modular, feature-oriented architecture.

The application is primarily a WEB APPLICATION.

It must work across desktop, laptop, tablet and mobile browsers.

Do not convert the project into an Android application.

Do not make Android development, Android emulators, Android SDKs, physical Android devices, iOS simulators or native mobile development mandatory prerequisites for the web application's development, security decisions, acceptance criteria or phase progression.

Mobile-browser compatibility and responsive design are mandatory.

---

# 3. ARCHITECTURE

Design a scalable modular architecture.

Separate:

- Application shell
- Core infrastructure
- Authentication
- Security and cryptography
- Data access
- Storage
- Synchronization
- Shared UI
- Design system
- Feature modules
- Testing infrastructure
- Platform/browser integrations

Each feature module should have clearly defined responsibilities and boundaries.

Avoid tightly coupled modules.

Adding a new module in the future should not require rewriting unrelated functionality or the application core.

Establish shared services for:

- Authentication
- Cryptography
- Data access
- Encryption
- Storage
- Cache management
- Synchronization
- Error handling
- Validation
- Notifications
- Reminders
- Search
- Permissions
- Logging
- UI state management
- Accessibility utilities

Do not force a specific folder structure before inspecting the repository. Establish an appropriate structure based on the existing project.

---

# 4. SECURITY AND PRIVACY — HIGHEST PRIORITY

Security is a fundamental product requirement.

The application will contain extremely sensitive personal information.

Treat the application as a security-sensitive product, not an ordinary web application.

## Security objectives

- Protect sensitive data at rest.
- Protect sensitive data in transit.
- Minimize plaintext exposure.
- Keep cryptographic operations client-side where appropriate.
- Never casually expose sensitive information to the backend.
- Prevent unauthorized access.
- Prevent cross-account data access.
- Prevent sensitive data from leaking through logs, error reporting, browser storage, URLs or debugging tools.
- Avoid unnecessary permissions.
- Avoid unnecessary external services.
- Avoid telemetry and tracking.

## Cryptographic architecture

Design and document a complete cryptographic architecture before implementing sensitive storage.

Evaluate and appropriately use:

- Strong password-based key derivation
- Argon2id or another appropriately justified secure KDF
- Web Crypto APIs where appropriate
- Authenticated encryption such as AES-GCM
- Secure random number generation
- Proper nonce/IV generation
- Key hierarchy
- Key separation
- Data encryption keys
- Master-key derivation
- Key rotation
- Recovery mechanisms
- Authentication and integrity verification

Do not invent cryptographic algorithms.

Do not reuse encryption keys or nonces incorrectly.

Do not hardcode cryptographic secrets.

Do not treat a database password or authentication token as the vault encryption key.

Do not assume that Supabase, HTTPS or authentication alone protects the vault's data.

## Threat model

Create and maintain a realistic threat model.

Consider:

- Malicious actors
- Database compromise
- Backend compromise
- Unauthorized account access
- Session compromise
- XSS
- CSRF where applicable
- Malicious browser extensions
- Phishing
- Weak master passwords
- Brute-force attempts
- Data leakage
- Backup compromise
- Secure-sharing abuse
- Device compromise
- Clipboard exposure
- Browser storage exposure
- Supply-chain risks
- Third-party dependency vulnerabilities

Document what the application can and cannot realistically protect against.

## Authentication

Implement an appropriate authentication system.

Separate authentication from vault encryption.

Design:

- Account authentication
- Vault unlocking
- Session management
- Reauthentication for sensitive actions
- Logout
- Session expiry
- Account recovery
- Vault recovery
- Device/session management where applicable

Never claim that authentication alone encrypts vault data.

## Logging

Never log:

- Passwords
- Master passwords
- Encryption keys
- Decrypted vault contents
- CVVs
- Full sensitive card details
- Sensitive document contents
- Private financial records
- Recovery secrets

Logs must be safe and useful.

## Security verification

Independently review:

- Cryptographic implementation
- Authentication
- Authorization
- Database policies
- Storage
- Data access
- Secure sharing
- Recovery
- Backup
- Session handling
- XSS protection
- Dependency vulnerabilities

Do not claim that the product is secure simply because tests pass.

Document residual risks honestly.

---

# 5. OFFLINE-FIRST EXPERIENCE

Design an offline-capable architecture.

Users should be able to access appropriately cached and encrypted vault information without internet connectivity where supported and configured.

Implement:

- Encrypted local persistence
- Encrypted cache
- Offline read access
- Offline-safe operations where appropriate
- Synchronization
- Mutation queues
- Conflict handling
- Sync status
- Retry logic
- Data integrity checks
- Cache invalidation
- Secure logout and cache lifecycle

Do not store decrypted sensitive data unnecessarily.

Do not store secrets in plaintext localStorage.

If local persistence is used, implement a carefully reviewed encryption strategy.

Distinguish:

- Online
- Offline
- Pending synchronization
- Synchronization failure
- Conflict
- Partial synchronization

Never silently lose user data.

---

# 6. PASSWORD MANAGER

Build a fully functional password manager.

Features:

- Create credentials
- Edit credentials
- Delete credentials
- Archive credentials
- Restore credentials
- Favorites
- Search
- Filtering
- Categories
- Tags
- Notes
- Website URL
- Username
- Email
- Phone
- Password
- Custom fields
- Copy functionality
- Reveal/hide passwords
- Password strength analysis
- Password generator
- Password history where appropriate
- Creation and modification history
- Security-aware auto-hide
- Secure handling of clipboard content

## Multiple accounts per service

Allow grouping multiple accounts under the same service.

For example, a user can have several Instagram accounts, several Google accounts or several accounts for the same website.

The service group should have:

- Group-level organization
- Group-level favorites where appropriate
- Group-level metadata
- Multiple individual credential entries
- Individual account-level favorites
- Individual account-level metadata
- Independent editing and deletion

Do not force users to create separate unrelated entries when multiple accounts belong to the same service.

## Password generator

Provide a password generator directly within credential forms.

Support:

- Adjustable length
- Uppercase letters
- Lowercase letters
- Numbers
- Symbols
- Exclusion of ambiguous characters
- Presets
- Password strength feedback
- Regeneration
- Copy
- Immediate insertion into the selected field

---

# 7. GLOBAL SEARCH

Build a powerful global search system.

Search across relevant vault data, including:

- Credentials
- Groups
- Cards
- Bank accounts
- Documents
- Notes
- Vehicles
- Investments
- Subscriptions
- Other supported modules

Features:

- Fast search
- Debounced input
- Relevant results
- Categories
- Filters
- Keyboard navigation
- Search highlighting
- Recent searches where appropriate
- Offline-compatible searching of available encrypted data
- Search-result shortcuts

Search must be thoughtfully designed around the encryption architecture.

Do not weaken security simply to enable convenient search.

---

# 8. QUICK ACTIONS

Provide convenient quick actions.

Examples:

- Add password
- Add card
- Add bank account
- Add document
- Add note
- Add investment
- Add vehicle
- Add subscription
- Scan document
- Scan card
- Scan QR code

Implement an intuitive quick-action interface.

Avoid unnecessary navigation.

---

# 9. CARD SCANNING

Implement card scanning using appropriate browser capabilities.

Features:

- Camera access when available
- Card image capture
- OCR
- Card-number extraction where appropriate
- Name extraction where appropriate
- Expiry extraction
- Manual correction
- Verification before saving
- Secure processing
- Discard captured images by default unless explicitly retained

Do not automatically extract or save CVV information.

Do not assume OCR is correct.

Allow users to verify and edit extracted information before saving.

---

# 10. DOCUMENT SCANNER

Build a functional document scanner.

Features:

- Camera capture
- Image import
- Document boundary detection where available
- Edge detection
- Perspective correction
- Cropping
- Image enhancement
- Rotation
- Multi-page documents
- PDF generation
- OCR
- Preview
- Metadata
- Encrypted storage
- Secure export
- Document categorization
- Search

OCR and document processing should use appropriately selected libraries and browser capabilities.

Do not make native Android APIs mandatory.

---

# 11. QR AND BARCODE SCANNER

Implement a browser-based QR/barcode scanner where supported.

Support useful formats and workflows such as:

- URLs
- Wi-Fi information
- Contacts
- Digital business cards
- Supported payment or informational QR formats
- Other supported structured data

Preview extracted information.

Require verification before saving sensitive data.

Never automatically trust scanned content.

---

# 12. DEBIT CARDS

Build a premium debit-card management module.

Features:

- Bank name
- Cardholder name
- Card number
- Expiry
- Network
- Card type
- Linked account
- Custom fields
- Notes
- Favorites
- Archive
- Reveal/hide
- Copy
- Secure access

Provide a realistic card visual renderer.

Support:

- Front and back visual presentation
- Card flipping
- Masking
- Reveal controls
- Appropriate card-network visual distinctions
- Bank branding where appropriate
- Customizable card appearance where practical

Do not expose CVV unnecessarily.

Do not persist sensitive card images or details insecurely.

---

# 13. CREDIT CARDS AND LIABILITY MANAGEMENT

Build a credit-card management module.

Features:

- Card information
- Credit limit
- Available limit
- Outstanding amount
- Utilization
- Billing cycle
- Statement date
- Payment due date
- Payments
- Payment history
- Outstanding balance
- Reminder integration
- Charts
- Usage history

Provide accurate financial calculations.

Credit limits are not assets.

Outstanding credit-card debt should be treated appropriately as a liability when calculating net worth.

Avoid double-counting.

---

# 14. BANK ACCOUNTS

Build a bank-account module.

Features:

- Bank name
- Account name
- Account number
- IFSC
- Branch
- Account type
- Currency
- Current balance
- Notes
- Linked cards
- Linked documents
- Account history

Allow manual balance updates.

Implement a smooth balance-update experience.

Maintain balance history when appropriate.

Do not fabricate transaction data.

Allow users to distinguish between manually recorded balances and actual synchronized balances.

Do not imply that bank integrations exist unless implemented and verified.

---

# 15. DOCUMENT VAULT

Build a secure document vault.

Support document types such as:

- PAN
- Aadhaar
- Passport
- Driving licence
- Insurance
- Certificates
- Employment documents
- Financial documents
- Personal documents
- Other custom document types

Features:

- Document metadata
- Document number
- Issue date
- Expiry date
- Issuing authority
- Attachments
- Images
- PDFs
- Secure preview
- Secure export
- Search
- Categories
- Tags
- Favorites
- Archive
- Relationships
- Expiry reminders

Treat documents and their attachments as highly sensitive.

---

# 16. VEHICLES

Build a vehicle-management module.

Features:

- Vehicle name
- Type
- Registration number
- Chassis number
- Engine number
- Manufacturer
- Model
- Purchase information
- Insurance
- PUC
- Registration information
- Expiry dates
- Documents
- Service history
- Maintenance records
- Reminders
- Notes

Support relationships between vehicles and documents.

---

# 17. INVESTMENTS

Build an investment-management module.

Support:

- Stocks
- Mutual funds
- ETFs
- Bonds
- Fixed deposits
- Gold
- Other assets
- Custom investment types

Features:

- Investment name
- Asset type
- Units
- Quantity
- Purchase date
- Purchase price
- Cost basis
- Invested amount
- Current valuation
- Profit/loss
- Broker
- Notes
- Transaction history
- Include/exclude from net worth
- Appropriate calculations

Do not fabricate live prices.

Clearly distinguish manual valuation from verified market data.

---

# 18. FINANCIAL OVERVIEW AND NET WORTH

Build a financial dashboard.

Support:

- Bank balances
- Cash
- Investments
- Assets
- Liabilities
- Credit-card outstanding
- Other debts
- Net worth
- Historical trends
- Manual adjustments
- Configurable inclusion/exclusion

Create a transparent net-worth calculation engine.

Avoid:

- Double-counting
- Treating credit limits as assets
- Incorrect liability calculations
- Mixing invested amounts with valuations
- Unclear calculation assumptions

Make calculations explainable.

---

# 19. CUSTOMIZABLE DASHBOARD

Create a customizable home dashboard.

Include configurable widgets such as:

- Net worth
- Bank accounts
- Investments
- Credit cards
- Upcoming reminders
- Documents nearing expiry
- Recent items
- Favorites
- Quick actions
- Subscriptions
- Vehicles
- Other module summaries

Allow customization where appropriate.

The dashboard should remain visually clean and not overwhelming.

---

# 20. REMINDERS AND CALENDAR

Create a unified reminder system.

Support:

- Document expiry
- Insurance renewal
- PUC renewal
- Credit-card payments
- Subscriptions
- Vehicle maintenance
- Investment-related reminders where appropriate
- Custom reminders

Features:

- Reminder dates
- Recurrence
- Notification preferences
- Calendar view
- Upcoming reminders
- Completed reminders
- Snooze
- Rescheduling
- Reminder history

Use appropriate browser notification capabilities where supported and permission is granted.

Do not assume notifications are available in every browser.

---

# 21. SUBSCRIPTIONS AND RECURRING EXPENSES

Build a subscription management module.

Features:

- Service name
- Amount
- Currency
- Billing frequency
- Billing date
- Renewal date
- Payment method
- Category
- Status
- Notes
- Reminder
- History
- Monthly and annual summaries

Support recurring expenses.

Make upcoming payments easy to track.

---

# 22. SECURE NOTES

Build a secure notes module.

Features:

- Notes
- Titles
- Categories
- Tags
- Search
- Favorites
- Archive
- Custom fields where appropriate
- Relationships
- Secure editing
- Secure storage

Treat note contents as sensitive data.

---

# 23. RELATIONSHIPS AND PERSONAL ORGANIZATION

Allow appropriate relationships between modules.

Examples:

- Documents linked to bank accounts
- Documents linked to vehicles
- Cards linked to accounts
- Notes linked to records
- Investments linked to brokers
- Reminders linked to records
- Subscriptions linked to payment methods

Create a flexible relationship architecture without creating unnecessary complexity.

---

# 24. ARCHIVE, TRASH AND ACTIVITY

Implement:

- Archive
- Restore
- Trash
- Recovery
- Permanent deletion
- Appropriate confirmation
- Activity history

Sensitive activity history must not expose decrypted data or secrets.

Implement appropriate retention and deletion policies.

---

# 25. SECURE SHARING

Design secure sharing carefully.

If implemented, support:

- Scoped access
- Expiring links
- 12-hour or 24-hour expiry where appropriate
- Server-enforced expiry
- Revocation
- Unpredictable tokens
- Minimal exposed data
- Access controls
- Audit information
- Abuse prevention

Do not rely only on frontend expiry.

Do not create insecure sharing mechanisms.

Secure sharing is an optional feature that must not compromise the vault's foundational security.

---

# 26. BACKUP AND RECOVERY

Design a robust backup and recovery architecture.

Support appropriate:

- Encrypted backups
- Backup export
- Restore
- Recovery workflows
- Integrity verification
- Versioning where appropriate
- Recovery documentation

Backups must not casually expose plaintext vault data.

Make recovery limitations understandable to the user.

---

# 27. BIOMETRICS AND AUTOFILL

Evaluate browser-compatible integrations.

Potential integrations:

- Passkeys
- WebAuthn
- Credential-management APIs where supported
- Browser autofill
- Appropriate platform authentication integrations

Implement only what is genuinely supported and secure.

Do not claim universal biometric or autofill support.

Biometrics must not replace a properly designed cryptographic vault architecture.

---

# 28. UI/UX AND DESIGN SYSTEM

Create a premium, modern and consistent design system.

The design must be:

- Clean
- Elegant
- Minimal
- Premium
- Functional
- Responsive
- Accessible
- Consistent

Establish:

- Typography
- Color system
- Spacing
- Layout
- Grid
- Navigation
- Components
- Cards
- Tables
- Dialogs
- Forms
- Dropdowns
- Tooltips
- Toasts
- Loading states
- Empty states
- Error states
- Skeletons
- Responsive patterns
- Motion
- Focus states

Avoid unnecessary visual clutter.

Avoid excessive gradients, decorative elements and oversized UI.

Use animations purposefully.

Provide a coherent design system rather than designing each module independently.

---

# 29. MANDATORY RESPONSIVE DESIGN

Responsiveness is a project-wide requirement.

The entire application must work and look polished across:

- Small mobile phones
- Large mobile phones
- Tablets
- Laptops
- Desktop displays
- Large screens

Use mobile-first design.

Every module, form, dialog, card, table, chart, navigation element and interaction must adapt appropriately.

Test representative viewports including:

- 360px
- 390px
- 768px
- 1024px
- 1440px

Use additional viewport sizes where appropriate.

Requirements:

- No unintended horizontal overflow.
- No clipped content.
- No inaccessible controls.
- No desktop-only functionality.
- Touch-friendly controls.
- Appropriate mobile navigation.
- Responsive tables and data presentation.
- Adaptive typography and spacing.
- Mobile-friendly forms.
- Responsive modal/dialog behaviour.
- Appropriate mobile-browser camera functionality where supported.
- Responsive charts.
- Appropriate keyboard behaviour.

Mobile responsiveness must not be treated as a simplified or neglected version of the application.

Responsive validation is required in every UI-building phase.

Use browser automation and actual browser viewport testing wherever available.

Do not make Android emulators or physical mobile devices mandatory for responsive acceptance.

---

# 30. ACCESSIBILITY

Implement accessibility throughout.

Consider:

- Semantic HTML
- Keyboard navigation
- Screen readers
- Accessible labels
- Focus management
- Dialog accessibility
- Color contrast
- Text scaling
- Reduced motion
- Touch targets
- Accessible errors
- Accessible loading states
- Focus indicators
- Accessible charts
- Accessible tables

Accessibility must be integrated into components and feature development, not added only at the end.

---

# 31. PERFORMANCE

Optimize throughout the project.

Consider:

- Bundle size
- Lazy loading
- Code splitting
- Unnecessary rerenders
- Data-fetching efficiency
- Request deduplication
- Batching
- Debouncing
- Caching
- Offline behaviour
- Image optimization
- Document processing
- Search performance
- Rendering performance
- Memory usage
- Error handling

Avoid unnecessary API calls.

Avoid repeatedly fetching the same data.

Use appropriate caching and synchronization strategies.

Do not sacrifice security for performance.

---

# 32. STATE AND UI RELIABILITY

Every major UI operation must handle relevant states.

Include where appropriate:

- Loading
- Empty
- Error
- Success
- Saving
- Saved
- Offline
- Pending sync
- Sync failure
- Partial failure
- Conflict
- Validation error
- Unauthorized
- Expired session

Do not allow silent failure.

Provide clear, actionable feedback.

---

# 33. TESTING

Establish a comprehensive testing strategy.

Use appropriate:

- Unit tests
- Integration tests
- Component tests
- End-to-end tests
- Browser automation
- Responsive tests
- Accessibility tests
- Security tests
- Performance tests
- Data integrity tests

Test:

- Authentication
- Encryption
- Decryption
- Key derivation
- Storage
- Synchronization
- Recovery
- Authorization
- CRUD
- Relationships
- Calculations
- Search
- Scanners
- Documents
- Reminders
- Offline workflows
- Responsive layouts
- UI states

Use synthetic data.

Do not test with real personal credentials, financial data or identity documents.

Never falsely claim that tests were run or passed.

---

# 34. WEB-ONLY DEVELOPMENT AND TESTING REQUIREMENT

This project is a web application.

Do not unnecessarily launch Android emulators.

Do not require Android SDKs.

Do not require physical Android devices.

Do not block architecture, cryptography, storage, KDF selection, implementation or phase progression on access to a physical mobile device or emulator.

Use browser-based approaches for validation.

For cryptographic performance:

- Use browser-based benchmarks where possible.
- Use representative CPU and memory constraints where tooling permits.
- Use browser profiling.
- Use documented assumptions.
- Evaluate practical browser performance.
- Measure performance on available hardware.
- Clearly distinguish measured results from simulated results.
- Document limitations honestly.

Do not invent mobile hardware benchmarks.

Do not treat the absence of a physical low-end mobile device as a blocker when defensible browser-based evidence and documented assumptions allow progression.

Mobile browser compatibility remains mandatory.

---

# 35. DEVELOPMENT ROADMAP

Execute the roadmap sequentially.

## Phase 00 — Discovery and Repository Audit

Inspect the existing repository.

Understand the existing codebase, architecture, dependencies, current state, Git history and project kit.

Establish the project specification and initial execution plan.

Do not destroy existing work.

## Phase 01 — Architecture and Foundation

Establish the modular application architecture, core infrastructure, data boundaries, shared services, application shell and foundation.

## Phase 02 — Design System, Responsive UX and Accessibility

Build the design system, navigation, reusable components, responsive foundation, accessibility standards and common UI states.

## Phase 03 — Authentication, Threat Model and Cryptography

Establish the threat model, authentication, cryptographic design, key derivation, encryption architecture and security foundations.

Use browser-based evidence and documented assumptions.

Do not block on Android emulator/device access.

## Phase 04 — Encrypted Storage, Cache, Offline and Synchronization

Implement secure persistence, encrypted cache, offline architecture, synchronization and data integrity.

## Phase 05 — Global Search, Favorites, Recent Items and Quick Actions

Implement the search and quick-action foundation.

## Phase 06 — Credential Management and Password Intelligence

Implement password manager functionality, account grouping, generators, favorites, search and security features.

## Phase 07 — Scanners, OCR, Documents and QR

Implement card scanning, document scanning, OCR, QR/barcode workflows and verification.

## Phase 08 — Debit Cards

Implement debit-card management, card visual renderer and secure card handling.

## Phase 09 — Credit Cards and Liabilities

Implement credit-card management, limits, utilization, payment history and liability calculations.

## Phase 10 — Bank Accounts

Implement bank accounts, balance updates, history and relationships.

## Phase 11 — Document Vault

Implement document management, metadata, secure attachments, relationships and expiry reminders.

## Phase 12 — Vehicles

Implement vehicle records, registration, insurance, PUC, maintenance and documents.

## Phase 13 — Investments

Implement investment records, valuations, calculations and asset classification.

## Phase 14 — Financial Dashboard and Net Worth

Implement financial overview, dashboard, net-worth engine and configurable widgets.

## Phase 15 — Reminders, Calendar and Subscriptions

Implement reminders, calendar, recurring expenses and subscriptions.

## Phase 16 — Notes, Relationships, Archive and Activity

Implement secure notes, relationships, archive, trash and activity.

## Phase 17 — Secure Sharing, Backup and Recovery

Implement carefully reviewed secure sharing, encrypted backups and recovery workflows.

## Phase 18 — Performance, API Efficiency and UI States

Optimize performance, API usage, rendering, data management and UI reliability.

## Phase 19 — Browser Integrations, Autofill and Biometrics

Implement appropriate browser/platform integrations where supported.

## Phase 20 — Comprehensive Testing and Independent Audits

Conduct comprehensive testing, security review, accessibility review, responsive validation, performance evaluation and independent code audits.

Fix identified defects.

Document remaining risks.

## Phase 21 — Release and Documentation

Finalize the application, documentation, deployment readiness, operational guidance, security documentation and release procedures.

---

# 36. PHASE GATES

Phase gates must ensure quality, not create unnecessary artificial blockers.

A phase must be sufficiently implemented, tested, reviewed and documented before being marked complete.

However:

- Do not demand evidence that is impossible to obtain in the current environment when reasonable alternative evidence exists.
- Do not make physical device availability a prerequisite for web development.
- Do not block the entire project because a particular external tool, device or integration is unavailable.
- Document limitations.
- Use alternative validation methods.
- Continue with defensible engineering decisions.
- Revisit limitations during later testing when additional tools become available.

A genuine security concern must be handled seriously.

An environmental limitation must not automatically become an architectural deadlock.

---

# 37. AUTONOMOUS EXECUTION

Execute the project autonomously.

Read all instructions before beginning.

Use the existing project kit and repository as the source of truth.

Do not merely plan the project.

Build the actual application.

Do not pause for routine approval.

Make reasonable engineering decisions independently.

Use agents strategically where available.

Assign independent tasks carefully.

Use worktrees where appropriate.

Avoid conflicting edits.

Review and integrate agent output.

Do not falsely claim agent work or verification.

Continue through all phases until completion or a genuine blocker.

---

# 38. MODEL AND RESOURCE STRATEGY

Use the available reasoning resources efficiently.

Prioritize strong reasoning for:

- Architecture
- Cryptography
- Security
- Data integrity
- Recovery
- Difficult debugging
- Independent audits

Use bounded tasks and appropriate agents for:

- Routine implementation
- Documentation
- Testing
- Independent review
- UI tasks
- Repetitive work

Do not unnecessarily consume maximum reasoning resources for trivial tasks.

Do not restart completed work merely because a model, reasoning level or session changes.

---

# 39. GIT AND CHECKPOINTS

Maintain reliable checkpoints.

At meaningful milestones:

- Review changes.
- Run relevant tests.
- Commit stable verified work.
- Push checkpoints where repository access permits.
- Update progress documentation.

Never destroy existing user work.

Never blindly reset or overwrite the repository.

Inspect Git state before modifications.

---

# 40. INTERRUPTION AND USAGE-LIMIT RECOVERY

Assume execution may be interrupted due to:

- Usage limits
- Context limits
- Session termination
- Environment interruption
- Tool failures

At every meaningful checkpoint:

Update:

- `PROGRESS.md`
- `REMOTE_PROGRESS/STATUS.md`
- `REMOTE_PROGRESS/PHASE_LOG.md`

Record:

- Current phase
- Completed tasks
- Remaining tasks
- Important architectural decisions
- Files changed
- Tests run
- Test results
- Known defects
- Security concerns
- Limitations
- Active blockers
- Exact next steps

Keep critical decisions in repository files, not only conversation context.

Commit stable verified checkpoints where appropriate.

If interrupted, inspect:

- Repository state
- Git state
- Progress files
- Phase instructions
- Current implementation

Resume from the last verified checkpoint.

Do not repeat completed work unnecessarily.

Do not blindly overwrite unfinished work.

Continue autonomously.

---

# 41. DEFINITION OF DONE

The project is not complete merely because it compiles.

Completion requires, to the extent supported by the environment:

- All roadmap phases addressed
- Core modules implemented
- Security architecture documented
- Security-sensitive implementations reviewed
- Responsive application across mobile, tablet and desktop
- Accessible interface
- Functional core workflows
- Appropriate offline support
- Data integrity
- Comprehensive tests
- Independent review
- Performance evaluation
- Documentation
- Deployment readiness
- Honest documentation of limitations and residual risks

Do not falsely claim perfection, complete security or tests that were not performed.

---

# FINAL DIRECTIVE

Inspect the repository and all project instructions.

Reconcile the project kit with the existing codebase.

Establish or update the Codex-native AGENTS.md instructions.

Then execute the roadmap autonomously from the first incomplete phase through Phase 21.

Build a genuinely functional, secure, responsive, premium Personal Vault web application.

Do not unnecessarily launch Android emulators.

Do not block the project on physical mobile-device availability.

Do not pause for routine approval.

Maintain progress, checkpoints, tests, reviews and interruption-recovery documentation.

Start immediately and continue working until the project is complete or a genuine blocker prevents further progress.


Provide an option to save email addresses and mobile numbers.



Suggest saved email addresses and mobile numbers in relevant email and phone fields.



Make the website installable on phones as a PWA, if possible. If Android Studio or other native development tools are required and aren't already available, don't install or use them.



Keep everything minimal, clean and uncluttered. The interface should not feel overloaded with too many options.



Use aesthetically pleasing fonts and create a genuinely modern design. Avoid a generic AI-generated look. Design and user experience should be the application's main USP.



Add both light and dark themes.



In the Notes section, include an option to save and organize ideas as well.