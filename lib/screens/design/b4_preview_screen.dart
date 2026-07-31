import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../models/room_model.dart';
import '../../providers/design_provider.dart';
import '../../providers/room_provider.dart';
import '../../widgets/design/stage_progress_line.dart';
import '../../widgets/room/room_canvas.dart';
import '../../widgets/common/success_toast.dart';

/// B4: Design Preview & Confirmation
/// Shows a summary of all design selections and allows user to confirm or modify
class B4PreviewScreen extends ConsumerStatefulWidget {
  const B4PreviewScreen({super.key});

  @override
  ConsumerState<B4PreviewScreen> createState() => _B4PreviewScreenState();
}

class _B4PreviewScreenState extends ConsumerState<B4PreviewScreen> {
  bool _isCompleting = false;

  Future<void> _completeDesign() async {
    setState(() => _isCompleting = true);

    try {
      await ref.read(activeDesignProvider.notifier).complete();

      if (mounted) {
        SuccessToast.show(context, 'Design saved successfully!');
        // Navigate to next phase (could be furniture, electrical, etc.)
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          context.go('/design/complete');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    } finally {
      if (mounted) {
        setState(() => _isCompleting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final room = ref.watch(activeRoomProvider);
    final design = ref.watch(activeDesignProvider);

    if (room == null || design == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Design Preview')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Design Preview'),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          // Progress indicator
          Padding(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            child: StageProgressLine(currentStep: 3, totalSteps: 4),
          ),
          // Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Room preview
                  Padding(
                    padding: const EdgeInsets.all(DesignTokens.spacing16),
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(color: DesignTokens.border),
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusMd,
                        ),
                      ),
                      child: RoomCanvas(room: room, onItemSelected: (id) {}),
                    ),
                  ),

                  // Summary sections
                  Padding(
                    padding: const EdgeInsets.all(DesignTokens.spacing16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Room info
                        _SectionHeader(title: 'Room'),
                        _SummaryRow(label: 'Name', value: room.name),
                        _SummaryRow(
                          label: 'Dimensions',
                          value:
                              '${room.dimensions.width.toStringAsFixed(1)}m × ${room.dimensions.length.toStringAsFixed(1)}m × ${room.dimensions.height.toStringAsFixed(1)}m',
                        ),
                        _SummaryRow(
                          label: 'Area',
                          value:
                              '${(room.dimensions.width * room.dimensions.length).toStringAsFixed(1)} m²',
                        ),
                        const SizedBox(height: DesignTokens.spacing24),

                        // Condition info
                        _SectionHeader(title: 'Current Condition'),
                        if (design.roomCondition != null) ...[
                          _SummaryRow(
                            label: 'Walls',
                            value: _getConditionLabel(
                              design.roomCondition!.wall,
                            ),
                          ),
                          _SummaryRow(
                            label: 'Floor',
                            value: _getConditionLabel(
                              design.roomCondition?.floor,
                            ),
                          ),
                          _SummaryRow(
                            label: 'Ceiling',
                            value: _getConditionLabel(
                              design.roomCondition?.ceiling,
                            ),
                          ),
                        ],
                        const SizedBox(height: DesignTokens.spacing24),

                        // Material selections
                        _SectionHeader(title: 'Materials Selected'),
                        if (design.selections.isEmpty)
                          Text(
                            'No materials selected yet',
                            style: DesignTokens.bodyMedium.copyWith(
                              color: DesignTokens.textSecondary,
                            ),
                          )
                        else
                          ...design.selections.entries.map((entry) {
                            final selection = entry.value;
                            return _SummaryRow(
                              label: entry.key,
                              value:
                                  '${selection.color} - ${selection.price.toStringAsFixed(0)} UZS/m²',
                            );
                          }).toList(),
                        const SizedBox(height: DesignTokens.spacing24),

                        // Cost estimate
                        if (design.selections.isNotEmpty)
                          _CostEstimate(selections: design.selections),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Action buttons
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: DesignTokens.border)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: _isCompleting ? () {} : _completeDesign,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: DesignTokens.spacing12,
                    ),
                    child: _isCompleting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Confirm & Continue'),
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing12),
                OutlinedButton.icon(
                  onPressed: () => context.go('/design/b3'),
                  icon: const Icon(Icons.edit),
                  label: const Text('Modify Selections'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getConditionLabel(SurfaceCondition? condition) {
    if (condition == null) return 'Not specified';
    switch (condition) {
      case SurfaceCondition.raw:
        return 'Raw (Korobka)';
      case SurfaceCondition.plastered:
        return 'Plastered (Suvoq)';
      case SurfaceCondition.puttied:
        return 'Puttied (Shpaklovka)';
    }
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: DesignTokens.subtitle1.copyWith(color: DesignTokens.text),
        ),
        const SizedBox(height: DesignTokens.spacing12),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DesignTokens.spacing12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: DesignTokens.bodyMedium.copyWith(
              color: DesignTokens.textSecondary,
            ),
          ),
          Text(
            value,
            style: DesignTokens.subtitle2.copyWith(color: DesignTokens.text),
          ),
        ],
      ),
    );
  }
}

class _CostEstimate extends StatelessWidget {
  const _CostEstimate({required this.selections});

  final Map<String, MaterialSelection> selections;

  @override
  Widget build(BuildContext context) {
    final totalCost = selections.values.fold<double>(
      0,
      (sum, s) => sum + (s.price * s.area),
    );

    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        color: DesignTokens.primaryBlue.withValues(alpha: 0.05),
        border: Border.all(
          color: DesignTokens.primaryBlue.withValues(alpha: 0.2),
        ),
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estimated Cost',
            style: DesignTokens.subtitle1.copyWith(color: DesignTokens.text),
          ),
          const SizedBox(height: DesignTokens.spacing8),
          Text(
            '${totalCost.toStringAsFixed(0)} UZS',
            style: DesignTokens.heading3.copyWith(
              color: DesignTokens.primaryBlue,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing8),
          Text(
            '${selections.length} materials for ${selections.values.fold<double>(0, (sum, s) => sum + s.area).toStringAsFixed(1)} m²',
            style: DesignTokens.caption.copyWith(
              color: DesignTokens.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
