import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../providers/design_provider.dart';
import '../../widgets/room/room_perspective_view.dart';

/// C7: Aylanib yurish — first-person walkthrough of the now-furnished
/// room. Joystick pans/moves along the floor; reset re-centers.
class C7WalkthroughScreen extends ConsumerStatefulWidget {
  const C7WalkthroughScreen({super.key});

  @override
  ConsumerState<C7WalkthroughScreen> createState() =>
      _C7WalkthroughScreenState();
}

class _C7WalkthroughScreenState extends ConsumerState<C7WalkthroughScreen> {
  Offset _joystickOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final condition =
        ref.watch(activeDesignProvider.select((d) => d?.roomCondition));

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: RoomPerspectiveView(
              wallCondition: condition?.wall ?? SurfaceCondition.raw,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(DesignTokens.spacingMd),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: DesignTokens.textDark,
                      ),
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacingMd),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DesignTokens.spacingMd,
                      vertical: DesignTokens.spacingSm,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusFull,
                      ),
                    ),
                    child: const Text(
                      'Polda yurish mumkin — barmoq bilan suring',
                      style: DesignTokens.caption,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: DesignTokens.spacingLg,
            bottom: DesignTokens.spacingXl,
            child: GestureDetector(
              onPanUpdate: (details) => setState(() {
                final next = _joystickOffset + details.delta * 0.3;
                _joystickOffset = Offset(
                  next.dx.clamp(-27, 27),
                  next.dy.clamp(-27, 27),
                );
              }),
              onPanEnd: (_) => setState(() => _joystickOffset = Offset.zero),
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: Align(
                  alignment: Alignment(
                    _joystickOffset.dx / 27,
                    _joystickOffset.dy / 27,
                  ),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: const BoxDecoration(
                      color: DesignTokens.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: DesignTokens.spacingLg,
            bottom: DesignTokens.spacingXl,
            child: GestureDetector(
              onTap: () => setState(() => _joystickOffset = Offset.zero),
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.center_focus_strong,
                  color: DesignTokens.textDark,
                ),
              ),
            ),
          ),
          Positioned(
            top: DesignTokens.spacingMd,
            right: DesignTokens.spacingMd,
            child: SafeArea(
              child: OutlinedButton(
                onPressed: () => context.push('/interior/c8'),
                child: const Text('Rejaga o\'tish →'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
