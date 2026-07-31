import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../providers/room_provider.dart';
import '../../widgets/design/stage_progress_line.dart';
import '../../widgets/common/success_toast.dart';

/// D10: Final Confirmation
/// Final review and confirmation of complete electrical system design
class D10FinalConfirmationScreen extends ConsumerStatefulWidget {
  const D10FinalConfirmationScreen({super.key});

  @override
  ConsumerState<D10FinalConfirmationScreen> createState() =>
      _D10FinalConfirmationScreenState();
}

class _D10FinalConfirmationScreenState
    extends ConsumerState<D10FinalConfirmationScreen> {
  bool _confirmDesign = false;
  bool _confirmSafety = false;
  bool _confirmBudget = false;
  bool _isCompleting = false;

  Future<void> _completeElectrical() async {
    if (!_confirmDesign || !_confirmSafety || !_confirmBudget) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please confirm all requirements')),
      );
      return;
    }

    setState(() => _isCompleting = true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        SuccessToast.show(context, 'Electrical design completed!');
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          context.go('/electrical/complete');
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

    if (room == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Final Confirmation')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Confirmation'),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          // Progress
          Padding(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            child: StageProgressLine(currentStep: 2, totalSteps: 3),
          ),
          // Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(DesignTokens.spacing16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Confirm Your Electrical Design',
                      style: DesignTokens.heading3.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    Text(
                      'Review and confirm all aspects of your electrical system design.',
                      style: DesignTokens.bodyMedium.copyWith(
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Design summary
                    _SummarySection(
                      title: 'Design Summary',
                      items: [
                        ('Room', room.name),
                        (
                          'Floor Area',
                          '${(room.dimensions.width * room.dimensions.length).toStringAsFixed(1)} m²',
                        ),
                        ('Outlets Planned', '6-8 units'),
                        ('Switches Planned', '3-4 units'),
                        ('Light Fixtures', '3-4 fixtures'),
                        ('Wire Routing', '~20m cable'),
                      ],
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Cost summary
                    _SummarySection(
                      title: 'Cost Summary',
                      items: [
                        ('Materials', '95,000-143,000 UZS'),
                        ('Labor', '100,000-150,000 UZS'),
                        ('Total', '195,000-293,000 UZS'),
                      ],
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Confirmation checkboxes
                    Text(
                      'Confirmation Required',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing16),
                    _ConfirmationCheckbox(
                      label: 'Design is complete and accurate',
                      description:
                          'All devices, wires, and fixtures are properly planned',
                      value: _confirmDesign,
                      onChanged: (v) =>
                          setState(() => _confirmDesign = v ?? false),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _ConfirmationCheckbox(
                      label: 'Design meets safety standards',
                      description:
                          'All electrical codes and safety requirements satisfied',
                      value: _confirmSafety,
                      onChanged: (v) =>
                          setState(() => _confirmSafety = v ?? false),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _ConfirmationCheckbox(
                      label: 'Budget is acceptable',
                      description: 'Estimated cost is within acceptable range',
                      value: _confirmBudget,
                      onChanged: (v) =>
                          setState(() => _confirmBudget = v ?? false),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Info box
                    Container(
                      padding: const EdgeInsets.all(DesignTokens.spacing12),
                      decoration: BoxDecoration(
                        color: DesignTokens.primaryBlue.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusSm,
                        ),
                        border: Border.all(
                          color: DesignTokens.primaryBlue.withValues(
                            alpha: 0.2,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Next Steps',
                            style: DesignTokens.subtitle2.copyWith(
                              color: DesignTokens.primaryBlue,
                            ),
                          ),
                          const SizedBox(height: DesignTokens.spacing8),
                          Text(
                            '1. Download electrical design PDF\n'
                            '2. Contact a licensed electrician\n'
                            '3. Review quote and timeline\n'
                            '4. Schedule installation',
                            style: DesignTokens.caption.copyWith(
                              color: DesignTokens.textSecondary,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                ElevatedButton(
                  onPressed:
                      (_confirmDesign &&
                          _confirmSafety &&
                          _confirmBudget &&
                          !_isCompleting)
                      ? _completeElectrical
                      : null,
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
                        : const Text('Complete Electrical Design'),
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing12),
                OutlinedButton.icon(
                  onPressed: () => context.go('/electrical/d9'),
                  icon: const Icon(Icons.edit),
                  label: const Text('Review Costs'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummarySection extends StatelessWidget {
  const _SummarySection({required this.title, required this.items});

  final String title;
  final List<(String, String)> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        border: Border.all(color: DesignTokens.border),
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: DesignTokens.subtitle1.copyWith(color: DesignTokens.text),
          ),
          const SizedBox(height: DesignTokens.spacing12),
          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: DesignTokens.spacing8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.$1,
                    style: DesignTokens.bodyMedium.copyWith(
                      color: DesignTokens.textSecondary,
                    ),
                  ),
                  Text(
                    item.$2,
                    style: DesignTokens.subtitle2.copyWith(
                      color: DesignTokens.text,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class _ConfirmationCheckbox extends StatelessWidget {
  const _ConfirmationCheckbox({
    required this.label,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String description;
  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing12),
      decoration: BoxDecoration(
        border: Border.all(
          color: value ? DesignTokens.primaryBlue : DesignTokens.border,
          width: value ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
        color: value
            ? DesignTokens.primaryBlue.withValues(alpha: 0.05)
            : DesignTokens.surface,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: DesignTokens.primaryBlue,
          ),
          const SizedBox(width: DesignTokens.spacing8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: DesignTokens.subtitle2.copyWith(
                    color: DesignTokens.text,
                    fontWeight: value ? FontWeight.bold : FontWeight.w600,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing4),
                Text(
                  description,
                  style: DesignTokens.caption.copyWith(
                    color: DesignTokens.textSecondary,
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
