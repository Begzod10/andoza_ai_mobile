import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/room_model.dart';
import '../../providers/room_provider.dart';
import '../../widgets/design/stage_progress_line.dart';
import '../../widgets/electrical/electrical_totals_card.dart';
import '../../models/electrical_model.dart';

/// D7: Device Placement Review
/// Review all electrical devices, fixtures, and their specifications
class D7DeviceReviewScreen extends ConsumerStatefulWidget {
  const D7DeviceReviewScreen({super.key});

  @override
  ConsumerState<D7DeviceReviewScreen> createState() =>
      _D7DeviceReviewScreenState();
}

class _D7DeviceReviewScreenState extends ConsumerState<D7DeviceReviewScreen> {
  late ElectricalLayout _layout;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _layout = ElectricalLayout(
      id: 'layout_1',
      roomId: '',
      devices: [
        ElectricalDevice(
          id: 'outlet_1',
          type: DeviceType.outlet,
          position: const Offset(100, 100),
          wallId: 'wall_north',
        ),
        ElectricalDevice(
          id: 'switch_1',
          type: DeviceType.lightSwitch,
          position: const Offset(50, 100),
          wallId: 'wall_west',
          heightCm: 120,
        ),
        ElectricalDevice(
          id: 'light_1',
          type: DeviceType.light,
          position: const Offset(150, 150),
          wallId: 'ceiling',
          heightCm: 250,
        ),
      ],
      wires: [],
      pipes: [],
      junctionBoxes: [],
    );
  }

  Future<void> _continueToEstimate() async {
    setState(() => _isSaving = true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        context.go('/electrical/d8');
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
        appBar: AppBar(title: const Text('Device Review')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Devices'),
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
                      'Device Placement Review',
                      style: DesignTokens.heading3.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    Text(
                      'Review all electrical devices and their placement.',
                      style: DesignTokens.bodyMedium.copyWith(
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Summary card
                    ElectricalTotalsCard(layout: _layout),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Device list
                    Text(
                      'Device Details',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    ..._layout.devices.map((device) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: DesignTokens.spacing12,
                        ),
                        child: _DeviceCard(device: device),
                      );
                    }).toList(),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Requirements
                    Text(
                      'Installation Requirements',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _RequirementItem(
                      title: 'Outlets',
                      spec: '2.5mm² wire, 16A circuit',
                    ),
                    _RequirementItem(
                      title: 'Switches',
                      spec: '1.5mm² wire, 10A circuit',
                    ),
                    _RequirementItem(
                      title: 'Lights',
                      spec: '1.5mm² wire, 10A circuit',
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
            child: ElevatedButton(
              onPressed: _isSaving ? () {} : _continueToEstimate,
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
                    : const Text('Continue to Cost Estimate'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceCard extends StatelessWidget {
  const _DeviceCard({required this.device});

  final ElectricalDevice device;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing12),
      decoration: BoxDecoration(
        border: Border.all(color: DesignTokens.border),
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            _getIconForType(device.type),
            color: DesignTokens.primaryBlue,
            size: 24,
          ),
          const SizedBox(width: DesignTokens.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getLabel(device.type),
                  style: DesignTokens.subtitle2.copyWith(
                    color: DesignTokens.text,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing4),
                Text(
                  'Height: ${device.heightCm}cm | Wall: ${device.wallId}',
                  style: DesignTokens.caption.copyWith(
                    color: DesignTokens.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.check_circle_outline,
            color: DesignTokens.success,
            size: 20,
          ),
        ],
      ),
    );
  }

  IconData _getIconForType(DeviceType type) {
    switch (type) {
      case DeviceType.outlet:
        return Icons.power_outlined;
      case DeviceType.lightSwitch:
        return Icons.toggle_on_outlined;
      case DeviceType.light:
        return Icons.lightbulb_outline;
      case DeviceType.breaker:
        return Icons.miscellaneous_services_outlined;
    }
  }

  String _getLabel(DeviceType type) {
    switch (type) {
      case DeviceType.outlet:
        return 'Outlet';
      case DeviceType.lightSwitch:
        return 'Switch';
      case DeviceType.light:
        return 'Light Fixture';
      case DeviceType.breaker:
        return 'Breaker';
    }
  }
}

class _RequirementItem extends StatelessWidget {
  const _RequirementItem({
    required this.title,
    required this.spec,
  });

  final String title;
  final String spec;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DesignTokens.spacing12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: DesignTokens.bodyMedium.copyWith(
              color: DesignTokens.text,
            ),
          ),
          Text(
            spec,
            style: DesignTokens.caption.copyWith(
              color: DesignTokens.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
