import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../providers/catalog_provider.dart';
import '../../providers/design_provider.dart';
import '../../providers/room_persistence_provider.dart';
import '../../utils/catalog_rail.dart';
import '../../widgets/common/success_toast.dart';
import '../../widgets/design/stage_progress_line.dart';
import '../../widgets/room/room_perspective_view.dart';
import '../../widgets/room_3d_rail.dart';
import 'wallpaper_library_sheet.dart';

/// Rail ids that are real backend material UUIDs (vs. the hardcoded fallback
/// swatch slugs like 'kok') can be persisted to the room's surfaces.
final _uuidRe = RegExp(
  r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
);

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
  String? _selectedMaterialId;
  String? _wallpaperUrl;

  @override
  void initState() {
    super.initState();
    // Ensure the room exists on the backend so material choices can persist and
    // feed the real smeta. Best-effort; the screen works offline regardless.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(roomPersistenceProvider.notifier).ensurePersisted();
    });
  }

  /// Persists [materialId] to the given wall [surfaces] on the backend room, if
  /// it's a real catalog material (fallback swatch slugs are local-only). This
  /// is what makes the E1 smeta/delta reflect the chosen paint/wallpaper.
  void _persist(List<String> surfaces, String materialId) {
    if (!_uuidRe.hasMatch(materialId)) return;
    ref.read(roomPersistenceProvider.notifier).setSurfaceMaterials(
          surfaces: surfaces,
          materialId: materialId,
        );
  }

  void _applySwatch(RailItem item) {
    setState(() {
      _wallColor = item.color;
      _selectedMaterialId = item.id;
    });
    // Single-tap applies to wall A (the room's "back wall" in the preview).
    _persist(const ['A'], item.id);
    SuccessToast.show(context, '✓ A devorga qo\'llanildi');
  }

  void _applyToAllWalls() {
    setState(() => _appliedToAll = true);
    final materialId = _selectedMaterialId;
    if (materialId != null) {
      _persist(const ['A', 'B', 'C', 'D'], materialId);
    }
    SuccessToast.show(context, '✓ Hamma devorga qo\'llanildi');
  }

  /// Opens the shared wallpaper library. A picked wallpaper is applied to the
  /// preview wall as a texture. (Uploaded wallpapers are image textures, not
  /// catalog materials, so they aren't persisted to room.surfaces here — the
  /// 3D Studio owns richer per-wall texture state.)
  Future<void> _openWallpaperLibrary() async {
    final wallpaper = await WallpaperLibrarySheet.show(context);
    if (wallpaper == null || !mounted) return;
    setState(() => _wallpaperUrl = wallpaper.url);
    SuccessToast.show(context, '✓ Oboy tanlandi: ${wallpaper.name}');
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
          // Wallpaper-library trigger — a standalone button pinned bottom-left so
          // it stays above the room drag-layer and the material rail overlay.
          Positioned(
            left: DesignTokens.spacingMd,
            bottom: DesignTokens.spacingXl,
            child: SafeArea(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton.extended(
                    heroTag: 'wallpaperLib',
                    onPressed: _openWallpaperLibrary,
                    backgroundColor: DesignTokens.white,
                    foregroundColor: DesignTokens.primaryBlue,
                    icon: const Icon(Icons.collections_outlined),
                    label: const Text('Oboy kutubxonasi'),
                  ),
                  if (_wallpaperUrl != null) ...[
                    const SizedBox(width: DesignTokens.spacingSm),
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(DesignTokens.radiusMd),
                      child: Image.network(
                        _wallpaperUrl!,
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                        errorBuilder: (_, e, s) =>
                            const SizedBox(width: 44, height: 44),
                      ),
                    ),
                  ],
                ],
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
