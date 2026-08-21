import 'package:flutter/material.dart' hide MaterialType;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../models/room_model.dart';
import '../../providers/design_provider.dart';
import '../../providers/room_provider.dart';
import '../../widgets/design/stage_progress_line.dart';
import '../../widgets/room/room_canvas.dart';
import '../../widgets/common/material_rail.dart';

/// B2: Floor Material Selection
/// Allows user to browse and select flooring materials with live room preview
class B2FloorSelectionScreen extends ConsumerStatefulWidget {
  const B2FloorSelectionScreen({super.key});

  @override
  ConsumerState<B2FloorSelectionScreen> createState() =>
      _B2FloorSelectionScreenState();
}

class _B2FloorSelectionScreenState
    extends ConsumerState<B2FloorSelectionScreen> {
  String? _selectedMaterialId;
  bool _isSaving = false;

  final List<MaterialItem> _floorMaterials = [
    MaterialItem(
      id: 'tile-ceramic-001',
      name: 'Ceramic Tile',
      description: 'Durable ceramic flooring. 500-800 UZS/m²',
      imageUrl: 'assets/materials/ceramic.png',
    ),
    MaterialItem(
      id: 'tile-porcelain-001',
      name: 'Porcelain Tile',
      description:
          'High-quality porcelain with modern finishes. 1000-1500 UZS/m²',
      imageUrl: 'assets/materials/porcelain.png',
    ),
    MaterialItem(
      id: 'laminate-001',
      name: 'Laminate',
      description: 'Budget-friendly wood-look flooring. 300-600 UZS/m²',
      imageUrl: 'assets/materials/laminate.png',
    ),
    MaterialItem(
      id: 'vinyl-001',
      name: 'Vinyl Plank',
      description: 'Waterproof luxury vinyl plank. 700-1200 UZS/m²',
      imageUrl: 'assets/materials/vinyl.png',
    ),
    MaterialItem(
      id: 'wood-001',
      name: 'Hardwood',
      description: 'Premium real hardwood flooring. 2000-4000 UZS/m²',
      imageUrl: 'assets/materials/hardwood.png',
    ),
  ];

  Future<void> _selectFloor() async {
    if (_selectedMaterialId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a flooring material')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final selectedMaterial = _floorMaterials.firstWhere(
        (m) => m.id == _selectedMaterialId,
      );

      final material = MaterialSelection(
        materialId: selectedMaterial.id,
        material: MaterialType.floorTile,
        color: 'Default',
        price: 800.0, // Placeholder price
        area: 20.0, // Placeholder area (from room dimensions)
      );

      ref
          .read(activeDesignProvider.notifier)
          .selectMaterial(surfaceId: 'floor', material: material);

      if (mounted) {
        context.go('/design/b3');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final room = ref.watch(activeRoomProvider);

    if (room == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Floor Selection')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Flooring'),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          // Progress indicator
          Padding(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            child: StageProgressLine(currentStep: 1, totalSteps: 4),
          ),
          // Main content area with canvas and rail
          Expanded(
            child: Row(
              children: [
                // Room canvas
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(DesignTokens.spacing16),
                    child: RoomCanvas(
                      room: room,
                      plan: ref.watch(activeRoomPlanProvider),
                      onItemSelected: (id) {},
                    ),
                  ),
                ),
                // Material selection rail
                MaterialRail(
                  items: _floorMaterials,
                  onSelected: (id) => setState(() => _selectedMaterialId = id),
                  selectedId: _selectedMaterialId,
                ),
              ],
            ),
          ),
          // Action bar
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: DesignTokens.border)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_selectedMaterialId != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: DesignTokens.spacing12,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(DesignTokens.spacing12),
                      decoration: BoxDecoration(
                        color: DesignTokens.primaryBlue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusMd,
                        ),
                      ),
                      child: Text(
                        'Selected: ${_floorMaterials.firstWhere((m) => m.id == _selectedMaterialId).name}',
                        style: DesignTokens.bodyMedium.copyWith(
                          color: DesignTokens.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                ElevatedButton(
                  onPressed: _isSaving ? () {} : _selectFloor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: DesignTokens.spacing12,
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Continue to Paint'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
