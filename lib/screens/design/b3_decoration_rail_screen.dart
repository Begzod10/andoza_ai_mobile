import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../providers/design_provider.dart';
import '../../widgets/common/success_toast.dart';
import '../../widgets/design/stage_progress_line.dart';
import '../../widgets/room/room_perspective_view.dart';
import '../../widgets/room_3d_rail.dart';

const _paintSwatches = [
  RailItem(id: 'kok', label: 'Ko\'k', color: Color(0xFFBFD8F5)),
  RailItem(id: 'bej', label: 'Bej', color: Color(0xFFF5F0E6)),
  RailItem(id: 'siren', label: 'Siren', color: Color(0xFFE9DCEF)),
  RailItem(id: 'zaytun', label: 'Zaytun', color: Color(0xFFDCE8DC)),
  RailItem(id: 'naqsh', label: 'Naqsh', color: Color(0xFFEAD9C8)),
];

/// B3: Bosqich + rail — the key interaction. The right rail opens on the
/// Bo'yoq/Oboi stage; a one-time onboarding overlay hints at the
/// drag-swatch-to-wall gesture that drives every decoration/electrical
/// screen from here through Batch D.
class B3DecorationRailScreen extends ConsumerStatefulWidget {
  const B3DecorationRailScreen({super.key});

  @override
  ConsumerState<B3DecorationRailScreen> createState() =>
      _B3DecorationRailScreenState();
}

class _B3DecorationRailScreenState
    extends ConsumerState<B3DecorationRailScreen> {
  bool _showOnboarding = true;
  Color? _wallpaperColor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(activeDesignProvider.notifier)
          .setRenovationStageLocal(RenovationStage.boyoqOboi);
    });
  }

  void _applySwatch(RailItem item) {
    setState(() {
      _wallpaperColor = item.color;
      _showOnboarding = false;
    });
    SuccessToast.show(context, '✓ Shpaklovka qo\'shildi');
  }

  @override
  Widget build(BuildContext context) {
    final design = ref.watch(activeDesignProvider);
    final condition = design?.roomCondition;
    final stageStates = condition == null
        ? null
        : deriveStageStates(
            condition: condition,
            currentStage: design!.renovationStage,
          );

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: RoomPerspectiveView(
              wallCondition: condition?.wall ?? SurfaceCondition.raw,
              wallpaperColor: _wallpaperColor,
              onBackWallDrop: _applySwatch,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(DesignTokens.spacingMd),
              child: Container(
                padding: const EdgeInsets.all(DesignTokens.spacingMd),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                ),
                child: StageProgressLine(
                  currentStep: RenovationStage.boyoqOboi.index,
                  totalSteps: RenovationStage.values.length,
                  stageStates: stageStates,
                  stageLabel: 'Bo\'yoq/Oboi bosqichi',
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SafeArea(
              child: Room3DRail(
                initiallyExpanded: true,
                tabs: const [RailTab(label: 'Bo\'yoq', items: _paintSwatches)],
                onItemSelected: _applySwatch,
                selectedItemId: null,
              ),
            ),
          ),
          if (_showOnboarding)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => setState(() => _showOnboarding = false),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.5),
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(DesignTokens.spacingXl),
                      padding: const EdgeInsets.all(DesignTokens.spacingLg),
                      decoration: BoxDecoration(
                        color: DesignTokens.white,
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusLg,
                        ),
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('👆', style: TextStyle(fontSize: 40)),
                          SizedBox(height: DesignTokens.spacingMd),
                          Text(
                            'Materialni barmog\'ingiz bilan devorga sudrang',
                            textAlign: TextAlign.center,
                            style: DesignTokens.body1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (!_showOnboarding && _wallpaperColor != null)
            Positioned(
              left: DesignTokens.spacingMd,
              right: DesignTokens.spacingMd,
              bottom: DesignTokens.spacingXl,
              child: SafeArea(
                top: false,
                child: SizedBox(
                  width: double.infinity,
                  height: DesignTokens.buttonHeightLarge,
                  child: ElevatedButton(
                    onPressed: () => context.push('/interior/c1'),
                    child: const Text('Keyingi bosqich →'),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
