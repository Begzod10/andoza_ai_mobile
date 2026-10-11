import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

/// Asks before leaving a screen whose edits would be lost — back button, iOS
/// swipe and Android back alike. With no changes it lets the pop through.
///
/// A screen that leaves on purpose after saving should do so with
/// `Navigator.pop` / `context.go` (which skip this guard) or report
/// `hasChanges: false` first.
class UnsavedChangesGuard extends StatelessWidget {
  const UnsavedChangesGuard({
    required this.hasChanges,
    required this.child,
    super.key,
  });

  final bool hasChanges;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !hasChanges,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final leave = await confirmDiscardChanges(context);
        if (leave && context.mounted) Navigator.of(context).pop(result);
      },
      child: child,
    );
  }
}

/// "Saqlanmagan o'zgarishlar — Chiqish / Qolish". True when the user chose to leave.
Future<bool> confirmDiscardChanges(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  final leave = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.unsavedChangesTitle),
      content: Text(l10n.unsavedChangesBody),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: Text(l10n.unsavedChangesStay),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(l10n.unsavedChangesLeave),
        ),
      ],
    ),
  );
  return leave ?? false;
}
