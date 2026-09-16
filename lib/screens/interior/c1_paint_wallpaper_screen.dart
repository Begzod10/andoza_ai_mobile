import 'package:flutter/material.dart';

import '../studio/studio_redirect_view.dart';

/// C1 (Bo'yoq/Oboi) — deferred to the web 3D Studio.
///
/// This native screen used to paint/wallpaper walls against a flat
/// [RoomPerspectiveView] placeholder (there is no native 3D engine). The real
/// material editing happens in the embedded web Studio, so entering C1 now
/// forwards straight into it via [StudioRedirectView] for the current room
/// instead of showing the placeholder editor.
class C1PaintWallpaperScreen extends StatelessWidget {
  const C1PaintWallpaperScreen({super.key});

  @override
  Widget build(BuildContext context) => const StudioRedirectView();
}
