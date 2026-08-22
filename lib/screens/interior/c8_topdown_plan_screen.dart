import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../providers/design_provider.dart';
import '../../providers/room_provider.dart';
import '../../widgets/room/room_canvas.dart';
import '../../widgets/room/room_perspective_view.dart';

enum _ViewMode { topDown, threeD, orbit }

/// C8: Top-down plan — Tepadan/3D/Aylanish view toggle over the furnished
/// room; "Tepadan" reuses the existing top-down [RoomCanvas] (doors,
/// windows, furniture footprints); 3D/Aylanish fall back to the
/// perspective placeholder since there's no real 3D engine yet.
class C8TopdownPlanScreen extends ConsumerStatefulWidget {
  const C8TopdownPlanScreen({super.key});

  @override
  ConsumerState<C8TopdownPlanScreen> createState() =>
      _C8TopdownPlanScreenState();
}

class _C8TopdownPlanScreenState extends ConsumerState<C8TopdownPlanScreen> {
  _ViewMode _mode = _ViewMode.topDown;

  @override
  Widget build(BuildContext context) {
    final room = ref.watch(activeRoomProvider);
    final plan = ref.watch(activeRoomPlanProvider);
    final condition = ref.watch(activeDesignProvider)?.roomCondition;

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacingMd),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: DesignTokens.white,
                  borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
                  boxShadow: const [DesignTokens.shadowCard],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ModeChip(
                      label: 'Tepadan',
                      selected: _mode == _ViewMode.topDown,
                      onTap: () => setState(() => _mode = _ViewMode.topDown),
                    ),
                    _ModeChip(
                      label: '3D',
                      selected: _mode == _ViewMode.threeD,
                      onTap: () => setState(() => _mode = _ViewMode.threeD),
                    ),
                    _ModeChip(
                      label: 'Aylanish',
                      selected: _mode == _ViewMode.orbit,
                      onTap: () => setState(() => _mode = _ViewMode.orbit),
                    ),
                  ],
                ),
              ),
            ),
            if (_mode == _ViewMode.topDown)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.screenPaddingHorizontal,
                ),
                child: Text(
                  'Mebelni sudrab aniq joylashtiring',
                  style: DesignTokens.caption.copyWith(
                    color: DesignTokens.textGray,
                  ),
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(DesignTokens.spacingMd),
                child: _mode == _ViewMode.topDown && room != null
                    ? RoomCanvas(room: room, plan: plan, onItemSelected: (_) {})
                    : RoomPerspectiveView(
                        wallCondition: condition?.wall ?? SurfaceCondition.raw,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                DesignTokens.screenPaddingHorizontal,
              ),
              child: SizedBox(
                width: double.infinity,
                height: DesignTokens.buttonHeightLarge,
                child: ElevatedButton(
                  onPressed: () => context.push('/interior/c9'),
                  child: const Text('Bezashni yakunlash'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingMd,
          vertical: DesignTokens.spacingSm,
        ),
        decoration: BoxDecoration(
          color: selected ? DesignTokens.primaryTint : Colors.transparent,
          borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
        ),
        child: Text(
          label,
          style: DesignTokens.caption.copyWith(
            color: selected ? DesignTokens.primaryBlue : DesignTokens.textGray,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
