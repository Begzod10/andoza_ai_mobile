# AndozaAI Design Rebuild — Construction Plan (v2, post-review)

## Objective
Bring every screen of `tamir_uy_mobile_flutter` to a **100% pixel-and-copy-accurate match** to the approved AndozaAI design spec — not structurally similar, not "close enough." Every color, spacing value, piece of Uzbek copy, and interaction described in the spec must be reproduced exactly. This also requires completing the delta-calculation business-logic layer (partially started, not finished) and reconciling/wiring every screen-to-screen navigation exactly as annotated in the spec.

## What changed since v1
This plan was drafted once, then adversarially reviewed by a strongest-model agent, then checked against (a) a parallel React Native implementation of the same spec and (b) a full inventory of what already exists in this Flutter codebase. All three passes found the same thing from different angles: **this is not a greenfield 55-screen build.** A meaningful fraction of the models, providers, and even some screens already exist and are partially correct. The plan below reflects that — every step now starts with "audit what's here" before "build."

## Non-negotiable acceptance bar (applies to every step)
For every screen touched, "done" means all of the following, verified against the source files below — not against memory of what the screen "should" look like:
1. **Copy** — exact Uzbek strings from the spec (no paraphrasing, no English placeholders).
2. **Colors/tokens** — exact hex values from the spec's design-tokens section, applied via the shared token file, never hardcoded per-screen.
3. **Layout** — matches the corresponding frame in `UyTamir Final.dc.html` (open in a browser, screenshot/inspect, compare side by side with the Flutter screen on the emulator).
4. **Business logic** — delta mechanic (only the difference between current and finished state is ever shown/priced), room-state gray-vs-blue state coding, electrical strictly last.
5. **Navigation** — matches the "Button wiring" table exactly (source → button → destination).

A step is not complete if it "renders without errors." It is complete when a side-by-side comparison against the spec shows no visible or textual difference, AND (per Step 13) a committed per-screen checklist file records that comparison — not just a verbal claim.

## Source of truth (read these, do not re-derive from memory)
- **Full spec (design tokens, all 55 screens described screen-by-screen, business rules, button-wiring table):**
  `/tmp/claude-1000/-home-rimefara/d2698f68-7fa3-49d0-b150-cd7deba205b1/scratchpad/design_zip/design_handoff_uyremont/README.md`
- **Hi-fi HTML mockup (open in a browser — every screen is a labeled frame on one canvas, exact pixel layout):**
  `/tmp/claude-1000/-home-rimefara/d2698f68-7fa3-49d0-b150-cd7deba205b1/scratchpad/design_zip/UyTamir Final.dc.html` (load alongside `support.js` in the same folder).
- **Brand assets:** `.../design_zip/assets/andozaai-mark.png` and `andozaai-lockup.png`.
- **Reference implementation (React Native — NOT the codebase to edit; use for business-logic and pattern reference only, translate RN idioms to Flutter/Riverpod idioms, do not copy code style):**
  `/home/rimefara/projects/tamir_uy_mobile/src/theme/tokens.ts`, `src/components/DeltaProgressBar.tsx`, `src/screens/C2_DragAnimation.tsx`, `src/store/deltaStore.ts`, and the `src/screens/` tree generally.
  See "RN reference map" below for exactly which batches are usable there and which are not.
- **Target codebase:** `/home/rimefara/projects/tamir_uy_mobile_flutter` (Flutter, Riverpod, GoRouter, Freezed, Dio — see `docs/development/QUICK_REFERENCE.md` for conventions).

