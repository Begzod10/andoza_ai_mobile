import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../models/room_model.dart' as room_model;
import '../../providers/design_provider.dart';
import '../../providers/room_provider.dart';
import '../home/home_empty_screen.dart';
import '../room_setup/new_project_sheet.dart';
import 'wall_measurements_screen.dart';

/// A9: Xona xulosasi — computed from the actual measured walls (not
/// hardcoded), per spec: netto wall area auto-subtracts openings.
class RoomSummaryScreen extends ConsumerStatefulWidget {
  const RoomSummaryScreen({super.key});

  @override
  ConsumerState<RoomSummaryScreen> createState() => _RoomSummaryScreenState();
}

class _RoomSummaryScreenState extends ConsumerState<RoomSummaryScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: DesignTokens.animationNormal,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final walls = ref.watch(wallMeasurementsProvider);

    // Rectangular-room approximation: opposite walls (A/C, B/D) share the
    // same run, so floor area = wallA.length * wallB.length.
    final wallA = walls.firstWhere(
      (w) => w.type.name == 'wallA',
      orElse: () => walls[0],
    );
    final wallB = walls.length > 1 ? walls[1] : walls[0];
    final floorArea = wallA.length * wallB.length;

    final perimeter = walls.fold<double>(0, (sum, w) => sum + w.length);
    final grossWallArea = walls.fold<double>(
      0,
      (sum, w) => sum + w.length * w.height,
    );
    final openingArea = walls.fold<double>(
      0,
      (sum, w) =>
          sum + w.openings.fold<double>(0, (s, o) => s + o.width * o.height),
    );
    final nettoWallArea = grossWallArea - openingArea;
    final openingCount = walls.fold<int>(
      0,
      (sum, w) => sum + w.openings.length,
    );

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: const BoxDecoration(
                        color: DesignTokens.successGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: DesignTokens.white,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacingMd),
                    Text(
                      'O\'lchamlar saqlandi!',
                      style: DesignTokens.heading2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacingXl),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: DesignTokens.spacingMd,
                mainAxisSpacing: DesignTokens.spacingMd,
                childAspectRatio: 1.3,
                children: [
                  _StatCard(
                    label: 'pol',
                    value: '${floorArea.toStringAsFixed(1)} m²',
                  ),
                  _StatCard(
                    label: 'devor (netto)',
                    value: '${nettoWallArea.toStringAsFixed(1)} m²',
                  ),
                  _StatCard(
                    label: 'perimetr',
                    value: '${perimeter.toStringAsFixed(1)} m',
                  ),
                  _StatCard(label: 'eshik/deraza', value: '$openingCount ta'),
                ],
              ),
              const SizedBox(height: DesignTokens.spacingMd),
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacingMd),
                decoration: BoxDecoration(
                  color: DesignTokens.borderGrayAlt,
                  borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: DesignTokens.primaryBlue,
                      size: DesignTokens.iconSm,
                    ),
                    const SizedBox(width: DesignTokens.spacingSm),
                    Expanded(
                      child: Text(
                        'Eshik/derazalar avtomatik ayirilgan (netto)',
                        style: DesignTokens.caption.copyWith(
                          color: DesignTokens.textGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacingXl),
              SizedBox(
                width: double.infinity,
                height: DesignTokens.buttonHeightLarge,
                child: ElevatedButton(
                  onPressed: () => _continueToNextBatch(context, ref),
                  child: const Text('Davom etish'),
                ),
              ),
              const SizedBox(height: DesignTokens.spacingMd),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => showNewProjectSheet(context),
                  child: const Text('+ Yangi xona qo\'shish'),
                ),
              ),
              const SizedBox(height: DesignTokens.spacingXl),
            ],
          ),
        ),
      ),
    );
  }

  void _continueToNextBatch(BuildContext context, WidgetRef ref) {
    final walls = ref.read(wallMeasurementsProvider);
    final roomId = DateTime.now().microsecondsSinceEpoch.toString();

    final modelWalls = <room_model.Wall>[];
    final doors = <room_model.Door>[];
    final windows = <room_model.Window>[];

    for (final wall in walls) {
      final wallId = '${roomId}_${wall.type.name}';
      modelWalls.add(
        room_model.Wall(
          id: wallId,
          type: wall.type,
          measurements: room_model.WallMeasurements(
            height: wall.height,
            length: wall.length,
          ),
        ),
      );

      for (final opening in wall.openings) {
        final position = wall.length == 0
            ? 0.0
            : (opening.offset / wall.length).clamp(0.0, 1.0);
        if (opening.type == room_model.OpeningType.dual) {
          windows.add(
            room_model.Window(
              id: opening.id,
              wallId: wallId,
              position: position,
              width: opening.width,
              height: opening.height,
              type: opening.type,
            ),
          );
        } else {
          doors.add(
            room_model.Door(
              id: opening.id,
              wallId: wallId,
              position: position,
              width: opening.width,
              height: opening.height,
              type: opening.type,
            ),
          );
        }
      }
    }

    final wallA = walls.firstWhere(
      (w) => w.type.name == 'wallA',
      orElse: () => walls[0],
    );
    final wallB = walls.length > 1 ? walls[1] : walls[0];

    final room = room_model.Room(
      id: roomId,
      name: 'Mehmonxona ta\'miri',
      dimensions: room_model.RoomDimensions(
        width: wallB.length,
        length: wallA.length,
        height: wallA.height,
      ),
      walls: modelWalls,
      doors: doors,
      windows: windows,
      createdAt: DateTime.now(),
    );
    ref.read(activeRoomProvider.notifier).setLocal(room);

    ref
        .read(activeDesignProvider.notifier)
        .setLocal(
          DesignSelection(
            id: '${roomId}_design',
            roomId: roomId,
            stage: DesignStage.floor,
            renovationStage: RenovationStage.suvoq,
          ),
        );

    ref
        .read(homeStateProvider.notifier)
        .addProject(
          ProjectItem(
            id: roomId,
            name: room.name,
            location: '',
            roomCount: 1,
            createdAt: DateTime.now(),
          ),
        );

    context.go('/design/b1');
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        color: DesignTokens.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        border: Border.all(color: DesignTokens.borderGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: DesignTokens.heading3.copyWith(
              color: DesignTokens.primaryBlue,
            ),
          ),
          const SizedBox(height: DesignTokens.spacingXs),
          Text(
            label,
            style: DesignTokens.caption.copyWith(color: DesignTokens.textGray),
          ),
        ],
      ),
    );
  }
}
