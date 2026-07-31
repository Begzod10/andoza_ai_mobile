import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/electrical_model.dart';
import '../../models/room_model.dart';
import '../../providers/room_provider.dart';
import '../../widgets/design/stage_progress_line.dart';
import '../../widgets/room/room_canvas.dart';
import '../../widgets/electrical/electrical_totals_card.dart';

/// D5: Outlet Placement
/// Allows user to place and configure electrical outlets throughout the room
class D5OutletPlacementScreen extends ConsumerStatefulWidget {
  const D5OutletPlacementScreen({super.key});

  @override
  ConsumerState<D5OutletPlacementScreen> createState() =>
      _D5OutletPlacementScreenState();
}

class _D5OutletPlacementScreenState
    extends ConsumerState<D5OutletPlacementScreen> {
  late ElectricalLayout _layout;
  String? _selectedOutletId;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _layout = ElectricalLayout(
      id: 'layout_1',
      roomId: '',
      devices: _generateSampleOutlets(),
      wires: [],
      pipes: [],
      junctionBoxes: [],
    );
  }

  List<ElectricalDevice> _generateSampleOutlets() {
    return [
      ElectricalDevice(
        id: 'outlet_1',
        type: DeviceType.outlet,
        position: const Offset(100, 100),
        wallId: 'wall_north',
        heightCm: 30,
        gangCount: 2,
      ),
      ElectricalDevice(
        id: 'outlet_2',
        type: DeviceType.outlet,
        position: const Offset(200, 100),
        wallId: 'wall_north',
        heightCm: 30,
        gangCount: 2,
      ),
    ];
  }

  Future<void> _continueLights() async {
    setState(() => _isSaving = true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        context.go('/electrical/d6');
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
        appBar: AppBar(title: const Text('Outlet Placement')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Outlets'),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          // Progress
          Padding(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            child: StageProgressLine(currentStep: 1, totalSteps: 3),
          ),
          // Main content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(DesignTokens.spacing16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Instructions
                    Text(
                      'Place Electrical Outlets',
                      style: DesignTokens.heading3.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    Text(
                      'Standard outlet height is 30-45cm from floor. Click on walls to add new outlets.',
                      style: DesignTokens.bodyMedium.copyWith(
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Room preview
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: DesignTokens.border),
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusMd,
                        ),
                      ),
                      child: RoomCanvas(
                        room: room,
                        onItemSelected: (id) =>
                            setState(() => _selectedOutletId = id),
                        selectedItemId: _selectedOutletId,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Summary card
                    ElectricalTotalsCard(layout: _layout),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Outlet specifications
                    Text(
                      'Outlet Specifications',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _SpecItem(
                      label: 'Standard Height',
                      value: '30-45 cm from floor',
                    ),
                    _SpecItem(
                      label: 'Recommended Spacing',
                      value: '1 outlet per 1.8m of wall',
                    ),
                    _SpecItem(
                      label: 'Gang Count',
                      value: '1-3 gangs per outlet',
                    ),
                    _SpecItem(label: 'Wire Gauge', value: '2.5-4mm² (typical)'),
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
              onPressed: _isSaving ? () {} : _continueLights,
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
                    : const Text('Continue to Lights & Switches'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecItem extends StatelessWidget {
  const _SpecItem({required this.label, required this.value});

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
