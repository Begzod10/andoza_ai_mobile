# Screen-Mapping Reconciliation (Step 3)

Decided by reading actual file content (class doc-comments, models, widget structure) against the design spec — not by filename alone. Three competing partial implementations of Batch A's capture flow existed; the design/b1-b4 "Batch B vs C" question turned out to be per-file, not a clean batch reassignment.

## Batch A (capture/measurement flow)

| Spec screen | Chosen source file | Files retired | Rationale |
|---|---|---|---|
| A3 ("+" bottom sheet: LiDAR/360°/manual entry) | **none — build fresh in Step 4** | `room_setup/room_selection_sheet.dart` | That file's own doc-comment says "A3" but it's actually a room-**type** picker (Living Room/Bedroom/Kitchen/Office/Garage/Hallway/Custom) — a concept that does not exist anywhere in the spec. No existing file implements the real A3 (3 entry-path cards: LiDAR skaner / 360° Foto skan / Razmer-Plan yuklash). |
| A4 (LiDAR scan) | `scanning/lidar_scanning_screen.dart` | `measurement/a6_lidar_screen.dart` | `scanning/` version (429 lines) has point-cloud/progress-ring/battery patterns closer to spec's progress-ring-67%+live-footer-counts; `measurement/a6` (234 lines) is thinner and English-generic. |
| A5 (360° capture) | `scanning/photo_scanning_screen.dart` | `measurement/a7_photo_screen.dart` | Same reasoning — `scanning/` version (446 lines) tracks capture progress more elaborately than `measurement/a7` (268 lines). Progress-counting logic (currently "12 photos") needs changing to the spec's "8 point markers on a dashed circle" model in Step 4. |
| A6 (manual dimensions/floorplan) | `room_setup/dimensions_entry_screen.dart` | `measurement/a4_dimensions_screen.dart`, `measurement/a5_furniture_screen.dart` | Own doc-comment confirms "A6"; has the tab/unit/summary structure the spec needs. Note: has a local duplicate `RoomDimensions` class — Step 4 must reconcile this with the canonical `lib/models/room_model.dart`'s `RoomDimensions`, not keep both. |
| A7 (wall-by-wall measurement) | `room_setup/wall_measurements_screen.dart` | `measurement/a2_camera_screen.dart` | Own doc-comment confirms "A7"; has real per-wall state (length/height/type/features) matching the spec's wall-by-wall elevation UI. Uses a local `WallMeasurement` class — Step 4 must reconcile with `lib/models/room_model.dart`'s `WallType`/`OpeningType`, not keep both. |
| A8 (opening-add sheet) | `room_setup/door_window_modal.dart` | `measurement/a3_room_name_screen.dart` | Structurally matches spec's type/preset-size/position sheet. Same model-duplication caveat as A7 (`DoorWindowFeature` vs canonical `OpeningType`). |
| A9 (room summary) | `room_setup/room_summary_screen.dart` | `measurement/a1_start_screen.dart`, `measurement/a8_review_screen.dart`, `measurement/a9_summary_screen.dart` | Own doc-comment confirms "A9"; already has `_MetricCard` stat-card widgets matching the spec's 4-stat-card layout. |

**Deleted in this step:** all 9 files in `lib/screens/measurement/a1-a9*.dart`, plus `lib/screens/room_setup/room_selection_sheet.dart`. Their router.dart routes (`/measurement/a1`-`/measurement/a9`, `/setup/room-selection`) removed along with them.

**Retained but stripped:** `lib/screens/measurement/measurement_stubs.dart` — kept only for its generic `MeasurementStub` class (still used by other genuinely-not-yet-built routes: `/design/complete`, `/electrical/complete`, `/shop/s2`, `/shop/s3`, `/shop/s4`, `/shop/s6`). Its duplicate `A2CameraScreen`...`A9SummaryScreen` stub classes (which existed only to be `hide`-imported around by router.dart to avoid a name collision with the now-deleted real files) are removed.

## Batch B vs Batch C (`lib/screens/design/b1-b4`)

Per-file, not a blanket reassignment:

| File | Verdict | Rationale |
|---|---|---|
| `b1_room_intro_screen.dart` | **Correctly Batch B — keep, refine content in Step 5.** | Own doc-comment: "B1: Room Introduction & Baseline Condition Selection... select current surface condition." This is exactly spec's real B1 ("Xonangiz hozir qaysi holatda?"). |
| `b2_floor_selection_screen.dart` | **Reference-only for Step 9's C4 — not a direct destination.** | Content (floor material browsing) matches spec's C4 concept, but spec requires this to happen via drag-from-rail-onto-the-3D-floor, not a standalone full-screen picker. Salvage any reusable swatch-grid widget code into the new `room_3d_rail.dart`-based C4 screen; retire the standalone screen once salvaged. |
| `b3_paint_selection_screen.dart` | **Reference-only for Step 9's C1 — not a direct destination.** | Same reasoning as b2, for spec's C1 (Bo'yoq/Oboi). |
| `b4_preview_screen.dart` | **Reference-only, no clean spec-screen match.** | "Design Preview & Confirmation" doesn't correspond to any single spec screen; closest analog is C9's completion screen, but C9's actual framing ("Bezash yakunlandi" + CTA to Elektrga o'tish) is simpler. Consult if Step 9 needs a selections-summary pattern, otherwise leave unrouted/retire. |

Spec's actual B1-alt, B2, B3 (floor/ceiling sheet, entering the 3D room, right-rail decoration begins) **do not exist in this codebase in any form** — build fresh in Step 5.

## E9 reconciliation

`lib/screens/onboarding/e9_preferences_settings_screen.dart` ("E9: App Preferences & Settings" — notifications/display) has **no relationship** to the spec's own E9 concept (spec: "E9 = not built separately, = E5 Loyihalarim/Barcha loyihalar"). This file is a legitimate settings screen that just happens to have collided on the "E9" label.

**Decision:** keep the file, but re-route it from the top-level `/onboarding/e9` to `/profile/settings`, reachable only via E4's "⚙️ Sozlamalar" menu item (wire this in Step 8, not as its own batch/tab screen). Uzbek-ify its copy at that point.

## Execution
All deletions and router changes for this table were made directly in this step (Step 3), not deferred — see the commit for this step.
