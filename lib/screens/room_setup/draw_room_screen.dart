import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../models/room_model.dart';
import '../../models/room_model.dart' as room_model;
import '../../providers/design_provider.dart';
import '../../providers/room_persistence_provider.dart';
import '../../providers/room_provider.dart';
import '../home/home_empty_screen.dart';
import 'wall_measurements_screen.dart';

/// How the room outline is created.
enum _DrawMode {
  /// Freehand — drag a finger to trace the outline; it's simplified to corners.
  freehand,

  /// Polygon — tap to place each corner; drag corners afterwards to reshape.
  polygon,
}

/// "O'zingiz chizing" — sketch a room outline (any shape) with live per-wall
/// measurements, in two modes: freehand tracing or tap-to-place polygon.
/// Corners are draggable so you can resize/reshape after drawing. On finish it
/// feeds the shared wall pipeline (bounding size) and opens the 3D Studio.
class DrawRoomScreen extends ConsumerStatefulWidget {
  const DrawRoomScreen({super.key});

  @override
  ConsumerState<DrawRoomScreen> createState() => _DrawRoomScreenState();
}

class _DrawRoomScreenState extends ConsumerState<DrawRoomScreen> {
  /// Logical pixels per metre (fixes the sketch-to-metres scale). ~30 px/m lets
  /// a ~12 m room fit a phone width.
  static const double _pxPerMeter = 30.0;
  static const double _snapMeters = 0.5;
  static const double _grabRadius = 24.0;
  static const double _minMeters = 1.0;
  static const List<double> _heightPresets = [2.5, 2.7, 2.8, 3.0, 3.2];

  _DrawMode _mode = _DrawMode.polygon;
  final List<Offset> _points = [];
  bool _closed = false;
  int? _dragIndex;
  bool _freehandDrawing = false;
  List<Offset> _rawStroke = [];
  Offset? _cursor;
  double _height = 2.8;
  bool _saving = false;

  // --- helpers --------------------------------------------------------------

  Offset _snap(Offset p) {
    const step = _pxPerMeter * _snapMeters;
    return Offset((p.dx / step).round() * step, (p.dy / step).round() * step);
  }

  int? _vertexAt(Offset p) {
    for (var i = 0; i < _points.length; i++) {
      if ((_points[i] - p).distance <= _grabRadius) return i;
    }
    return null;
  }

  /// Edge lengths in metres (closed → includes the closing edge).
  List<double> get _wallLengthsM {
    final n = _points.length;
    if (n < 2) return const [];
    final last = _closed ? n : n - 1;
    return [
      for (var i = 0; i < last; i++)
        (_points[(i + 1) % n] - _points[i]).distance / _pxPerMeter,
    ];
  }

  double get _areaM2 {
    if (!_closed || _points.length < 3) return 0;
    var a = 0.0;
    for (var i = 0; i < _points.length; i++) {
      final p1 = _points[i];
      final p2 = _points[(i + 1) % _points.length];
      a += p1.dx * p2.dy - p2.dx * p1.dy;
    }
    return (a.abs() / 2) / (_pxPerMeter * _pxPerMeter);
  }

  ({double width, double length}) get _boundingSize {
    if (_points.isEmpty) return (width: 0, length: 0);
    var minX = _points.first.dx, maxX = _points.first.dx;
    var minY = _points.first.dy, maxY = _points.first.dy;
    for (final p in _points) {
      minX = math.min(minX, p.dx);
      maxX = math.max(maxX, p.dx);
      minY = math.min(minY, p.dy);
      maxY = math.max(maxY, p.dy);
    }
    return (
      width: (maxX - minX) / _pxPerMeter,
      length: (maxY - minY) / _pxPerMeter,
    );
  }

  bool get _valid {
    final b = _boundingSize;
    return _closed && b.width >= _minMeters && b.length >= _minMeters;
  }

  // --- gestures -------------------------------------------------------------

  void _onTapUp(TapUpDetails d) {
    if (_mode != _DrawMode.polygon || _closed) return;
    final p = _snap(d.localPosition);
    setState(() {
      if (_points.length >= 3 &&
          (d.localPosition - _points.first).distance <= _grabRadius) {
        _closed = true;
        _cursor = null;
      } else {
        _points.add(p);
      }
    });
  }

