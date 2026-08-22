import 'package:flutter/material.dart' hide MaterialType;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../providers/design_provider.dart';
import '../../providers/room_provider.dart';
import '../../widgets/design/stage_progress_line.dart';
import '../../widgets/common/material_rail.dart';

/// B3: Paint & Wall Color Selection
/// Allows user to select paint colors and finishes for walls and ceiling
class B3PaintSelectionScreen extends ConsumerStatefulWidget {
  const B3PaintSelectionScreen({super.key});

  @override
  ConsumerState<B3PaintSelectionScreen> createState() =>
      _B3PaintSelectionScreenState();
}

class _B3PaintSelectionScreenState
    extends ConsumerState<B3PaintSelectionScreen> {
  String? _wallPaintId;
  String? _ceilingPaintId;
  bool _isSaving = false;

  final List<MaterialItem> _paintColors = [
    MaterialItem(
      id: 'paint-white-001',
      name: 'Pure White',
      description: 'Clean, bright white. 150-200 UZS/liter',
      imageUrl: 'assets/colors/white.png',
    ),
    MaterialItem(
      id: 'paint-light-gray-001',
      name: 'Light Gray',
      description: 'Soft gray for warm interiors. 160-210 UZS/liter',
      imageUrl: 'assets/colors/light-gray.png',
    ),
    MaterialItem(
      id: 'paint-beige-001',
      name: 'Beige',
      description: 'Warm beige neutral tone. 160-210 UZS/liter',
      imageUrl: 'assets/colors/beige.png',
    ),
    MaterialItem(
      id: 'paint-blue-001',
      name: 'Sky Blue',
      description: 'Calming blue for bedrooms. 180-230 UZS/liter',
      imageUrl: 'assets/colors/sky-blue.png',
    ),
    MaterialItem(
      id: 'paint-green-001',
      name: 'Sage Green',
      description: 'Relaxing green shade. 180-230 UZS/liter',
      imageUrl: 'assets/colors/sage-green.png',
    ),
    MaterialItem(
      id: 'paint-warm-white-001',
      name: 'Warm White',
      description: 'Creamy warm white. 160-210 UZS/liter',
      imageUrl: 'assets/colors/warm-white.png',
    ),
  ];

  Future<void> _continueToPreviews() async {
    if (_wallPaintId == null || _ceilingPaintId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select colors for walls and ceiling'),
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final wallPaint = _paintColors.firstWhere((p) => p.id == _wallPaintId);
      final ceilingPaint = _paintColors.firstWhere(
        (p) => p.id == _ceilingPaintId,
      );

      final wallMaterial = MaterialSelection(
        materialId: wallPaint.id,
        material: MaterialType.paint,
        color: wallPaint.name,
        price: 190.0,
        area: 60.0, // Wall area calculation
      );

      final ceilingMaterial = MaterialSelection(
        materialId: ceilingPaint.id,
        material: MaterialType.paint,
        color: ceilingPaint.name,
        price: 190.0,
        area: 20.0, // Ceiling area calculation
      );

      final notifier = ref.read(activeDesignProvider.notifier);
      notifier.selectMaterial(surfaceId: 'walls', material: wallMaterial);
      notifier.selectMaterial(surfaceId: 'ceiling', material: ceilingMaterial);

      if (mounted) {
        context.go('/design/b4');
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
        appBar: AppBar(title: const Text('Paint Selection')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Paint Colors'),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          // Progress indicator
          Padding(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            child: StageProgressLine(currentStep: 2, totalSteps: 4),
          ),
          // Main content area
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(DesignTokens.spacing16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Instructions
                    Text(
                      'Choose your paint colors',
                      style: DesignTokens.heading3.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    Text(
                      'Select colors for walls and ceiling. These colors will be applied throughout your room.',
                      style: DesignTokens.bodyMedium.copyWith(
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Wall color selection
                    Text(
                      'Wall Color',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _ColorGrid(
                      colors: _paintColors,
                      selectedId: _wallPaintId,
                      onSelected: (id) => setState(() => _wallPaintId = id),
                    ),
                    const SizedBox(height: DesignTokens.spacing32),

                    // Ceiling color selection
                    Text(
                      'Ceiling Color',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _ColorGrid(
                      colors: _paintColors,
                      selectedId: _ceilingPaintId,
                      onSelected: (id) => setState(() => _ceilingPaintId = id),
                    ),
                    const SizedBox(height: DesignTokens.spacing40),

                    // Action button
                    ElevatedButton(
                      onPressed: _isSaving ? () {} : _continueToPreviews,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: DesignTokens.spacing12,
                        ),
                        child: _isSaving
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Continue to Preview'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorGrid extends StatelessWidget {
  const _ColorGrid({
    required this.colors,
    required this.selectedId,
    required this.onSelected,
  });

  final List<MaterialItem> colors;
  final String? selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: DesignTokens.spacing12,
      crossAxisSpacing: DesignTokens.spacing12,
      childAspectRatio: 0.85,
      children: colors.map((color) {
        final isSelected = selectedId == color.id;
        return InkWell(
          onTap: () => onSelected(color.id),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected
                    ? DesignTokens.primaryBlue
                    : DesignTokens.border,
                width: isSelected ? 2.5 : 1.5,
              ),
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Color preview circle
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: DesignTokens.border, width: 1),
                    color: _getColorForMaterial(color.id),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check_circle,
                          color: DesignTokens.primaryBlue,
                          size: 28,
                        )
                      : null,
                ),
                const SizedBox(height: DesignTokens.spacing8),
                // Color name
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacing8,
                  ),
                  child: Text(
                    color.name,
                    style: DesignTokens.caption.copyWith(
                      color: DesignTokens.text,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _getColorForMaterial(String id) {
    switch (id) {
      case 'paint-white-001':
        return const Color(0xFFFAFAFA);
      case 'paint-light-gray-001':
        return const Color(0xFFC0C0C0);
      case 'paint-beige-001':
        return const Color(0xFFF5E6D3);
      case 'paint-blue-001':
        return const Color(0xFF87CEEB);
      case 'paint-green-001':
        return const Color(0xFF9DC183);
      case 'paint-warm-white-001':
        return const Color(0xFFFFF8DC);
      default:
        return Colors.grey[300] ?? Colors.grey;
    }
  }
}
