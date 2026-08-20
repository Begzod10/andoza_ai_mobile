import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/design_tokens.dart';
import '../../geometry/geometry_config.dart';
import '../../geometry/room_geometry.dart';
import '../../models/room_plan.dart';
import '../../services/room_plan_handoff.dart';

/// How the room outline is created.
enum _DrawMode { freehand, polygon }

/// "O'zingiz chizing" — sketch a room outline (any N-corner shape) with live
/// per-wall measurements, in two modes: freehand tracing (auto-straightened via
/// the geometry module) or tap-to-place polygon. Corners are draggable to
/// resize/reshape. All state is kept in METRES; the [RoomPlan] it produces is
/// handed off via [handoffRoomPlan].
class DrawRoomScreen extends ConsumerStatefulWidget {
  const DrawRoomScreen({super.key});

  @override
  ConsumerState<DrawRoomScreen> createState() => _DrawRoomScreenState();
}

class _DrawRoomScreenState extends ConsumerState<DrawRoomScreen>
    with SingleTickerProviderStateMixin {
  /// Logical pixels per metre for the top-down canvas.
  static const double _ppm = 30.0;
  static const double _grabRadiusPx = 24.0;
  static const List<double> _heightPresets = [2.5, 2.7, 2.8, 3.0, 3.2];

  _DrawMode _mode = _DrawMode.polygon;

  /// Authoritative room corners, in METRES.
  List<Vec2> _corners = [];
  bool _closed = false;
  int? _dragIndex;
  double _height = GeometryConfig.defaultHeightM;
  bool _saving = false;

  // Freehand
  bool _freehandDrawing = false;
  List<Vec2> _rawStrokeM = [];
  List<Vec2>? _rawCornersM; // before regularization (for the toggle)
  List<Vec2>? _regularizedM; // after regularization
  bool _showRaw = false;

  // Regularization animation (raw → clean)
  late final AnimationController _anim = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 260),
  )..addListener(() => setState(() {}));
  List<Vec2>? _animFrom;
  List<Vec2>? _animTo;

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  // --- coordinate transform -------------------------------------------------

  Offset _toScreen(Vec2 w) => Offset(w.x * _ppm, w.y * _ppm);
  Vec2 _toWorld(Offset s) => Vec2(s.dx / _ppm, s.dy / _ppm);
  Vec2 _snap(Vec2 w) => Vec2(
        roundTo(w.x, GeometryConfig.wallLengthStepM),
        roundTo(w.y, GeometryConfig.wallLengthStepM),
      );

  /// Corners currently displayed (lerped mid-animation).
  List<Vec2> get _display {
    if (_anim.isAnimating &&
        _animFrom != null &&
        _animTo != null &&
        _animFrom!.length == _animTo!.length) {
      final t = Curves.easeOut.transform(_anim.value);
      return [
        for (var i = 0; i < _animTo!.length; i++)
          _animFrom![i] + (_animTo![i] - _animFrom![i]) * t,
      ];
    }
    return _corners;
  }

  RoomPlan get _plan => RoomPlan.fromCorners(
        _corners,
        ceilingHeightM: _height,
        source: _mode == _DrawMode.freehand
            ? RoomSource.sketch
            : RoomSource.drag,
      );

  int? _cornerAt(Offset screen) {
    for (var i = 0; i < _corners.length; i++) {
      if ((_toScreen(_corners[i]) - screen).distance <= _grabRadiusPx) return i;
    }
    return null;
  }

  // --- gestures -------------------------------------------------------------

  void _onTapUp(TapUpDetails d) {
    if (_mode != _DrawMode.polygon || _closed) return;
    setState(() {
      if (_corners.length >= 3 &&
          (_toScreen(_corners.first) - d.localPosition).distance <=
              _grabRadiusPx) {
        _closed = true;
      } else {
        _corners.add(_snap(_toWorld(d.localPosition)));
      }
    });
  }

  void _onPanStart(DragStartDetails d) {
    final pos = d.localPosition;
    if (_closed) {
      final v = _cornerAt(pos);
      if (v != null) setState(() => _dragIndex = v);
      return;
    }
    if (_mode == _DrawMode.freehand) {
      setState(() {
        _freehandDrawing = true;
        _rawStrokeM = [_toWorld(pos)];
      });
    }
  }

  void _onPanUpdate(DragUpdateDetails d) {
    if (_dragIndex != null) {
      setState(() => _corners[_dragIndex!] = _snap(_toWorld(d.localPosition)));
    } else if (_freehandDrawing) {
      setState(() => _rawStrokeM.add(_toWorld(d.localPosition)));
    }
  }

  void _onPanEnd(DragEndDetails d) {
    if (_freehandDrawing) {
      final raw = mergeCloseVertices(rdpSimplify(resample(_rawStrokeM)));
      setState(() {
        _freehandDrawing = false;
        _rawStrokeM = [];
        if (raw.length >= 3) {
          final reg = regularize(raw);
          _rawCornersM = raw;
          _regularizedM = reg;
          _corners = reg;
          _closed = true;
          _showRaw = false;
          _animFrom = raw;
          _animTo = reg;
          _anim.forward(from: 0);
        }
      });
    }
    setState(() => _dragIndex = null);
  }

  void _closeShape() {
    if (_corners.length >= 3 && !_closed) setState(() => _closed = true);
  }

  void _toggleRawAfter() {
    if (_rawCornersM == null || _regularizedM == null) return;
    setState(() {
      _showRaw = !_showRaw;
      _corners = _showRaw ? List.of(_rawCornersM!) : List.of(_regularizedM!);
      _anim.stop();
    });
  }

  void _undo() {
    setState(() {
      if (_closed && _mode == _DrawMode.polygon) {
        _closed = false;
      } else if (_corners.isNotEmpty) {
        _corners.removeLast();
      }
    });
  }

  void _clear() => setState(() {
        _corners = [];
        _closed = false;
        _dragIndex = null;
        _rawCornersM = null;
        _regularizedM = null;
        _anim.stop();
      });

  void _switchMode(_DrawMode m) {
    if (m == _mode) return;
    setState(() {
      _mode = m;
      _clear();
    });
  }

  // --- build ----------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final plan = _plan;
    final wallLengths = _wallLengths(_display, _closed);
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
            canClose:
                _mode == _DrawMode.polygon && !_closed && _corners.length >= 3,
            onClose: _closeShape,
            canToggle: _rawCornersM != null && _closed,
            showRaw: _showRaw,
            onToggle: _toggleRawAfter,
            canUndo: _corners.isNotEmpty || _closed,
            onUndo: _undo,
            onClear: _clear,
          ),
          Expanded(
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
                    corners: [for (final c in _display) _toScreen(c)],
                    closed: _closed,
                    rawStroke: _freehandDrawing
                        ? [for (final p in _rawStrokeM) _toScreen(p)]
                        : const [],
                    ppm: _ppm,
                    wallLengths: wallLengths,
                    areaM2: _closed ? shoelaceArea(_display) : 0,
                  ),
                ),
              ),
            ),
          ),
          _BottomPanel(
            plan: plan,
            height: _height,
            heightPresets: _heightPresets,
            saving: _saving,
            onHeight: (h) => setState(() => _height = h),
            onFinish:
                plan.isValid && !_saving && _closed ? _finish : null,
          ),
        ],
      ),
    );
  }

  List<double> _wallLengths(List<Vec2> pts, bool closed) {
    final n = pts.length;
    if (n < 2) return const [];
    final last = closed ? n : n - 1;
    return [
      for (var i = 0; i < last; i++) pts[i].distanceTo(pts[(i + 1) % n]),
    ];
  }

  String get _hint {
    if (_showRaw) return 'Xom chizma. "Toza"ga qaytish uchun tugmani bosing.';
    if (_closed) {
      return 'Shakl tayyor! Burchaklarni surib o\'lchamni o\'zgartiring.';
    }
    if (_mode == _DrawMode.freehand) {
      return 'Xona shaklini barmog\'ingiz bilan chizing.';
    }
    if (_corners.isEmpty) return 'Xona burchaklarini belgilang (kamida 3 ta).';
    if (_corners.length < 3) {
      return 'Yana ${3 - _corners.length} ta nuqta qo\'ying.';
    }
    return 'Yopish uchun birinchi nuqtaga bosing yoki "Yopish".';
  }

  Future<void> _finish() async {
    setState(() => _saving = true);
    final plan = _plan;
    try {
      final roomId = await handoffRoomPlan(ref, plan);
      if (!mounted) return;
      context.go(roomId != null ? '/studio/$roomId' : '/design/b1');
    } catch (_) {
      if (mounted) context.go('/design/b1');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
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
            color:
                selected ? DesignTokens.primaryBlue : DesignTokens.borderGray,
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
    required this.canClose,
    required this.onClose,
    required this.canToggle,
    required this.showRaw,
    required this.onToggle,
    required this.canUndo,
    required this.onUndo,
    required this.onClear,
  });

  final String text;
  final bool canClose;
  final VoidCallback onClose;
  final bool canToggle;
  final bool showRaw;
  final VoidCallback onToggle;
  final bool canUndo;
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
          if (canClose || canToggle || canUndo)
            Row(
              children: [
                if (canClose)
                  FilledButton.icon(
                    onPressed: onClose,
                    icon: const Icon(Icons.check, size: 16),
                    label: const Text('Yopish'),
                    style: FilledButton.styleFrom(
                        visualDensity: VisualDensity.compact),
                  ),
                if (canToggle)
                  OutlinedButton.icon(
                    onPressed: onToggle,
                    icon: const Icon(Icons.compare_arrows, size: 16),
                    label: Text(showRaw ? 'Toza' : 'Xom'),
                    style: OutlinedButton.styleFrom(
                        visualDensity: VisualDensity.compact),
                  ),
                const Spacer(),
                if (canUndo) ...[
                  TextButton.icon(
                    onPressed: onUndo,
                    icon: const Icon(Icons.undo, size: 16),
                    label: const Text('Orqaga'),
                    style: TextButton.styleFrom(
                        visualDensity: VisualDensity.compact),
                  ),
                  TextButton.icon(
                    onPressed: onClear,
                    icon: const Icon(Icons.delete_outline, size: 16),
                    label: const Text('Tozalash'),
                    style: TextButton.styleFrom(
                        visualDensity: VisualDensity.compact),
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
    required this.corners,
    required this.closed,
    required this.rawStroke,
    required this.ppm,
    required this.wallLengths,
    required this.areaM2,
  });

  final List<Offset> corners;
  final bool closed;
  final List<Offset> rawStroke;
  final double ppm;
  final List<double> wallLengths;
  final double areaM2;

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = const Color(0xFFEDEFF3)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += ppm) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += ppm) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    if (rawStroke.length > 1) {
      final p = Path()..moveTo(rawStroke.first.dx, rawStroke.first.dy);
      for (final o in rawStroke.skip(1)) {
        p.lineTo(o.dx, o.dy);
      }
      canvas.drawPath(
        p,
        Paint()
          ..color = DesignTokens.primaryBlue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..strokeCap = StrokeCap.round,
      );
    }

    if (corners.isEmpty) return;

    final line = Paint()
      ..color = DesignTokens.primaryBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeJoin = StrokeJoin.round;

    if (closed && corners.length >= 3) {
      final fill = Path()..moveTo(corners.first.dx, corners.first.dy);
      for (final o in corners.skip(1)) {
        fill.lineTo(o.dx, o.dy);
      }
      fill.close();
      canvas.drawPath(
          fill, Paint()..color = DesignTokens.primaryBlue.withValues(alpha: 0.10));
      canvas.drawPath(fill, line);
    } else {
      final p = Path()..moveTo(corners.first.dx, corners.first.dy);
      for (final o in corners.skip(1)) {
        p.lineTo(o.dx, o.dy);
      }
      canvas.drawPath(p, line);
    }

    final n = corners.length;
    final edges = closed ? n : n - 1;
    for (var i = 0; i < edges && i < wallLengths.length; i++) {
      final a = corners[i], b = corners[(i + 1) % n];
      _label(canvas, formatLength(wallLengths[i]),
          Offset((a.dx + b.dx) / 2, (a.dy + b.dy) / 2));
    }
    if (closed && areaM2 > 0) {
      var cx = 0.0, cy = 0.0;
      for (final o in corners) {
        cx += o.dx;
        cy += o.dy;
      }
      _label(canvas, '${areaM2.toStringAsFixed(1)} m²',
          Offset(cx / n, cy / n),
          muted: true);
    }

    for (final o in corners) {
      canvas.drawCircle(o, 6, Paint()..color = DesignTokens.primaryBlue);
      canvas.drawCircle(
          o,
          6,
          Paint()
            ..color = DesignTokens.white
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2);
    }
  }

  void _label(Canvas canvas, String text, Offset at, {bool muted = false}) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: muted ? DesignTokens.textGray : DesignTokens.primaryBlue,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final dx = at.dx - tp.width / 2;
    final dy = at.dy - tp.height / 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(dx - 4, dy - 2, tp.width + 8, tp.height + 4),
          const Radius.circular(6)),
      Paint()..color = DesignTokens.white.withValues(alpha: 0.9),
    );
    tp.paint(canvas, Offset(dx, dy));
  }

  @override
  bool shouldRepaint(_RoomPainter old) =>
      old.corners != corners ||
      old.closed != closed ||
      old.rawStroke != rawStroke;
}

