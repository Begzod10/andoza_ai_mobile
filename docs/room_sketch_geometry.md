# Room sketch — geometry pipeline & tuning

The "O'zingiz chizing" (Draw your own) screen turns a finger sketch or a
tapped/dragged polygon into a clean `RoomPlan`. All the geometry is a pure,
UI-free layer so it can be unit-tested and reused.

## Layers

- `lib/geometry/room_geometry.dart` — pure geometry (only `dart:math`): `Vec2`,
  `shoelaceArea`, `perimeter`, `boundingSize`, `resample`, `rdpSimplify`,
  `mergeCloseVertices`, `snapAngleRad`, `regularize`, `regularizeFreehand`,
  `removeCollinearVertices`, `isSelfIntersecting`, `formatLength`, `roundTo`.
- `lib/geometry/geometry_config.dart` — **every tuning constant** (below).
- `lib/models/room_plan.dart` — the unified `RoomPlan{corners, walls,
  ceilingHeightM, source}` contract (N corners, not hardcoded to 4) with
  `isValid` / `invalidReason` / `boundingSize`.
- `lib/services/room_plan_handoff.dart` — maps a `RoomPlan` onto the existing
  rectangular pipeline (by bounding size) → persists → opens the 3D Studio.
- `lib/widgets/room/iso_projector.dart` + `isometric_room_view.dart` — the
  shared isometric 3D renderer (rectangle + polygon).

## Freehand pipeline (`regularizeFreehand`)

Raw finger stroke → `resample` (even spacing) → `rdpSimplify` (corner
candidates) → `mergeCloseVertices` → `regularize` (snap edge angles, round
lengths, re-close, drop collinear points). The result is a clean closed
polygon; wobbly straight walls collapse to a single wall, but genuinely skewed
rooms keep their free angles.

## Angle snapping

Each edge direction is snapped to the nearest multiple of a base angle in
`snapBasesDeg` **only if within `angleSnapToleranceDeg`**; otherwise the free
angle is kept. Default bases are `[90, 45]` (right angles + diagonals). A 15°
base is intentionally *not* on by default: a 15° grid is finer than
2×tolerance, which would leave no "free angle" band and force every wall to a
grid — breaking the "real rooms aren't always square" requirement. Add `15.0`
to `snapBasesDeg` if you want a finer grid and accept losing free angles.

## Tuning constants (`GeometryConfig`)

| Constant | Default | Meaning |
|---|---|---|
| `resampleStepM` | 0.10 m | Even-spacing of a raw stroke before simplifying |
| `rdpEpsilonM` | 0.12 m | RDP corner tolerance (larger → fewer corners) |
| `mergeDistM` | 0.20 m | Vertices closer than this merge into one |
| `angleSnapToleranceDeg` | 12° | Snap an edge only within this of a base angle |
| `snapBasesDeg` | [90, 45] | Base angles edges snap to |
| `collinearToleranceDeg` | 8° | Turn below this = straight → vertex removed |
| `wallLengthStepM` | 0.05 m | Wall lengths rounded to 5 cm |
| `minWallM` | 0.30 m | Minimum wall length |
| `minAreaWarnM2` / `maxAreaWarnM2` | 2 / 200 m² | Soft area warning (never blocks) |
| `minHeightM` / `maxHeightM` / `defaultHeightM` | 2.0 / 5.0 / 2.8 m | Ceiling clamp + default |
| `autoCloseDistM` | 0.50 m | Freehand auto-closes if the end is this near the start |

## Validity

`RoomPlan.isValid` requires ≥3 corners, a simple (non-self-intersecting)
polygon, every wall ≥ `minWallM`, and a ceiling height in range. When invalid,
`invalidReason` gives a short user-facing message (the Yakunlash button shows
it while disabled).

## Handoff note

The backend room + web 3D Studio currently render a **rectangular** room, so a
polygon `RoomPlan` is handed off by its bounding width × length. The full
polygon is preserved on `RoomPlan` as a clean extension point for a future
polygon-aware Studio.
