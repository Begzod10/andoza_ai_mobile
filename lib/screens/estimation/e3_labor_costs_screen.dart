import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/room_model.dart';
import '../../providers/room_provider.dart';
import '../../widgets/design/stage_progress_line.dart';

/// E3: Labor Cost Calculator
/// Calculate total labor costs for installation and finishing work
class E3LaborCostsScreen extends ConsumerStatefulWidget {
  const E3LaborCostsScreen({super.key});

  @override
  ConsumerState<E3LaborCostsScreen> createState() => _E3LaborCostsScreenState();
}

class _E3LaborCostsScreenState extends ConsumerState<E3LaborCostsScreen> {
  late Map<String, double> _laborCosts;
  late Map<String, int> _hours;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _laborCosts = {
      'flooring': 80000.0,
      'paint': 60000.0,
      'fixtures': 50000.0,
      'electrical': 100000.0,
      'finishing': 40000.0,
    };
    _hours = {
      'flooring': 20,
      'paint': 15,
      'fixtures': 10,
      'electrical': 25,
      'finishing': 8,
    };
  }

  double get _totalLabor =>
      _laborCosts.values.fold(0.0, (sum, cost) => sum + cost);

  Future<void> _continueToSummary() async {
    setState(() => _isSaving = true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        context.go('/estimation/e10');
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
        appBar: AppBar(title: const Text('Labor Costs')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Labor Costs'),
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
                      'Labor Costs Calculator',
                      style: DesignTokens.heading3.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    Text(
                      'Estimate labor costs based on hours and daily rates.',
                      style: DesignTokens.bodyMedium.copyWith(
                        color: DesignTokens.textSecondary,
                      ),
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
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: DesignTokens.primaryBlue,
                            size: 18,
                          ),
                          const SizedBox(width: DesignTokens.spacing8),
                          Expanded(
                            child: Text(
                              'Standard daily rate: 3,000-5,000 UZS/hour',
                              style: DesignTokens.caption.copyWith(
                                color: DesignTokens.primaryBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Labor categories
                    Text(
                      'Labor Breakdown',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing16),
                    _LaborItem(
                      label: 'Flooring Installation',
                      hours: _hours['flooring']!,
                      cost: _laborCosts['flooring']!,
                      onCostChanged: (value) =>
                          setState(() => _laborCosts['flooring'] = value),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _LaborItem(
                      label: 'Painting & Finishing',
                      hours: _hours['paint']!,
                      cost: _laborCosts['paint']!,
                      onCostChanged: (value) =>
                          setState(() => _laborCosts['paint'] = value),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _LaborItem(
                      label: 'Fixture Installation',
                      hours: _hours['fixtures']!,
                      cost: _laborCosts['fixtures']!,
                      onCostChanged: (value) =>
                          setState(() => _laborCosts['fixtures'] = value),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _LaborItem(
                      label: 'Electrical Work',
                      hours: _hours['electrical']!,
                      cost: _laborCosts['electrical']!,
                      onCostChanged: (value) =>
                          setState(() => _laborCosts['electrical'] = value),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _LaborItem(
                      label: 'Final Finishing',
                      hours: _hours['finishing']!,
                      cost: _laborCosts['finishing']!,
                      onCostChanged: (value) =>
                          setState(() => _laborCosts['finishing'] = value),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Summary
                    Text(
                      'Total Hours & Cost',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    Container(
                      padding: const EdgeInsets.all(DesignTokens.spacing16),
                      decoration: BoxDecoration(
                        border: Border.all(color: DesignTokens.border),
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusMd,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Hours',
                                style: DesignTokens.bodyMedium.copyWith(
                                  color: DesignTokens.textSecondary,
                                ),
                              ),
                              Text(
                                '${_hours.values.fold<int>(0, (sum, h) => sum + h)} hours',
                                style: DesignTokens.subtitle2.copyWith(
                                  color: DesignTokens.text,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: DesignTokens.spacing12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Average Daily Rate',
                                style: DesignTokens.bodyMedium.copyWith(
                                  color: DesignTokens.textSecondary,
                                ),
                              ),
                              Text(
                                '4,000 UZS/hour',
                                style: DesignTokens.subtitle2.copyWith(
                                  color: DesignTokens.text,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: DesignTokens.border,
                            height: DesignTokens.spacing20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Labor Cost',
                                style: DesignTokens.subtitle1.copyWith(
                                  color: DesignTokens.text,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${_totalLabor.toStringAsFixed(0)} UZS',
                                style: DesignTokens.heading3.copyWith(
                                  color: DesignTokens.primaryBlue,
                                ),
                              ),
                            ],
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
              onPressed: _isSaving ? () {} : _continueToSummary,
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
                    : const Text('View Final Estimate'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LaborItem extends StatefulWidget {
  const _LaborItem({
    required this.label,
    required this.hours,
    required this.cost,
    required this.onCostChanged,
  });

  final String label;
  final int hours;
  final double cost;
  final ValueChanged<double> onCostChanged;

  @override
  State<_LaborItem> createState() => _LaborItemState();
}

class _LaborItemState extends State<_LaborItem> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.cost.toStringAsFixed(0));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing12),
      decoration: BoxDecoration(
        border: Border.all(color: DesignTokens.border),
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.label,
                  style: DesignTokens.subtitle2.copyWith(
                    color: DesignTokens.text,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacing8,
                  vertical: DesignTokens.spacing4,
                ),
                decoration: BoxDecoration(
                  color: DesignTokens.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                ),
                child: Text(
                  '${widget.hours}h',
                  style: DesignTokens.caption.copyWith(
                    color: DesignTokens.primaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing12),
          TextField(
            controller: _controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              final numValue = double.tryParse(value) ?? 0.0;
              widget.onCostChanged(numValue);
            },
            decoration: InputDecoration(
              hintText: '0',
              suffixText: 'UZS',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing12,
                vertical: DesignTokens.spacing8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
