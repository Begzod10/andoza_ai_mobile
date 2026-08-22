import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../providers/design_provider.dart';
import '../../widgets/design/furniture_edit_card.dart';
import '../../widgets/room/room_perspective_view.dart';
import '../../widgets/room_3d_rail.dart';

const _mehmonxonaFurniture = [
  RailItem(id: 'divan', label: 'Divan', icon: Icons.weekend_outlined),
  RailItem(id: 'stol', label: 'Jurnal stol', icon: Icons.table_bar_outlined),
  RailItem(id: 'tv-tumba', label: 'TV va tumba', icon: Icons.tv_outlined),
];
const _oshxonaFurniture = [
  RailItem(
    id: 'oshxona-stol',
    label: 'Oshxona stoli',
    icon: Icons.table_restaurant_outlined,
  ),
];
const _yotoqxonaFurniture = [
  RailItem(id: 'krovat', label: 'Krovat', icon: Icons.bed_outlined),
];
const _vannaFurniture = [
  RailItem(id: 'rakovina', label: 'Rakovina', icon: Icons.bathtub_outlined),
];

/// C5-C6: Mebel stage — room-tab rail (Mehmonxona/Oshxona/Yotoqxona/Vanna),
/// drag furniture onto the floor, tap a placed item to open the C6
/// selected-item card ([FurnitureEditCard] — no price anywhere).
class C5FurniturePlacementScreen extends ConsumerStatefulWidget {
  const C5FurniturePlacementScreen({super.key});

  @override
  ConsumerState<C5FurniturePlacementScreen> createState() =>
      _C5FurniturePlacementScreenState();
}

class _C5FurniturePlacementScreenState
    extends ConsumerState<C5FurniturePlacementScreen> {
  final _floorKey = GlobalKey();

  void _placeFurniture(RailItem item, Offset globalPosition) {
    final box = _floorKey.currentContext?.findRenderObject() as RenderBox?;
    final local = box?.globalToLocal(globalPosition) ?? Offset.zero;

    ref
        .read(activeDesignProvider.notifier)
        .addFurniture(
          FurniturePlacement(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            itemId: item.id,
            name: item.label,
            position: local,
            selectedColor: 'Qora',
          ),
        );
  }

  void _openEditCard(FurniturePlacement placement) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => FurnitureEditCard(
        furniture: placement,
        onSave: (updated) =>
            ref.read(activeDesignProvider.notifier).updateFurniture(updated),
        onDelete: () {
          ref.read(activeDesignProvider.notifier).removeFurniture(placement.id);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final design = ref.watch(activeDesignProvider);
    final condition = design?.roomCondition;
    final placements = design?.furniture ?? const <FurniturePlacement>[];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            key: _floorKey,
            child: DragTarget<RailItem>(
              onWillAcceptWithDetails: (_) => true,
              onAcceptWithDetails: (details) =>
                  _placeFurniture(details.data, details.offset),
              builder: (context, candidateData, rejectedData) {
                return Stack(
                  children: [
                    RoomPerspectiveView(
                      wallCondition: condition?.wall ?? SurfaceCondition.raw,
                    ),
                    for (final placement in placements)
                      Positioned(
                        left: placement.position.dx - 24,
                        top: placement.position.dy - 24,
                        child: GestureDetector(
                          onTap: () => _openEditCard(placement),
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: DesignTokens.primaryBlue.withValues(
                                alpha: 0.85,
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: DesignTokens.white,
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.chair,
                              color: DesignTokens.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    if (candidateData.isNotEmpty)
                      Center(
                        child: Container(
                          width: 100,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(60),
                            border: Border.all(
                              color: DesignTokens.primaryBlue,
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                            color: DesignTokens.primaryBlue.withValues(
                              alpha: 0.15,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(DesignTokens.spacingMd),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacingMd,
                  vertical: DesignTokens.spacingSm,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                ),
                child: const Text('Mebel bosqichi', style: DesignTokens.subtitle2),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SafeArea(
              child: Room3DRail(
                initiallyExpanded: true,
                tabs: const [
                  RailTab(label: 'Mehmonxona', items: _mehmonxonaFurniture),
                  RailTab(label: 'Oshxona', items: _oshxonaFurniture),
                  RailTab(label: 'Yotoqxona', items: _yotoqxonaFurniture),
                  RailTab(label: 'Vanna', items: _vannaFurniture),
                ],
                onItemSelected: (_) {}, // Placement happens via drag-drop only.
              ),
            ),
          ),
          if (placements.isNotEmpty)
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
                    onPressed: () => context.push('/interior/c7'),
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
