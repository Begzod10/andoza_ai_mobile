import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../providers/measurement_provider.dart';

/// A5: Furniture Placement Screen
/// Allows user to add optional furniture to the room
class A5FurnitureScreen extends ConsumerStatefulWidget {
  const A5FurnitureScreen({super.key});

  @override
  ConsumerState<A5FurnitureScreen> createState() => _A5FurnitureScreenState();
}

class _A5FurnitureScreenState extends ConsumerState<A5FurnitureScreen> {
  static const furnitureOptions = [
    ('Bed', Icons.bed),
    ('Sofa', Icons.chair),
    ('Desk', Icons.table_chart),
    ('Wardrobe', Icons.door_sliding),
    ('Bookshelf', Icons.shelves),
    ('Dining Table', Icons.restaurant),
    ('Armchair', Icons.chair_alt),
    ('Coffee Table', Icons.square_foot),
  ];

  @override
  Widget build(BuildContext context) {
    final measurement = ref.watch(measurementProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Furniture'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add Furniture (Optional)',
                style: DesignTokens.headingMedium.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              Text(
                'Select furniture items in your room',
                style: DesignTokens.bodyMedium.copyWith(
                  color: DesignTokens.textSecondary,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),
              // Furniture grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: DesignTokens.spacing16,
                  mainAxisSpacing: DesignTokens.spacing16,
                  childAspectRatio: 1.2,
                ),
                itemCount: furnitureOptions.length,
                itemBuilder: (context, index) {
                  final (label, icon) = furnitureOptions[index];
                  final isSelected = measurement.furniture.contains(label);

                  return _FurnitureOption(
                    label: label,
                    icon: icon,
                    isSelected: isSelected,
                    onTap: () {
                      if (isSelected) {
                        ref.read(measurementProvider.notifier)
                            .removeFurniture(label);
                      } else {
                        ref.read(measurementProvider.notifier).addFurniture(label);
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: DesignTokens.spacing32),
              // Summary
              if (measurement.furniture.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(DesignTokens.spacing16),
                  decoration: BoxDecoration(
                    color: DesignTokens.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Items (${measurement.furniture.length})',
                        style: DesignTokens.subtitle2.copyWith(
                          color: DesignTokens.text,
                        ),
                      ),
                      const SizedBox(height: DesignTokens.spacing12),
                      Wrap(
                        spacing: DesignTokens.spacing8,
                        children: measurement.furniture
                            .map(
                              (item) => Chip(
                                label: Text(item),
                                onDeleted: () {
                                  ref.read(measurementProvider.notifier)
                                      .removeFurniture(item);
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing24),
              ],
              // Navigation buttons
              ElevatedButton(
                onPressed: () => context.push('/measurement/a6'),
                child: const Text('Next: LiDAR Scan'),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              OutlinedButton(
                onPressed: () => context.push('/measurement/a8'),
                child: const Text('Skip to Review'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FurnitureOption extends StatefulWidget {
  const _FurnitureOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_FurnitureOption> createState() => _FurnitureOptionState();
}

class _FurnitureOptionState extends State<_FurnitureOption> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: widget.isSelected
                ? DesignTokens.primary.withValues(alpha: 0.1)
                : DesignTokens.surface,
            border: Border.all(
              color: widget.isSelected
                  ? DesignTokens.primary
                  : (widget.isSelected
                      ? DesignTokens.primary
                      : DesignTokens.border),
              width: widget.isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(DesignTokens.radiusLarge),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    widget.icon,
                    size: 40,
                    color: widget.isSelected
                        ? DesignTokens.primary
                        : DesignTokens.textSecondary,
                  ),
                  if (widget.isSelected)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: DesignTokens.success,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: DesignTokens.white,
                          size: 14,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: DesignTokens.spacing8),
              Text(
                widget.label,
                style: DesignTokens.bodySmall.copyWith(
                  color: widget.isSelected
                      ? DesignTokens.primary
                      : DesignTokens.text,
                  fontWeight:
                      widget.isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
