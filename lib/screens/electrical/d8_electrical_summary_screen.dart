import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/room_model.dart';
import '../../providers/room_provider.dart';
import '../../widgets/design/stage_progress_line.dart';
import '../../widgets/electrical/electrical_totals_card.dart';

/// D8: Electrical System Summary & Review
/// Shows comprehensive summary of all electrical planning decisions
class D8ElectricalSummaryScreen extends ConsumerStatefulWidget {
  const D8ElectricalSummaryScreen({super.key});

  @override
  ConsumerState<D8ElectricalSummaryScreen> createState() =>
      _D8ElectricalSummaryScreenState();
}

class _D8ElectricalSummaryScreenState
    extends ConsumerState<D8ElectricalSummaryScreen> {
  bool _isConfirming = false;

  Future<void> _confirmElectrical() async {
    setState(() => _isConfirming = true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        context.go('/electrical/complete');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isConfirming = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final room = ref.watch(activeRoomProvider);

    if (room == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Electrical Summary')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Electrical System Summary'),
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
                      'Electrical Plan Review',
                      style: DesignTokens.heading3.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    Text(
                      'Review your complete electrical system design and material requirements below.',
                      style: DesignTokens.bodyMedium.copyWith(
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Room info
                    _SectionHeader(title: 'Room Information'),
                    _InfoRow(
                      label: 'Room Name',
                      value: room.name,
                    ),
                    _InfoRow(
                      label: 'Dimensions',
                      value:
                          '${room.dimensions.width.toStringAsFixed(1)}m × ${room.dimensions.length.toStringAsFixed(1)}m',
                    ),
                    _InfoRow(
                      label: 'Floor Area',
                      value:
                          '${(room.dimensions.width * room.dimensions.length).toStringAsFixed(1)} m²',
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // System overview
                    _SectionHeader(title: 'Electrical System Overview'),
                    Text(
                      'Wiring & Cable',
                      style: DesignTokens.subtitle2.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing8),
                    _SpecificationItem(
                      label: 'Main Cable Run',
                      value: '~15-20 meters',
                      icon: Icons.cable,
                    ),
                    _SpecificationItem(
                      label: 'Junction Boxes',
                      value: '2-3 boxes',
                      icon: Icons.category_outlined,
                    ),
                    const SizedBox(height: DesignTokens.spacing16),

                    Text(
                      'Devices & Fixtures',
                      style: DesignTokens.subtitle2.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing8),
                    _SpecificationItem(
                      label: 'Outlets',
                      value: '6-8 units',
                      icon: Icons.power_outlined,
                    ),
                    _SpecificationItem(
                      label: 'Switches',
                      value: '3-4 units',
                      icon: Icons.toggle_on_outlined,
                    ),
                    _SpecificationItem(
                      label: 'Light Fixtures',
                      value: '4-6 fixtures',
                      icon: Icons.lightbulb_outline,
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Estimated costs
                    _SectionHeader(title: 'Material & Labor Estimate'),
                    _CostBreakdown(
                      categories: [
                        ('Cable & Wiring', '15,000-25,000'),
                        ('Outlets & Switches', '30,000-45,000'),
                        ('Light Fixtures', '50,000-80,000'),
                        ('Junction Boxes & Accessories', '20,000-30,000'),
                        ('Labor', '100,000-150,000'),
                      ],
                      total: '215,000-330,000',
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Notes
                    Container(
                      padding: const EdgeInsets.all(DesignTokens.spacing16),
                      decoration: BoxDecoration(
                        color: DesignTokens.primaryBlue.withValues(alpha: 0.05),
                        borderRadius:
                            BorderRadius.circular(DesignTokens.radiusMd),
                        border: Border.all(
                          color: DesignTokens.primaryBlue
                              .withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: DesignTokens.primaryBlue,
                                size: 20,
                              ),
                              const SizedBox(width: DesignTokens.spacing8),
                              Text(
                                'Important Notes',
                                style: DesignTokens.subtitle2.copyWith(
                                  color: DesignTokens.primaryBlue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: DesignTokens.spacing12),
                          Text(
                            '• All electrical work must be performed by a licensed electrician\n'
                            '• Costs are estimates and subject to local material prices\n'
                            '• Comply with local electrical codes and safety standards\n'
                            '• Proper grounding and circuit protection required',
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
              border: Border(
                top: BorderSide(color: DesignTokens.border),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: _isConfirming ? () {} : _confirmElectrical,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: DesignTokens.spacing12,
                    ),
                    child: _isConfirming
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Confirm & Complete'),
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing12),
                OutlinedButton.icon(
                  onPressed: () => context.go('/electrical/d5'),
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Electrical Plan'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
          style: DesignTokens.subtitle1.copyWith(
            color: DesignTokens.text,
          ),
        ),
        const SizedBox(height: DesignTokens.spacing12),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
  });

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
            style: DesignTokens.subtitle2.copyWith(
              color: DesignTokens.text,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecificationItem extends StatelessWidget {
  const _SpecificationItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DesignTokens.spacing8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: DesignTokens.primaryBlue),
          const SizedBox(width: DesignTokens.spacing12),
          Expanded(
            child: Text(
              label,
              style: DesignTokens.bodyMedium.copyWith(
                color: DesignTokens.text,
              ),
            ),
          ),
          Text(
            value,
            style: DesignTokens.caption.copyWith(
              color: DesignTokens.primaryBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _CostBreakdown extends StatelessWidget {
  const _CostBreakdown({
    required this.categories,
    required this.total,
  });

  final List<(String, String)> categories;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        color: DesignTokens.surface,
        border: Border.all(color: DesignTokens.border),
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...categories.map((cat) {
            return Padding(
              padding: const EdgeInsets.only(bottom: DesignTokens.spacing12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cat.$1,
                    style: DesignTokens.bodyMedium.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  Text(
                    cat.$2,
                    style: DesignTokens.caption.copyWith(
                      color: DesignTokens.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          Divider(color: DesignTokens.border),
          const SizedBox(height: DesignTokens.spacing8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Estimated Cost',
                style: DesignTokens.subtitle2.copyWith(
                  color: DesignTokens.text,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                total,
                style: DesignTokens.heading3.copyWith(
                  color: DesignTokens.primaryBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
