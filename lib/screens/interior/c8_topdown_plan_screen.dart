import 'package:flutter/material.dart';

import '../studio/studio_redirect_view.dart';

/// C8 (Tepadan/3D/Aylanish reja) — deferred to the web 3D Studio.
///
/// This native screen offered a top-down plan plus "3D"/"Aylanish" toggles that
/// only ever fell back to a flat [RoomPerspectiveView] placeholder (there is no
/// native 3D engine). The real 3D/top-down viewing happens in the embedded web
/// Studio, so entering C8 now forwards straight into it via [StudioRedirectView]
/// for the current room.
class C8TopdownPlanScreen extends StatelessWidget {
  const C8TopdownPlanScreen({super.key});

  @override
  Widget build(BuildContext context) => const StudioRedirectView();
}
