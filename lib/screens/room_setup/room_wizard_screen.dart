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
import '../../widgets/room/isometric_room_view.dart';
import '../home/home_empty_screen.dart';
import 'door_window_modal.dart';
import 'wall_measurements_screen.dart';

/// Native room-capture wizard: an isometric 3D room preview on top, and a
/// single flow of steps below — ceiling height → each wall's length + openings
/// → summary. Replaces the WebView `/wizard`, giving a fully native experience
/// (instant, offline, no web dependency) with the same shape as the web wizard.
class RoomWizardScreen extends ConsumerStatefulWidget {
  const RoomWizardScreen({super.key});

  @override
  ConsumerState<RoomWizardScreen> createState() => _RoomWizardScreenState();
}

class _RoomWizardScreenState extends ConsumerState<RoomWizardScreen> {
  // Step 0 = ceiling, steps 1..4 = walls A–D, step 5 = summary.
  int _step = 0;
  bool _openingStudio = false;
  final _ceilingController = TextEditingController();

  static const _ceilingPresets = [2.5, 2.7, 3.0, 3.2];

  @override
  void initState() {
    super.initState();
    _ceilingController.text = _ceiling.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _ceilingController.dispose();
    super.dispose();
  }

  double get _ceiling => ref.read(wallMeasurementsProvider).first.height;
  int get _totalSteps => 6; // ceiling + 4 walls + summary

