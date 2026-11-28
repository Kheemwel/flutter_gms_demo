# Flutter GMS Demo — Tasklist

## Legend

- [ ] Not started
- [x] Done
- Phases are ordered — finish each before starting the next unless you intentionally reorder.
- Bugs come first so cleanup has a stable baseline to test against.
- File uploads/downloads and image assets are deferred (skip all file I/O related items for now).

---

## Phase 1 — Bugs (small, unblocks everything else)

### Audit Trail

- [x] Login / logout actions are not being recorded — fixed (circular dependency in `AuditLogsNotifier` removed; `log()` now takes `userFullName` explicitly).
- [x] Form/request actions are not being recorded — fixed (approve, disapprove, create form, submit form, edit form, sign form, complete form, delete form all now log).
- [x] Sign Form / Complete Form audit writes were previously skipped when a form had no other participants — fixed.
- [x] Duplicate `Sign Form` audit log inside `sign()`'s completion block — removed.
- [ ] (moved to Phase 3) Other features' writes are still unlogged — see "Audit coverage" in Phase 3.

### Persistence — single source of truth for users

- [x] Auth reads from `seedUsers` instead of the app's user table — fixed.
- [x] Async signature for `changePassword` and `updateOwnProfile` (`Future<String?>`) — done.
- [x] Profile Save button is disabled until the form is dirty — done.

### Fill Out Forms

- [x] Convert all fields to their proper input type.
- [x] Prefill inventory-derived fields at form creation.
- [x] Prefill `adviser` with the selected teacher's name.
- [x] Home visitation creation now uses `RadioGroup` + `RadioListTile` for single-select student.
- [x] Home visitation student picker no longer crashes when the selected student has no linked parent.
- [x] Archived parents/principals are excluded from lookups in creation and approval paths.
- [x] Teacher-side picker has an empty-state message when no parented students are available.

### Student: My Records

- [x] Tab contents are empty on first load.
- [x] "Sign as student" does not reflect immediately.

### Parent: My Child Records

- [x] Tab contents are empty on first load.
- [x] "Sign as parent" does not reflect immediately.

### Guidance: Students

- [x] Deleting an anecdotal record does not reflect immediately.
- [x] Individual inventory and anecdotal record are empty on first load.
- [x] Writing a new anecdotal entry does not reflect immediately.

---

## Phase 2 — Missing Must-Do Features

### Profile & Password

- [x] Add Profile page (view own profile; edit own name/email; dirty-state Save button).
- [x] Add Change Password flow (verifies current password; enforces rules; clears `mustChangePassword`).
- [x] Reinstate the `mustChangePassword` banner on the dashboard (linking to the change-password page).

### User Manual

- [x] Add a user manual / help page describing what the app is about and how to use it.
- [x] (follow-up) Add the Help entry to the sidebar (`_navItems`) if not already present, or keep it top-bar-only if that's the chosen design. Verify discoverability on narrow viewports after the responsive work in Phase 2.5.
- [x] Make User Manual / Help Page responsive with a bottom sheet table-of-contents navigation.

### Signing

- [x] Add a real e-signing pad (`signature: ^6.4.0`).
- [x] Integrate the signing pad wherever signatures are currently stubbed.
- [x] Signature preview widget renders the stored data URL inline.

### Student Inventory Authoring

- [x] Add UI to create/edit a `StudentIndividualInventory`. Dialog opened from the student detail dialog's Inventory tab, gated by `manageStudentInventory`. Audit logs on create/update.

### Student Parent Management

- [x] Add UI to link/unlink parents to students. **Decision:** mutation happens only in **account management** (User Accounts → Add user / Edit user). The student detail dialog's "Parents" tab was removed.
- [x] Student account form: **multi-select parent picker** (`_ParentCheckboxPicker`). Parent(s) can be changed on edit; diff logic calls `linkChildToParent` / `unlinkChildFromParent` per added/removed parent.
- [x] Parent account form: child picker remains multi-select; children are now **optional** (validation removed).
- [x] Both pickers filter out archived accounts.
- [x] **Known architectural flaw kept:** home visitation forms have a single `parentId` participant. Multiple linked parents → form picks the first. Matches the original FLAGMS design. See Phase 5.

---

## Phase 2.5 — Responsive Layout (NEW — Must Do)

Goal: the app should be usable on mobile-width viewports (phones and small tablets) as well as desktop/web. Every screen listed below must pass a manual test at 375×812 (iPhone SE/13 mini baseline) and 768×1024 (iPad portrait baseline) without horizontal scrolling, clipped content, or overlapping widgets.

### Shell and navigation

