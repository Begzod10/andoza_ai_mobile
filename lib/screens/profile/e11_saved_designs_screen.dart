import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';
import '../../widgets/empty_state_pattern.dart';

/// E11: Saqlangan dizaynlar — hosts the reusable [EmptyStatePattern] for
/// the "Saqlangan dizayn yo'q" case. No saved-design persistence exists
/// yet in this rebuild pass, so this screen always shows the empty state.
class E11SavedDesignsScreen extends StatelessWidget {
  const E11SavedDesignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        title: const Text('Saqlangan dizaynlar', style: DesignTokens.heading3),
      ),
      body: const Padding(
        padding: EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
        child: Center(
          child: EmptyStatePattern(
            icon: Icons.bookmark_border,
            title: 'Saqlangan dizayn yo\'q',
            message: 'Yoqqan dizaynlaringizni shu yerda saqlab qo\'ying',
          ),
        ),
      ),
    );
  }
}
