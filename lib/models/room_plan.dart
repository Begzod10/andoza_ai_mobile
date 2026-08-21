import '../geometry/geometry_config.dart';
import '../geometry/room_geometry.dart';

/// Where a [RoomPlan] came from. The unified output of every room-capture
/// method (so all four flows can produce the same contract).
enum RoomSource { lidar, photo, wizard, sketch, drag }

/// One wall of a [RoomPlan], referencing two corner indices.
class RoomWall {
  /// Index of the start corner in [RoomPlan.corners].
  final int a;

  /// Index of the end corner in [RoomPlan.corners].
  final int b;

  /// Wall length in metres.
  final double lengthM;

  const RoomWall(this.a, this.b, this.lengthM);
}

/// The unified room contract: a closed, ordered polygon of corners (metres),
/// its walls, ceiling height and origin. NOT hardcoded to 4 walls — L-shaped
/// and other N-corner rooms are valid.
class RoomPlan {
  /// Ordered polygon corners in metres (closing edge is implied corners.last →
  /// corners.first).
  final List<Vec2> corners;
  final List<RoomWall> walls;
  final double ceilingHeightM;
  final RoomSource source;

  const RoomPlan({
    required this.corners,
    required this.walls,
    required this.ceilingHeightM,
    required this.source,
  });

  /// Build a plan from ordered corners, deriving the walls.
  factory RoomPlan.fromCorners(
    List<Vec2> corners, {
    required double ceilingHeightM,
    required RoomSource source,
  }) {
    final walls = <RoomWall>[
      for (var i = 0; i < corners.length; i++)
        RoomWall(i, (i + 1) % corners.length,
            corners[i].distanceTo(corners[(i + 1) % corners.length])),
    ];
    return RoomPlan(
      corners: List.unmodifiable(corners),
      walls: List.unmodifiable(walls),
      ceilingHeightM: ceilingHeightM,
      source: source,
    );
  }

  double get areaM2 => shoelaceArea(corners);
  double get perimeterM => perimeter(corners);

  /// Axis-aligned bounding size — used by the adapter that maps a plan onto the
  /// existing rectangular room pipeline / 3D Studio.
  ({double width, double length}) get boundingSize => boundingSize2(corners);

  bool get isRectangleLike => corners.length == 4;

  /// True only for a plain axis-aligned rectangle (4 corners, every edge purely
  /// horizontal or vertical). Real polygons — L-shapes, trapezoids, triangles,
  /// skewed quads — are false, so the handoff persists their true vertices +
  /// N walls instead of collapsing them to a bounding box.
  bool get isAxisAlignedRect => isAxisAlignedRectangle(corners);

  /// A plan is valid when it is a simple (non-self-intersecting) closed polygon
  /// of ≥3 corners, each wall is at least [GeometryConfig.minWallM], and the
  /// ceiling height is in range.
  bool get isValid =>
      corners.length >= 3 &&
      !isSelfIntersecting(corners) &&
      walls.every((w) => w.lengthM >= GeometryConfig.minWallM) &&
      ceilingHeightM >= GeometryConfig.minHeightM &&
      ceilingHeightM <= GeometryConfig.maxHeightM;

  /// A human reason the plan can't be finished yet, or null when [isValid].
  String? get invalidReason {
    if (corners.length < 3) return 'Kamida 3 ta burchak kerak';
    if (isSelfIntersecting(corners)) return 'Devorlar kesishmasligi kerak';
    if (walls.any((w) => w.lengthM < GeometryConfig.minWallM)) {
      return 'Har bir devor kamida ${formatLength(GeometryConfig.minWallM)}';
    }
    if (ceilingHeightM < GeometryConfig.minHeightM ||
        ceilingHeightM > GeometryConfig.maxHeightM) {
      return 'Balandlik ${GeometryConfig.minHeightM}–${GeometryConfig.maxHeightM} m';
    }
    return null;
  }
}

/// Small alias so [RoomPlan.boundingSize] can call the free function without a
/// name clash with the getter.
({double width, double length}) boundingSize2(List<Vec2> poly) =>
    boundingSize(poly);
