import 'package:flutter/material.dart';

import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';

/// U4/U5 reached without a craftsman (a deep link or a restored route has no
/// `extra`). Used to fall back to "the first usta in the list" — someone else's
/// profile, or a crash when the list was empty.
class MasterNotFoundScreen extends StatelessWidget {
  const MasterNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          l10n.mastersNotFound,
          style: DesignTokens.bodyMedium.copyWith(color: DesignTokens.textGray),
        ),
      ),
    );
  }
}
