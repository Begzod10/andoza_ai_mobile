import 'dart:math' as math;
import 'dart:ui' show Offset, Size;

/// Pure, widget-free isometric projector for an N-corner room prism.
///
/// Given a floor polygon (corners in METRES, `x = Offset.dx`, `y = Offset.dy`),
/// a room [heightM] and a target [canvasSize], it:
///   1. normalises so the largest floor extent is 1.0 (keeps aspect ratio),
///   2. rotates the floor by [orbitRad] around the floor centroid,
///   3. isometric-projects with `((x-y)cos30, (x+y)sin30 - z*heightScale)`,
///   4. auto-fits every floor (z=0) and top (z=height) corner into the canvas
///      with [padPx] padding, yielding a [scale] and screen [origin].
///
/// The whole (x, y) → screen map at z=0 is a constant affine map, so its linear
/// part is a fixed 2×2 matrix. [floorDeltaFromScreen] inverts that matrix to
/// turn a screen drag into a floor-plane metre delta, and
/// [heightMetrePerScreenY] exposes the vertical (z) scale for height drags.
class IsoProjector {
  IsoProjector({
    required List<Offset> floorCornersM,
    required this.heightM,
    required Size canvasSize,
    this.orbitRad = 0,
    this.heightScale = 0.85,
    this.padPx = 24,
  })  : _floorM = List<Offset>.unmodifiable(floorCornersM),
        _cosO = math.cos(orbitRad),
        _sinO = math.sin(orbitRad) {
    assert(floorCornersM.isNotEmpty, 'floorCornersM must not be empty');

    // Floor centroid (rotation pivot).
    var sx = 0.0, sy = 0.0;
    for (final c in _floorM) {
      sx += c.dx;
      sy += c.dy;
    }
    _cx = sx / _floorM.length;
    _cy = sy / _floorM.length;

    // Largest floor extent → normalisation so that extent maps to 1.0.
    var minX = double.infinity, maxX = -double.infinity;
    var minY = double.infinity, maxY = -double.infinity;
    for (final c in _floorM) {
      minX = math.min(minX, c.dx);
      maxX = math.max(maxX, c.dx);
      minY = math.min(minY, c.dy);
      maxY = math.max(maxY, c.dy);
    }
    final maxDim =
        math.max(maxX - minX, maxY - minY).clamp(0.1, double.infinity);
    _sNorm = 1.0 / maxDim;
    _maxDim = maxDim.toDouble();

    // Fit: project all floor+top corners (pre-scale) and find their bounds.
    final raw = <Offset>[
      for (final c in _floorM) _raw(c.dx, c.dy, 0),
      for (final c in _floorM) _raw(c.dx, c.dy, heightM),
    ];
    var rminX = double.infinity, rmaxX = -double.infinity;
    var rminY = double.infinity, rmaxY = -double.infinity;
    for (final p in raw) {
      rminX = math.min(rminX, p.dx);
      rmaxX = math.max(rmaxX, p.dx);
      rminY = math.min(rminY, p.dy);
      rmaxY = math.max(rmaxY, p.dy);
    }
    final spanX = (rmaxX - rminX).clamp(1e-6, double.infinity);
    final spanY = (rmaxY - rminY).clamp(1e-6, double.infinity);
    scale = math.min(
      (canvasSize.width - 2 * padPx) / spanX,
      (canvasSize.height - 2 * padPx) / spanY,
    );
    origin = Offset(
      padPx - rminX * scale + (canvasSize.width - 2 * padPx - spanX * scale) / 2,
      padPx -
          rminY * scale +
          (canvasSize.height - 2 * padPx - spanY * scale) / 2,
    );

    // Linear part of the z=0 floor map, by exact finite difference (the map is
    // affine, so these differences are exact). Columns of the 2×2 matrix M.
    final o = project(0, 0, 0);
    final mx = project(1, 0, 0) - o; // M · (1,0)
    final my = project(0, 1, 0) - o; // M · (0,1)
    _m00 = mx.dx;
    _m10 = mx.dy;
    _m01 = my.dx;
    _m11 = my.dy;
    final det = _m00 * _m11 - _m01 * _m10;
    final invDet = det.abs() < 1e-12 ? 0.0 : 1.0 / det;
    _inv00 = _m11 * invDet;
    _inv01 = -_m01 * invDet;
    _inv10 = -_m10 * invDet;
    _inv11 = _m00 * invDet;
  }

  final double heightM;
  final double orbitRad;
  final double heightScale;
  final double padPx;

  final List<Offset> _floorM;
  final double _cosO;
  final double _sinO;

  late final double _cx;
  late final double _cy;
  late final double _sNorm;
  late final double _maxDim;

  /// Screen-space scale factor (metres·normalised → pixels) after auto-fit.
  late final double scale;

  /// Screen-space translation applied after [scale].
  late final Offset origin;

  // Inverse of the z=0 floor linear map (screen → floor metres).
  late final double _m00, _m01, _m10, _m11;
  late final double _inv00, _inv01, _inv10, _inv11;

  static const _cos30 = 0.8660254; // cos(30°)
  static const _sin30 = 0.5; // sin(30°)

  /// Pre-scale isometric position of a world point (metres).
  Offset _raw(double xM, double yM, double zM) {
    // Translate to centroid, rotate by orbit, normalise.
    final dx = xM - _cx;
    final dy = yM - _cy;
    final rx = dx * _cosO - dy * _sinO;
    final ry = dx * _sinO + dy * _cosO;
    final nx = rx * _sNorm;
    final ny = ry * _sNorm;
    final nz = zM * _sNorm;
    return Offset(
      (nx - ny) * _cos30,
      (nx + ny) * _sin30 - nz * heightScale,
    );
  }

  /// Full world (metres) → screen (pixels).
  Offset project(double xM, double yM, double zM) =>
      origin + _raw(xM, yM, zM) * scale;

  /// Floor corner [i] at z = 0.
  Offset floorScreen(int i) => project(_floorM[i].dx, _floorM[i].dy, 0);

  /// Floor corner [i] at z = [heightM] (the ceiling).
  Offset topScreen(int i) => project(_floorM[i].dx, _floorM[i].dy, heightM);

  /// All floor corners projected at z = 0.
  List<Offset> get floorScreenAll =>
      [for (var i = 0; i < _floorM.length; i++) floorScreen(i)];

  /// All floor corners projected at z = [heightM].
  List<Offset> get topScreenAll =>
      [for (var i = 0; i < _floorM.length; i++) topScreen(i)];

  /// Number of floor corners.
  int get cornerCount => _floorM.length;

  /// Invert the z=0 floor linear map: a screen-space delta → floor (x,y) metre
  /// delta. Solves `M · dWorld = dScreen` with the precomputed inverse of the
  /// constant 2×2 matrix M (orbit ∘ normalise ∘ iso ∘ scale, all linear at z=0).
  Offset floorDeltaFromScreen(Offset screenDelta) => Offset(
        _inv00 * screenDelta.dx + _inv01 * screenDelta.dy,
        _inv10 * screenDelta.dx + _inv11 * screenDelta.dy,
      );

  /// Metres of room height represented by one screen-y pixel. Height enters the
  /// iso map only through the `-z*heightScale` term (scaled by [scale] and the
  /// normalisation), so this is the constant `maxDim / (scale * heightScale)`.
  /// A vertical drag of `dy` pixels ⇒ a height change of `-dy * this`.
  double get heightMetrePerScreenY {
    final denom = scale * heightScale;
    return denom.abs() < 1e-12 ? 0.0 : _maxDim / denom;
  }
}
