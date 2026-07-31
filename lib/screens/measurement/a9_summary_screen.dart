import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../providers/measurement_provider.dart';
import '../../providers/room_provider.dart';

/// A9: Summary/Completion Screen
/// Shows completion message and options for next steps
class A9SummaryScreen extends ConsumerStatefulWidget {
  const A9SummaryScreen({super.key});

  @override
  ConsumerState<A9SummaryScreen> createState() => _A9SummaryScreenState();
}

class _A9SummaryScreenState extends ConsumerState<A9SummaryScreen> {
  bool _isCreatingRoom = false;

  void _startDesignFlow() {
    setState(() => _isCreatingRoom = true);
    ref.read(activeRoomProvider.notifier).createFromMeasurement(
      width: ref.read(measurementProvider).width!,
      length: ref.read(measurementProvider).length!,
      height: ref.read(measurementProvider).height!,
      name: ref.read(measurementProvider).roomName!,
    ).then((_) {
      if (mounted) {
        context.go('/design/b1');
      }
    }).catchError((e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
      setState(() => _isCreatingRoom = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final measurement = ref.watch(measurementProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Measurement Complete'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: DesignTokens.spacing32),
              // Success animation
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: DesignTokens.success.withValues(alpha: 0.1),
                  ),
                  child: Icon(
                    Icons.check_circle,
                    size: 80,
                    color: DesignTokens.success,
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),
              // Title
              Text(
                'Measurement Saved!',
                style: DesignTokens.headingLarge.copyWith(
                  color: DesignTokens.text,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DesignTokens.spacing16),
              Text(
                'Your room measurement has been successfully recorded',
                style: DesignTokens.bodyMedium.copyWith(
                  color: DesignTokens.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DesignTokens.spacingXxl),
              // Measurement summary card
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing24),
                decoration: BoxDecoration(
                  border: Border.all(color: DesignTokens.border),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusLarge),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Measurement Summary',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),
                    _SummaryRow(
                      label: 'Room Name',
                      value: measurement.roomName ?? 'Unnamed',
                      icon: Icons.door_front_door_outlined,
                    ),
                    const SizedBox(height: DesignTokens.spacing16),
                    _SummaryRow(
                      label: 'Width',
                      value: '${measurement.width?.toStringAsFixed(2) ?? 0} m',
                      icon: Icons.straighten,
                    ),
                    const SizedBox(height: DesignTokens.spacing16),
                    _SummaryRow(
                      label: 'Length',
                      value: '${measurement.length?.toStringAsFixed(2) ?? 0} m',
                      icon: Icons.straighten,
                    ),
                    const SizedBox(height: DesignTokens.spacing16),
                    _SummaryRow(
                      label: 'Height',
                      value: '${measurement.height?.toStringAsFixed(2) ?? 0} m',
                      icon: Icons.layers_outlined,
                    ),
                    const Divider(height: DesignTokens.spacing32),
                    _SummaryRow(
                      label: 'Floor Area',
                      value: measurement.area != null
                          ? '${measurement.area!.toStringAsFixed(2)} m²'
                          : 'N/A',
                      icon: Icons.square_foot,
                      isHighlight: true,
                    ),
                    const SizedBox(height: DesignTokens.spacing16),
                    _SummaryRow(
                      label: 'Volume',
                      value: measurement.volume != null
                          ? '${measurement.volume!.toStringAsFixed(2)} m³'
                          : 'N/A',
                      icon: Icons.inventory_2_outlined,
                      isHighlight: true,
                    ),
                    if (measurement.furniture.isNotEmpty) ...[
                      const SizedBox(height: DesignTokens.spacing16),
                      _SummaryRow(
                        label: 'Furniture Items',
                        value: '${measurement.furniture.length}',
                        icon: Icons.chair,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacingXxl),
              // Next steps
              Text(
                'What\'s Next?',
                style: DesignTokens.subtitle1.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              _NextStepOption(
                icon: Icons.palette_outlined,
                title: 'Design Interior',
                description: 'Get design suggestions and visualizations',
                onTap: _isCreatingRoom ? () {} : _startDesignFlow,
              ),
              const SizedBox(height: DesignTokens.spacing12),
              _NextStepOption(
                icon: Icons.calculate_outlined,
                title: 'Get Estimates',
                description: 'Calculate material and labor costs',
                onTap: () => context.go('/'),
              ),
              const SizedBox(height: DesignTokens.spacing12),
              _NextStepOption(
                icon: Icons.shopping_bag_outlined,
                title: 'Find Materials',
                description: 'Browse and shop for materials',
                onTap: () => context.go('/'),
              ),
              const SizedBox(height: DesignTokens.spacing32),
              // Action buttons
              ElevatedButton.icon(
                onPressed: () => context.go('/'),
                icon: const Icon(Icons.home),
                label: const Text('Go to Home'),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              OutlinedButton.icon(
                onPressed: () {
                  ref.read(measurementProvider.notifier).reset();
                  context.go('/measurement/a1');
                },
                icon: const Icon(Icons.add),
                label: const Text('New Measurement'),
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
    this.isHighlight = false,
  });

  final String label;
  final String value;
  final IconData icon;
  final bool isHighlight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isHighlight
                  ? DesignTokens.primary
                  : DesignTokens.textSecondary,
            ),
            const SizedBox(width: DesignTokens.spacing12),
            Text(
              label,
              style: DesignTokens.bodyMedium.copyWith(
                color: DesignTokens.textSecondary,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: DesignTokens.subtitle2.copyWith(
            color: isHighlight ? DesignTokens.primary : DesignTokens.text,
            fontWeight: isHighlight ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _NextStepOption extends StatefulWidget {
  const _NextStepOption({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  State<_NextStepOption> createState() => _NextStepOptionState();
}

class _NextStepOptionState extends State<_NextStepOption> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.all(DesignTokens.spacing16),
          decoration: BoxDecoration(
            color: _isHovering
                ? DesignTokens.primary.withValues(alpha: 0.05)
                : DesignTokens.surface,
            border: Border.all(
              color: _isHovering
                  ? DesignTokens.primary.withValues(alpha: 0.3)
                  : DesignTokens.border,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(DesignTokens.radiusLarge),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 32,
                color: _isHovering ? DesignTokens.primary : DesignTokens.textSecondary,
              ),
              const SizedBox(width: DesignTokens.spacing16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: DesignTokens.subtitle2.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing4),
                    Text(
                      widget.description,
                      style: DesignTokens.bodySmall.copyWith(
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: _isHovering ? DesignTokens.primary : DesignTokens.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
