import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/room_model.dart';
import 'door_window_modal.dart';

/// A single opening (door/window) placed on a wall, positioned by offset
/// from the wall's start.
class WallOpening {
  final String id;
  final OpeningType type;
  final double width;
  final double height;
  final double offset;

  const WallOpening({
    required this.id,
    required this.type,
    required this.width,
    required this.height,
    required this.offset,
  });
}

/// One measured wall — uses the canonical [WallType] enum (A-D) rather
/// than a free-text name, per plans/screen-mapping.md's reconciliation note.
class WallMeasurement {
  final WallType type;
  final double length;
  final double height;
  final List<WallOpening> openings;

  const WallMeasurement({
    required this.type,
    required this.length,
    required this.height,
    this.openings = const [],
  });

  WallMeasurement copyWith({
    double? length,
    double? height,
    List<WallOpening>? openings,
  }) {
    return WallMeasurement(
      type: type,
      length: length ?? this.length,
      height: height ?? this.height,
      openings: openings ?? this.openings,
    );
  }

  String get label => switch (type) {
    WallType.wallA => 'Devor A',
    WallType.wallB => 'Devor B',
    WallType.wallC => 'Devor C',
    WallType.wallD => 'Devor D',
  };
}

final wallMeasurementsProvider =
    StateNotifierProvider<WallMeasurementsNotifier, List<WallMeasurement>>(
      (ref) => WallMeasurementsNotifier(),
    );

class WallMeasurementsNotifier extends StateNotifier<List<WallMeasurement>> {
  WallMeasurementsNotifier()
    : super(const [
        WallMeasurement(type: WallType.wallA, length: 4.5, height: 2.8),
        WallMeasurement(type: WallType.wallB, length: 3.2, height: 2.8),
        WallMeasurement(type: WallType.wallC, length: 4.5, height: 2.8),
        WallMeasurement(type: WallType.wallD, length: 3.2, height: 2.8),
      ]);

  void updateWall(WallType type, {double? length, double? height}) {
    state = [
      for (final wall in state)
        if (wall.type == type)
          wall.copyWith(length: length, height: height)
        else
          wall,
    ];
  }

  void addOpening(WallType type, WallOpening opening) {
    state = [
      for (final wall in state)
        if (wall.type == type)
          wall.copyWith(openings: [...wall.openings, opening])
        else
          wall,
    ];
  }
}

/// A7: Devor [A-D] o'lchovi — wall-by-wall elevation with a length slider,
/// per-opening rows, and progress dots across the 4 walls.
class WallMeasurementsScreen extends ConsumerStatefulWidget {
  const WallMeasurementsScreen({super.key});

  @override
  ConsumerState<WallMeasurementsScreen> createState() =>
      _WallMeasurementsScreenState();
}

