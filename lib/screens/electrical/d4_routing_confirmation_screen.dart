import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/room_model.dart';
import '../../providers/room_provider.dart';
import '../../widgets/design/stage_progress_line.dart';
import '../../widgets/electrical/wire_routing_view.dart';
import '../../models/electrical_model.dart';

/// D4: Wire Routing Confirmation
/// Final review and confirmation of wire routing plan before device placement
class D4RoutingConfirmationScreen extends ConsumerStatefulWidget {
  const D4RoutingConfirmationScreen({super.key});

  @override
  ConsumerState<D4RoutingConfirmationScreen> createState() =>
      _D4RoutingConfirmationScreenState();
}

class _D4RoutingConfirmationScreenState
    extends ConsumerState<D4RoutingConfirmationScreen> {
  late ElectricalLayout _layout;
  bool _confirmAccuracy = false;
  bool _confirmCompliance = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _layout = ElectricalLayout(
      id: 'layout_1',
      roomId: '',
      devices: [],
      wires: [],
      pipes: [],
      junctionBoxes: [],
    );
  }

  Future<void> _proceedToDevices() async {
    if (!_confirmAccuracy || !_confirmCompliance) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please confirm accuracy and compliance requirements'),
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        context.go('/electrical/d5');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
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
        appBar: AppBar(title: const Text('Confirmation')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Wire Routes'),
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
                      'Review Wire Routing',
                      style: DesignTokens.heading3.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    Text(
                      'Confirm your wire routing plan is accurate and compliant before proceeding.',
                      style: DesignTokens.bodyMedium.copyWith(
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Wire routing preview
                    Text(
                      'Wire Layout Preview',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: DesignTokens.border),
                        borderRadius:
                            BorderRadius.circular(DesignTokens.radiusMd),
                      ),
                      child: WireRoutingView(
                        width: room.dimensions.width,
                        length: room.dimensions.length,
                        layout: _layout,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Route summary
                    Text(
                      'Route Summary',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _SummaryItem(
                      label: 'Total Cable Length',
                      value: '~20m',
                      icon: Icons.cable,
                    ),
                    _SummaryItem(
                      label: 'Main Route Path',
                      value: 'Entry → North Wall → East Wall',
                      icon: Icons.route,
                    ),
                    _SummaryItem(
                      label: 'Junction Boxes',
                      value: '3 locations planned',
                      icon: Icons.category_outlined,
                    ),
                    _SummaryItem(
                      label: 'Estimated Cost',
                      value: '20,000-25,000 UZS',
                      icon: Icons.attach_money,
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Confirmation checklist
                    Text(
                      'Confirm Before Proceeding',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing16),
                    _CheckboxItem(
                      label: 'Wire routes are accurate and practical',
                      description: 'All paths are feasible and minimize wall damage',
                      value: _confirmAccuracy,
                      onChanged: (value) =>
                          setState(() => _confirmAccuracy = value ?? false),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _CheckboxItem(
                      label: 'Routes comply with electrical codes',
                      description: 'Spacing, clearances, and safety standards met',
                      value: _confirmCompliance,
                      onChanged: (value) =>
                          setState(() => _confirmCompliance = value ?? false),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Code reference
                    Container(
                      padding: const EdgeInsets.all(DesignTokens.spacing12),
                      decoration: BoxDecoration(
                        color: DesignTokens.accentOrange.withValues(alpha: 0.1),
                        borderRadius:
                            BorderRadius.circular(DesignTokens.radiusSm),
                        border: Border.all(
                          color: DesignTokens.accentOrange
                              .withValues(alpha: 0.3),
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
                                size: 18,
                              ),
                              const SizedBox(width: DesignTokens.spacing8),
                              Text(
                                'Code Requirements',
                                style: DesignTokens.caption.copyWith(
                                  color: DesignTokens.accentOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: DesignTokens.spacing8),
                          Text(
                            '• Maintain 15cm clearance from pipes\n'
                            '• Use conduit in wet areas\n'
                            '• Support cables every 45cm\n'
                            '• Proper grounding at all junction points',
                            style: DesignTokens.caption.copyWith(
                              color: DesignTokens.textSecondary,
                              height: 1.5,
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
                  onPressed: (_confirmAccuracy && _confirmCompliance && !_isSaving)
                      ? _proceedToDevices
                      : null,
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
                        : const Text('Proceed to Device Placement'),
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing12),
                OutlinedButton.icon(
                  onPressed: () => context.go('/electrical/d3'),
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Routes'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
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
      padding: const EdgeInsets.only(bottom: DesignTokens.spacing12),
      child: Row(
        children: [
          Icon(icon, color: DesignTokens.primaryBlue, size: 20),
          const SizedBox(width: DesignTokens.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: DesignTokens.caption.copyWith(
                    color: DesignTokens.textSecondary,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing4),
                Text(
                  value,
                  style: DesignTokens.bodyMedium.copyWith(
                    color: DesignTokens.text,
                    fontWeight: FontWeight.w600,
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

class _CheckboxItem extends StatelessWidget {
  const _CheckboxItem({
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
