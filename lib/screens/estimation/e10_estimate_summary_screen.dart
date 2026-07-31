import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/room_model.dart';
import '../../providers/room_provider.dart';
import '../../widgets/design/stage_progress_line.dart';
import '../../widgets/common/success_toast.dart';

/// E10: Final Estimate Summary
/// Complete project estimate with breakdown and export options
class E10EstimateSummaryScreen extends ConsumerStatefulWidget {
  const E10EstimateSummaryScreen({super.key});

  @override
  ConsumerState<E10EstimateSummaryScreen> createState() =>
      _E10EstimateSummaryScreenState();
}

class _E10EstimateSummaryScreenState
    extends ConsumerState<E10EstimateSummaryScreen> {
  bool _agreeTerms = false;
  bool _isExporting = false;

  Future<void> _exportPDF() async {
    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the terms')),
      );
      return;
    }

    setState(() => _isExporting = true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        SuccessToast.show(context, 'Estimate exported successfully!');
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          context.go('/');
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
        setState(() => _isExporting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final room = ref.watch(activeRoomProvider);

    if (room == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Estimate Summary')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    const materialTotal = 495000.0;
    const laborTotal = 330000.0;
    const grandTotal = 825000.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Estimate'),
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
                      'Your Project Estimate',
                      style: DesignTokens.heading3.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    Text(
                      'Complete cost breakdown for ${room.name}',
                      style: DesignTokens.bodyMedium.copyWith(
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Project info
                    _InfoSection(
                      title: 'Project Information',
                      items: [
                        ('Room', room.name),
                        (
                          'Area',
                          '${(room.dimensions.width * room.dimensions.length).toStringAsFixed(1)} m²',
                        ),
                        ('Date', 'July 30, 2026'),
                        ('Validity', '30 days from date'),
                      ],
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Cost breakdown
                    _CostSection(
                      title: 'Materials',
                      items: [
                        ('Flooring', '150,000'),
                        ('Paint & Finishes', '80,000'),
                        ('Fixtures & Fittings', '120,000'),
                        ('Electrical Components', '95,000'),
                        ('Accessories', '50,000'),
                      ],
                      subtotal: 'Materials Total: 495,000 UZS',
                    ),
                    const SizedBox(height: DesignTokens.spacing16),
                    _CostSection(
                      title: 'Labor',
                      items: [
                        ('Flooring Installation', '80,000'),
                        ('Painting & Finishing', '60,000'),
                        ('Fixture Installation', '50,000'),
                        ('Electrical Work', '100,000'),
                        ('Final Finishing', '40,000'),
                      ],
                      subtotal: 'Labor Total: 330,000 UZS',
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Grand total
                    Container(
                      padding: const EdgeInsets.all(DesignTokens.spacing16),
                      decoration: BoxDecoration(
                        color: DesignTokens.accentOrange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusMd,
                        ),
                        border: Border.all(
                          color: DesignTokens.accentOrange.withValues(
                            alpha: 0.3,
                          ),
                        ),
                      ),
                      child: Column(
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
                                '495,000 UZS',
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
                                '330,000 UZS',
                                style: DesignTokens.subtitle2.copyWith(
                                  color: DesignTokens.text,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: DesignTokens.accentOrange.withValues(
                              alpha: 0.3,
                            ),
                            height: DesignTokens.spacing20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Project Cost',
                                style: DesignTokens.subtitle1.copyWith(
                                  color: DesignTokens.text,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '825,000 UZS',
                                style: DesignTokens.heading2.copyWith(
                                  color: DesignTokens.accentOrange,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Terms & conditions
                    Container(
                      padding: const EdgeInsets.all(DesignTokens.spacing12),
                      decoration: BoxDecoration(
                        color: DesignTokens.primaryBlue.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusSm,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Terms & Conditions',
                            style: DesignTokens.subtitle2.copyWith(
                              color: DesignTokens.text,
                            ),
                          ),
                          const SizedBox(height: DesignTokens.spacing8),
                          Text(
                            '• This estimate is valid for 30 days\n'
                            '• Prices may vary based on material availability\n'
                            '• Additional charges may apply for unforeseen issues\n'
                            '• Timeline estimates are approximate',
                            style: DesignTokens.caption.copyWith(
                              color: DesignTokens.textSecondary,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing16),

                    // Agreement checkbox
                    Container(
                      padding: const EdgeInsets.all(DesignTokens.spacing12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _agreeTerms
                              ? DesignTokens.primaryBlue
                              : DesignTokens.border,
                          width: _agreeTerms ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusSm,
                        ),
                        color: _agreeTerms
                            ? DesignTokens.primaryBlue.withValues(alpha: 0.05)
                            : DesignTokens.surface,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: _agreeTerms,
                            onChanged: (v) =>
                                setState(() => _agreeTerms = v ?? false),
                            activeColor: DesignTokens.primaryBlue,
                          ),
                          const SizedBox(width: DesignTokens.spacing8),
                          Expanded(
                            child: Text(
                              'I agree to the terms and conditions and understand that this is an estimate subject to change',
                              style: DesignTokens.caption.copyWith(
                                color: DesignTokens.text,
                              ),
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
                ElevatedButton.icon(
                  onPressed: (_agreeTerms && !_isExporting) ? _exportPDF : null,
                  icon: const Icon(Icons.download),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: DesignTokens.spacing12,
                    ),
                    child: _isExporting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text('Export Estimate as PDF'),
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing12),
                OutlinedButton.icon(
                  onPressed: () => context.go('/estimation/e3'),
                  icon: const Icon(Icons.edit),
                  label: const Text('Adjust Costs'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({required this.title, required this.items});

  final String title;
  final List<(String, String)> items;

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
        Container(
          padding: const EdgeInsets.all(DesignTokens.spacing12),
          decoration: BoxDecoration(
            border: Border.all(color: DesignTokens.border),
            borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          ),
          child: Column(
            children: items
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(
                      bottom: DesignTokens.spacing8,
                    ),
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
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _CostSection extends StatelessWidget {
  const _CostSection({
    required this.title,
    required this.items,
    required this.subtotal,
  });

  final String title;
  final List<(String, String)> items;
  final String subtotal;

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
        Container(
          padding: const EdgeInsets.all(DesignTokens.spacing12),
          decoration: BoxDecoration(
            border: Border.all(color: DesignTokens.border),
            borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          ),
          child: Column(
            children: [
              ...items
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: DesignTokens.spacing8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.$1,
                            style: DesignTokens.bodySmall.copyWith(
                              color: DesignTokens.text,
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
                    ),
                  )
                  .toList(),
              Divider(
                color: DesignTokens.border,
                height: DesignTokens.spacing12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    subtotal.split(':')[0],
                    style: DesignTokens.subtitle2.copyWith(
                      color: DesignTokens.text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtotal.split(': ')[1],
                    style: DesignTokens.subtitle2.copyWith(
                      color: DesignTokens.primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