class _WallMeasurementsScreenState
    extends ConsumerState<WallMeasurementsScreen> {
  int _currentWallIndex = 0;

  @override
  Widget build(BuildContext context) {
    final walls = ref.watch(wallMeasurementsProvider);
    final wall = walls[_currentWallIndex];
    final isLastWall = _currentWallIndex == walls.length - 1;

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: DesignTokens.backgroundLight,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: DesignTokens.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(wall.label, style: DesignTokens.heading3),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.screenPaddingHorizontal,
              ),
              child: Row(
                children: [
                  for (var i = 0; i < walls.length; i++) ...[
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: i <= _currentWallIndex
                              ? DesignTokens.primaryBlue
                              : DesignTokens.borderGray,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    if (i < walls.length - 1)
                      const SizedBox(width: DesignTokens.spacingSm),
                  ],
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.screenPaddingHorizontal,
                ),
                decoration: BoxDecoration(
                  color: DesignTokens.white,
                  borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                  border: Border.all(color: DesignTokens.borderGray),
                ),
                child: CustomPaint(
                  painter: _WallElevationPainter(wall: wall),
                  size: Size.infinite,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                DesignTokens.screenPaddingHorizontal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Uzunlik', style: DesignTokens.body2),
                      Text(
                        '${wall.length.toStringAsFixed(1)} m',
                        style: DesignTokens.subtitle2.copyWith(
                          color: DesignTokens.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: wall.length.clamp(1.0, 10.0),
                    min: 1,
                    max: 10,
                    activeColor: DesignTokens.primaryBlue,
                    onChanged: (value) => ref
                        .read(wallMeasurementsProvider.notifier)
                        .updateWall(wall.type, length: value),
                  ),
                  if (wall.openings.isNotEmpty) ...[
                    const SizedBox(height: DesignTokens.spacingSm),
                    Text('Eshik / derazalar', style: DesignTokens.subtitle2),
                    const SizedBox(height: DesignTokens.spacingSm),
                    for (final opening in wall.openings)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: DesignTokens.spacingXs,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              opening.type == OpeningType.single
                                  ? Icons.door_front_door_outlined
                                  : Icons.window_outlined,
                              size: DesignTokens.iconSm,
                              color: DesignTokens.textGray,
                            ),
                            const SizedBox(width: DesignTokens.spacingSm),
                            Text(
                              '${(opening.width * 100).toStringAsFixed(0)}×${(opening.height * 100).toStringAsFixed(0)} sm',
                              style: DesignTokens.caption,
                            ),
                            const Spacer(),
                            Text(
                              'Chapdan ${opening.offset.toStringAsFixed(1)} m',
                              style: DesignTokens.caption.copyWith(
                                color: DesignTokens.textGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                  const SizedBox(height: DesignTokens.spacingSm),
                  OutlinedButton.icon(
                    onPressed: () => _showAddOpeningSheet(context, wall.type),
                    icon: const Icon(Icons.add),
                    label: const Text('Eshik/Deraza qo\'shish'),
                  ),
                  const SizedBox(height: DesignTokens.spacingMd),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _currentWallIndex > 0
                              ? () => setState(() => _currentWallIndex--)
                              : () => Navigator.of(context).pop(),
                          child: const Text('Ortga'),
                        ),
                      ),
                      const SizedBox(width: DesignTokens.spacingMd),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (isLastWall) {
                              context.push('/setup/summary');
                            } else {
                              setState(() => _currentWallIndex++);
                            }
                          },
                          child: Text(isLastWall ? 'Yakunlash' : 'Keyingi'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddOpeningSheet(BuildContext context, WallType wallType) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => DoorWindowModal(
        onAdd: (type, width, height, offset) {
          ref
              .read(wallMeasurementsProvider.notifier)
              .addOpening(
                wallType,
                WallOpening(
                  id: DateTime.now().microsecondsSinceEpoch.toString(),
                  type: type,
                  width: width,
                  height: height,
                  offset: offset,
                ),
              );
          Navigator.of(sheetContext).pop();
        },
      ),
    );
  }
}

class _WallElevationPainter extends CustomPainter {
  final WallMeasurement wall;

  _WallElevationPainter({required this.wall});

  @override
  void paint(Canvas canvas, Size size) {
    const padding = 40.0;
    final width = size.width - (2 * padding);
    final height = size.height - (2 * padding);
    final wallRect = Rect.fromLTWH(padding, padding, width, height);

    canvas.drawRect(
      wallRect,
      Paint()..color = DesignTokens.primaryBlue.withValues(alpha: 0.05),
    );
    canvas.drawRect(
      wallRect,
      Paint()
        ..color = const Color(0xFFEF4444)
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke,
    );

    for (final opening in wall.openings) {
      final openingX = padding + (opening.offset / wall.length) * width;
      final openingWidth = (opening.width / wall.length) * width;
      canvas.drawRect(
        Rect.fromLTWH(openingX, padding, openingWidth, height),
        Paint()..color = DesignTokens.accentOrange.withValues(alpha: 0.3),
      );
    }

    // Human silhouette for scale (~1.7m relative to wall height).
    final silhouetteHeight = (1.7 / wall.height) * height;
    final silhouetteX = padding + width - 30;
    final silhouetteTop = padding + height - silhouetteHeight;
    canvas.drawOval(
      Rect.fromLTWH(silhouetteX, silhouetteTop, 14, 14),
      Paint()..color = DesignTokens.textMuted,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          silhouetteX - 3,
          silhouetteTop + 14,
          20,
          silhouetteHeight - 14,
        ),
        const Radius.circular(6),
      ),
      Paint()..color = DesignTokens.textMuted,
    );

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.text = TextSpan(
      text: '${wall.length.toStringAsFixed(1)} m',
      style: const TextStyle(
        color: DesignTokens.accentOrange,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        padding + (width / 2) - (textPainter.width / 2),
        padding + height + 12,
      ),
    );
  }

  @override
  bool shouldRepaint(_WallElevationPainter oldDelegate) {
    return oldDelegate.wall.length != wall.length ||
        oldDelegate.wall.height != wall.height ||
        oldDelegate.wall.openings.length != wall.openings.length;
  }
}
