import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../features/room_scan/models/captured_room.dart';
import '../../features/room_scan/room_scan_converter.dart';
import '../../features/room_scan/room_scan_service.dart';
import '../../geometry/room_geometry.dart';
import '../../models/room_plan.dart';
import '../../services/room_plan_handoff.dart';

/// Nav payload for [RoomScanReviewPage] (passed via go_router `extra`).
class RoomScanReviewArgs {
  final RoomScanDraft draft;
  final ScanResult scan;
  const RoomScanReviewArgs({required this.draft, required this.scan});
}

const List<double> _ceilingChips = [2.5, 2.7, 2.8, 3.0, 3.2];

/// Uzbek label for a scanned object category.
String scanCategoryLabelUz(ScanObjectCategory c) {
  switch (c) {
    case ScanObjectCategory.table:
      return 'Stol';
    case ScanObjectCategory.chair:
      return 'Stul';
    case ScanObjectCategory.sofa:
      return 'Divan';
    case ScanObjectCategory.bed:
      return 'Karavot';
    case ScanObjectCategory.storage:
      return 'Shkaf';
    case ScanObjectCategory.refrigerator:
      return 'Muzlatgich';
    case ScanObjectCategory.stove:
      return 'Plita';
    case ScanObjectCategory.sink:
      return 'Rakovina';
    case ScanObjectCategory.toilet:
      return 'Unitaz';
    case ScanObjectCategory.bathtub:
      return 'Vanna';
    case ScanObjectCategory.washer:
      return 'Kir yuvish mashinasi';
    case ScanObjectCategory.television:
      return 'Televizor';
    case ScanObjectCategory.fireplace:
      return 'Kamin';
    case ScanObjectCategory.stairs:
      return 'Zina';
    case ScanObjectCategory.other:
      return 'Boshqa';
  }
}

/// Review + confirm a LiDAR-scanned room before creating the project: a 2-D
/// top-down preview, an editable ceiling height, per-wall lengths and the list
/// of detected objects. "Davom etish" persists the room (same handoff as the
/// manual flow), uploads the scan artifacts, then opens the studio.
class RoomScanReviewPage extends ConsumerStatefulWidget {
  const RoomScanReviewPage({required this.args, super.key});

  final RoomScanReviewArgs args;

  @override
  ConsumerState<RoomScanReviewPage> createState() => _RoomScanReviewPageState();
}

class _RoomScanReviewPageState extends ConsumerState<RoomScanReviewPage> {
  static final Logger _logger = Logger();
  late double _ceiling;
  bool _busy = false;

  RoomPlan get _plan => widget.args.draft.plan;
  List<ScanObjectPlacement> get _objects => widget.args.draft.objects;

  @override
  void initState() {
    super.initState();
    _ceiling = _plan.ceilingHeightM;
  }

