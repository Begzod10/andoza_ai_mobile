import '../models/room_model.dart';
import '../models/room_plan.dart';

/// Real floor/wall area for the active room, falling back to a typical
/// single-room baseline when the user hasn't gone through Batch A yet —
/// same semantic-default rationale as home_empty_screen.dart's
/// [ProjectItem]. Shared by shop_provider.dart (Do'kon quantities) and
/// estimate_provider.dart (Smeta pricing) so both agree on the same
/// project size.
typedef ProjectAreas = ({double floorArea, double wallArea});

/// Prefers the polygon [RoomPlan] as the source of truth when present — its
/// true [RoomPlan.areaM2] (shoelace) and [RoomPlan.netWallAreaM2] make
/// L-shapes/trapezoids accurate — and falls back to the legacy [Room] path
/// (bounding floor + summed wall band) when only a legacy room exists.
///
/// For an axis-aligned rectangle the two paths are numerically identical, so
/// existing rectangular rooms' estimates are unchanged.
ProjectAreas computeProjectAreas(Room? room, {RoomPlan? plan}) {
  if (plan != null) {
    final floorArea = plan.areaM2;
    final wallArea = plan.netWallAreaM2;
    return (
      floorArea: floorArea > 0 ? floorArea : 18.0,
      wallArea: wallArea > 0 ? wallArea : 48.0,
    );
  }
  if (room == null) {
    return (floorArea: 18.0, wallArea: 48.0);
  }
  final floorArea = room.dimensions.width * room.dimensions.length;
  final wallArea = room.walls.fold<double>(
    0,
    (sum, w) => sum + w.measurements.height * w.measurements.length,
  );
  return (
    floorArea: floorArea > 0 ? floorArea : 18.0,
    wallArea: wallArea > 0 ? wallArea : 48.0,
  );
}
