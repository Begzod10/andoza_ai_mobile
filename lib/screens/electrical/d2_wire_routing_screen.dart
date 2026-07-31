import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/electrical_model.dart';
import '../../models/room_model.dart';
import '../../providers/room_provider.dart';
import '../../widgets/design/stage_progress_line.dart';
import '../../widgets/electrical/wire_routing_view.dart';
import '../../widgets/common/device_rail.dart';

/// D2: Wire Routing - Basic Layout
/// Allows user to plan main wire routing paths through the room
class D2WireRoutingScreen extends ConsumerStatefulWidget {
  const D2WireRoutingScreen({super.key});

  @override
  ConsumerState<D2WireRoutingScreen> createState() =>
      _D2WireRoutingScreenState();
}

class _D2WireRoutingScreenState extends ConsumerState<D2WireRoutingScreen> {
  late ElectricalLayout _layout;
  bool _showGrid = true;
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

  Future<void> _continueToDevices() async {
    setState(() => _isSaving = true);

    try {
      // In production, save layout to provider
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        context.go('/electrical/d5');
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
        appBar: AppBar(title: const Text('Wire Routing')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Wire Routes'),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          // Progress
          Padding(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            child: StageProgressLine(currentStep: 0, totalSteps: 3),
          ),
          // Main content
          Expanded(
            child: Row(
              children: [
                // Wire routing canvas
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(DesignTokens.spacing16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Instructions
                        Container(
                          padding: const EdgeInsets.all(DesignTokens.spacing12),
                          decoration: BoxDecoration(
                            color: DesignTokens.primaryBlue.withValues(
                              alpha: 0.05,
                            ),
                            borderRadius: BorderRadius.circular(
                              DesignTokens.radiusMd,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: DesignTokens.primaryBlue,
                                size: 20,
                              ),
                              const SizedBox(width: DesignTokens.spacing8),
                              Expanded(
                                child: Text(
                                  'Click to add wire routes. Use junction boxes to split paths.',
                                  style: DesignTokens.caption.copyWith(
                                    color: DesignTokens.primaryBlue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: DesignTokens.spacing12),
                        // Canvas
                        Expanded(
                          child: WireRoutingView(
                            width: room.dimensions.width,
                            length: room.dimensions.length,
                            layout: _layout,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Device rail
                DeviceRail(
                  deviceTypes: const [
                    DeviceType.outlet,
                    DeviceType.lightSwitch,
                    DeviceType.light,
                    DeviceType.breaker,
                  ],
                  onDeviceSelected: (type) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Select device type: $type'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
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
                Text(
                  'Wires: ${_layout.wires.length} | Devices: ${_layout.devices.length}',
                  style: DesignTokens.caption.copyWith(
                    color: DesignTokens.textSecondary,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing12),
                ElevatedButton(
                  onPressed: _isSaving ? () {} : _continueToDevices,
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
                        : const Text('Continue to Devices'),
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
