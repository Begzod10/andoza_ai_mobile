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

/// "O'zingiz chizing" — sketch a room by dragging a rectangle; the width and
/// length are measured live in metres as you draw (draw smaller → smaller
/// room, draw bigger → the dimension grows next to the edge in real time).
/// On finish it feeds the same wall pipeline as the 3D wizard and opens the
/// 3D Studio.
class DrawRoomScreen extends ConsumerStatefulWidget {
  const DrawRoomScreen({super.key});

  @override
  ConsumerState<DrawRoomScreen> createState() => _DrawRoomScreenState();
}

class _DrawRoomScreenState extends ConsumerState<DrawRoomScreen> {
  /// Logical pixels per metre — fixes the drawing-to-metres scale so a larger
  /// sketch yields a larger room. ~46 px/m lets an ~8 m room fit a phone width.
  static const double _pxPerMeter = 46.0;

  /// Minimum side (m) before the room can be finished.
  static const double _minMeters = 1.0;

  static const List<double> _heightPresets = [2.5, 2.7, 2.8, 3.0, 3.2];

  Offset? _start;
  Offset? _end;
  double _height = 2.8;
  bool _saving = false;

  double get _widthM =>
      _start == null || _end == null ? 0 : (_end!.dx - _start!.dx).abs() / _pxPerMeter;
  double get _lengthM =>
      _start == null || _end == null ? 0 : (_end!.dy - _start!.dy).abs() / _pxPerMeter;
  bool get _valid => _widthM >= _minMeters && _lengthM >= _minMeters;

  void _onPanStart(DragStartDetails d) {
    setState(() {
      _start = d.localPosition;
      _end = d.localPosition;
    });
  }

  void _onPanUpdate(DragUpdateDetails d) {
    setState(() => _end = d.localPosition);
  }

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
          // --- Drawing canvas ------------------------------------------------
          Expanded(
            child: GestureDetector(
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              child: Container(
                width: double.infinity,
                color: DesignTokens.white,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _RoomPainter(
                          start: _start,
                          end: _end,
                          pxPerMeter: _pxPerMeter,
                          widthM: _widthM,
                          lengthM: _lengthM,
                        ),
                      ),
                    ),
                    if (_start == null)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            'Xonani chizish uchun barmog\'ingizni suring — '
                            'o\'lchamlar o\'zi hisoblanadi',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: DesignTokens.textMuted),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          // --- Bottom controls ----------------------------------------------
          _BottomPanel(
            widthM: _widthM,
            lengthM: _lengthM,
            height: _height,
            heightPresets: _heightPresets,
            valid: _valid,
            saving: _saving,
            onHeight: (h) => setState(() => _height = h),
            onReset: () => setState(() {
              _start = null;
              _end = null;
            }),
            onFinish: _valid && !_saving ? _finish : null,
          ),
        ],
      ),
    );
  }

  /// Feed the drawn rectangle into the shared wall pipeline, persist the room,
  /// and open the 3D Studio (offline fallback → native design flow).
  Future<void> _finish() async {
    setState(() => _saving = true);
    final w = double.parse(_widthM.toStringAsFixed(2));
    final l = double.parse(_lengthM.toStringAsFixed(2));
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

  /// Builds the room from the wall measurements and populates the app's
  /// providers — mirrors the 3D wizard's setup so downstream flows match.
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
// Painter
// ---------------------------------------------------------------------------

class _RoomPainter extends CustomPainter {
  _RoomPainter({
    required this.start,
    required this.end,
    required this.pxPerMeter,
    required this.widthM,
    required this.lengthM,
  });

  final Offset? start;
  final Offset? end;
  final double pxPerMeter;
  final double widthM;
  final double lengthM;

  @override
  void paint(Canvas canvas, Size size) {
    // 1 m grid so the user has a sense of scale.
    final grid = Paint()
      ..color = const Color(0xFFEDEFF3)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += pxPerMeter) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += pxPerMeter) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    if (start == null || end == null) return;
    final rect = Rect.fromPoints(start!, end!);

    // Fill + border.
    canvas.drawRect(
      rect,
      Paint()..color = DesignTokens.primaryBlue.withValues(alpha: 0.10),
    );
    canvas.drawRect(
      rect,
      Paint()
        ..color = DesignTokens.primaryBlue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );

    // Corner handles.
    final handle = Paint()..color = DesignTokens.primaryBlue;
    for (final p in [rect.topLeft, rect.topRight, rect.bottomLeft, rect.bottomRight]) {
      canvas.drawCircle(p, 5, handle);
      canvas.drawCircle(p, 5, Paint()
        ..color = DesignTokens.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2);
    }

    // Live dimension labels: width on the top edge, length on the left edge,
    // area in the centre.
    _label(canvas, '${widthM.toStringAsFixed(1)} m',
        Offset(rect.center.dx, rect.top - 2), anchorBottom: true);
    _label(canvas, '${lengthM.toStringAsFixed(1)} m',
        Offset(rect.left - 2, rect.center.dy), anchorRight: true);
    if (widthM > 0 && lengthM > 0) {
      _label(canvas, '${(widthM * lengthM).toStringAsFixed(1)} m²', rect.center,
          center: true, muted: true);
    }
  }

  void _label(
    Canvas canvas,
    String text,
    Offset at, {
    bool anchorBottom = false,
    bool anchorRight = false,
    bool center = false,
    bool muted = false,
  }) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: muted ? DesignTokens.textGray : DesignTokens.primaryBlue,
          fontSize: muted ? 13 : 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    var dx = at.dx;
    var dy = at.dy;
    if (center) {
      dx -= tp.width / 2;
      dy -= tp.height / 2;
    } else if (anchorBottom) {
      dx -= tp.width / 2;
      dy -= tp.height + 4;
    } else if (anchorRight) {
      dx -= tp.width + 4;
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
      old.start != start || old.end != end;
}

// ---------------------------------------------------------------------------
// Bottom panel
// ---------------------------------------------------------------------------

class _BottomPanel extends StatelessWidget {
  const _BottomPanel({
    required this.widthM,
    required this.lengthM,
    required this.height,
    required this.heightPresets,
    required this.valid,
    required this.saving,
    required this.onHeight,
    required this.onReset,
    required this.onFinish,
  });

  final double widthM;
  final double lengthM;
  final double height;
  final List<double> heightPresets;
  final bool valid;
  final bool saving;
  final ValueChanged<double> onHeight;
  final VoidCallback onReset;
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
                    '${widthM.toStringAsFixed(1)} × ${lengthM.toStringAsFixed(1)} × '
                    '${height.toStringAsFixed(1)} m',
                    style: DesignTokens.subtitle1,
                  ),
                ),
                Text(
                  '${(widthM * lengthM).toStringAsFixed(1)} m²',
                  style: DesignTokens.subtitle2.copyWith(
                    color: DesignTokens.textGray,
                  ),
                ),
                if (widthM > 0) ...[
                  const SizedBox(width: DesignTokens.spacingSm),
                  IconButton(
                    onPressed: onReset,
                    icon: const Icon(Icons.refresh),
                    tooltip: 'Qayta chizish',
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ],
            ),
            const SizedBox(height: DesignTokens.spacingXs),
            Text(
              'Shift balandligi',
              style: DesignTokens.caption.copyWith(color: DesignTokens.textGray),
            ),
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
