import 'dart:math' as math;

import '../../geometry/room_geometry.dart';
import '../../models/room_plan.dart';

/// What the Android ARCore scanner hands back over `andoza/arscan`: raw floor
/// corners in metres (ARCore's X/Z, arbitrary orientation) plus the measured
/// ceiling height. All cleaning-up happens in [buildArcorePlan].
class ArScanRaw {
  const ArScanRaw({
    required this.corners,
    required this.height,
    required this.heightMeasured,
    required this.closed,
    required this.trackingLossCount,
    required this.durationSec,
  });

  /// When [closed], the last point is the tap that snapped onto the first
  /// corner (the loop's closure error), not a corner of its own.
  final List<Vec2> corners;
  final double height;
  final bool heightMeasured;
  final bool closed;
  final int trackingLossCount;
  final int durationSec;

  factory ArScanRaw.fromMap(Map<String, dynamic> m) => ArScanRaw(
        corners: [
          for (final p in (m['corners'] as List? ?? const []))
            Vec2((p as List)[0].toDouble(), p[1].toDouble()),
        ],
        height: (m['height'] as num? ?? 0).toDouble(),
        heightMeasured: m['heightMeasured'] == true,
        closed: m['closed'] == true,
        trackingLossCount: (m['trackingLossCount'] as num? ?? 0).toInt(),
        durationSec: (m['durationSec'] as num? ?? 0).toInt(),
      );
}

sealed class ArPlanResult {
  const ArPlanResult();
}

class ArPlanOk extends ArPlanResult {
  const ArPlanOk(this.plan);
  final RoomPlan plan;
}

/// [reason]: `too_few_corners` | `self_intersecting` | `wall_too_long`.
class ArPlanRejected extends ArPlanResult {
  const ArPlanRejected(this.reason);
  final String reason;
}

const double _mergeM = 0.10;
const double _snapToleranceDeg = 8;
const double _maxWallM = 30;

/// Raw ARCore corners → a squared, validated [RoomPlan]:
/// spread the loop's closure error → merge corners < 10 cm apart → square walls
/// within ±8° of a right angle (slanted walls stay slanted) → validate → 1 cm.
ArPlanResult buildArcorePlan(ArScanRaw raw, {String name = 'Xona'}) {
  var pts = List<Vec2>.of(raw.corners);
  if (raw.closed && pts.length >= 4) pts = _spreadClosureError(pts);
  pts = mergeCloseVertices(pts, _mergeM);
  if (pts.length < 3) return const ArPlanRejected('too_few_corners');
  if (_longestEdge(pts) > _maxWallM) return const ArPlanRejected('wall_too_long');
  if (isSelfIntersecting(pts)) return const ArPlanRejected('self_intersecting');

  pts = removeCollinearVertices(_square(pts));
  if (pts.length < 3) return const ArPlanRejected('too_few_corners');
  // Squaring re-closes the loop by stretching walls, so check the final plan too.
  if (_longestEdge(pts) > _maxWallM) return const ArPlanRejected('wall_too_long');
  if (isSelfIntersecting(pts)) return const ArPlanRejected('self_intersecting');

  // ARCore's origin is wherever the session started; start the plan at (0, 0)
  // like the iOS converter does.
  final minX = pts.map((p) => p.x).reduce(math.min);
  final minY = pts.map((p) => p.y).reduce(math.min);
  final corners = [for (final p in pts) Vec2(_cm(p.x - minX), _cm(p.y - minY))];
  final n = corners.length;
  return ArPlanOk(RoomPlan(
    corners: List.unmodifiable(corners),
    walls: List.unmodifiable([
      for (var i = 0; i < n; i++)
        RoomWall(i, (i + 1) % n, _cm(corners[i].distanceTo(corners[(i + 1) % n])),
            openings: const []),
    ]),
    ceilingHeightM: raw.height,
    source: RoomSource.arcore,
    name: name,
  ));
}