  Future<void> _continue() async {
    setState(() => _busy = true);
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    // Rebuild the plan with the (possibly overridden) ceiling height.
    final plan = RoomPlan(
      corners: _plan.corners,
      walls: _plan.walls,
      ceilingHeightM: _ceiling,
      source: RoomSource.lidar,
      name: _plan.name,
    );
    try {
      final roomId = await handoffRoomPlan(ref, plan);
      if (roomId == null) {
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.scanReviewSaveFailed)),
        );
        if (mounted) setState(() => _busy = false);
        return;
      }
      // Best-effort: attach the scan artifacts. Becomes functional once the
      // Phase 4 endpoint exists; a failure here must not block the studio since
      // the room itself is already created from the parametric data.
      try {
        await ref.read(roomScanServiceProvider).upload(roomId, widget.args.scan);
      } catch (e) {
        _logger.w('roomscan artifact upload failed (Phase 4 endpoint?): $e');
      }
      router.pushReplacement('/studio/$roomId');
    } catch (e) {
      _logger.e('roomscan continue failed', error: e);
      messenger.showSnackBar(SnackBar(content: Text(l10n.scanReviewError('$e'))));
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final corners = _plan.corners;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.scanReviewTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
          children: [
            // 2-D top-down preview.
            AspectRatio(
              aspectRatio: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                  border: Border.all(color: DesignTokens.borderGray),
                ),
                child: CustomPaint(
                  painter: RoomScanPainter(
                    corners: corners,
                    walls: _plan.walls,
                    objects: _objects,
                  ),
                ),
              ),
            ),
            const SizedBox(height: DesignTokens.spacingLg),

            // Ceiling height override.
            Text(l10n.ceilingHeightLabel, style: DesignTokens.subtitle2),
            const SizedBox(height: DesignTokens.spacingXs),
            Text(l10n.scanReviewDetected(formatLength(_plan.ceilingHeightM)),
                style: DesignTokens.caption.copyWith(color: DesignTokens.textGray)),
            const SizedBox(height: DesignTokens.spacingSm),
            Wrap(
              spacing: DesignTokens.spacingSm,
              children: [
                for (final h in _ceilingChips)
                  ChoiceChip(
                    label: Text('$h m'),
                    selected: (_ceiling - h).abs() < 0.001,
                    onSelected: (_) => setState(() => _ceiling = h),
                  ),
              ],
            ),
            const SizedBox(height: DesignTokens.spacingLg),

            // Per-wall lengths.
            Text(l10n.scanReviewWalls(_plan.walls.length),
                style: DesignTokens.subtitle2),
            const SizedBox(height: DesignTokens.spacingXs),
            for (var i = 0; i < _plan.walls.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l10n.scanReviewWall(i + 1), style: DesignTokens.body2),
                    Text(formatLength(_plan.walls[i].lengthM),
                        style: DesignTokens.body2.copyWith(color: DesignTokens.textGray)),
                  ],
                ),
              ),
            const SizedBox(height: DesignTokens.spacingLg),

            // Detected objects.
            Text(l10n.scanReviewObjects(_objects.length),
                style: DesignTokens.subtitle2),
            const SizedBox(height: DesignTokens.spacingXs),
            if (_objects.isEmpty)
              Text(l10n.scanReviewNoObjects,
                  style: DesignTokens.caption.copyWith(color: DesignTokens.textMuted))
            else
              for (final o in _objects)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(scanCategoryLabelUz(o.category), style: DesignTokens.body2),
                      Text(
                        '${o.width.toStringAsFixed(2)}×${o.depth.toStringAsFixed(2)} m',
                        style: DesignTokens.body2.copyWith(color: DesignTokens.textGray),
                      ),
                    ],
                  ),
                ),
            const SizedBox(height: DesignTokens.spacingXl),

            // Actions.
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _busy
                        ? null
                        : () => context.pushReplacement('/scanning/roomplan'),
                    child: Text(l10n.scanReviewRescan),
                  ),
                ),
                const SizedBox(width: DesignTokens.spacingMd),
                Expanded(
                  child: FilledButton(
                    onPressed: _busy ? null : _continue,
                    child: _busy
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.actionContinue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Draws a top-down floor plan of the scanned room: floor polygon, walls,
/// openings (door = green, window = blue) and detected-object footprints.
class RoomScanPainter extends CustomPainter {
  RoomScanPainter({
    required this.corners,
    required this.walls,
    required this.objects,
  });

  final List<Vec2> corners;
  final List<RoomWall> walls;
  final List<ScanObjectPlacement> objects;

  @override
  void paint(Canvas canvas, Size size) {
    if (corners.length < 3) return;

    // Fit the room (metres) into the canvas with padding, Y-up (north up).
    const pad = 16.0;
    var minX = corners.first.x, maxX = corners.first.x;
    var minY = corners.first.y, maxY = corners.first.y;
    for (final c in corners) {
      minX = math.min(minX, c.x);
      maxX = math.max(maxX, c.x);
      minY = math.min(minY, c.y);
      maxY = math.max(maxY, c.y);
    }
    final spanX = math.max(maxX - minX, 0.01);
    final spanY = math.max(maxY - minY, 0.01);
    final scale = math.min((size.width - 2 * pad) / spanX, (size.height - 2 * pad) / spanY);
    // Centre the drawing.
    final offX = (size.width - spanX * scale) / 2;
    final offY = (size.height - spanY * scale) / 2;
    Offset p(Vec2 v) => Offset(
          offX + (v.x - minX) * scale,
          // flip Y so +y (room length) points up on screen
          size.height - (offY + (v.y - minY) * scale),
        );

    // Floor fill.
    final path = Path()..moveTo(p(corners.first).dx, p(corners.first).dy);
    for (var i = 1; i < corners.length; i++) {
      path.lineTo(p(corners[i]).dx, p(corners[i]).dy);
    }
    path.close();
    canvas.drawPath(path, Paint()..color = const Color(0xFFE9ECF2));

    // Object footprints (under the walls, above the floor).
    final objFill = Paint()..color = const Color(0x33F59E0B);
    final objStroke = Paint()
      ..color = const Color(0xFFB77300)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (final o in objects) {
      final centre = p(Vec2(o.x, o.y));
      canvas.save();
      canvas.translate(centre.dx, centre.dy);
      canvas.rotate(-o.rotationRad); // screen Y is flipped
      final w = o.width * scale, d = o.depth * scale;
      final rect = Rect.fromCenter(center: Offset.zero, width: w, height: d);
      canvas.drawRect(rect, objFill);
      canvas.drawRect(rect, objStroke);
      canvas.restore();
    }

    // Walls + openings.
    final wallPaint = Paint()
      ..color = const Color(0xFF2B3242)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    final n = corners.length;
    for (var i = 0; i < n; i++) {
      final a = corners[i];
      final b = corners[(i + 1) % n];
      canvas.drawLine(p(a), p(b), wallPaint);

      // Openings along this wall, drawn as a coloured chunk at their fraction.
      final wall = i < walls.length ? walls[i] : null;
      if (wall == null) continue;
      final wallLen = a.distanceTo(b);
      if (wallLen <= 0) continue;
      for (final o in wall.openings) {
        final halfFrac = (o.width / wallLen) / 2;
        final t0 = (o.position - halfFrac).clamp(0.0, 1.0);
        final t1 = (o.position + halfFrac).clamp(0.0, 1.0);
        final s0 = a + (b - a) * t0;
        final s1 = a + (b - a) * t1;
        final paint = Paint()
          ..color = o.type == 'window'
              ? const Color(0xFF2563EB)
              : DesignTokens.successGreen
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.butt;
        canvas.drawLine(p(s0), p(s1), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant RoomScanPainter old) =>
      old.corners != corners || old.walls != walls || old.objects != objects;
}
