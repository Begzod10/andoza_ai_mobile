import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../providers/catalog_provider.dart';
import '../../providers/design_provider.dart';
import '../../utils/catalog_rail.dart';
import '../../widgets/common/success_toast.dart';
import '../../widgets/design/stage_progress_line.dart';
import '../../widgets/room/room_perspective_view.dart';
import '../../widgets/room_3d_rail.dart';

/// Hardcoded fallbacks — shown only while the backend catalog is loading, or
/// if it's unreachable/empty, so the rail is never blank.
const _paintSwatches = [
  RailItem(id: 'kok', label: 'Ko\'k', color: Color(0xFFBFD8F5)),
  RailItem(id: 'bej', label: 'Bej', color: Color(0xFFF5F0E6)),
  RailItem(id: 'siren', label: 'Siren', color: Color(0xFFE9DCEF)),
  RailItem(id: 'zaytun', label: 'Zaytun', color: Color(0xFFDCE8DC)),
  RailItem(id: 'naqsh', label: 'Naqsh', color: Color(0xFFEAD9C8)),
];
const _wallpaperSwatches = [
  RailItem(id: 'vinil-kok', label: 'Vinil ko\'k', color: Color(0xFFB8CDE8)),
  RailItem(id: 'vinil-bej', label: 'Vinil bej', color: Color(0xFFEDE3D3)),
  RailItem(id: 'naqshli', label: 'Naqshli', color: Color(0xFFE3D6E8)),
];
const _kafelSwatches = [
  RailItem(id: 'oq-kafel', label: 'Oq kafel', color: Color(0xFFF2F2F2)),
  RailItem(
    id: 'kulrang-kafel',
    label: 'Kulrang kafel',
    color: Color(0xFFD9D9D9),
  ),
];

/// C1-C3: Bo'yoq/Oboi/Kafel stage — covers the spec's C1 (rail open),
/// C2 (drag mid-action, live via [RoomPerspectiveView.onBackWallDrop]'s
/// hover highlight), and C3 (applied + toast + "Hamma devorga qo'llash")
/// as one continuous interactive screen, since they describe moments of a
/// single drag gesture rather than separately-navigable destinations —
/// the button-wiring table has no distinct C1→C2→C3 route, only
/// "Keyingi bosqich → next stage," which this screen provides once a wall
/// is done.
class C1PaintWallpaperScreen extends ConsumerStatefulWidget {
  const C1PaintWallpaperScreen({super.key});

  @override
  ConsumerState<C1PaintWallpaperScreen> createState() =>
      _C1PaintWallpaperScreenState();
}

class _C1PaintWallpaperScreenState
    extends ConsumerState<C1PaintWallpaperScreen> {
  Color? _wallColor;
  bool _appliedToAll = false;

  void _applySwatch(RailItem item) {
    setState(() => _wallColor = item.color);
    SuccessToast.show(context, '✓ A devorga qo\'llanildi');
  }

  void _applyToAllWalls() {
    setState(() => _appliedToAll = true);
    SuccessToast.show(context, '✓ Hamma devorga qo\'llanildi');
  }

  /// Real backend materials for [category], mapped to rail swatches. Falls back
  /// to [fallback] while loading or if the catalog is unreachable/empty, so the
  /// rail is always populated and never blocks on the network.
  List<RailItem> _railItems(String category, List<RailItem> fallback) {
    return ref.watch(materialsProvider(category)).maybeWhen(
          data: (materials) =>
              materials.isEmpty ? fallback : materialsToRailItems(materials),
          orElse: () => fallback,
        );
  }

  @override
  Widget build(BuildContext context) {
    final design = ref.watch(activeDesignProvider);
    final condition = design?.roomCondition;
    final stageStates = condition == null
        ? null
        : deriveStageStates(
            condition: condition,
            currentStage: RenovationStage.boyoqOboi,
          );

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: RoomPerspectiveView(
              wallCondition: condition?.wall ?? SurfaceCondition.raw,
              wallpaperColor: _wallColor,
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
                tabs: [
                  RailTab(
                    label: 'Bo\'yoq',
                    items: _railItems('boyoq', _paintSwatches),
                  ),
                  RailTab(
                    label: 'Oboy',
                    items: _railItems('oboy', _wallpaperSwatches),
                  ),
                  RailTab(
                    label: 'Kafel',
                    items: _railItems('plitka', _kafelSwatches),
                  ),
                ],
                onItemSelected: _applySwatch,
              ),
            ),
          ),
          if (_wallColor != null)
            Positioned(
              left: DesignTokens.spacingMd,
              right: DesignTokens.spacingMd,
              bottom: DesignTokens.spacingXl,
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    if (!_appliedToAll)
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: _applyToAllWalls,
                          child: const Text('Hamma devorga qo\'llash'),
                        ),
                      ),
                    const SizedBox(height: DesignTokens.spacingSm),
                    SizedBox(
                      width: double.infinity,
                      height: DesignTokens.buttonHeightLarge,
                      child: ElevatedButton(
                        onPressed: () {
                          ref
                              .read(activeDesignProvider.notifier)
                              .setRenovationStageLocal(RenovationStage.pol);
                          context.push('/interior/c4');
                        },
                        child: const Text('Keyingi bosqich →'),
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
}