  void _onPanStart(DragStartDetails d) {
    final pos = d.localPosition;
    // Corners are only draggable AFTER the shape is closed (reshape/resize).
    // While still placing points, pans must not hijack a nearby vertex.
    if (_closed) {
      final v = _vertexAt(pos);
      if (v != null) {
        setState(() => _dragIndex = v);
      }
      return;
    }
    if (_mode == _DrawMode.freehand) {
      setState(() {
        _freehandDrawing = true;
        _rawStroke = [pos];
      });
    }
  }

  void _closeShape() {
    if (_points.length >= 3 && !_closed) {
      setState(() {
        _closed = true;
        _cursor = null;
      });
    }
  }

  void _onPanUpdate(DragUpdateDetails d) {
    final pos = d.localPosition;
    if (_dragIndex != null) {
      setState(() => _points[_dragIndex!] = _snap(pos));
    } else if (_freehandDrawing) {
      setState(() => _rawStroke.add(pos));
    }
  }

  void _onPanEnd(DragEndDetails d) {
    if (_freehandDrawing) {
      final simplified = _simplify(_rawStroke, 10)
          .map(_snap)
          .toList();
      // Drop consecutive duplicates after snapping.
      final pts = <Offset>[];
      for (final p in simplified) {
        if (pts.isEmpty || (pts.last - p).distance > 1) pts.add(p);
      }
      setState(() {
        _freehandDrawing = false;
        _rawStroke = [];
        if (pts.length >= 3) {
          _points
            ..clear()
            ..addAll(pts);
          _closed = true;
        }
      });
    }
    setState(() => _dragIndex = null);
  }

  void _onHover(Offset p) {
    if (_mode == _DrawMode.polygon && !_closed && _points.isNotEmpty) {
      setState(() => _cursor = p);
    }
  }

  void _undo() {
    setState(() {
      if (_closed) {
        _closed = false;
      } else if (_points.isNotEmpty) {
        _points.removeLast();
      }
      _cursor = null;
    });
  }

  void _clear() => setState(() {
        _points.clear();
        _closed = false;
        _dragIndex = null;
        _cursor = null;
      });

  void _switchMode(_DrawMode m) {
    if (m == _mode) return;
    setState(() {
      _mode = m;
      _clear();
    });
  }

  /// Ramer–Douglas–Peucker polyline simplification.
  List<Offset> _simplify(List<Offset> pts, double epsilon) {
    if (pts.length < 3) return pts;
    var maxD = 0.0;
    var idx = 0;
    final end = pts.length - 1;
    for (var i = 1; i < end; i++) {
      final d = _perpDistance(pts[i], pts[0], pts[end]);
      if (d > maxD) {
        maxD = d;
        idx = i;
      }
    }
    if (maxD > epsilon) {
      final left = _simplify(pts.sublist(0, idx + 1), epsilon);
      final right = _simplify(pts.sublist(idx), epsilon);
      return [...left.sublist(0, left.length - 1), ...right];
    }
    return [pts.first, pts.last];
  }

  double _perpDistance(Offset p, Offset a, Offset b) {
    final dx = b.dx - a.dx, dy = b.dy - a.dy;
    final len = math.sqrt(dx * dx + dy * dy);
    if (len == 0) return (p - a).distance;
    return ((p.dx - a.dx) * dy - (p.dy - a.dy) * dx).abs() / len;
  }