// ---------------------------------------------------------------------------
// Bottom panel
// ---------------------------------------------------------------------------

class _BottomPanel extends StatelessWidget {
  const _BottomPanel({
    required this.plan,
    required this.height,
    required this.heightPresets,
    required this.saving,
    required this.onHeight,
    required this.onFinish,
  });

  final RoomPlan plan;
  final double height;
  final List<double> heightPresets;
  final bool saving;
  final ValueChanged<double> onHeight;
  final VoidCallback? onFinish;

  @override
  Widget build(BuildContext context) {
    final b = plan.boundingSize;
    final rect = plan.isRectangleLike;
    final title = rect
        ? 'Xona: ${b.width.toStringAsFixed(1)} × ${b.length.toStringAsFixed(1)} × ${height.toStringAsFixed(1)} m'
        : 'Ko\'pburchak · ${plan.corners.length} devor · ${b.width.toStringAsFixed(1)}×${b.length.toStringAsFixed(1)} m';
    final area = plan.corners.length >= 3 ? plan.areaM2 : 0.0;
    final reason = plan.invalidReason;
    final areaWarn = area > 0 &&
        (area < GeometryConfig.minAreaWarnM2 ||
            area > GeometryConfig.maxAreaWarnM2);

    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
          color: DesignTokens.white,
          boxShadow: [DesignTokens.shadowCard]),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(title, style: DesignTokens.subtitle1)),
                Text('${area.toStringAsFixed(1)} m²',
                    style: DesignTokens.subtitle2
                        .copyWith(color: DesignTokens.textGray)),
              ],
            ),
            if (areaWarn)
              Text(
                'Diqqat: yuza odatiy oraliqdan tashqarida',
                style: DesignTokens.caption
                    .copyWith(color: DesignTokens.accentOrange),
              ),
            const SizedBox(height: DesignTokens.spacingXs),
            Text('Shift balandligi',
                style: DesignTokens.caption
                    .copyWith(color: DesignTokens.textGray)),
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
                            strokeWidth: 2, color: DesignTokens.white),
                      )
                    : Text(onFinish != null
                        ? 'Yakunlash'
                        : (reason ?? 'Xonani chizing')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