  void _setCeiling(double h) {
    final clamped = h.clamp(2.0, 5.0);
    for (final w in WallType.values) {
      ref.read(wallMeasurementsProvider.notifier).updateWall(w, height: clamped);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final walls = ref.watch(wallMeasurementsProvider);
    final wallB = walls.firstWhere((w) => w.type == WallType.wallB);
    final wallA = walls.firstWhere((w) => w.type == WallType.wallA);

    // The wall being edited on wall steps (1..4).
    final activeWall = (_step >= 1 && _step <= 4) ? walls[_step - 1] : null;

    return Scaffold(
      backgroundColor: DesignTokens.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: DesignTokens.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: DesignTokens.textDark),
          onPressed: _back,
        ),
        title: Text('Yangi xona', style: DesignTokens.heading3),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Isometric room preview (hidden on the summary step, which has its
          // own celebratory header).
          if (_step < _totalSteps - 1)
            SizedBox(
              height: 240,
              width: double.infinity,
              child: IsometricRoomView(
                widthM: wallB.length,
                depthM: wallA.length,
                heightM: _ceiling,
                activeWall: activeWall?.type,
              ),
            ),
          // Progress bar.
          if (_step < _totalSteps - 1)
            LinearProgressIndicator(
              value: (_step + 1) / (_totalSteps - 1),
              minHeight: 3,
              backgroundColor: DesignTokens.borderGray,
              color: DesignTokens.primaryBlue,
            ),
          Expanded(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
              child: _step == 0
                  ? _CeilingStep(
                      controller: _ceilingController,
                      presets: _ceilingPresets,
                      current: _ceiling,
                      onPick: (h) {
                        _ceilingController.text = h.toStringAsFixed(2);
                        _setCeiling(h);
                      },
                      onExact: (h) => _setCeiling(h),
                    )
                  : (_step <= 4
                      ? _WallStep(
                          wall: activeWall!,
                          onLength: (v) => ref
                              .read(wallMeasurementsProvider.notifier)
                              .updateWall(activeWall.type, length: v),
                          onAddOpening: () =>
                              _showAddOpeningSheet(activeWall.type),
                        )
                      : _SummaryStep(
                          walls: walls,
                          openingStudio: _openingStudio,
                          onViewSmeta: _goSmeta,
                          onStartDesign: _goStudio,
                        )),
            ),
          ),
          // Bottom nav (not on the summary step — it has its own CTAs).
          if (_step < _totalSteps - 1)
            SafeArea(
              top: false,
              child: Padding(
                padding:
                    const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
                child: Row(
                  children: [
                    if (_step > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _back,
                          child: const Text('Ortga'),
                        ),
                      ),
                    if (_step > 0)
                      const SizedBox(width: DesignTokens.spacingMd),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: DesignTokens.buttonHeightLarge,
                        child: ElevatedButton(
                          onPressed: () => setState(() => _step++),
                          child: const Text('Keyingi'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _back() {
    if (_step > 0) {
      setState(() => _step--);
    } else {
      Navigator.of(context).pop();
    }
  }

  void _showAddOpeningSheet(WallType wallType) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => DoorWindowModal(
        onAdd: (type, width, height, offset) {
          ref.read(wallMeasurementsProvider.notifier).addOpening(
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

  /// "Smeta ko'rish" — set up the room and show the smeta (E1 persists it and
  /// computes the estimate).
  void _goSmeta() {
    _setupRoom();
    context.go('/estimation/e1');
  }

  /// "Bezashni boshlash" — like the web wizard, open the 3D Studio. That needs a
  /// real backend room id, so persist the room first, then navigate to
  /// /studio/{id}. Falls back to the native design flow if the backend is
  /// unreachable (offline).
  Future<void> _goStudio() async {
    _setupRoom();
    setState(() => _openingStudio = true);
    try {
      final notifier = ref.read(roomPersistenceProvider.notifier);
      await notifier.ensurePersisted();
      final persisted = ref.read(roomPersistenceProvider).valueOrNull;
      if (!mounted) return;
      if (persisted != null) {
        context.go('/studio/${persisted.roomId}');
      } else {
        context.go('/design/b1'); // offline fallback
      }
    } catch (_) {
      if (mounted) context.go('/design/b1');
    } finally {
      if (mounted) setState(() => _openingStudio = false);
    }
  }

  /// Builds the room from the captured walls and populates the app's providers
  /// (same as the classic summary flow).
  void _setupRoom() {
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
        final position =
            wall.length == 0 ? 0.0 : (opening.offset / wall.length).clamp(0.0, 1.0);
        final o = room_model.Window(
          id: opening.id,
          wallId: wallId,
          position: position,
          width: opening.width,
          height: opening.height,
          type: opening.type,
        );
        if (opening.type == room_model.OpeningType.dual) {
          windows.add(o);
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

    final wallA = walls.firstWhere((w) => w.type == WallType.wallA);
    final wallB = walls.firstWhere((w) => w.type == WallType.wallB);

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
// Steps
// ---------------------------------------------------------------------------

class _CeilingStep extends StatelessWidget {
  const _CeilingStep({
    required this.controller,
    required this.presets,
    required this.current,
    required this.onPick,
    required this.onExact,
  });

  final TextEditingController controller;
  final List<double> presets;
  final double current;
  final ValueChanged<double> onPick;
  final ValueChanged<double> onExact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Shiftning balandligi?', style: DesignTokens.heading2),
        const SizedBox(height: DesignTokens.spacingXs),
        Text(
          'Odatda 2.5–3.2 metr oralig\'ida',
          style: DesignTokens.body2.copyWith(color: DesignTokens.textGray),
        ),
        const SizedBox(height: DesignTokens.spacingLg),
        Wrap(
          spacing: DesignTokens.spacingSm,
          children: [
            for (final p in presets)
              ChoiceChip(
                label: Text('${p.toStringAsFixed(1)} m'),
                selected: (current - p).abs() < 0.001,
                onSelected: (_) => onPick(p),
                selectedColor: DesignTokens.primaryBlue,
                labelStyle: TextStyle(
                  color: (current - p).abs() < 0.001
                      ? DesignTokens.white
                      : DesignTokens.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        const SizedBox(height: DesignTokens.spacingLg),
        Text('Aniq qiymat (m)', style: DesignTokens.subtitle2),
        const SizedBox(height: DesignTokens.spacingSm),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(border: OutlineInputBorder()),
          onChanged: (v) {
            final parsed = double.tryParse(v);
            if (parsed != null) onExact(parsed);
          },
        ),
      ],
    );
  }
}

class _WallStep extends StatelessWidget {
  const _WallStep({
    required this.wall,
    required this.onLength,
    required this.onAddOpening,
  });

  final WallMeasurement wall;
  final ValueChanged<double> onLength;
  final VoidCallback onAddOpening;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${_letter(wall.type)} devor', style: DesignTokens.heading2),
        const SizedBox(height: DesignTokens.spacingXs),
        Text(
          'Uzunligini kiriting',
          style: DesignTokens.body2.copyWith(color: DesignTokens.textGray),
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        // Wall elevation diagram (reused painter).
        AspectRatio(
          aspectRatio: 1.6,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: DesignTokens.backgroundLight,
              borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
              border: Border.all(color: DesignTokens.borderGray),
            ),
            child: CustomPaint(painter: WallElevationPainter(wall: wall)),
          ),
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Uzunlik', style: DesignTokens.body2),
            Text(
              '${wall.length.toStringAsFixed(1)} m',
              style: DesignTokens.subtitle2
                  .copyWith(color: DesignTokens.primaryBlue),
            ),
          ],
        ),
        Slider(
          value: wall.length.clamp(1.0, 10.0),
          min: 1,
          max: 10,
          divisions: 90,
          activeColor: DesignTokens.primaryBlue,
          onChanged: onLength,
        ),
        if (wall.openings.isNotEmpty) ...[
          const SizedBox(height: DesignTokens.spacingSm),
          for (final o in wall.openings)
            Padding(
              padding: const EdgeInsets.only(bottom: DesignTokens.spacingXs),
              child: Row(
                children: [
                  Icon(
                    o.type == OpeningType.dual
                        ? Icons.window_outlined
                        : Icons.door_front_door_outlined,
                    size: DesignTokens.iconSm,
                    color: DesignTokens.textGray,
                  ),
                  const SizedBox(width: DesignTokens.spacingSm),
                  Text(
                    '${(o.width * 100).toStringAsFixed(0)}×${(o.height * 100).toStringAsFixed(0)} sm',
                    style: DesignTokens.caption,
                  ),
                ],
              ),
            ),
        ],
        const SizedBox(height: DesignTokens.spacingSm),
        OutlinedButton.icon(
          onPressed: onAddOpening,
          icon: const Icon(Icons.add),
          label: const Text('Eshik / Deraza qo\'shish'),
        ),
      ],
    );
  }

  String _letter(WallType t) => switch (t) {
        WallType.wallA => 'A',
        WallType.wallB => 'B',
        WallType.wallC => 'C',
        WallType.wallD => 'D',
      };
}

class _SummaryStep extends StatelessWidget {
  const _SummaryStep({
    required this.walls,
    required this.openingStudio,
    required this.onViewSmeta,
    required this.onStartDesign,
  });

  final List<WallMeasurement> walls;
  final bool openingStudio;
  final VoidCallback onViewSmeta;
  final VoidCallback onStartDesign;

  @override
  Widget build(BuildContext context) {
    final wallA = walls.firstWhere((w) => w.type == WallType.wallA);
    final wallB = walls.firstWhere((w) => w.type == WallType.wallB);
    final floorArea = wallA.length * wallB.length;
    final perimeter = walls.fold<double>(0, (s, w) => s + w.length);
    final grossWall = walls.fold<double>(0, (s, w) => s + w.length * w.height);
    final openingArea = walls.fold<double>(
      0,
      (s, w) => s + w.openings.fold<double>(0, (a, o) => a + o.width * o.height),
    );
    final nettoWall = grossWall - openingArea;
    final openingCount = walls.fold<int>(0, (s, w) => s + w.openings.length);

    return Column(
      children: [
        const SizedBox(height: DesignTokens.spacingLg),
        Container(
          width: 72,
          height: 72,
          decoration: const BoxDecoration(
            color: DesignTokens.successGreen,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: DesignTokens.white, size: 36),
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        Text('O\'lchamlar saqlandi!',
            style: DesignTokens.heading2, textAlign: TextAlign.center),
        Text(
          'Xona parametrlari muvaffaqiyatli qayd etildi',
          style: DesignTokens.body2.copyWith(color: DesignTokens.textGray),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: DesignTokens.spacingXl),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: DesignTokens.spacingMd,
          mainAxisSpacing: DesignTokens.spacingMd,
          childAspectRatio: 1.5,
          children: [
            _Stat(value: '${floorArea.toStringAsFixed(1)} m²', label: 'POL MAYDONI'),
            _Stat(value: '${nettoWall.toStringAsFixed(1)} m²', label: 'DEVOR MAYDONI (NETTO)'),
            _Stat(value: '${perimeter.toStringAsFixed(1)} m', label: 'PERIMETR'),
            _Stat(value: '$openingCount ta', label: 'ESHIK/DERAZALAR'),
          ],
        ),
        const SizedBox(height: DesignTokens.spacingXl),
        SizedBox(
          width: double.infinity,
          height: DesignTokens.buttonHeightLarge,
          child: ElevatedButton(
            onPressed: openingStudio ? null : onViewSmeta,
            child: const Text('Smeta ko\'rish'),
          ),
        ),
        const SizedBox(height: DesignTokens.spacingSm),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: openingStudio ? null : onStartDesign,
            icon: openingStudio
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.view_in_ar_outlined),
            label: Text(openingStudio ? 'Ochilmoqda…' : 'Bezashni boshlash'),
          ),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;

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
          Text(value,
              style: DesignTokens.heading3.copyWith(color: DesignTokens.primaryBlue)),
          const SizedBox(height: DesignTokens.spacingXs),
          Text(label,
              style: DesignTokens.caption.copyWith(color: DesignTokens.textGray)),
        ],
      ),
    );
  }
}
