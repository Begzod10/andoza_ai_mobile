import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/electrical_model.dart';
import '../../models/room_model.dart';
import '../../providers/room_provider.dart';
import '../../widgets/design/stage_progress_line.dart';
import '../../widgets/room/room_canvas.dart';

/// D6: Lighting & Switch Placement
/// Plan lighting fixtures and switch locations throughout the room
class D6LightingPlacementScreen extends ConsumerStatefulWidget {
  const D6LightingPlacementScreen({super.key});

  @override
  ConsumerState<D6LightingPlacementScreen> createState() =>
      _D6LightingPlacementScreenState();
}

class _D6LightingPlacementScreenState
    extends ConsumerState<D6LightingPlacementScreen> {
  late ElectricalLayout _layout;
  String? _selectedItemId;
  int _lightingType = 0; // 0: standard, 1: recessed, 2: smart
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _layout = ElectricalLayout(
      id: 'layout_1',
      roomId: '',
      devices: _generateSampleLighting(),
      wires: [],
      pipes: [],
      junctionBoxes: [],
    );
  }

  List<ElectricalDevice> _generateSampleLighting() {
    return [
      ElectricalDevice(
        id: 'light_1',
        type: DeviceType.light,
        position: const Offset(150, 150),
        wallId: 'ceiling',
        heightCm: 250,
        colorTemp: ColorTemp.neutral,
      ),
      ElectricalDevice(
        id: 'switch_1',
        type: DeviceType.lightSwitch,
        position: const Offset(50, 100),
        wallId: 'wall_west',
        heightCm: 120,
      ),
    ];
  }

  Future<void> _continueToReview() async {
    setState(() => _isSaving = true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        context.go('/electrical/d7');
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
        appBar: AppBar(title: const Text('Lighting Placement')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Lighting & Switches'),
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title
                    Text(
                      'Plan Lighting & Switches',
                      style: DesignTokens.heading3.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    Text(
                      'Place ceiling lights and wall switches for optimal lighting coverage.',
                      style: DesignTokens.bodyMedium.copyWith(
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Room preview
                    Container(
                      height: 280,
                      decoration: BoxDecoration(
                        border: Border.all(color: DesignTokens.border),
                        borderRadius:
                            BorderRadius.circular(DesignTokens.radiusMd),
                      ),
                      child: RoomCanvas(
                        room: room,
                        onItemSelected: (id) =>
                            setState(() => _selectedItemId = id),
                        selectedItemId: _selectedItemId,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Lighting type selector
                    Text(
                      'Lighting Type',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _LightingTypeCard(
                      title: 'Standard Pendant',
                      description: 'Classic overhead fixtures\n15,000-25,000 UZS per unit',
                      icon: Icons.lightbulb_outline,
                      isSelected: _lightingType == 0,
                      onTap: () => setState(() => _lightingType = 0),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _LightingTypeCard(
                      title: 'Recessed Ceiling',
                      description: 'Modern recessed lights\n20,000-35,000 UZS per unit',
                      icon: Icons.crop_square,
                      isSelected: _lightingType == 1,
                      onTap: () => setState(() => _lightingType = 1),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _LightingTypeCard(
                      title: 'Smart Lighting',
                      description: 'WiFi-enabled RGB lights\n40,000-60,000 UZS per unit',
                      icon: Icons.lightbulb,
                      isSelected: _lightingType == 2,
                      onTap: () => setState(() => _lightingType = 2),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Placement specs
                    Text(
                      'Standard Placement',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _SpecItem(
                      label: 'Main Light',
                      value: 'Ceiling center',
                    ),
                    _SpecItem(
                      label: 'Entry Switch Height',
                      value: '120-140 cm from floor',
                    ),
                    _SpecItem(
                      label: 'Recommended Fixtures',
                      value: '2-3 fixtures for room this size',
                    ),
                    _SpecItem(
                      label: 'Color Temperature',
                      value: 'Neutral white (4000K)',
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
              onPressed: _isSaving ? () {} : _continueToReview,
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
                    : const Text('Continue to Review'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LightingTypeCard extends StatelessWidget {
  const _LightingTypeCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacing16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? DesignTokens.primaryBlue
                : DesignTokens.border,
            width: isSelected ? 2.5 : 1.5,
          ),
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          color: isSelected
              ? DesignTokens.primaryBlue.withValues(alpha: 0.05)
              : DesignTokens.surface,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected
                  ? DesignTokens.primaryBlue
                  : DesignTokens.textSecondary,
            ),
            const SizedBox(width: DesignTokens.spacing16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: DesignTokens.subtitle2.copyWith(
                      color: isSelected
                          ? DesignTokens.primaryBlue
                          : DesignTokens.text,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w600,
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
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: DesignTokens.primaryBlue,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}

class _SpecItem extends StatelessWidget {
  const _SpecItem({
    required this.label,
    required this.value,
  });

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
