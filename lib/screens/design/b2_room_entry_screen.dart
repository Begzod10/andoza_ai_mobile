import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../providers/design_provider.dart';
import '../../widgets/room/room_perspective_view.dart';
import '../../widgets/room_3d_rail.dart';

/// B2: Xonaga kirish — first-person entry into the 3D room, matching the
/// chosen baseline condition's texture. Collapsed rail tab pulses to hint
/// at the decoration flow that starts in B3.
class B2RoomEntryScreen extends ConsumerStatefulWidget {
  const B2RoomEntryScreen({super.key});

  @override
  ConsumerState<B2RoomEntryScreen> createState() => _B2RoomEntryScreenState();
}

class _B2RoomEntryScreenState extends ConsumerState<B2RoomEntryScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  String _conditionLabel(SurfaceCondition condition) => switch (condition) {
    SurfaceCondition.raw => 'korobka holatida',
    SurfaceCondition.plastered => 'suvoq qilingan',
    SurfaceCondition.puttied => 'shpaklovka qilingan',
  };

  @override
  Widget build(BuildContext context) {
    final design = ref.watch(activeDesignProvider);
    final wallCondition = design?.roomCondition?.wall ?? SurfaceCondition.raw;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: RoomPerspectiveView(wallCondition: wallCondition),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(DesignTokens.spacingMd),
              child: Container(
                padding: const EdgeInsets.all(DesignTokens.spacingMd),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                  boxShadow: [DesignTokens.shadowCard],
                ),
                child: Text(
                  'Xonangiz shu holatda — ${_conditionLabel(wallCondition)}. Endi bosqichma-bosqich bezaymiz.',
                  style: DesignTokens.body1,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SafeArea(
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) => Transform.scale(
                  scale: 1 + (_pulseController.value * 0.08),
                  child: child,
                ),
                child: const Room3DRail(tabs: [], onItemSelected: _noop),
              ),
            ),
          ),
          Positioned(
            left: DesignTokens.spacingMd,
            right: DesignTokens.spacingMd,
            bottom: DesignTokens.spacingXl,
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                height: DesignTokens.buttonHeightLarge,
                child: ElevatedButton(
                  onPressed: () => context.go('/design/b3'),
                  child: const Text('Boshlash'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _noop(RailItem _) {}
