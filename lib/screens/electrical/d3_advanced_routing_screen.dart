import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/electrical_model.dart';
import '../../models/room_model.dart';
import '../../providers/room_provider.dart';
import '../../widgets/design/stage_progress_line.dart';
import '../../widgets/electrical/wire_routing_view.dart';

/// D3: Advanced Wire Routing
/// Optimize wire routes, add junction boxes, and plan complex routing scenarios
class D3AdvancedRoutingScreen extends ConsumerStatefulWidget {
  const D3AdvancedRoutingScreen({super.key});

  @override
  ConsumerState<D3AdvancedRoutingScreen> createState() =>
      _D3AdvancedRoutingScreenState();
}

class _D3AdvancedRoutingScreenState
    extends ConsumerState<D3AdvancedRoutingScreen> {
  late ElectricalLayout _layout;
  int _selectedRoutingOption = 0;
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

  Future<void> _continueToConfirmation() async {
    setState(() => _isSaving = true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        context.go('/electrical/d4');
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
        appBar: AppBar(title: const Text('Advanced Routing')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Wire Routing'),
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title
                    Text(
                      'Optimize Wire Routes',
                      style: DesignTokens.heading3.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    Text(
                      'Plan junction boxes and optimize cable paths to minimize waste.',
                      style: DesignTokens.bodyMedium.copyWith(
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Routing canvas
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(color: DesignTokens.border),
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusMd,
                        ),
                      ),
                      child: WireRoutingView(
                        width: room.dimensions.width,
                        length: room.dimensions.length,
                        layout: _layout,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Routing options
                    Text(
                      'Routing Strategy',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _RoutingOptionCard(
                      title: 'Minimal Path (Efficient)',
                      description: 'Uses ~15m cable, minimizes waste',
                      icon: Icons.trending_down,
                      isSelected: _selectedRoutingOption == 0,
                      onTap: () => setState(() => _selectedRoutingOption = 0),
                      savings: '5,000-8,000 UZS',
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _RoutingOptionCard(
                      title: 'Standard Path (Balanced)',
                      description: 'Uses ~20m cable, good flexibility',
                      icon: Icons.balance,
                      isSelected: _selectedRoutingOption == 1,
                      onTap: () => setState(() => _selectedRoutingOption = 1),
                      savings: 'Standard cost',
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _RoutingOptionCard(
                      title: 'Redundant Path (Safe)',
                      description: 'Uses ~25m cable, backup routes',
                      icon: Icons.shield_outlined,
                      isSelected: _selectedRoutingOption == 2,
                      onTap: () => setState(() => _selectedRoutingOption = 2),
                      savings: '+5,000-8,000 UZS',
                    ),
                    const SizedBox(height: DesignTokens.spacing24),

                    // Junction box specs
                    Text(
                      'Junction Box Placement',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _SpecCard(
                      label: 'Main Distribution Box',
                      value: 'Panel entry location',
                      icon: Icons.dashboard_customize_outlined,
                    ),
                    _SpecCard(
                      label: 'Secondary Junctions',
                      value: '2-3 boxes along routes',
                      icon: Icons.category_outlined,
                    ),
                    _SpecCard(
                      label: 'Branch Points',
                      value: 'Wall-mounted for accessibility',
                      icon: Icons.call_split,
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
              onPressed: _isSaving ? () {} : _continueToConfirmation,
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
                    : const Text('Continue to Confirmation'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoutingOptionCard extends StatelessWidget {
  const _RoutingOptionCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.savings,
  });

  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final String savings;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacing16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? DesignTokens.primaryBlue : DesignTokens.border,
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
                  const SizedBox(height: DesignTokens.spacing4),
                  Text(
                    savings,
                    style: DesignTokens.caption.copyWith(
                      color: DesignTokens.primaryBlue,
                      fontWeight: FontWeight.bold,
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

class _SpecCard extends StatelessWidget {
  const _SpecCard({
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
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacing12),
        decoration: BoxDecoration(
          color: DesignTokens.surface,
          border: Border.all(color: DesignTokens.border),
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
        ),
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
      ),
    );
  }
}
