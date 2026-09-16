import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/empty_state_pattern.dart';

/// E11: Saqlangan dizaynlar — hosts the reusable [EmptyStatePattern] for
/// the "Saqlangan dizayn yo'q" case. No saved-design persistence exists
/// yet in this rebuild pass, so this screen always shows the empty state.
class E11SavedDesignsScreen extends StatelessWidget {
  const E11SavedDesignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        title: Text(l10n.profileMenuSavedDesigns, style: DesignTokens.heading3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
        child: Center(
          child: EmptyStatePattern(
            icon: Icons.bookmark_border,
            title: l10n.profileSavedDesignsEmptyTitle,
            message: l10n.profileSavedDesignsEmptyMessage,
          ),
        ),
      ),
    );
  }
}
