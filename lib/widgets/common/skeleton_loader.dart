import 'package:flutter/material.dart';

import '../../config/design_tokens.dart';

/// A single shimmering placeholder block — the basic unit every skeleton
/// layout in this app is built from. Shape (rectangle, circle, rounded
/// line) and size are the caller's job; this widget only owns painting the
/// shimmer sweep, driven by the nearest ancestor [SkeletonShimmer]'s shared
/// [AnimationController] so every box on screen sweeps in sync instead of
/// flickering independently. Must be used inside a [SkeletonShimmer].
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    this.width,
    this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    super.key,
  });

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxShape shape;

  /// A circular placeholder (avatars, status dots) — just [SkeletonBox]
  /// with [BoxShape.circle], sized to a square.
  const SkeletonBox.circle({required double size, Key? key})
    : this(width: size, height: size, shape: BoxShape.circle, key: key);

  @override
  Widget build(BuildContext context) {
    final controller = SkeletonShimmer._controllerOf(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: shape,
          borderRadius: shape == BoxShape.rectangle
              ? (borderRadius ?? BorderRadius.circular(DesignTokens.radiusSm))
              : null,
          gradient: LinearGradient(
            begin: Alignment(-1.0 - controller.value * 3, 0),
            end: Alignment(1.0 - controller.value * 3, 0),
            colors: const [
              DesignTokens.borderGrayAlt,
              Color(0xFFEFF3FA),
              DesignTokens.borderGrayAlt,
            ],
            stops: const [0.35, 0.5, 0.65],
          ),
        ),
      ),
    );
  }
}

/// Wraps a subtree of [SkeletonBox]es in one shared shimmer sweep. Every
/// full-page skeleton in the app should have exactly one of these at its
/// root (screens compose their skeleton as plain `Column`/`Row`/`ListView`
/// layouts of [SkeletonBox] beneath it). Sharing a single
/// [AnimationController] here — rather than each box driving its own — is
/// what keeps a whole list of skeleton rows moving as one sheet of light
/// instead of animating out of phase with each other.
class SkeletonShimmer extends StatefulWidget {
  const SkeletonShimmer({required this.child, super.key});

  final Widget child;

  static AnimationController _controllerOf(BuildContext context) {
    final state = context
        .findAncestorStateOfType<_SkeletonShimmerState>();
    assert(
      state != null,
      'SkeletonBox must be used inside a SkeletonShimmer ancestor.',
    );
    return state!._controller;
  }

  @override
  State<SkeletonShimmer> createState() => _SkeletonShimmerState();
}

class _SkeletonShimmerState extends State<SkeletonShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
