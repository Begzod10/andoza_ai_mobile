import 'package:flutter/material.dart';

import '../studio/studio_redirect_view.dart';

/// D1 (Elektr / Yorug'lik / Santexnika) — deferred to the web 3D Studio.
///
/// This native screen drag-placed electrical devices onto a flat
/// [RoomPerspectiveView] placeholder (there is no native 3D engine). The real
/// electrical/lighting placement happens in the embedded web Studio, so entering
/// D1 now forwards straight into it via [StudioRedirectView] for the current
/// room instead of showing the placeholder editor.
class D1ElectricalIntroScreen extends StatelessWidget {
  const D1ElectricalIntroScreen({super.key});

  @override
  Widget build(BuildContext context) => const StudioRedirectView();
}
