import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/room_model.dart';
import '../../providers/room_provider.dart';
import '../../widgets/design/stage_progress_line.dart';

/// E1: Estimation Overview
/// Introduction to cost estimation process and summary of completed design/electrical
class E1EstimationIntroScreen extends ConsumerStatefulWidget {
  const E1EstimationIntroScreen({super.key});

  @override
  ConsumerState<E1EstimationIntroScreen> createState() =>
      _E1EstimationIntroScreenState();
}

class _E1EstimationIntroScreenState
    extends ConsumerState<E1EstimationIntroScreen> {
  @override
  Widget build(BuildContext context) {
    final room = ref.watch(activeRoomProvider);

    if (room == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Estimation')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cost Estimation'),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress
              StageProgressLine(currentStep: 0, totalSteps: 3),
              const SizedBox(height: DesignTokens.spacing32),

              // Header
              Text(
                'Get Your Cost Estimate',
                style: DesignTokens.heading3.copyWith(color: DesignTokens.text),
              ),
              const SizedBox(height: DesignTokens.spacing12),
              Text(
                'We\'ve collected all design and electrical details. Now let\'s calculate the total project cost.',
                style: DesignTokens.bodyMedium.copyWith(
                  color: DesignTokens.textSecondary,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),

              // Project summary card
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing16),
                decoration: BoxDecoration(
                  border: Border.all(color: DesignTokens.border),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  color: DesignTokens.primaryBlue.withValues(alpha: 0.05),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Project Summary',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing16),
                    _SummaryRow(
                      label: 'Room',
                      value: room.name,
                      icon: Icons.door_front_door_outlined,
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _SummaryRow(
                      label: 'Floor Area',
                      value:
                          '${(room.dimensions.width * room.dimensions.length).toStringAsFixed(1)} m²',
                      icon: Icons.square_foot,
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _SummaryRow(
                      label: 'Design Status',
                      value: 'Complete',
                      icon: Icons.check_circle_outline,
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _SummaryRow(
                      label: 'Electrical Status',
                      value: 'Complete',
                      icon: Icons.check_circle_outline,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),

              // Estimation steps
              Text(
                'Estimation Process',
                style: DesignTokens.subtitle1.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              _EstimationStep(
                number: '1',
                title: 'Material Costs',
                description:
                    'Calculate flooring, paint, fixtures, electrical components',
                icon: Icons.shopping_cart_outlined,
              ),
              const SizedBox(height: DesignTokens.spacing12),
              _EstimationStep(
                number: '2',
                title: 'Labor Costs',
                description:
                    'Estimate worker hours for installation and finishing',
                icon: Icons.construction_outlined,
              ),
              const SizedBox(height: DesignTokens.spacing12),
              _EstimationStep(
                number: '3',
                title: 'Final Summary',
                description: 'Review total cost and breakdown by category',
                icon: Icons.summarize_outlined,
              ),
              const SizedBox(height: DesignTokens.spacing32),

              // Cost estimate preview
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing16),
                decoration: BoxDecoration(
                  color: DesignTokens.accentOrange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  border: Border.all(
                    color: DesignTokens.accentOrange.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: DesignTokens.accentOrange,
                          size: 20,
                        ),
                        const SizedBox(width: DesignTokens.spacing8),
                        Text(
                          'Estimated Range',
                          style: DesignTokens.subtitle2.copyWith(
                            color: DesignTokens.accentOrange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Design Work',
                              style: DesignTokens.caption.copyWith(
                                color: DesignTokens.textSecondary,
                              ),
                            ),
                            const SizedBox(height: DesignTokens.spacing4),
                            Text(
                              '500,000-800,000',
                              style: DesignTokens.subtitle2.copyWith(
                                color: DesignTokens.text,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Electrical Work',
                              style: DesignTokens.caption.copyWith(
                                color: DesignTokens.textSecondary,
                              ),
                            ),
                            const SizedBox(height: DesignTokens.spacing4),
                            Text(
                              '195,000-293,000',
                              style: DesignTokens.subtitle2.copyWith(
                                color: DesignTokens.text,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: DesignTokens.accentOrange.withValues(alpha: 0.3),
                      height: DesignTokens.spacing20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Estimate',
                          style: DesignTokens.subtitle1.copyWith(
                            color: DesignTokens.text,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '695,000-1,093,000 UZS',
                          style: DesignTokens.heading3.copyWith(
                            color: DesignTokens.accentOrange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacing40),

              // Action buttons
              ElevatedButton(
                onPressed: () => context.go('/estimation/e2'),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: DesignTokens.spacing12,
                  ),
                  child: Text('Calculate Material Costs'),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing12),
              OutlinedButton.icon(
                onPressed: () => context.go('/electrical/complete'),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to Design'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: DesignTokens.primaryBlue, size: 20),
        const SizedBox(width: DesignTokens.spacing12),
        Expanded(
          child: Text(
            label,
            style: DesignTokens.bodyMedium.copyWith(
              color: DesignTokens.textSecondary,
            ),
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
    );
  }
}

class _EstimationStep extends StatelessWidget {
  const _EstimationStep({
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
  });

  final String number;
  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        border: Border.all(color: DesignTokens.border),
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: DesignTokens.primaryBlue,
            ),
            child: Center(
              child: Text(
                number,
                style: DesignTokens.subtitle2.copyWith(
                  color: DesignTokens.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: DesignTokens.spacing16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: DesignTokens.subtitle2.copyWith(
                    color: DesignTokens.text,
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
          Icon(icon, color: DesignTokens.textSecondary, size: 24),
        ],
      ),
    );
  }
}