- [x] **Sidebar collapses on narrow viewports.** Below a breakpoint (~900px), replace the persistent 260px sidebar with either a `Drawer` opened by a hamburger icon in the top bar, or a `NavigationBar` at the bottom. Pick one and be consistent — do not mix.
- [x] **Top bar adapts.** At mobile widths, collapse the user name + email next to the avatar (hide them, leave the avatar + dropdown). Help and notification icons stay. Hamburger (if using Drawer) gets added to the leading edge.
- [ ] **Content area expands** to fill the freed-up width when the sidebar collapses.

### Tables

- [x] **`AppDataTable` supports horizontal scroll + `mobileTileBuilder`** — wraps `DataTable` in horizontal/vertical `SingleChildScrollView`s, switches to a `ListView` via `mobileTileBuilder` below `mobileBreakpoint` (768px), and includes client-side sorting (`sortBy`) + pagination.
- [x] **Update remaining `AppDataTable` callers** with `sortBy` and `mobileTileBuilder`: `requests_by_status_tab.dart`, `schedule_tags_tab.dart`, `item_table.dart`, `tags_tab.dart`, `categories_tab.dart`, `levels_tab.dart`, `offenses_tab.dart`.
- [x] **Migrate raw `DataTable` pages to `AppDataTable`**: `roles_page.dart` and `user_accounts_page.dart`.

### Two-column layouts

- [ ] **Dashboard `_TwoColumn`** already stacks below 900px — verify it works and doesn't overflow.
- [x] **Guidance Program calendar + day detail** — below 720px, displays only the calendar (scrollable with `compact` grid sizing on short viewports) and opens a full modal bottom sheet on day tap; tapping an event swaps the sheet content to event details via `AnimatedSwitcher` with a back button.
- [x] **Help page two-pane nav + content** — the left nav (280px) + content pane collapses to a single-pane reading view on narrow viewports below ~900px, with a Topics button opening a table of contents drawer on demand.

### Dialogs

- [x] **Guidance Program dialogs** — `event_form_dialog.dart` switches to `Dialog.fullscreen` below 720px; `schedule_tag_form_dialog.dart` switches to a full modal bottom sheet below 720px; `view_event_dialog.dart` is handled inline inside the day-events bottom sheet on small screens.
- [ ] **Remaining dialogs** with `ConstrainedBox(maxWidth: …)` need to relax to `maxWidth: double.infinity` (or use `Dialog.fullscreen` / bottom sheets) on narrow viewports. Check: `user_form_dialog.dart`, `inventory_form_dialog.dart`, `write_anecdotal_dialog.dart`, `fill_form_dialog.dart`, `create_form_dialog.dart`, `new_request_dialog.dart`, `approval_details_dialog.dart`, `signature_pad_dialog.dart`, `view_user_dialog.dart`, `student_detail_dialog.dart`.
- [ ] **Signature pad** — the pen area should size to viewport width on mobile.

### Specific screens to spot-check

- [ ] **Login page** — form fields stack, buttons remain full-width, no overflow.
- [ ] **Dashboard** — KPI strip wraps to 2 columns (or 1) below ~600px instead of forcing 3 across.
- [ ] **User Accounts** — filters row (search + role dropdown) stacks vertically below ~600px.
- [x] **Forms list** — already uses `AppDataTable` with `mobileTileBuilder`; spot-check at 375×812 and 768×1024.
- [ ] **Profile page** — form fields and cards stack, no overflow.
- [x] **Audit Trail** — already uses `AppDataTable` with `mobileTileBuilder`; spot-check at 375×812 and 768×1024.
- [ ] **Notifications** — cards already stack, verify no overflow.

### Verification

- [ ] Manual test at 375×812 (mobile), 768×1024 (small tablet), and 1440×900 (desktop) for each major route.
- [ ] Use `flutter run -d web-server` and resize the browser window, or use browser devtools mobile emulation.
- [ ] No `RenderFlex overflowed` warnings in the console at any width.

---

## Phase 3 — Code Clean-up

### Redundancy

- [ ] Reduce redundancy: unify similar-looking widgets into reusable components.
- [ ] Reduce redundancy: extract repeated logic/computation into shared utility functions.
- [ ] Use extensions to reduce verbosity, boilerplate, and redundancy.
- [ ] Use extension types for models where they add clarity and safety.

### Hygiene

- [ ] Remove TODO comments that are already fulfilled.
- [ ] Sweep for deprecated and legacy Riverpod/Flutter APIs and replace with current equivalents.
- [ ] Add `assert(tabs.length == children.length)` to `AppTabs` constructor so mismatches fail with a clear message instead of a deep Material assertion.

### Riverpod & State

- [ ] Create a provider extension per feature to reduce `ref.watch(...)` / `ref.read(...)` noise at call sites.
- [ ] Use `Consumer` (or extracted `ConsumerWidget`) for granular rebuilds wherever practical.
- [ ] Where appropriate, migrate ad-hoc state to dedicated classes.
- [ ] Remove all remaining direct imports of `data/in_memory/seed_users.dart` outside of the repository/seed layer.