  // --- build ----------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        title: Text('Xonani chizing', style: DesignTokens.heading3),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.spacingMd,
              vertical: DesignTokens.spacingSm,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _ModeChip(
                    icon: Icons.gesture,
                    label: 'Qo\'lda',
                    selected: _mode == _DrawMode.freehand,
                    onTap: () => _switchMode(_DrawMode.freehand),
                  ),
                ),
                const SizedBox(width: DesignTokens.spacingSm),
                Expanded(
                  child: _ModeChip(
                    icon: Icons.timeline,
                    label: 'Vizual',
                    selected: _mode == _DrawMode.polygon,
                    onTap: () => _switchMode(_DrawMode.polygon),
                  ),
                ),
              ],
            ),
          ),
          _HintBar(
            text: _hint,
            canUndo: _points.isNotEmpty || _closed,
            canClose: _mode == _DrawMode.polygon && !_closed && _points.length >= 3,
            onClose: _closeShape,
            onUndo: _undo,
            onClear: _clear,
          ),
          Expanded(
            child: MouseRegion(
              onHover: (e) => _onHover(e.localPosition),
              child: GestureDetector(
                onTapUp: _onTapUp,
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
                child: Container(
                  width: double.infinity,
                  color: DesignTokens.white,
                  child: CustomPaint(
                    painter: _RoomPainter(
                      points: _points,
                      closed: _closed,
                      cursor: _cursor,
                      rawStroke: _freehandDrawing ? _rawStroke : const [],
                      pxPerMeter: _pxPerMeter,
                      wallLengths: _wallLengthsM,
                      areaM2: _areaM2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          _BottomPanel(
            boundingSize: _boundingSize,
            areaM2: _areaM2,
            height: _height,
            heightPresets: _heightPresets,
            valid: _valid,
            saving: _saving,
            onHeight: (h) => setState(() => _height = h),
            onFinish: _valid && !_saving ? _finish : null,
          ),
        ],
      ),
    );
  }

  String get _hint {
    if (_closed) return 'Shakl tayyor! Burchaklarni surib o\'lchamni o\'zgartiring.';
    if (_mode == _DrawMode.freehand) {
      return 'Xona shaklini barmog\'ingiz bilan chizing.';
    }
    if (_points.isEmpty) return 'Xona burchaklarini belgilang (kamida 3 ta).';
    if (_points.length < 3) {
      return 'Yana ${3 - _points.length} ta nuqta qo\'ying.';
    }
    return 'Yopish uchun birinchi nuqtaga bosing.';
  }

  Future<void> _finish() async {
    setState(() => _saving = true);
    final b = _boundingSize;
    final w = double.parse(b.width.toStringAsFixed(2));
    final l = double.parse(b.length.toStringAsFixed(2));
    final notifier = ref.read(wallMeasurementsProvider.notifier);
    notifier.updateWall(WallType.wallA, length: l, height: _height);
    notifier.updateWall(WallType.wallB, length: w, height: _height);
    notifier.updateWall(WallType.wallC, length: l, height: _height);
    notifier.updateWall(WallType.wallD, length: w, height: _height);

    _setupRoom();

    try {
      await ref.read(roomPersistenceProvider.notifier).ensurePersisted();
      final persisted = ref.read(roomPersistenceProvider).valueOrNull;
      if (!mounted) return;
      if (persisted != null) {
        context.go('/studio/${persisted.roomId}');
      } else {
        context.go('/design/b1');
      }
    } catch (_) {
      if (mounted) context.go('/design/b1');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _setupRoom() {
    final walls = ref.read(wallMeasurementsProvider);
    final roomId = DateTime.now().microsecondsSinceEpoch.toString();

    final modelWalls = <room_model.Wall>[
      for (final wall in walls)
        room_model.Wall(
          id: '${roomId}_${wall.type.name}',
          type: wall.type,
          measurements: room_model.WallMeasurements(
            height: wall.height,
            length: wall.length,
          ),
        ),
    ];

    final wallA = walls.firstWhere((w) => w.type == WallType.wallA);
    final wallB = walls.firstWhere((w) => w.type == WallType.wallB);

    final room = room_model.Room(
      id: roomId,
      name: 'Mening xonam',
      dimensions: room_model.RoomDimensions(
        width: wallB.length,
        length: wallA.length,
        height: wallA.height,
      ),
      walls: modelWalls,
      doors: const [],
      windows: const [],
      createdAt: DateTime.now(),
    );
    ref.read(activeRoomProvider.notifier).setLocal(room);
    ref.read(activeDesignProvider.notifier).setLocal(
          DesignSelection(
            id: '${roomId}_design',
            roomId: roomId,
            stage: DesignStage.floor,
            renovationStage: RenovationStage.suvoq,
          ),
        );
    ref.read(homeStateProvider.notifier).addProject(
          ProjectItem(
            id: roomId,
            name: room.name,
            location: '',
            roomCount: 1,
            createdAt: DateTime.now(),
          ),
        );
  }
}

// ---------------------------------------------------------------------------
// Mode chip
// ---------------------------------------------------------------------------

class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingSm),
        decoration: BoxDecoration(
          color: selected ? DesignTokens.primaryBlue : DesignTokens.white,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          border: Border.all(
            color: selected ? DesignTokens.primaryBlue : DesignTokens.borderGray,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 18,
                color: selected ? DesignTokens.white : DesignTokens.textGray),
            const SizedBox(width: DesignTokens.spacingXs),
            Text(
              label,
              style: DesignTokens.subtitle2.copyWith(
                color: selected ? DesignTokens.white : DesignTokens.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Hint bar
// ---------------------------------------------------------------------------

class _HintBar extends StatelessWidget {
  const _HintBar({
    required this.text,
    required this.canUndo,
    required this.canClose,
    required this.onClose,
    required this.onUndo,
    required this.onClear,
  });

  final String text;
  final bool canUndo;
  final bool canClose;
  final VoidCallback onClose;
  final VoidCallback onUndo;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        DesignTokens.spacingMd,
        0,
        DesignTokens.spacingMd,
        DesignTokens.spacingSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: DesignTokens.caption.copyWith(color: DesignTokens.textGray),
          ),
          if (canClose || canUndo)
            Row(
              children: [
                if (canClose)
                  FilledButton.icon(
                    onPressed: onClose,
                    icon: const Icon(Icons.check, size: 16),
                    label: const Text('Yopish'),
                    style: FilledButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                const Spacer(),
                if (canUndo) ...[
                  TextButton.icon(
                    onPressed: onUndo,
                    icon: const Icon(Icons.undo, size: 16),
                    label: const Text('Orqaga'),
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: onClear,
                    icon: const Icon(Icons.delete_outline, size: 16),
                    label: const Text('Tozalash'),
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Painter
// ---------------------------------------------------------------------------

class _RoomPainter extends CustomPainter {
  _RoomPainter({
    required this.points,
    required this.closed,
    required this.cursor,
    required this.rawStroke,
    required this.pxPerMeter,
    required this.wallLengths,
    required this.areaM2,
  });

  final List<Offset> points;
  final bool closed;
  final Offset? cursor;
  final List<Offset> rawStroke;
  final double pxPerMeter;
  final List<double> wallLengths;
  final double areaM2;

  @override
  void paint(Canvas canvas, Size size) {
    // 1 m grid.
    final grid = Paint()
      ..color = const Color(0xFFEDEFF3)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += pxPerMeter) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += pxPerMeter) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    // Freehand live stroke.
    if (rawStroke.length > 1) {
      final stroke = Paint()
        ..color = DesignTokens.primaryBlue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round;
      final path = Path()..moveTo(rawStroke.first.dx, rawStroke.first.dy);
      for (final p in rawStroke.skip(1)) {
        path.lineTo(p.dx, p.dy);
      }
      canvas.drawPath(path, stroke);
    }

    if (points.isEmpty) return;

    final line = Paint()
      ..color = DesignTokens.primaryBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeJoin = StrokeJoin.round;

    // Fill when closed.
    if (closed && points.length >= 3) {
      final fill = Path()..moveTo(points.first.dx, points.first.dy);
      for (final p in points.skip(1)) {
        fill.lineTo(p.dx, p.dy);
      }
      fill.close();
      canvas.drawPath(
        fill,
        Paint()..color = DesignTokens.primaryBlue.withValues(alpha: 0.10),
      );
      canvas.drawPath(fill, line);
    } else {
      // Open polyline.
      final path = Path()..moveTo(points.first.dx, points.first.dy);
      for (final p in points.skip(1)) {
        path.lineTo(p.dx, p.dy);
      }
      canvas.drawPath(path, line);
      // Guide segment to the cursor.
      if (cursor != null) {
        canvas.drawLine(
          points.last,
          cursor!,
          Paint()
            ..color = DesignTokens.primaryBlue.withValues(alpha: 0.4)
            ..strokeWidth = 1.5,
        );
      }
    }

    // Wall length labels at each edge midpoint.
    final n = points.length;
    final edgeCount = closed ? n : n - 1;
    for (var i = 0; i < edgeCount && i < wallLengths.length; i++) {
      final a = points[i];
      final b = points[(i + 1) % n];
      final mid = Offset((a.dx + b.dx) / 2, (a.dy + b.dy) / 2);
      _label(canvas, '${wallLengths[i].toStringAsFixed(1)} m', mid,
          center: true);
    }

    // Area label at the centroid.
    if (closed && points.length >= 3 && areaM2 > 0) {
      var cx = 0.0, cy = 0.0;
      for (final p in points) {
        cx += p.dx;
        cy += p.dy;
      }
      _label(canvas, '${areaM2.toStringAsFixed(1)} m²',
          Offset(cx / n, cy / n),
          center: true, muted: true);
    }

    // Draggable corner handles.
    for (final p in points) {
      canvas.drawCircle(p, 6, Paint()..color = DesignTokens.primaryBlue);
      canvas.drawCircle(
        p,
        6,
        Paint()
          ..color = DesignTokens.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
  }

  void _label(Canvas canvas, String text, Offset at,
      {bool center = false, bool muted = false}) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: muted ? DesignTokens.textGray : DesignTokens.primaryBlue,
          fontSize: muted ? 13 : 13,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    var dx = at.dx, dy = at.dy;
    if (center) {
      dx -= tp.width / 2;
      dy -= tp.height / 2;
    }
    final bg = Rect.fromLTWH(dx - 4, dy - 2, tp.width + 8, tp.height + 4);
    canvas.drawRRect(
      RRect.fromRectAndRadius(bg, const Radius.circular(6)),
      Paint()..color = DesignTokens.white.withValues(alpha: 0.9),
    );
    tp.paint(canvas, Offset(dx, dy));
  }

  @override
  bool shouldRepaint(_RoomPainter old) =>
      old.points != points ||
      old.closed != closed ||
      old.cursor != cursor ||
      old.rawStroke != rawStroke;
}

// ---------------------------------------------------------------------------
// Bottom panel
// ---------------------------------------------------------------------------

class _BottomPanel extends StatelessWidget {
  const _BottomPanel({
    required this.boundingSize,
    required this.areaM2,
    required this.height,
    required this.heightPresets,
    required this.valid,
    required this.saving,
    required this.onHeight,
    required this.onFinish,
  });

  final ({double width, double length}) boundingSize;
  final double areaM2;
  final double height;
  final List<double> heightPresets;
  final bool valid;
  final bool saving;
  final ValueChanged<double> onHeight;
  final VoidCallback? onFinish;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        color: DesignTokens.white,
        boxShadow: [DesignTokens.shadowCard],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Xona: ${boundingSize.width.toStringAsFixed(1)} × '
                    '${boundingSize.length.toStringAsFixed(1)} × '
                    '${height.toStringAsFixed(1)} m',
                    style: DesignTokens.subtitle1,
                  ),
                ),
                Text(
                  '${areaM2.toStringAsFixed(1)} m²',
                  style: DesignTokens.subtitle2
                      .copyWith(color: DesignTokens.textGray),
                ),
              ],
            ),
            const SizedBox(height: DesignTokens.spacingXs),
            Text('Shift balandligi',
                style:
                    DesignTokens.caption.copyWith(color: DesignTokens.textGray)),
            const SizedBox(height: DesignTokens.spacingXs),
            Wrap(
              spacing: DesignTokens.spacingSm,
              children: [
                for (final h in heightPresets)
                  ChoiceChip(
                    label: Text('${h.toStringAsFixed(1)} m'),
                    selected: (height - h).abs() < 0.01,
                    onSelected: (_) => onHeight(h),
                    backgroundColor: DesignTokens.backgroundLight,
                    selectedColor: DesignTokens.primaryBlue,
                    labelStyle: DesignTokens.caption.copyWith(
                      color: (height - h).abs() < 0.01
                          ? DesignTokens.white
                          : DesignTokens.textDark,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onFinish,
                child: saving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: DesignTokens.white,
                        ),
                      )
                    : Text(valid ? 'Yakunlash' : 'Xonani chizing'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