double _cm(double v) => (v * 100).roundToDouble() / 100;

double _longestEdge(List<Vec2> p) {
  var best = 0.0;
  for (var i = 0; i < p.length; i++) {
    best = math.max(best, p[i].distanceTo(p[(i + 1) % p.length]));
  }
  return best;
}

/// The last point is where the user closed the loop; it should have been the
/// first corner. Pull every corner back by its share of that error, in
/// proportion to how far along the walk it sits, then drop the closing point.
List<Vec2> _spreadClosureError(List<Vec2> pts) {
  final error = pts.last - pts.first;
  var total = 0.0;
  for (var i = 0; i < pts.length - 1; i++) {
    total += pts[i].distanceTo(pts[i + 1]);
  }
  if (total == 0) return pts.sublist(0, pts.length - 1);
  final out = <Vec2>[];
  var walked = 0.0;
  for (var i = 0; i < pts.length - 1; i++) {
    if (i > 0) walked += pts[i - 1].distanceTo(pts[i]);
    out.add(pts[i] - error * (walked / total));
  }
  return out;
}

/// Square the outline in the room's own frame (the longest wall along X):
/// edges within ±8° of a multiple of 90° become exact, the rest keep their
/// angle, and the loop is re-closed by stretching the squared walls along
/// their own axis so no snapped angle is disturbed.
List<Vec2> _square(List<Vec2> pts) {
  final n = pts.length;
  var longest = 0;
  for (var i = 1; i < n; i++) {
    if (_edge(pts, i).length > _edge(pts, longest).length) longest = i;
  }
  final e = _edge(pts, longest);
  final theta = math.atan2(e.y, e.x);
  final local = [for (final p in pts) _rotate(p, -theta)];

  final dirs = <double>[];
  final lens = <double>[];
  final axis = <int>[]; // 0 = along X, 1 = along Y, -1 = free
  for (var i = 0; i < n; i++) {
    final d = _edge(local, i);
    lens.add(d.length);
    final a = math.atan2(d.y, d.x);
    final snapped = (a / (math.pi / 2)).round() * (math.pi / 2);
    if ((a - snapped).abs() * 180 / math.pi <= _snapToleranceDeg) {
      dirs.add(snapped);
      axis.add(((snapped / (math.pi / 2)).round() % 2 == 0) ? 0 : 1);
    } else {
      dirs.add(a);
      axis.add(-1);
    }
  }

  Vec2 walkEnd() {
    var p = local[0];
    for (var i = 0; i < n; i++) {
      p = p + Vec2(math.cos(dirs[i]), math.sin(dirs[i])) * lens[i];
    }
    return p;
  }

  final gap = local[0] - walkEnd();
  for (final ax in const [0, 1]) {
    final g = ax == 0 ? gap.x : gap.y;
    final idx = [for (var i = 0; i < n; i++) if (axis[i] == ax) i];
    final sum = idx.fold<double>(0, (s, i) => s + lens[i]);
    if (sum == 0) continue;
    for (final i in idx) {
      final sign = ax == 0 ? math.cos(dirs[i]).sign : math.sin(dirs[i]).sign;
      lens[i] = math.max(0.01, lens[i] + sign * g * (lens[i] / sum));
    }
  }

  // Anything still open (no squared wall on an axis) is spread over the corners.
  final rest = local[0] - walkEnd();
  final out = <Vec2>[local[0]];
  for (var i = 0; i < n - 1; i++) {
    out.add(out.last + Vec2(math.cos(dirs[i]), math.sin(dirs[i])) * lens[i]);
  }
  return [for (var i = 0; i < n; i++) out[i] + rest * (i / n)];
}

Vec2 _edge(List<Vec2> p, int i) => p[(i + 1) % p.length] - p[i];

Vec2 _rotate(Vec2 p, double a) =>
    Vec2(p.x * math.cos(a) - p.y * math.sin(a), p.x * math.sin(a) + p.y * math.cos(a));
