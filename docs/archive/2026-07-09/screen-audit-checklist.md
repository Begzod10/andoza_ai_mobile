# Screen Audit Checklist (Step 13)

Source of truth for `layout` comparison: `UyTamir Final.dc.html` in the design
zip. Columns: **copy** (Uzbek text matches spec), **tokens** (colors/type/
spacing come from `DesignTokens`, not hand-picked values), **wiring**
(navigation matches the README's button-wiring table — verified in Step 12
by grepping every screen's `context.go`/`push` calls against the table),
**layout** (pixel/structure side-by-side against the HTML mockup).

**Honesty note on `layout`:** this sandbox's Android emulator crashed
repeatedly throughout the rebuild (5+ times across Steps 4-5) and was not
running at the time of this Step 13 pass. No screen in this checklist has
had a live side-by-side visual comparison performed *during Step 13*
specifically — `layout` is marked `code-reviewed` (structure/spacing verified
by reading the widget tree against the spec's prose description) rather than
`✓`, except where explicitly noted otherwise. A real emulator or browser
pass against `UyTamir Final.dc.html` is the outstanding follow-up work for
100% layout confidence, not something this pass can honestly claim.

| Screen | copy | tokens | wiring | layout | Notes |
|---|---|---|---|---|---|
| Splash | ✓ | ✓ | ✓ | code-reviewed | Real brand assets (andozaai-mark.png), dark radial gradient. |
| A1 | ✓ | ✓ | ✓ | code-reviewed | Story circles → E7/E8, quick actions → E1/S1, empty state uses shared `EmptyStatePattern`. |
| A2 | ✓ | ✓ | ✓ (fixed Step 12) | code-reviewed | "Davom etish" was going to B1 instead of B2 — fixed in Step 12. |
| A3 | ✓ | ✓ | ✓ | code-reviewed | Bottom sheet, 3 entry paths → A4/A5/A6. |
| A4 | ✓ | ✓ | ✓ | code-reviewed | LiDAR scan placeholder + green wireframe sweep animation. |
| A5 | ✓ | ✓ | ✓ | code-reviewed | 360° capture placeholder + pulse animation. |
| A6 | ✓ | ✓ | ✓ | code-reviewed | Manual dimensions entry → A7. |
| A7 | ✓ | ✓ | ✓ | code-reviewed | Wall-by-wall cycling, last wall → A9. |
| A8 | ✓ | ✓ | ✓ | code-reviewed | Modal sheet from A7, not a standalone route (matches spec). |
| A9 | ✓ | ✓ | ✓ | code-reviewed | Real computed floor/wall/perimeter stats; builds real Room/DesignSelection → B1. |
| B1 | ✓ | ✓ | ✓ | code-reviewed | Single condition question via `RoomConditionCard`. |
| B1-alt | ✓ | ✓ | ✓ | code-reviewed | Floor/ceiling picker sheet from B1, not a standalone route (matches spec). |
| B2 | ✓ | ✓ | ✓ | code-reviewed | First-person entry via `RoomPerspectiveView`. |
| B3 | ✓ | ✓ | ✓ | code-reviewed | Rail opens, drag-to-wall onboarding overlay. |
| C1 | ✓ | ✓ | ✓ | code-reviewed | Consolidated: covers spec's C1 (rail open) + C2 (drag mid-action) + C3 (applied toast) as one continuous screen — documented deviation, see file's doc comment. |
| C2 | — | — | — | — | No standalone screen; covered by C1 (see above). |
| C3 | — | — | — | — | No standalone screen; covered by C1 (see above). |
| C4 | ✓ | ✓ | ✓ | code-reviewed | Floor material selection. |
| C5 | ✓ | ✓ | ✓ | code-reviewed | Consolidated: covers spec's C5 (furniture placement) + C6 (selected-item sheet, via `FurnitureEditCard`) — documented deviation. |
| C6 | — | — | — | — | No standalone screen; covered by C5 (see above). |
| C7 | ✓ | ✓ | ✓ | code-reviewed | First-person walkthrough with joystick. |
| C8 | ✓ | ✓ | ✓ | code-reviewed | Reuses existing `RoomCanvas` widget for top-down mode. |
| C9 | ✓ | ✓ | ✓ | code-reviewed | Decoration complete → D1 (only entry point into electrical, confirmed in Step 13's rule-c re-check). |
| D1 | ✓ | ✓ | ✓ | code-reviewed | Consolidated: covers spec's D1-D7 (3-tab rail: Elektr/Yorug'lik/Santexnika, box-first gating, socket-near-furniture detection) — documented deviation. |
| D2 | — | — | — | — | No standalone screen; covered by D1 (see above). |
| D3 | — | — | — | — | No standalone screen; covered by D1 (see above). |
| D4 | — | — | — | — | No standalone screen; covered by D1 (see above). |
| D5 | — | — | — | — | No standalone screen; covered by D1 (see above). |
| D6 | — | — | — | — | No standalone screen; covered by D1 (see above). |
| D7 | — | — | — | — | No standalone screen; covered by D1 (see above). |
| D8 | ✓ | ✓ | ✓ | code-reviewed | 2D/3D toggle, real `WireRoutingView` + recompute button. |
| D9 | ✓ | ✓ | ✓ | code-reviewed | Rewritten from a price-showing "Detailed Cost Estimate" bug to quantities-only "Elektr natijasi". |
| D10 | ✓ | ✓ | ✓ | code-reviewed | Finished-room overlay → E1, no price shown (confirmed in rule-a re-check). |
| U1 | ✓ | ✓ | ✓ | code-reviewed | Real `FlutterMap`, trade filter chips, list-view FAB → U3. |
| U2 | ✓ | ✓ | ✓ | code-reviewed | `_PinSheet` bottom sheet from U1, not a standalone route (matches spec). |
| U3 | ✓ | ✓ | ✓ | code-reviewed | List view, online-first sort. |
| U4 | ✓ | ✓ | ✓ | code-reviewed | Full profile, 800m approximate-zone circle only (privacy rule). |
| U5 | ✓ | ✓ | ✓ (backfilled Step 11) | code-reviewed | Send-smeta figure now reads the real `estimateProvider` total (was a Step-6 placeholder). |
| S1 | ✓ | ✓ | ✓ | code-reviewed | Project banner reads real state, not a hardcoded string. |
| S2 | ✓ | ✓ | ✓ | code-reviewed | Grouped-by-stage list computed from real project/electrical data. |
| S3 | ✓ | ✓ | ✓ | code-reviewed | Real computed project-quantity recommendation card. |
| S4 | ✓ | ✓ | ✓ | code-reviewed | Dealer comparison, cheapest gets "ENG YAXSHI". |
| S5 | ✓ | ✓ | ✓ | code-reviewed | Real grouped-by-dealer cart. |
| S6 | ✓ | ✓ | ✓ | code-reviewed | In-app payment tiles only, no external redirect, no card data collected. |
| S7 | ✓ | ✓ | ✓ | code-reviewed | Real order-status stepper, reused by E6's order-card tap-through. |
| E1 | ✓ | ✓ | ✓ | code-reviewed | Real Estimate; excluded stages render gray/struck-through/"hisoblanmadi"; green savings banner is computed, not hardcoded. |
| E2 | ✓ | ✓ | ✓ | code-reviewed | Real itemized material/labor lines (qty × unit price). |
| E3 | ✓ | ✓ | ✓ | code-reviewed | Tier switch + DIY toggle live-recompute (verified by 5 unit tests). |
| E4 | ✓ | ✓ | ✓ | code-reviewed | Stat cards now real (project count, order count, real savings — "tejaldi" backfilled from Step 8's placeholder). |
| E5 | ✓ | ✓ | ✓ (fixed Step 12) | code-reviewed | Reuses A2's real `homeStateProvider` project list; also serves as A2's "Barchasi"/E9 destination. Card tap was going to B1 instead of B2 — fixed in Step 12. |
| E6 | ✓ | ✓ | ✓ | code-reviewed | Real (session-local) order history from a new `ordersProvider`, appended by every S6 checkout; also bound to `/history` (intentional, spec has no separate history concept). |
| E7 | ✓ | ✓ | ✓ | code-reviewed | 4-slide dark PageView; slide 2 uses the real `existingStateGray`/`delta.completed` tokens, not arbitrary colors. |
| E8 | ✓ | ✓ | ✓ | code-reviewed | Video placeholder + 5-step list → A3. |
| E9 | ✓ | ✓ | ✓ | — | Alias for E5, not a separate screen (per spec). |
| E10 | ✓ | ✓ | ✓ | code-reviewed | Rebuilt from an unrelated "final estimate export" screen that was squatting on the E10 slot (numbering collision); real search over the shop catalog. |
| E11 | ✓ | ✓ | ✓ | code-reviewed | Reusable `EmptyStatePattern` widget (dashed card via custom painter); retrofitted into A1's empty-project card. |

## Business-rule re-verification (Step 13, task 3)

- **(a) No price before E1:** `grep -rn "so'm" lib/screens/` and a matching
  `UZS` sweep, both excluding `estimation/`, `shop/`, `masters/u4`,
  `masters/u5`, `profile/e6` — zero unexpected matches. The 3 files that do
  still contain `UZS` (`design/b2_floor_selection_screen.dart`,
  `b3_paint_selection_screen.dart`, `b4_preview_screen.dart`) are unrouted
  reference-only files from Step 3/9's reconciliation, unreachable from any
  live navigation path.
- **(b) Delta mechanic agrees everywhere:** A2/E5's project cards, every
  in-3D-room stage line (B3/C1/C4/C5/C7/D1 etc. via `StageProgressLine`),
  E1's stage rows, and E7's slide 2 all derive from the same
  `deriveStageStates` function in `design_selection_model.dart` — not
  independent copies. Covered by 10 tests in
  `test/unit/renovation_delta_test.dart` plus 5 in
  `test/unit/estimate_provider_test.dart`.
- **(c) Electrical only reachable after C9:** `grep -rn "'/electrical/d1'"
  lib/` shows exactly one caller (`c9_decoration_complete_screen.dart`) plus
  the route definition itself — no other entry point exists.

## Automated checks (Step 13, task 1)

- `dart analyze lib/` — 0 errors (18 pre-existing info/warning-level issues
  in files untouched by this rebuild, e.g. deprecated `withOpacity`).
- `dart format lib/ --set-exit-if-changed` — clean, 0 files changed.
- `flutter test` — 15/15 passing. The stale default `test/widget_test.dart`
  (a counter-app smoke test unrelated to this app) was deleted in Step 13.

## Login / splash-loop regression check (Step 13, task 4)

- `_GoRouterRefreshNotifier` in `router.dart` still bridges
  `authStateProvider` via `ref.listen` (not `ref.watch`) — the original
  splash-loop fix is intact.
- Login credentials (`rimefara` / `12345678`) are backend account data set
  up earlier in this session, not app code — nothing to regress in the
  Flutter source. **Not re-verified live in this pass**: the emulator was not
  running at Step 13 time (see the layout-column honesty note above); the
  backend containers (`tamir_uy-api-1` etc.) are confirmed up via `docker
  ps`.

## Known gaps for follow-up (Step 13, task 6)

1. **Live visual verification.** Every `layout` cell above is
   `code-reviewed`, not an actual emulator/browser side-by-side against
   `UyTamir Final.dc.html`. This is the single biggest outstanding item
   before declaring 100% pixel fidelity — needs a stable emulator (or the
   HTML file opened in a browser next to real device screenshots).
2. **Consolidated screens** (C2/C3/C6, D2-D7, B1-alt, U2) intentionally have
   no standalone file/route — they're covered by a continuous parent screen
   per this rebuild's explicit, documented architecture decision. If a
   future audit requires literal 1:1 screen-to-file correspondence, these
   11 spec-numbered "screens" would need to be split out.
3. **Reference-only dead files** (`design/b2_floor_selection_screen.dart`,
   `b3_paint_selection_screen.dart`, `b4_preview_screen.dart`) still exist,
   still compile, still show `UZS` prices, but are unrouted. They were kept
   as reference material for Batch C's rebuild per Step 3's decision; they
   could now be deleted outright since Batch C is complete and they've
   served their purpose — not done in this pass to avoid scope creep beyond
   Step 13's stated task list.
4. **E1-E3's pricing constants** are mock-but-plausible (explicitly, per the
   plan), not real market rates — expected and documented, not a defect.
