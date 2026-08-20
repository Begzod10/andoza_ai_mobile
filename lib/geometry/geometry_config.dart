/// Tuning constants for the room-sketch geometry pipeline.
///
/// Every magic number used by the geometry layer lives here so behaviour can be
/// tuned in one place (no numbers scattered through the code). Distances are in
/// metres, angles in degrees.
class GeometryConfig {
  const GeometryConfig._();

  /// Even-spacing step used to normalise a raw freehand stroke before
  /// simplification (m).
  static const double resampleStepM = 0.10;

  /// Ramer–Douglas–Peucker tolerance for corner detection (m). Larger → fewer
  /// corners.
  static const double rdpEpsilonM = 0.12;

  /// Vertices closer than this are merged into a single corner (m).
  static const double mergeDistM = 0.20;

  /// An edge's direction is snapped to the nearest "nice" angle only when it is
  /// within this tolerance; otherwise the free angle is kept — real rooms are
  /// not always square.
  static const double angleSnapToleranceDeg = 12.0;

  /// The base angles edges snap to: directions are pulled to the nearest
  /// multiple of any of these. Defaults to right angles (90°) and diagonals
  /// (45°); their multiples give the {0,45,90,135,…} grid. A 15° base is
  /// deliberately NOT included by default — a 15° grid is finer than
  /// 2×[angleSnapToleranceDeg], which would leave no "free angle" band and so
  /// break the keep-free-angle requirement. Add 15.0 here to enable it.
  static const List<double> snapBasesDeg = [90.0, 45.0];

  /// After angle-snapping, a vertex whose turn is smaller than this is treated
  /// as a straight (collinear) point and removed — this is what turns a wobbly
  /// straight wall into one clean wall.
  static const double collinearToleranceDeg = 8.0;

  /// Wall lengths are rounded to this step (m) = 5 cm.
  static const double wallLengthStepM = 0.05;

  /// Minimum allowed wall length (m). Drags/shapes below this are rejected.
  static const double minWallM = 0.30;

  /// Soft floor-area bounds (m²) — outside this we warn but do NOT block.
  static const double minAreaWarnM2 = 2.0;
  static const double maxAreaWarnM2 = 200.0;

  /// Ceiling-height clamp (m) and default.
  static const double minHeightM = 2.0;
  static const double maxHeightM = 5.0;
  static const double defaultHeightM = 2.8;

  /// A freehand stroke auto-closes if its end lands within this of its start
  /// (m).
  static const double autoCloseDistM = 0.50;
}