## RN reference map (what's actually usable to port from `tamir_uy_mobile`)
Verified by direct file inspection, not assumed:
- **Batch A** — 9/9 screens present (`A1_Home` … `A9_Summary`), matches spec numbering exactly. Good reference.
- **Batch B** — only 3/4 (`B1_RoomState`, `B1a_SurfaceStateSheet`, `B2_3DEntry`, `B3_OnboardingRail`) — no B4 there either (spec itself only has 4 named B-screens with B1-alt as a sub-sheet, so this is likely fine, but verify against README directly).
- **Batch C** — 9/9 present. Good reference, including the one real drag-gesture implementation (`C2_DragAnimation.tsx`, using `react-native-gesture-handler` `PanGestureHandler` + `reanimated` — translate the *pattern* (live hit-testing during drag, spring-back on invalid drop, domain callback on valid drop) to Flutter's `GestureDetector.onPanUpdate`, not the library).
- **Batch D** — ⚠️ **DO NOT PORT the RN "live" D-folder** — it's about furniture-room-selection/plumbing/HVAC, and HVAC does not appear anywhere in the actual spec. There's an abandoned `screens/_archive_D/` folder there that's closer to the real (electrical-focused) spec content, but still verify every screen against the README text directly rather than trusting either RN version.
- **Batch U** — only 1/5 (`U1_ContractorSearch`, under `screens/Contractors/`, not `Masters/`). U2-U5 don't exist in RN at all — Flutter is on its own for those.
- **Batch S** — 7/7 present, matches spec exactly. Good reference.
- **Batch E** — only `E1_Smeta.tsx` and `Profile/E4_ProfileHome.tsx` exist. E2/E3/E5/E6/E7/E8/E10/E11 don't exist in RN — Flutter is on its own for those.
- **Tokens** (`src/theme/tokens.ts`) — organized as **semantic nested groups**, not a flat palette: `colorTokens.primary[50-900]`, `colorTokens.roomState.{korobka,suvoq,shpaklovka}`, `colorTokens.delta.{completed,inProgress,upcoming,skipped}`, `colorTokens.measurement.{lidar,photo360,manual,captured,pending}`, plus `typographyTokens` (named `fontSize` scale + a `styles` map of preset `h1-h5`/`body*`/`label*`/`caption` combos), `componentTokens` (per-component defaults: button/card/input/bottomSheet/progressBar/badge sizing). **Port this grouping structure to Flutter's `DesignTokens`, not just flat hex constants** — later screens will want to reference `DesignTokens.delta.completed`, not a flat `deltaCompletedGreen`. Where this file's values conflict with the README's "Updated design tokens" section (it predates that revision), **the README wins** — but they mostly agree (`primary 600 = #1E3A8A`, `success 600 = #16A34A`, `warning 500 = #F97316` all match).
- **`DeltaProgressBar.tsx`** — props `completedStages: number[]`, `skippedStages: number[]`, `inProgressStage?`. Priority order for segment color: skipped > completed > inProgress > default-by-index. **Critical:** there is no derivation function anywhere in RN that computes `completedStages`/`skippedStages` from a `roomState` — screens just pass hardcoded literal arrays. **The delta-derivation pure function is new work in both codebases, not something to port** — design it fresh from the README's business rules (Step 2).
- **8-stage canonical list, confirmed from RN's `STAGES` constant:** `[Suvoq, Shpaklovka, "Bo'yoq/Oboi", Pol, Mebel, Elektr, Yorug'lik, Santexnika]` (0-indexed) — note **Mebel (furniture) at index 4, before Elektr at index 5**, consistent with the spec's "electrical is always last" rule. **Adopt this exact list as the canonical stage taxonomy for Step 2** — it resolves the 6-vs-7-vs-8 contradiction the adversarial review flagged (A2/E5's "X/8" bar uses all 8; the B/C/D stage-line rail groups some of these; E1's stage-priced-rows list is a grouped view of the same 8, not a separate taxonomy).
- `deltaStore.ts` (496 lines) has a richer `DeltaPhase{id,name,stage,order,tasks[]}` model than any RN screen actually consumes — worth reading in full before finalizing Step 2's Dart model shape as a conceptual reference, even though it's not directly portable.

## Existing Flutter codebase reality (per-directory verdict — extend vs. rewrite)
Verified by direct file inspection. **No orphaned screens and no dead routes exist today** — every screen has a router path and every router path resolves to a real file. That will change as this rebuild retires superseded files; Step 12 must clean those up.

**Models (`lib/models/`) — extend, do not replace:**
- `design_selection_model.dart` — already has `SurfaceCondition` (raw/plastered/puttied = korobka/suvoq/shpaklovka) + `RoomCondition{wall,floor,ceiling}`, explicitly commented for delta calc. **This is roughly half of Step 2's planned state model, already correct.**
- `electrical_model.dart` — `PipeType`, `ColorTemp` (warm/neutral/cold/rgb, matches D6 exactly), `DeviceType`, `ElectricalDevice{id,type,position,wallId,...}` — close match to spec's `placedDevices[]`.
- `estimate_model.dart` — `EstimateStageName` (only 5 today: floor/paint/furniture/electrical/mep — needs extending to the 8-stage canonical list), `EstimateLineItem{quantity,unitPrice,lineTotal}`, `EstimateStage`. **Missing:** `counterfactualPrice`/`isExcluded` fields needed for E1's "gray struck-through, tejaldingiz" rule — add these, don't rebuild the model.
- `room_model.dart` — `WallType` (wallA-D), `OpeningType` (single/dual/sliding = spec's eshik/deraza/balkon eshigi), `RoomDimensions{width,height,length}` — close match to spec's `Wall`/`Opening`.
- **Genuinely missing from all models:** a `renovationStage` field/enum over the canonical 8-stage list. This is the one real gap — add it, wired to the existing `RoomCondition`/`SurfaceCondition` types above.

**Providers (`lib/providers/`) — extend, do not replace:**
- `design_provider.dart` (245 lines) — working `ActiveDesignNotifier extends StateNotifier<DesignSelection?>` plus derived providers. Extend for the 8-stage/delta needs, don't fork a parallel provider.
- `room_provider.dart` — working `ActiveRoomNotifier extends StateNotifier<Room?>`. Same verdict.
- `measurement_provider.dart`, `lidar_provider.dart` — support the A-batch capture flow; audit before touching.

**Widgets (`lib/widgets/`) — structurally reusable, none delta-aware yet:**
- `widgets/design/stage_progress_line.dart` (55 lines) — generic linear step indicator, English "Step X of Y" caption, no gray/blue/light 3-state semantics. **Extend this file in place** (add a `stageStates: List<StageState>` param carrying skipped/active/upcoming per segment + Uzbek "Bosqich X/8" caption) rather than build a new `delta_progress_bar.dart` from scratch.
- `widgets/common/material_rail.dart` (172 lines) — `MaterialRail` collapsible right rail, animated expand/collapse, matches the spec's right-rail pattern structurally well. Extend for multi-tab support, don't replace.
- `widgets/common/device_rail.dart` — electrical-device counterpart to material_rail; same verdict, audit before extending.
- `widgets/common/drag_drop_target.dart` (150 lines) — real, generic `Draggable`/drop-target wrapper (`feedback`/`childWhenDragging`/`onDropped(T, Offset)`). **Build the C-batch drag-to-surface interaction on top of this, do not reinvent it.**
- `widgets/common/success_toast.dart` — likely already the reusable toast needed for "✓ ... qo'llanildi" messages; audit before writing a new one.
- `widgets/design/room_condition_card.dart`, `furniture_edit_card.dart` — likely map to B1's texture-choice cards and C6's selected-item card; audit content/copy against spec.
- `widgets/electrical/wire_routing_view.dart`, `electrical_totals_card.dart` — map directly to D8/D9; high-value, audit for correctness rather than rebuilding.
- `widgets/room/room_canvas.dart` — likely the shared 3D-room-placeholder view reused across B2/C7-C8/D — verify its API is generic enough before any batch step extends it; this is the single most cross-cutting widget in the app.

**Screens — completeness signal (from a Uzbek-copy-density audit, indicative not definitive):**
- **Near-zero Uzbek, genuinely thin — full rewrite needed, no shortcuts:** `splash_screen.dart`, `login_screen.dart`, `app_shell.dart`, `home_empty_screen.dart`, `home_with_projects_screen.dart` (structurally fixed this session, content still generic), `onboarding/e7`, `e8`, `e9_preferences_settings_screen.dart` (note: **spec's E9 is explicitly "not built separately" = E5** — this file is an unrelated Settings screen with no spec counterpart at the top level; it likely becomes a menu item under E4, not its own route — reconcile in Step 3), `room_setup/*`, `scanning/*`, `masters/u4`, `u5` (0 Uzbek markers despite 291-335 lines — long but English-heavy), `profile/e5`, `e6`.
- **Real Uzbek content already present — audit-and-patch, not wholesale rewrite:** `estimation/e3_labor_costs_screen.dart` (richest, 12 markers/406 lines), `design/b3_paint_selection_screen.dart` (8/329), `design/b2_floor_selection_screen.dart` (6 markers but also 2 stub markers — mixed), `masters/u1_masters_intro_screen.dart` (7/300), `shop/s1_shop_home_screen.dart` (7/350), `estimation/e2`, `electrical/d1-d10` (1-3 markers each across all 10 files — consistently partial, not zero; and unlike RN's live D-folder, these are electrical/plumbing-themed, not furniture/HVAC — **good news: Flutter's own D-batch is topically correct, cross-check against README text, don't import RN's mismatched D-folder**).
- **Router-level stubs confirmed to need real screens built from nothing:** `/design/complete`, `/electrical/complete`, `/shop/s2`, `/shop/s3`, `/shop/s4`, `/shop/s6` (6 routes, `MeasurementStub` placeholder, no real file exists).

**Naming collisions requiring reconciliation before Steps 4/5/9 start (see Step 3):**
- Three competing partial implementations of the spec's Batch-A capture flow: `lib/screens/measurement/a1-a9` (own numbering: start/camera/room_name/dimensions/furniture/lidar/photo/review/summary — doesn't map 1:1 to spec's A1-A9), `lib/screens/room_setup/*` (room_selection_sheet/dimensions_entry_screen/wall_measurements_screen/door_window_modal/room_summary_screen — names read closer to spec's A3/A6/A7/A8/A9), and `lib/screens/scanning/*` (lidar_scanning_screen, photo_scanning_screen — likely A4/A5). These need one reconciliation pass, not three independent ones.
- `lib/screens/design/b1-b4` — file names suggest spec's Batch B, but content (paint selection, floor selection) reads like spec's **Batch C** (decoration), not spec's Batch B (room-state entry: korobka/suvoq/shpaklovka choice + entering the 3D room). This affects both Step 5 (Batch B) and Step 9 (Batch C) — they must coordinate on this renumbering together, not claim the same files independently.

---

## Dependency graph (13 steps)

```
Step 1 (tokens) ──► Step 2 (state model) ──► Step 3 (screen-mapping reconciliation)
                                                     │
                        ┌────────────────────────────┼───────────────────────┬─────────────────────┐
                        ▼                             ▼                       ▼                     ▼
                 Step 5 (Batch B, 4)          Step 6 (Batch U, 5)     Step 7 (Batch S, 7)   Step 8 (Batch E-part1:
                        │                                                                     E4,E7,E8,E10,E11 — 5)
                        ▼
                 Step 9 (Batch C, 9)
                        │
                        ▼
                 Step 10 (Batch D, 10)
                        │
                        ▼
                 Step 11 (Batch E-part2: E1,E2,E3,E5,E6 — 5, needs real smeta data from Step 10)
                        │
        ┌───────────────┴──────────────────────────────────────────────────┐
        ▼ (also needs 5,6,7,8 done, plus Step 4 done)                       │
 Step 12 (Navigation wiring integration + orphan-route cleanup, all batches) 
        │
        ▼
 Step 13 (Final QA / regression pass, committed per-screen checklist)
```

Steps 5, 6, 7, 8 have no shared files **except `lib/config/router.dart` and `lib/screens/app_shell.dart`** (both are touched by every batch — see "Shared-file protocol" below) and can otherwise run in parallel once Steps 3-4 are done. Step 9→10→11 is a serial chain that runs concurrently with the 5/6/7/8 wave. Step 12 is a barrier — it needs every screen batch finished. Step 13 is the final gate.

Step 4 (Batch A) sits between the reconciliation step and the parallel wave because A1's "Tezkor amallar" quick actions and the 4-tab nav are the actual entry points for U/S/E — the parallel wave cannot start until A1 exists and its nav/quick-action targets are defined (even if the destination screens themselves are still being built in parallel).

### Shared-file protocol (fixes the review's "false parallelism" finding)
`router.dart` and `app_shell.dart` are edited by nearly every step. To keep Steps 5/6/7/8 genuinely parallel-safe:
- Each batch step adds its own routes as a **separate route-list file** (`lib/config/routes/masters_routes.dart`, `shop_routes.dart`, `profile_routes.dart`, `room_state_routes.dart`) exporting a `List<RouteBase>` that `router.dart`'s main `routes: [...]` spreads in (`...mastersRoutes, ...shopRoutes, ...`).
- `app_shell.dart`'s 4-tab list is edited **once**, in Step 4 (Batch A), since the tabs themselves (Uy/Do'kon/Ustalar/Profil) are already fully known from the spec before any of Steps 5-8 need to touch it — later steps only add routes their tab already points at, they don't re-edit the tab list itself.
- Any step that still needs to touch `router.dart`'s shared `redirect`/`ShellRoute` wrapper itself (not just add a route file import) must flag it in its own step output so Step 12 can catch a conflicting edit before it's silently overwritten.

## Environment notes (read before starting)
- `tamir_uy_mobile_flutter` is **not tracked by its own git repo**. The nearest `.git` is at `/home/rimefara/projects` (root), whose `origin` remote points at `github.com/Begzod10/tamir_uy` (the separate backend/web repo) and contains dozens of unrelated project folders as untracked content. **Do not commit or push through that repo for this work.** Per the adversarial review's finding #15: **init a local-only git repo inside `tamir_uy_mobile_flutter` itself** (`git init`, no remote) before Step 1 starts, so every step can commit a checkpoint and rollback is a real `git revert`/`git checkout` instead of a manual file-copy promise. This sidesteps the `/home/rimefara/projects` remote problem entirely.
- `test/` currently contains only the default `test/widget_test.dart` — Step 2 must create `test/unit/` before its `flutter test test/unit/` verification command means anything, and Step 13's `flutter test` must first delete or rewrite the stale default widget test (it references the pre-rebuild counter-demo app and will fail).
- Backend API (`tamir_uy` project, port 8000 via Docker Compose) and an Android emulator (Pixel5, `emulator-5554`) are both already running — see `docs/development/DEVELOPMENT_SUMMARY.md` to relaunch if needed (`docker compose up`, `flutter emulators --launch Pixel5`, `flutter run -d emulator-5554`).
- Test login: username `rimefara`, password `12345678`.
- Known pre-existing bug already fixed this session: `routerProvider` must never do `ref.watch(authStateProvider)` directly (causes an infinite splash-screen reset loop) — it uses a `ChangeNotifier` bridge via `ref.listen` instead (`_GoRouterRefreshNotifier` in `lib/config/router.dart`). Do not reintroduce `ref.watch` there.
- Never use `Navigator.of(context).pushNamed(...)` anywhere in this codebase — no named-route table exists (`MaterialApp.router` + GoRouter only), it throws at runtime. Always `context.go(...)`/`context.push(...)`. This bug has already been found and fixed twice this session (splash screen, home screens) — it is the single most likely regression across 11 steps of new/edited screen code.
- No map package (`google_maps_flutter`, `flutter_map`, etc.) exists in `pubspec.yaml` today, despite `DEVELOPMENT_SUMMARY.md` implying one does — verify before assuming. Step 1 must add one (recommend `flutter_map` + `latlong2`, avoids needing a Google Maps API key for what's currently mock data anyway) for Batch U (Step 6).
- `design_tokens.dart` currently declares `fontFamily = 'Poppins'` with ~10 `static const TextStyle` fields consumed by `const` widgets throughout the app, plus a `class AndozaTheme` and a "BACKWARD COMPATIBILITY ALIASES" block. Switching to `GoogleFonts.inter(...)` breaks every one of those `const` declarations (GoogleFonts returns non-const `TextStyle`s) — this is a compile-wide cascade, not a value swap. **Recommended fix:** bundle Inter `.ttf` files as local assets (`pubspec.yaml` `fonts:` section) instead of using the `google_fonts` package, so `TextStyle(fontFamily: 'Inter', ...)` stays `const`-compatible. Keep the "BACKWARD COMPATIBILITY ALIASES" block intact through Steps 1-11 (other steps may still reference old names mid-rebuild); only remove it in Step 12/13 once a grep confirms nothing references it.

---

## Step 1 — Design tokens (foundation, serial, blocks everything)
**Model tier:** strongest (per review finding #13 — this is a compile-wide cascade risk, not mechanical transcription)
**Depends on:** nothing
**Files:** `lib/config/design_tokens.dart` (extend/restructure, keep `AndozaTheme` and the backward-compat alias block intact for now), `pubspec.yaml` (add Inter font assets + a map package), `assets/fonts/` (new, Inter TTFs).

### Context brief
Read the README's "Design Tokens" + "Updated design tokens" sections, AND read RN's `src/theme/tokens.ts` for the semantic-grouping structure to mirror (see "RN reference map" above) — do not just transcribe flat hex values.

Exact values (from the README's updated set — this supersedes the original spec section where they differ):
- Primary blue `#1E3A8A`, accent orange `#F97316`, success green `#16A34A`
- Background `#F8FAFC`, text primary `#1A2340`, secondary `#5A6785`, muted `#98A2BC`
- Borders `#E2E7F2` / `#EEF1F8`, primary tint `#EEF1F8`, "existing/gray" state `#C4CCE0`
- Card radius 16-20px, buttons 12px, bottom sheets 24px top corners
- Font: Inter, weights 400/500/600/700/800
- Screen padding 20px horizontal
- Shadows: card `0 8px 20px -12px rgba(17,24,39,.16)`, elevated/hero `0 18px 40px -18px rgba(30,64,175,.28)`, nav bar `0 -10px 26px rgba(17,24,39,.06)`, FAB `0 14px 26px -6px rgba(30,64,175,.6)`, primary button `0 14px 28px -10px rgba(30,64,175,.55)`

### Tasks
1. Download/extract Inter `.ttf` weights (400/500/600/700/800) into `assets/fonts/`, register in `pubspec.yaml`'s `fonts:` section as family `Inter`.
2. Restructure `design_tokens.dart` to mirror RN's semantic grouping: nested classes/objects for `DesignTokens.delta.{completed,inProgress,upcoming,skipped}`, `DesignTokens.roomState.{korobka,suvoq,shpaklovka}`, plus the flat brand colors above. Keep existing flat token names as aliases in the "BACKWARD COMPATIBILITY ALIASES" block (do not delete — other steps may still reference them until fully migrated).
3. Add every color/spacing/radius/shadow/typography value from the spec, replacing `fontFamily = 'Poppins'` with `'Inter'`.
4. Add a map package to `pubspec.yaml`: `flutter_map` + `latlong2` (recommended — no API key needed for Step 6's mock craftsman-pin data; revisit if real Google Maps integration is later required).
5. Grep the codebase for hardcoded `Color(0x...)` values outside `design_tokens.dart` and list them in this step's output (don't fix yet — later steps consume this list).

### Verification
```bash
cd /home/rimefara/projects/tamir_uy_mobile_flutter
git init && git add -A && git commit -m "checkpoint: pre-rebuild baseline"   # one-time, local-only, no remote
dart analyze lib/config/design_tokens.dart
dart format lib/config/design_tokens.dart
flutter pub get
flutter build apk --debug --target-platform android-x64 2>&1 | tail -50   # full-app compile check, since const TextStyle changes are compile-wide
```

### Exit criteria
- Every hex value matches the README's "Updated design tokens" section exactly (spot-check ≥10 values).
- Full app still compiles (the `flutter build apk --debug` command above, not just `dart analyze` on the one file) — this catches the `const`/font cascade risk.
- `AndozaTheme` and backward-compat aliases still present and functional.
- No screen content has been touched yet.

### Rollback
`git checkout -- lib/config/design_tokens.dart pubspec.yaml` (now safe, thanks to the Step-0 local git init).

---

## Step 2 — Delta-calculation state model (foundation, serial, blocks all batches)
**Model tier:** strongest (the core, easy-to-get-subtly-wrong business logic — the product's entire differentiator)
**Depends on:** Step 1 (tokens, for enum-adjacent display colors only)
**Files:** extend `lib/models/design_selection_model.dart`, `lib/models/estimate_model.dart`, `lib/models/room_model.dart`, `lib/models/electrical_model.dart` (do NOT create parallel new model files for concepts that already exist there); new `test/unit/renovation_delta_test.dart`; extend `lib/providers/design_provider.dart`/`room_provider.dart` (do not fork new providers).

### Context brief
Read the README's "The core product mechanic — delta calculation," "State Management," and "State additions vs the original spec" sections in full. Three hard rules, repeated because they're the most likely thing to get lost:
1. `material = norm(finished) − norm(current)` — only the delta is ever calculated/priced. Already-plastered walls never get re-counted for plaster.
2. **No prices anywhere during the flow.** Money only appears starting at E1, reached only after D10.
3. **Electrical is strictly last** — after furniture — because device positions depend on furniture placement.

**Adopt the canonical 8-stage list confirmed from RN's `STAGES` constant** (this resolves the contradiction between A2/E5's "X/8" bar, the 6-stage rail, and E1's 7 priced rows — they're all views of the same 8-item list, not three separate taxonomies):
```
0: Suvoq
1: Shpaklovka
2: Bo'yoq/Oboi
3: Pol
4: Mebel        ← furniture BEFORE electrical, per the spec's ordering rule
5: Elektr
6: Yorug'lik
7: Santexnika
```
Confirm this against the README's own screen-by-screen descriptions before finalizing (the README's B/C/D screen list groups D6/D7 as "Yorug'lik"/"Santexnika" sub-tabs of the Elektr stage in some places — decide whether they're 3 separate stage-line entries or 1 "Elektr" entry with 3 rail tabs, and document the decision here since E1's stage-priced-rows and every stage-line UI in B/C/D must agree with whatever you decide).

**What already exists (extend, don't rebuild):**
- `design_selection_model.dart`'s `SurfaceCondition` (raw/plastered/puttied) + `RoomCondition{wall,floor,ceiling}` ≈ 50% of the `roomState`/`floorState`/`ceilingState` need — extend, add the missing `renovationStage` field (int 0-7 over the list above).
- `room_model.dart`'s `WallType`/`OpeningType`/`RoomDimensions` ≈ the `Wall`/`Opening` need — extend with per-wall `List<Opening>` if not already structured that way.
- `electrical_model.dart`'s `PipeType`/`ColorTemp`/`DeviceType`/`ElectricalDevice` ≈ the `placedDevices[]` need.
- `estimate_model.dart`'s `EstimateStageName`/`EstimateLineItem`/`EstimateStage` — **extend** `EstimateStageName` from its current 5 values to the 8-stage canonical list, and **add** `counterfactualPrice` (what this stage would have cost from zero) + `isExcluded` (bool) fields to `EstimateLineItem`/`EstimateStage` — required for E1's "gray, struck-through, `0 so'm`, `hisoblanmadi`" rendering AND the green "tejaldingiz" banner, which needs both the real delta price (0 for excluded stages) and the counterfactual price (what was saved) simultaneously.
- **Genuinely new work (confirmed no prior implementation in either codebase):** the pure function that derives, from `(roomState, floorState, ceilingState, renovationStage)`, which of the 8 stages are `isExcluded` (already existed) vs active vs upcoming. RN never built this — its screens just pass hardcoded arrays. Design it fresh from the README's rules, TDD it first.

### Tasks
1. Create `test/unit/renovation_delta_test.dart` FIRST (TDD). Write failing tests for the delta-derivation function across all 3 `SurfaceCondition` values, plus at least one `floorState`/`ceilingState` override case (e.g. "walls are korobka but floor already has qoplama" → floor-related stage still excluded even though walls aren't).
2. Extend `design_selection_model.dart` with the `renovationStage` field.
3. Extend `estimate_model.dart`'s `EstimateStageName` enum to the 8-stage list; add `counterfactualPrice`/`isExcluded` to `EstimateLineItem`/`EstimateStage`.
4. Write the delta-derivation pure function (suggest: `List<StageDisplayState> deriveStageStates({required RoomCondition condition, required int renovationStage})` returning excluded/active/upcoming per stage index) — make tests from task 1 pass.
5. Extend `design_provider.dart`/`room_provider.dart` to expose the derived stage states and `renovationStage` as a Riverpod-derived provider (don't fork a new `renovationProvider` if the existing providers can just grow this responsibility — check first).
6. Run `dart run build_runner build --delete-conflicting-outputs` for Freezed codegen on the extended models.

### Verification
```bash
cd /home/rimefara/projects/tamir_uy_mobile_flutter
dart run build_runner build --delete-conflicting-outputs
dart analyze lib/models/ lib/providers/design_provider.dart lib/providers/room_provider.dart
flutter test test/unit/renovation_delta_test.dart   # must exist and pass
git add -A && git commit -m "step 2: delta-calculation state model"
```

### Exit criteria
- Delta-derivation function has unit tests covering all 3 `SurfaceCondition` values AND at least one floor/ceiling override case; all pass.
- `EstimateLineItem`/`EstimateStage` can represent "excluded, delta price 0, counterfactual price X" simultaneously (verify with a quick manual construction + assertion in the test file, not just visual code review).
- No screen references this model yet — pure domain layer only.

### Rollback
`git checkout -- lib/models/ lib/providers/design_provider.dart lib/providers/room_provider.dart test/unit/`

---

## Step 3 — Screen-mapping reconciliation (small, focused, blocks Steps 4/5/9)
**Model tier:** strongest (wrong calls here cause duplicate work or silent gaps across the whole rebuild)
**Depends on:** Step 2
**Files:** produces `plans/screen-mapping.md` (new, a committed decision table); may delete/merge files identified as redundant.

### Context brief
Three naming collisions were found during research and must be resolved once, centrally, before batch work starts — not rediscovered independently by Steps 4/5/9 (which would risk two steps claiming the same files, or one step deleting something another still needed):
1. **Batch A capture flow** has three competing partial implementations: `lib/screens/measurement/a1-a9` (own numbering, doesn't map 1:1 to spec), `lib/screens/room_setup/*` (room_selection_sheet/dimensions_entry_screen/wall_measurements_screen/door_window_modal/room_summary_screen — names read closer to spec's A3/A6/A7/A8/A9), `lib/screens/scanning/*` (lidar_scanning_screen/photo_scanning_screen — likely A4/A5).
2. **`lib/screens/design/b1-b4`** — file names suggest spec's Batch B, but content (paint/floor selection) reads like spec's Batch C (decoration). Affects both Step 5 (Batch B) and Step 9 (Batch C).
3. **`lib/screens/onboarding/e9_preferences_settings_screen.dart`** has no top-level spec counterpart — spec's E9 is explicitly "not built separately, = E5." Determine whether this file's content becomes a menu item under E4 or is retired outright.

### Tasks
1. Open `UyTamir Final.dc.html` and read each candidate file's actual content (not just filename) for A1-A9, B1-B4, and e9.
2. For each spec screen ID (A1...A9, B1/B1-alt/B2/B3), decide: which existing file (if any) becomes that screen, which existing files get deleted, which get merged.
3. Write the decision table to `plans/screen-mapping.md`: columns `spec_screen_id | chosen_source_file | files_to_delete | rationale`.
4. Delete the files marked for removal now (with the git checkpoint from Step 1, this is safely reversible) — don't leave dead code for Step 12 to discover.
5. Resolve `e9_preferences_settings_screen.dart`: fold its useful content into E4 as a menu-accessible sub-screen (spec's E4 menu list includes "⚙️ Sozlamalar") or delete if fully redundant with E4/E7-E9 onboarding content.

### Verification
```bash
cd /home/rimefara/projects/tamir_uy_mobile_flutter
test -f plans/screen-mapping.md && echo "mapping table exists"
dart analyze lib/  # after deletions, confirm no dangling imports/router references
git add -A && git commit -m "step 3: screen-mapping reconciliation"
```

### Exit criteria
- `plans/screen-mapping.md` exists and covers every spec screen ID in Batches A and B, plus the E9 decision.
- No dangling `import`/router reference to a deleted file (`dart analyze` clean).
- Steps 4, 5, 9 can each read this table and know exactly which file to start from without re-deciding.

### Rollback
`git revert` the reconciliation commit if a later step discovers the mapping was wrong for a specific screen — cheap since it's isolated to this one commit.

---

## Step 4 — Batch A: Entry & measurement (9 screens) + shared shell/nav
**Model tier:** default per-screen; the delta progress bar extension (shared, reused in B/C/D/E) and the `app_shell.dart` 4-tab nav (edited once, here, per the shared-file protocol) get a strongest-tier pass.
**Depends on:** Step 3
**Files:** `lib/screens/splash/splash_screen.dart` (S0), `lib/screens/home/home_empty_screen.dart` (A1), `lib/screens/home/home_with_projects_screen.dart` (A2), the file(s) chosen in Step 3's mapping for A3-A9, `lib/widgets/design/stage_progress_line.dart` (extend, per the codebase-reality section above — do not create a new `delta_progress_bar.dart`), `lib/screens/app_shell.dart`.

### Context brief
Read README "01 — Home (empty state)," "02 — Home (with user project)," "03 — '+' Bottom Sheet" through "06," and the "Batch A" summary, plus the corresponding frames in the HTML mockup. `home_empty_screen.dart`/`home_with_projects_screen.dart` already got the double-Scaffold/double-BottomNav structural bug fixed this session — keep that fix, this step replaces content/copy/tokens only.

Screen-by-screen (exact copy quoted from spec):
- **S0 Splash** — dark brand gradient, AndozaAI mark centered large, Inter wordmark "AndozaAI".
- **A1 Bosh sahifa (bo'sh)** — "Xush kelibsiz" (15/500 gray) + "Salom, Begzod! 👋" (25/800); 3 story circles (Qanday ishlaydi?/Demo qo'llanma/Demo, animated conic ring 2.5s, gray once seen) → E7/E8; empty-state card "Birinchi xonangizni qo'shing"; "Tezkor amallar" 2×2: Xonani skanlash/Smeta/Dilerlar/Ustalar (wire Smeta→E1, Ustalar→U1 via `context.go` even though those batches build later — the route path is defined now, the destination screen fills in during Steps 6/11); 4-tab nav (Uy/Do'kon/Ustalar/Profil) + center orange FAB — **build this tab list once here** per the shared-file protocol.
- **A2 Bosh sahifa (loyihalar)** — active project card, 3D house placeholder, **delta progress bar** using Step 2's `deriveStageStates` output (8 segments, gray=excluded/blue=active/light=upcoming), legend "Mavjud (hisoblanmaydi)"/"Kerak (delta)", caption "Bosqich [renovationStage+1]/8 · ✓ [excluded stage names] mavjud edi" computed from actual state, not hardcoded; "Barchasi" → E5.
- **A3-A9** — per Step 3's mapping table, using the file chosen there as the starting point; rewrite copy/tokens/layout to match README sections 03-06 exactly (bottom sheet entry paths, LiDAR/360/manual capture modes, wall-by-wall measurement with progress dots, opening-add sheet, summary stats computed from actual `Wall`/`Opening` data).

### Tasks
1. Extend `stage_progress_line.dart` into the delta-aware progress bar (add `stageStates` param, Uzbek caption, gray/blue/light coloring per Step 2's derived states) — this is the shared widget Steps 5/9/10/11 will also use.
2. Rewrite S0/A1/A2 with exact copy/colors/layout; build the 4-tab `app_shell.dart` nav once, here.
3. Rewrite A3-A9 starting from Step 3's chosen source files.
4. Wire all routes with `context.go`/`context.push` — never `pushNamed`.
5. A9's stat cards must read from actual `Wall`/`Opening` model data, not hardcoded numbers.

### Verification
```bash
cd /home/rimefara/projects/tamir_uy_mobile_flutter
dart analyze lib/screens/home/ lib/screens/app_shell.dart lib/widgets/design/stage_progress_line.dart lib/config/router.dart
flutter run -d emulator-5554  # walk S0 → A1 → A2 → A3 → A4-A6 → A7 → A8 → A9, compare each against the HTML mockup
git add -A && git commit -m "step 4: batch A + shared shell/nav"
```

### Exit criteria
- All 9 A-batch screens match the mockup exactly (copy, colors, layout).
- Delta progress bar on A2 correctly reflects at least 2 different simulated `roomState` values.
- `app_shell.dart`'s tab list is final — later steps only add routes, they don't re-edit this file's tab structure.
- No `pushNamed` anywhere in new code.

### Rollback
`git checkout -- <touched files>` per the Step 1 git init.

---

## Step 5 — Batch B: Room state & entering the 3D room (4 screens)
**Model tier:** default
**Depends on:** Step 4
**Files:** per Step 3's mapping decision for the B-batch naming collision — likely new files under `lib/screens/room_state/` if `design/b1-b4` was reassigned to Batch C in Step 3; `lib/widgets/room/room_condition_card.dart` (extend), new `lib/widgets/room_3d_rail.dart` built on top of `material_rail.dart`/`device_rail.dart`.

### Context brief
Read README "Batch B," "B1"/"B1-alt"/"B2"/"B3," and "Recurring patterns" (right-rail interaction, first used here). Reference Step 3's `plans/screen-mapping.md` for which files this step actually owns.
- **B1** — "Xonangiz hozir qaysi holatda?" — 3 texture cards bound to `SurfaceCondition`, links to B1-alt, CTA "Xonaga kirish" → B2.
- **B1-alt** — sheet: Pol (Xom beton/Styajka/Qoplama bor) + Shift (Xom/Suvoq/Tayyor) bound to `floorState`/`ceilingState`, "Saqlash".
- **B2** — first-person CSS-perspective interior (placeholder, texture reflects chosen `roomState`), collapsed pulsing rail tab, CTA "Boshlash" → B3.
- **B3** — right rail opens (Bo'yoq/Oboi swatches), stage line (reuse Step 4's extended progress bar), onboarding overlay, toast "✓ Shpaklovka qo'shildi" (reuse/audit `success_toast.dart`), "Keyingi bosqich →" → C1.

### Tasks
1. Build B1 bound to the extended `design_provider`'s `SurfaceCondition` setter.
2. Build B1-alt as a 24px-top-radius bottom sheet.
3. Build B2's placeholder interior using `room_canvas.dart` (audit its API first — this is the most cross-cutting widget in the app per the inventory).
4. Build the reusable `room_3d_rail.dart` on top of existing `material_rail.dart` (extend for tab support) — Steps 9/10 depend on this being generic, not hardcoded to Bo'yoq/Oboi.
5. Wire B1→B1-alt(optional)→B2→B3→C1.

### Verification
```bash
dart analyze lib/screens/room_state/ lib/widgets/room_3d_rail.dart lib/config/router.dart
flutter run -d emulator-5554  # A9 → B1 → (B1-alt) → B2 → B3
git add -A && git commit -m "step 5: batch B"
```

### Exit criteria
- B1's 3 texture cards visually distinguish korobka/suvoq/shpaklovka per spec.
- `room_3d_rail.dart` is generic (accepts tabs + item lists as parameters, no hardcoded Bo'yoq/Oboi content).

### Rollback
`git checkout --` the touched files; `room_3d_rail.dart`'s API is the one shared risk (same caveat as C/D reuse).

---

## Step 6 — Batch U: Ustalar craftsman marketplace (5 screens)
**Model tier:** default
**Depends on:** Step 4
**Can run in parallel with:** Steps 5, 7, 8
**Files:** `lib/screens/masters/u1-u5` (audit all 5 — inventory confirms u1 has real Uzbek content, u4/u5 are English-heavy despite length; u2/u3 not yet audited, check before assuming state).

### Context brief
Read README "Batch U" in full, including the explicit privacy rule: **never show an exact home address** — only approximate area + dashed-circle zone + "Chilonzor · ~2 km"-style distance. RN has only U1 built (under `Contractors/`, not usable structurally as-is) — Flutter is largely on its own for U2-U5.
- **U1** — map view (needs the map package added in Step 1), craftsman pins (color-coded by trade: ⚡`#F59E0B`/🎨`#8B5CF6`/🧱`#0EA5E9`/🔧`#10B981`/🪚`#B45309`), search, filter chips, map/list toggle.
- **U2** — selected-pin sheet, avatar+online dot, rating, area·~km, "Profilni ko'rish" → U4.
- **U3** — list view, online-first sort.
- **U4** — full profile, stat cards, portfolio, approximate-zone-only mini-map, "Smetani yuborish" → U5.
- **U5** — send-smeta sheet — **this screen needs a real project-summary figure ("28.6 mln so'm smeta") which depends on Step 11's pricing layer.** Until Step 11 lands, render this with a clearly-labeled placeholder value (not a hardcoded fake number that could pass unnoticed) and backfill in Step 11.

### Tasks
1. Audit u1-u5 against the spec; rewrite copy/tokens/layout to match exactly — do not assume existing length/structure means correctness (u4/u5 are long but English-heavy per the inventory).
2. Implement U1/U2's map view with the Step 1 map package + mock craftsman pin data.
3. Enforce the approximate-location privacy rule everywhere (U1, U2, U4) — no exact address string anywhere.
4. Wire U1↔U2↔U3↔U4↔U5, and the "Ustalar" tab/quick-action entry point from A1 (route only — A1 itself was built in Step 4).
5. Mark U5's smeta figure as a placeholder pending Step 11, tracked in this step's output for Step 11 to pick up.

### Verification
```bash
dart analyze lib/screens/masters/
flutter run -d emulator-5554  # A1 "Ustalar" quick action → U1 → U2 → U4 → U5
git add -A && git commit -m "step 6: batch U"
```

### Exit criteria
- No exact address ever rendered anywhere in this batch.
- Trade badge colors match the spec's exact hex-per-trade mapping.
- U5's placeholder figure is explicitly flagged (e.g. a `// PLACEHOLDER: backfilled in Step 11` marker plus a note in this step's completion report), not silently indistinguishable from a real one.

### Rollback
`git checkout --` isolated to `lib/screens/masters/`.

---

## Step 7 — Batch S: Do'kon project-linked shop (7 screens)
**Model tier:** default, except S6 (payment) gets a security-review pass.
**Depends on:** Step 4
**Can run in parallel with:** Steps 5, 6, 8
**Files:** `lib/screens/shop/s1-s7` (s1/s5/s7 have real content per the inventory; s2/s3/s4/s6 are router-level `MeasurementStub` placeholders — genuinely build these from nothing, not audit-and-patch). RN has all 7 screens built — good reference here (see "RN reference map").

### Context brief
Read README "Batch S" in full. Critical framing: **bound to the user's project** (the app knows the room + smeta and tells the user exactly what to buy), and **payment must happen in-app** — never link out externally.
- **S1** — Do'kon home, cart badge, search, big blue project banner ("SIZNING LOYIHANGIZ"), category chips, 2-col grid with "Loyihada" tags.
- **S2** — "Loyiha materiallari," green banner, list **grouped by renovation stage**, quantities computed from actual project data (not hardcoded), footer → S5.
- **S3** — product detail, blue recommendation card with actual computed quantity, → S4, sticky "Savatga qo'shish."
- **S4** — dealer comparison, best option green border + "ENG YAXSHI."
- **S5** — cart grouped by dealer, "Umumiy summa" → S6.
- **S6** — checkout: address, phone, Payme/Click/Uzum/Naqd tiles, → S7.
- **S7** — order status stepper, dealer/courier contact, "Ustaga topshirish."

### Tasks
1. Rewrite S1 with the real project-banner pattern reading from Step 2's extended state (not a hardcoded "~14 litr kerak" string).
2. Build S2-S4, S6 from nothing (replacing the router-level stubs).
3. Rewrite S5/S7 for exact spec match.
4. Wire S1→S2→S5→S6→S7 and S1→S3→S4 branches; cart badge reflects actual cart state across screens.

### Verification
```bash
dart analyze lib/screens/shop/
flutter run -d emulator-5554  # Do'kon tab → S1 → S2 → S5 → S6 → S7; S1 → product → S3 → S4
git add -A && git commit -m "step 7: batch S"
```

### Exit criteria
- S2's quantities are computed from actual project/room data.
- S6 never implies an external payment redirect.
- Cart badge count is consistent across S1/nav/S5.

### Rollback
`git checkout --` isolated to `lib/screens/shop/`.

---

## Step 8 — Batch E part 1: Profile, Onboarding, Utility (5 screens: E4, E7, E8, E10, E11)
**Model tier:** default
**Depends on:** Step 4
**Can run in parallel with:** Steps 5, 6, 7
**Files:** `lib/screens/profile/e4_profile_settings_screen.dart` (rewrite), `lib/screens/onboarding/e7`, `e8` (rewrite; e9's fate was decided in Step 3), new for E10/E11.

### Context brief
This subset has no dependency on Smeta data being live, so it parallelizes safely.
- **E4** — avatar, "Begzod," stat cards (**"4.2 mln tejaldi" depends on Step 11's pricing layer — same placeholder caveat as U5, flag it explicitly**), menu → E5/E6 (Step 11, stub-link the route now), E11, S6, E8, Chiqish.
- **E7** — 4 onboarding slides; **slide 2 is the delta-idea explainer** ("Hozirgi holatdan boshlaymiz" → "faqat FARQ hisoblanadi" pill) — this must visually agree with Step 2's actual mechanic, not just look pretty. Note: the README's slide numbering has slides 1/2/4 explicitly described and slide 3 following "the same template" — there is no independent frame for slide 3 in the mockup; build it from the same template, and exempt it from pixel-comparison in Step 13 since no reference frame exists for it.
- **E8** — video/animation placeholder, 5-step list, "O'zim sinab ko'raman" → A3.
- **E10** — search results, filter chips, "Loyihada" tags.
- **E11** — reusable empty-state pattern (dashed card/icon/title/one-liner/button) — build as one parameterized widget; retrofit into A1/A2's empty-project card from Step 4 if that shipped a bespoke one instead.

### Tasks
1. Rewrite E4 with exact copy/stat cards/menu wiring; mark the "tejaldi" figure as a Step-11-pending placeholder.
2. Build E7's 4 slides (slide 2 gets the most scrutiny), E8, E10.
3. Build the reusable `EmptyStatePattern` widget for E11; retrofit into Step 4's A1/A2 empty-state if needed (coordinate — don't silently duplicate).

### Verification
```bash
dart analyze lib/screens/profile/e4_profile_settings_screen.dart lib/screens/onboarding/ lib/widgets/empty_state_pattern.dart
flutter run -d emulator-5554  # Profil → E4; A1 story circle → E7, E8
git add -A && git commit -m "step 8: batch E part 1"
```

### Exit criteria
- E7 slide 2 correctly conveys the delta mechanic in the exact described pattern.
- `EmptyStatePattern` is parameterized and reused, not copy-pasted.
- E4's placeholder figure is explicitly flagged for Step 11 backfill.

### Rollback
`git checkout --` isolated files; `EmptyStatePattern` retrofit into Step 4's files is the one coordination point.

---

## Step 9 — Batch C: Step-by-step decoration inside 3D (9 screens)
**Model tier:** strongest for the drag-and-drop interaction (C1-C6), default for C7-C9.
**Depends on:** Step 5 (reuses `room_3d_rail.dart` and B3's stage-line)
**Files:** per Step 3's mapping — if `design/b1-b4` was reassigned here as spec's C-content, this step starts from those files rather than building fresh; extend `drag_drop_target.dart` for the wall/floor/furniture placement gesture, don't fork it.

### Context brief
Read README "Batch C" and "Recurring patterns" (drag-from-rail, ghost preview + height label, blue outline on target, never leave the 3D room). For the drag gesture itself, translate RN's `C2_DragAnimation.tsx` pattern (live hit-testing during drag via position math against target zones, `runOnJS`-style highlight callback, spring-back on invalid drop) into Flutter's `GestureDetector.onPanUpdate` + `drag_drop_target.dart`'s existing `feedback`/`childWhenDragging`/`onDropped(T, Offset)` API — extend that widget, don't reinvent the gesture from scratch.
- **C1** — Bo'yoq/Oboi stage, rail tabs Bo'yoq/Oboy/Kafel, 5 swatches.
- **C2** — drag mid-action, wall outlined blue, half-covered.
- **C3** — fully wallpapered, toast, "Keyingi bosqich →".
- **C4** — Pol stage, rail tabs Kafel/Laminat/Parket/Beton.
- **C5** — Mebel stage, room-tab rail, sofa dragged with blue dashed drop-zone ellipse.
- **C6** — selected-item card, **no price anywhere** — hard rule, do not add a price field even though `PlacedObject`/`ElectricalDevice` models could carry one.
- **C7** — walkthrough, reuse B2's perspective-floor pattern, now furnished.
- **C8** — top-down plan, view toggle Tepadan/3D/Aylanish.
- **C9** — "Bezash yakunlandi," → D1.

### Tasks
1. Extend `room_3d_rail.dart` (from Step 5) for C1/C4/C5's tab/swatch configurations — don't fork.
2. Extend `drag_drop_target.dart` with the live-hit-test-during-drag + ghost-preview-with-height-label behavior.
3. Build C6 enforcing "no price anywhere" as a hard rule.
4. Reuse the toast helper from Step 5.
5. Wire C1→C2→C3→(per-wall loop)→C4→C5→C6→C7/C8(toggle)→C9→D1.

### Verification
```bash
dart analyze lib/screens/interior/ lib/widgets/room_3d_rail.dart lib/widgets/common/drag_drop_target.dart
flutter run -d emulator-5554  # B3 → C1 → drag a swatch onto a wall (verify it actually works, touch-drag on the emulator) → C3 → C4 → C5 drag furniture → C6 → C7/C8 → C9
git add -A && git commit -m "step 9: batch C"
```

### Exit criteria
- Drag-and-drop actually works on the emulator — verify manually, don't just check compile success.
- No price shown anywhere in C1-C9.
- C9 routes to D1.

### Rollback
`git checkout --` isolated to `lib/screens/interior/`; `drag_drop_target.dart`/`room_3d_rail.dart` API changes are the shared risk, coordinate with Step 5/10 call sites before an incompatible change.

---

## Step 10 — Batch D: Electrical & plumbing, always last (10 screens)
**Model tier:** strongest for D8-D9 (wire-routing computation and totals table are the most logic-heavy screens in the app)
**Depends on:** Step 9
**Files:** existing `lib/screens/electrical/d1-d10` (topically correct already, per the inventory — electrical/plumbing-themed, unlike RN's mismatched live D-folder; audit and rewrite for spec-accuracy, don't import RN's D-folder content).

### Context brief
Read README "Batch D" in full. All D screens show the room **fully decorated and furnished**. **Do not port RN's live D-folder** (furniture/HVAC-themed, contradicts spec); Flutter's own D1-D10 are the better starting point, cross-checked against the README text directly — RN's abandoned `_archive_D/` folder is a secondary reference only, verify everything against the README regardless of which reference you consult.
- **D1** — stage line, Elektr active (last); rail tabs Elektr/Yorug'lik/Santexnika; devices dimmed until box placed.
- **D2** — dragging the electrical box, ghost + height label.
- **D3** — dragging a double socket next to the sofa — **must reference the sofa's actual placed position from Step 9's furniture data**, not a coincidental hardcoded spot.
- **D4** — compact settings card (height/type/blocks/color), toast "✓ Rozetka qo'shildi".
- **D5** — switch by the door.
- **D6** — Yorug'lik, drag to ceiling, light-color live-preview actually tinting the 3D view.
- **D7** — Santexnika, drag to wall, blue/red pipe lines.
- **D8** — wire-routing split view — real computed graph from `placedDevices[]` + box position, not decorative.
- **D9** — totals computed from D8's actual routing graph, quantities only, no prices.
- **D10** — finished room, "Loyihangiz tayyor," orange "Smetani ko'rish →" (→E1) — no price shown here either, only the button.

### Tasks
1. Audit existing D1-D10; rewrite for exact copy/token/layout match against the README (not against RN).
2. Build the wire-routing computation (D8) as a real function over `placedDevices[]` + box position; feed D9's stats/table from it.
3. Enforce "no prices" D1-D9.
4. Wire D1→...→D9→D10→E1.

### Verification
```bash
dart analyze lib/screens/electrical/
flutter run -d emulator-5554  # C9 → D1 → place box → place socket near furniture → D5-D7 → D8 → D9 → D10
git add -A && git commit -m "step 10: batch D"
```

### Exit criteria
- D9's totals change when a different number of devices is placed — verify by testing, not by reading the code.
- No price anywhere D1-D9; D10 shows no price, only the CTA.
- D3's socket placement demonstrably reads the sofa's actual position.

### Rollback
`git checkout --` isolated to `lib/screens/electrical/`.

---

## Step 11 — Batch E part 2: Smeta + remaining Profile screens (5 screens: E1, E2, E3, E5, E6)
**Model tier:** strongest (money-facing, first place actual figures appear, delta-savings messaging is the product's core value prop)
**Depends on:** Step 10 (real material/wire totals), Step 8 (shares E4's menu wiring, and backfills U5/E4's placeholder figures from Steps 6/8)
**Files:** existing `lib/screens/estimation/e1-e3, e10` (rewrite), new for E5/E6 (currently route to profile stubs per router).

### Context brief
Read README "QISM 1 — Smeta" and "QISM 2 — Profil." **Money appears for the first time in E1** — as part of this step's verification, grep every previously-built screen for currency-like strings and confirm none leaked a price early.
- **E1** — big blue total card (Materiallar/Ishchi kuchi split), **green delta banner computed from actual excluded stage(s)** (not hardcoded), stage list with per-stage prices where excluded stages show gray/struck-through/"hisoblanmadi" using the `isExcluded`/`counterfactualPrice` fields added in Step 2; footer → S5, → U1/U5.
- **E2** — per-stage breakdown, material+labour lines, → S2/S5.
- **E3** — quality tiers (Ekonom/Standart/Premium) with live-recomputing total, DIY toggle, → E1.
- **E5** — "Loyihalarim," also serves as A2's "Barchasi" destination (confirm Step 4 didn't already build a separate placeholder for this — retire it if so, per the spec's explicit single-destination note); reuse Step 4's delta progress bar; → A3.
- **E6** — "Buyurtmalarim" — **note this screen is currently also bound to the shell's `/history` tab route** (`router.dart` line ~108); rewriting E6 as an orders list changes what the History tab shows — confirm this is the intended final behavior (it matches the spec, which has no separate "history" concept) rather than an accidental side effect.

### Tasks
1. Build the real price-calculation layer feeding E1-E3: `(renovationStage/roomState delta-excluded stages) + Step 10's material/wire totals + a mock-but-plausible price-per-unit table` → real total + real "tejaldingiz" figure. Do not hardcode the spec's example numbers (28 640 000 etc.) as literal output — use them only as a plausibility check.
2. Build E1 with gray/struck-through rendering wired to Step 2's delta function — this must produce figures that **agree with** E7's onboarding explainer (Step 8) and U5/E4's now-real figures (backfilling their Step-6/Step-8 placeholders).
3. Build E2, E3.
4. Build E5 (confirm/retire any Step-4 duplicate), E6 (confirm the `/history` binding is intentional).
5. **Verification sweep:** grep every screen from Steps 4-10 for currency-like strings ("so'm," space-grouped digit strings) — none should exist outside E1-E3/E6 and the shop/masters screens that legitimately show prices.

### Verification
```bash
cd /home/rimefara/projects/tamir_uy_mobile_flutter
dart analyze lib/screens/estimation/
grep -rn "so'm" lib/screens/ | grep -v "lib/screens/estimation\|lib/screens/shop\|lib/screens/masters/u5\|lib/screens/masters/u4"
flutter run -d emulator-5554  # D10 → E1 → E2 → E3 tier switch → back to E1; Profil → E5, E6; verify U5/E4 now show real (not placeholder) figures
git add -A && git commit -m "step 11: batch E part 2, price layer, backfill U5/E4 placeholders"
```

### Exit criteria
- The grep sweep returns no unexpected matches.
- E1's delta-savings banner changes correctly across ≥2 simulated `roomState` values.
- E3's tier switch live-recomputes on screen.
- U5 (Step 6) and E4 (Step 8) no longer show placeholder figures — confirm the flag/marker from those steps is gone.

### Rollback
`git checkout --` isolated to `lib/screens/estimation/`; the price-calculation layer is new and shared only within this step (plus its two backfill call sites).

---

## Step 12 — Navigation wiring integration + orphan-route cleanup (barrier)
**Model tier:** strongest (cross-cutting correctness pass, easy to miss one wrong link in 55 screens)
**Depends on:** Steps 5, 6, 7, 8, 9, 10, 11 all complete
**Files:** `lib/config/router.dart` and its route-list files, plus targeted fixes to any screen with a wrong navigation call.

### Context brief
Read the README's "Button wiring" table start to finish — the single authoritative source for every screen-to-screen link.

### Tasks
1. Build a checklist from the button-wiring table; verify each row against actual code by grepping each screen's `context.go`/`context.push` calls — don't assume it was followed.
2. Verify the "Flow (final)" sequence renders as one continuous path on the emulator, start to finish.
3. Fix any mismatches found.
4. Re-grep the whole `lib/` tree for `pushNamed` — must return zero.
5. **Orphan cleanup:** every route in `router.dart` must map to exactly one spec screen. Delete/retire routes for anything superseded during this rebuild (`/setup/*`, `/scanning/*` if Step 3 already consolidated them, any remaining `/measurement/a1-a9` not chosen in Step 3's mapping, `/design/b4` if it had no spec counterpart, `/onboarding/e9` per Step 3's decision, `/estimation/e10` if renamed). Confirm via `dart analyze` that no dangling imports remain.

### Verification
```bash
cd /home/rimefara/projects/tamir_uy_mobile_flutter
grep -rn "pushNamed" lib/   # must return zero results
dart analyze lib/
flutter run -d emulator-5554  # walk the full "Flow (final)" sequence end to end
git add -A && git commit -m "step 12: navigation wiring + orphan cleanup"
```

### Exit criteria
- `grep -rn "pushNamed" lib/` returns nothing.
- Every row of the button-wiring table individually checked against code, not spot-checked.
- Every route in `router.dart` maps to exactly one spec screen — no orphans.
- Full end-to-end flow completes without a broken link.

### Rollback
`git checkout -- lib/config/router.dart` plus any individual screen navigation-call fixes.

---

## Step 13 — Final QA / regression pass (last gate)
**Model tier:** strongest for the adversarial side-by-side design review; default for mechanical test/analyze runs.
**Depends on:** Step 12

### Tasks
1. Run the automated check suite:
   ```bash
   dart analyze lib/
   dart format lib/ --set-exit-if-changed || dart format lib/   # review the diff if not already CI-enforced
   flutter test   # confirm the stale default widget_test.dart was removed/rewritten (see Environment notes)
   ```
2. Full manual walkthrough of every one of the 55 screens on the emulator, each compared side-by-side against its frame in `UyTamir Final.dc.html`. Produce a **committed checklist file** (`plans/screen-audit-checklist.md`, one row per screen ID: `copy ✓/✗ | tokens ✓/✗ | layout ✓/✗ | wiring ✓/✗ | notes`) — this is the artifact the acceptance bar requires; a verbal "looks good" is not sufficient. Exempt E7 slide 3 from layout comparison (no reference frame exists, per Step 8's note).
3. Re-verify the three hard business rules holistically: (a) no price shown before E1, (b) delta mechanic agrees everywhere it's displayed (A2, B/C/D stage-lines, E1's gray-struck-through rows, E7's slide 2 — all for the same simulated `roomState`), (c) electrical only reachable after C9.
4. Confirm login still works (`rimefara`/`12345678`) and the splash-loop bug hasn't regressed (`_GoRouterRefreshNotifier` intact in `router.dart`).
5. Grep for and remove the "BACKWARD COMPATIBILITY ALIASES" block in `design_tokens.dart` if nothing references it anymore (confirm via grep first, don't assume).
6. Produce a final findings summary: any screen not meeting the 100%-match bar gets logged with specifics in the checklist file for a follow-up pass — never silently declared "done" with known gaps.

### Exit criteria
- All 55 screens have a row in `plans/screen-audit-checklist.md`, and every row is ✓ across all four columns, or the gap is explicitly logged.
- `dart analyze` and `flutter test` clean.
- Full flow walkthrough works without errors or dead ends.
- No regression of previously-fixed bugs (splash loop, `pushNamed` crashes, double-Scaffold/BottomNav).

### Rollback
N/A — verification-only step; findings drive follow-up work, no code changes except the alias-block cleanup and `dart format`.

---

## Parallelism summary
- **Serial spine:** 1 → 2 → 3 → 4 → {5|6|7|8 parallel} → 9 → 10 → 11 → 12 → 13
- **Parallel wave after Step 4:** Steps 5, 6, 7, 8 (shared-file protocol above keeps `router.dart`/`app_shell.dart` conflict-free)
- **Serial sub-chain within the wave:** 9 depends on 5 only (not 6/7/8); 10 depends on 9; 11 depends on 10 AND 8 (menu wiring + placeholder backfills)
- Total: 13 steps, 4-way parallelism available mid-plan, critical path ≈ 10 steps (1→2→3→4→5→9→10→11→12→13).