### Audit coverage

- [ ] Audit every mutating action across the remaining features: Guidance Program (create/edit/delete event, tag CRUD), Lost & Found (item CRUD, claim/unclaim, type/tag CRUD), Offenses (all four entities' CRUD), Content Management (site content save), User Accounts (verify every archive/unarchive/delete/create/update logs — some may have been missed).
- [ ] Audit anecdotal sign actions (`setStudentSignature` / `setParentSignature`) — signatures currently don't log.
- [ ] Audit anecdotal create/delete from the student-records feature.
- [ ] Audit parent-student link/unlink actions — verify audit entries fire for all mutation paths (currently logged at the form call site, not inside the notifier).

---

## Phase 4 — Routing & Async

### Routing

- [ ] Migrate to typed GoRouter routes (`go_router_builder`).
- [ ] Introduce dynamic routing where possible — including routes for tabs.

### Async

- [ ] Migrate data providers to proper async patterns (`AsyncNotifier`).
- [ ] Show skeletons or loading indicators on first load and on slow operations.

---

## Phase 5 — Could Do (pick at will)

### UI

- [ ] Restructure main layout: remove header-of-sidebar, extend AppBar left, place sidebar below/beside content.
- [ ] Replace the landing page's quick-login role buttons with a proper marketing-style landing page.
- [ ] Add a dev-mode floating panel: quick sign-in, seed/reset data, other debugging actions.
- [ ] Clean up the UI to feel professional while still respecting Material Design and the original layout/structure.
- [ ] Add randomized artificial delay to data fetches to simulate network latency and exercise loading indicators/skeletons.
- [ ] Expand dashboard with charts or visual summaries where useful.

### Toast System (NEW)

- [ ] **Replace full-width SnackBars with a custom toast overlay.** Currently `ScaffoldMessenger.showSnackBar` produces full-width blocks that overlap the sidebar's Logout button. Evaluate two approaches:
  - **Approach A — Custom toast overlay:** a top-center or top-right floating pill (~300px max width) that auto-dismisses after 3s. Rendered via an `Overlay` entry or a top-level `Scaffold` that hosts a `Stack` with the toast. Requires either (a) a Riverpod-managed toast queue, or (b) a static toast service accessible from anywhere. Pros: full control over position, width, stacking, animation. Cons: some plumbing.
  - **Approach B — Constrain SnackBar width:** keep `SnackBar` but wrap the content in a fixed-width `SizedBox` (e.g., `SnackBar(width: 400, behavior: SnackBarBehavior.floating)` — the `width` param exists in newer Flutter versions and combines with floating). Pros: minimal change, keeps standard Material widget. Cons: limited to one position (bottom), can't easily do top toasts.

  **Decision criteria:** if the app has ~10+ success/error message call sites, approach A pays off; if it's fewer, approach B is enough. Either is Material 3–compliant — SnackBar's spec explicitly permits alternatives when the default would obstruct critical UI, which is exactly the Logout-button case. The important thing is **consistency**: pick one approach and use it everywhere. Do not mix SnackBar and toast for the same class of message.

- [ ] (after choosing an approach) Audit every `ScaffoldMessenger.showSnackBar` call site and migrate to the chosen system. Grep for `showSnackBar` to find them all.

### Redesign Home Visitation Form for Multiple Parents

- [ ] **Home visitation form currently supports only one parent signer.** If a student has multiple parents linked, the form picks the first one it finds. Redesign to either:
  - Support multiple parent signers (each parent signs their own slot), or
  - Explicitly require the form creator to pick one "primary parent" when creating the form.

### User Account Detail Improvements

- [x] **View student dialog and student profile page display linked parents.**
- [x] **Parent's children list shows names instead of IDs.**
- [ ] (refactor note) `_childrenDisplay` / `_parentsDisplay` are currently duplicated between `view_user_dialog.dart` and `profile_page.dart`. Extract to a shared helper (e.g., `lib/shared/utils/link_display.dart`) — tracked as part of Phase 3 "extract repeated logic."

### Persistence

- [ ] Add local offline persistence (replace in-memory stores) while keeping the ability to seed/reset via the dev panel.
- [ ] Ensure "reset demo data" (from the future dev panel) re-seeds `UserAccountsNotifier` from `seedUsers`, resets `Auth._passwords`, and clears audit/notification state.

### Dashboard UX

- [ ] Decide: clicking a "Needs Attention" item should navigate to the page, open the form directly, or both.
- [ ] Decide: clicking an "Upcoming Schedule" item should navigate to the calendar or open the event's detail immediately.

### Access Fixes

- [ ] Admin sidebar shows "My Records" but the page is student-only; hide it for admin (or make the empty state clearer).
