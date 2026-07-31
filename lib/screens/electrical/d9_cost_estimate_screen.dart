import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/room_model.dart';
import '../../providers/room_provider.dart';
import '../../widgets/design/stage_progress_line.dart';

/// D9: Detailed Cost Estimate
/// Comprehensive breakdown of electrical system costs
class D9CostEstimateScreen extends ConsumerStatefulWidget {
  const D9CostEstimateScreen({super.key});

  @override
  ConsumerState<D9CostEstimateScreen> createState() =>
      _D9CostEstimateScreenState();
}

class _D9CostEstimateScreenState extends ConsumerState<D9CostEstimateScreen> {
  bool _isSaving = false;

  Future<void> _continueFinal() async {
    setState(() => _isSaving = true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        context.go('/electrical/d10');
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
        appBar: AppBar(title: const Text('Cost Estimate')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cost Breakdown'),
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
                      'Electrical System Cost Estimate',
                      style: DesignTokens.heading3.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    Text(
                      'Detailed breakdown of materials and labor costs.',
                      style: DesignTokens.bodyMedium.copyWith(
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Materials section
                    _EstimateSection(
                      title: 'Materials',
                      items: [
                        ('Electrical Cable (2.5mm²)', '10,000-15,000'),
                        ('Electrical Cable (1.5mm²)', '5,000-8,000'),
                        ('Outlets (6-8 units)', '12,000-16,000'),
                        ('Switches (3-4 units)', '9,000-12,000'),
                        ('Light Fixtures (3-4 units)', '30,000-50,000'),
                        ('Junction Boxes & Covers', '8,000-12,000'),
                        ('Conduit & Accessories', '6,000-10,000'),
                        ('Breakers & Protection', '15,000-20,000'),
                      ],
                      subtotal: '95,000-143,000',
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Labor section
                    _EstimateSection(
                      title: 'Labor',
                      items: [
                        (
                          'Installation (per outlet/switch)',
                          '5,000-8,000 per unit',
                        ),
                        ('Wire routing & installation', '40,000-60,000'),
                        ('Lighting fixture installation', '20,000-30,000'),
                        ('Testing & certification', '10,000-15,000'),
                      ],
                      subtotal: '100,000-150,000',
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Summary card
                    Container(
                      padding: const EdgeInsets.all(DesignTokens.spacing16),
                      decoration: BoxDecoration(
                        color: DesignTokens.primaryBlue.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusMd,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Materials',
                                style: DesignTokens.bodyMedium.copyWith(
                                  color: DesignTokens.text,
                                ),
                              ),
                              Text(
                                '95,000-143,000 UZS',
                                style: DesignTokens.subtitle2.copyWith(
                                  color: DesignTokens.text,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: DesignTokens.spacing12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Labor',
                                style: DesignTokens.bodyMedium.copyWith(
                                  color: DesignTokens.text,
                                ),
                              ),
                              Text(
                                '100,000-150,000 UZS',
                                style: DesignTokens.subtitle2.copyWith(
                                  color: DesignTokens.text,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: DesignTokens.primaryBlue.withValues(
                              alpha: 0.3,
                            ),
                            height: DesignTokens.spacing20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Estimated Cost',
                                style: DesignTokens.subtitle1.copyWith(
                                  color: DesignTokens.text,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '195,000-293,000 UZS',
                                style: DesignTokens.heading3.copyWith(
                                  color: DesignTokens.primaryBlue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Notes
                    Container(
                      padding: const EdgeInsets.all(DesignTokens.spacing12),
                      decoration: BoxDecoration(
                        color: DesignTokens.accentOrange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusSm,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Important Notes',
                            style: DesignTokens.subtitle2.copyWith(
                              color: DesignTokens.accentOrange,
                            ),
                          ),
                          const SizedBox(height: DesignTokens.spacing8),
                          Text(
                            '• Prices are estimates and vary by supplier\n'
                            '• Labor rates depend on local standards\n'
                            '• Complexity may increase final cost\n'
                            '• Additional charges for special materials/requests',
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
            child: ElevatedButton(
              onPressed: _isSaving ? () {} : _continueFinal,
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
                    : const Text('Continue to Final Confirmation'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EstimateSection extends StatelessWidget {
  const _EstimateSection({
    required this.title,
    required this.items,
    required this.subtotal,
  });

  final String title;
  final List<(String, String)> items;
  final String subtotal;

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
                  Expanded(
                    child: Text(
                      item.$1,
                      style: DesignTokens.bodySmall.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                  ),
                  Text(
                    item.$2,
                    style: DesignTokens.caption.copyWith(
                      color: DesignTokens.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          Divider(color: DesignTokens.border, height: DesignTokens.spacing16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: DesignTokens.subtitle2.copyWith(
                  color: DesignTokens.text,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtotal,
                style: DesignTokens.subtitle2.copyWith(
                  color: DesignTokens.primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
