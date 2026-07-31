import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/room_model.dart';
import '../../providers/room_provider.dart';
import '../../widgets/design/stage_progress_line.dart';

/// E2: Material Cost Calculator
/// Calculate total material costs for design and electrical work
class E2MaterialCostsScreen extends ConsumerStatefulWidget {
  const E2MaterialCostsScreen({super.key});

  @override
  ConsumerState<E2MaterialCostsScreen> createState() =>
      _E2MaterialCostsScreenState();
}

class _E2MaterialCostsScreenState extends ConsumerState<E2MaterialCostsScreen> {
  late Map<String, double> _materialCosts;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _materialCosts = {
      'flooring': 150000.0,
      'paint': 80000.0,
      'fixtures': 120000.0,
      'electrical': 95000.0,
      'accessories': 50000.0,
    };
  }

  double get _totalMaterials =>
      _materialCosts.values.fold(0.0, (sum, cost) => sum + cost);

  Future<void> _continueToLabor() async {
    setState(() => _isSaving = true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        context.go('/estimation/e3');
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
        appBar: AppBar(title: const Text('Material Costs')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Costs'),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          // Progress
          Padding(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            child: StageProgressLine(currentStep: 1, totalSteps: 3),
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
                      'Material Costs Calculator',
                      style: DesignTokens.heading3.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    Text(
                      'Breakdown of all materials needed for your project.',
                      style: DesignTokens.bodyMedium.copyWith(
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Room info
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
                              'For room: ${room.name} (${(room.dimensions.width * room.dimensions.length).toStringAsFixed(1)} m²)',
                              style: DesignTokens.caption.copyWith(
                                color: DesignTokens.primaryBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Material categories
                    Text(
                      'Material Breakdown',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing16),
                    _MaterialItem(
                      label: 'Flooring',
                      description: 'Tiles, laminate, or wood (per m²)',
                      cost: _materialCosts['flooring']!,
                      onChanged: (value) =>
                          setState(() => _materialCosts['flooring'] = value),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _MaterialItem(
                      label: 'Paint & Finishes',
                      description: 'Wall paint, ceiling finish, primer',
                      cost: _materialCosts['paint']!,
                      onChanged: (value) =>
                          setState(() => _materialCosts['paint'] = value),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _MaterialItem(
                      label: 'Fixtures & Fittings',
                      description: 'Lights, switches, outlets, handles',
                      cost: _materialCosts['fixtures']!,
                      onChanged: (value) =>
                          setState(() => _materialCosts['fixtures'] = value),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _MaterialItem(
                      label: 'Electrical Components',
                      description: 'Cable, breakers, junction boxes',
                      cost: _materialCosts['electrical']!,
                      onChanged: (value) =>
                          setState(() => _materialCosts['electrical'] = value),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _MaterialItem(
                      label: 'Accessories & Other',
                      description: 'Fasteners, adhesives, misc items',
                      cost: _materialCosts['accessories']!,
                      onChanged: (value) =>
                          setState(() => _materialCosts['accessories'] = value),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Total
                    Container(
                      padding: const EdgeInsets.all(DesignTokens.spacing16),
                      decoration: BoxDecoration(
                        color: DesignTokens.primaryBlue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusMd,
                        ),
                        border: Border.all(
                          color: DesignTokens.primaryBlue.withValues(
                            alpha: 0.3,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Materials Cost',
                            style: DesignTokens.subtitle1.copyWith(
                              color: DesignTokens.text,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${_totalMaterials.toStringAsFixed(0)} UZS',
                            style: DesignTokens.heading3.copyWith(
                              color: DesignTokens.primaryBlue,
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
              onPressed: _isSaving ? () {} : _continueToLabor,
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
                    : const Text('Calculate Labor Costs'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MaterialItem extends StatefulWidget {
  const _MaterialItem({
    required this.label,
    required this.description,
    required this.cost,
    required this.onChanged,
  });

  final String label;
  final String description;
  final double cost;
  final ValueChanged<double> onChanged;

  @override
  State<_MaterialItem> createState() => _MaterialItemState();
}

class _MaterialItemState extends State<_MaterialItem> {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    style: DesignTokens.subtitle2.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing4),
                  Text(
                    widget.description,
                    style: DesignTokens.caption.copyWith(
                      color: DesignTokens.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing12),
          TextField(
            controller: _controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              final numValue = double.tryParse(value) ?? 0.0;
              widget.onChanged(numValue);
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
