import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../models/room_model.dart';
import '../../providers/design_provider.dart';
import '../../providers/room_provider.dart';
import '../../widgets/design/room_condition_card.dart';
import '../../widgets/design/stage_progress_line.dart';
import '../../widgets/common/success_toast.dart';

/// B1: Room Introduction & Baseline Condition Selection
/// Shows room summary and allows user to select current surface condition
class B1RoomIntroScreen extends ConsumerStatefulWidget {
  const B1RoomIntroScreen({super.key});

  @override
  ConsumerState<B1RoomIntroScreen> createState() => _B1RoomIntroScreenState();
}

class _B1RoomIntroScreenState extends ConsumerState<B1RoomIntroScreen> {
  late SurfaceCondition _wallCondition;
  late SurfaceCondition? _floorCondition;
  late SurfaceCondition? _ceilingCondition;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _wallCondition = SurfaceCondition.raw;
    _floorCondition = SurfaceCondition.raw;
    _ceilingCondition = SurfaceCondition.raw;
  }

  Future<void> _continueToFloor() async {
    setState(() => _isSaving = true);

    try {
      final roomCondition = RoomCondition(
        wall: _wallCondition,
        floor: _floorCondition,
        ceiling: _ceilingCondition,
      );

      await ref.read(activeDesignProvider.notifier).setRoomCondition(roomCondition);

      if (mounted) {
        context.go('/design/b2');
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
    final design = ref.watch(activeDesignProvider);

    if (room == null || design == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Room Design')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Design Interior'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress indicator
              StageProgressLine(currentStep: 0, totalSteps: 4),
              const SizedBox(height: DesignTokens.spacing32),

              // Room summary card
              _RoomSummaryCard(room: room),
              const SizedBox(height: DesignTokens.spacing32),

              // Introduction text
              Text(
                'What is your room\'s current condition?',
                style: DesignTokens.heading3.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing12),
              Text(
                'Select the current condition of your walls, floor, and ceiling. This helps us calculate the right materials needed.',
                style: DesignTokens.bodyMedium.copyWith(
                  color: DesignTokens.textSecondary,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),

              // Condition selectors
              RoomConditionCard(
                surface: 'Walls',
                condition: _wallCondition,
                onChanged: (value) => setState(() => _wallCondition = value),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              RoomConditionCard(
                surface: 'Floor',
                condition: _floorCondition ?? SurfaceCondition.raw,
                onChanged: (value) => setState(() => _floorCondition = value),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              RoomConditionCard(
                surface: 'Ceiling',
                condition: _ceilingCondition ?? SurfaceCondition.raw,
                onChanged: (value) => setState(() => _ceilingCondition = value),
              ),
              const SizedBox(height: DesignTokens.spacing40),

              // Action buttons
              ElevatedButton(
                onPressed: _isSaving ? () {} : _continueToFloor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacing12),
                  child: _isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Continue to Flooring'),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing12),
              OutlinedButton.icon(
                onPressed: () => context.go('/design/b1'),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to Room'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoomSummaryCard extends StatelessWidget {
  const _RoomSummaryCard({required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        border: Border.all(color: DesignTokens.border),
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        color: DesignTokens.primaryBlue.withValues(alpha: 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            room.name,
            style: DesignTokens.heading3.copyWith(
              color: DesignTokens.primaryBlue,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _InfoChip(
                icon: Icons.straighten,
                label: 'Width',
                value: '${room.dimensions.width.toStringAsFixed(2)} m',
              ),
              _InfoChip(
                icon: Icons.straighten,
                label: 'Length',
                value: '${room.dimensions.length.toStringAsFixed(2)} m',
              ),
              _InfoChip(
                icon: Icons.layers_outlined,
                label: 'Height',
                value: '${room.dimensions.height.toStringAsFixed(2)} m',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: DesignTokens.primaryBlue, size: 24),
        const SizedBox(height: DesignTokens.spacing8),
        Text(
          label,
          style: DesignTokens.caption.copyWith(
            color: DesignTokens.textSecondary,
          ),
        ),
        const SizedBox(height: DesignTokens.spacing4),
        Text(
          value,
          style: DesignTokens.subtitle2.copyWith(
            color: DesignTokens.text,
          ),
        ),
      ],
    );
  }
}
