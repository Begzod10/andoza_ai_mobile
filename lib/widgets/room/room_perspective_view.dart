import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../room_3d_rail.dart';

/// First-person CSS-perspective-style interior placeholder, per spec:
/// "the room's walls shown in the chosen state texture... floor, ceiling,
/// window." A structural reference, not a real 3D engine — per the design
/// handoff's own note that a real engine (SceneKit/Filament/three.js/etc.)
/// should eventually replace this.
///
/// Shared by B2 (entering the room), B3 (decoration begins), and later
/// C7 (walkthrough) so the "inside the room" look stays consistent.
class RoomPerspectiveView extends StatelessWidget {
  const RoomPerspectiveView({
    required this.wallCondition,
    this.wallpaperColor,
    this.floorColor,
    this.onBackWallDrop,
    super.key,
  });

  final SurfaceCondition wallCondition;

  /// Overrides the wall texture color once a wallpaper/paint has been
  /// applied (Batch C) — falls back to the raw [wallCondition] texture.
  final Color? wallpaperColor;
  final Color? floorColor;

  /// When set, the back wall becomes a drop target for a dragged
  /// [RailItem] (e.g. a paint/wallpaper swatch from [Room3DRail]) — used
  /// by B3/C1-C3's drag-from-rail-onto-wall interaction.
  final ValueChanged<RailItem>? onBackWallDrop;

  Color get _wallColor =>
      wallpaperColor ??
      switch (wallCondition) {
        SurfaceCondition.raw => DesignTokens.roomState.korobka,
        SurfaceCondition.plastered => DesignTokens.roomState.suvoq,
        SurfaceCondition.puttied => DesignTokens.roomState.shpaklovka,
      };

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        return Stack(
          children: [
            // Sky/ceiling (roofless-style top, per spec's hero imagery).
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: h * 0.18,
              child: Container(color: const Color(0xFFEEF1F7)),
            ),
            // Back wall — a drop target when [onBackWallDrop] is set.
            Positioned(
              top: h * 0.18,
              left: w * 0.15,
              right: w * 0.15,
              height: h * 0.5,
              child: onBackWallDrop == null
                  ? Container(color: _wallColor)
                  : DragTarget<RailItem>(
                      onWillAcceptWithDetails: (_) => true,
                      onAcceptWithDetails: (details) =>
                          onBackWallDrop!(details.data),
                      builder: (context, candidateData, rejectedData) {
                        final isHovering = candidateData.isNotEmpty;
                        return Container(
                          decoration: BoxDecoration(
                            color: _wallColor,
                            border: isHovering
                                ? Border.all(
                                    color: DesignTokens.primaryBlue,
                                    width: 3,
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
            ),
            // Back wall window.
            Positioned(
              top: h * 0.28,
              left: w * 0.42,
              width: w * 0.16,
              height: h * 0.2,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFBFDBFE),
                  border: Border.all(color: DesignTokens.white, width: 3),
                ),
              ),
            ),
            // Left wall (angled via a skewed clip).
            Positioned(
              top: h * 0.18,
              left: 0,
              width: w * 0.16,
              height: h * 0.5,
              child: ClipPath(
                clipper: _LeftWallClipper(),
                child: Container(color: _wallColor.withValues(alpha: 0.85)),
              ),
            ),
            // Right wall.
            Positioned(
              top: h * 0.18,
              right: 0,
              width: w * 0.16,
              height: h * 0.5,
              child: ClipPath(
                clipper: _RightWallClipper(),
                child: Container(color: _wallColor.withValues(alpha: 0.85)),
              ),
            ),
            // Floor (perspective trapezoid).
            Positioned(
              top: h * 0.68,
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipPath(
                clipper: _FloorClipper(),
                child: Container(color: floorColor ?? const Color(0xFFE7D9BF)),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LeftWallClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..moveTo(0, 0)
    ..lineTo(size.width, size.height * 0.1)
    ..lineTo(size.width, size.height * 0.9)
    ..lineTo(0, size.height)
    ..close();

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _RightWallClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..moveTo(size.width, 0)
    ..lineTo(0, size.height * 0.1)
    ..lineTo(0, size.height * 0.9)
    ..lineTo(size.width, size.height)
    ..close();

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _FloorClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..moveTo(size.width * 0.15, 0)
    ..lineTo(size.width * 0.85, 0)
    ..lineTo(size.width, size.height)
    ..lineTo(0, size.height)
    ..close();

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
