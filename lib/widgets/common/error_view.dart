import 'package:flutter/material.dart';

import '../../config/design_tokens.dart';
import '../../utils/error_mapper.dart';

/// Full-surface error state: an icon, an optional title, a mapped user message
/// and an optional **"Qayta urinish"** (retry) button.
///
/// Pass an [error] object to have the message derived via [mapErrorToMessage],
/// or a ready [message] string to show it verbatim. When [onRetry] is null the
/// button is hidden. Designed to be dropped straight into an
/// `AsyncValue.when(error: ...)` branch or any failed data-loading surface.
class ErrorView extends StatelessWidget {
  const ErrorView({
    this.error,
    this.message,
    this.onRetry,
    this.title,
    this.icon = Icons.cloud_off_outlined,
    super.key,
  });

  /// The caught error; mapped to an Uzbek message when [message] is not given.
  final Object? error;

  /// Explicit message that overrides [error] mapping when provided.
  final String? message;

  /// Retry callback; the button is hidden when null.
  final VoidCallback? onRetry;

  /// Optional bold heading shown above the message.
  final String? title;

  /// Leading icon; defaults to a "cloud off" glyph.
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final text = message ?? mapErrorToMessage(error);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: DesignTokens.iconXl,
              color: DesignTokens.textGray,
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            if (title != null) ...[
              Text(
                title!,
                style: DesignTokens.subtitle1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DesignTokens.spacingSm),
            ],
            Text(
              text,
              style: DesignTokens.body2.copyWith(color: DesignTokens.textGray),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: DesignTokens.spacingLg),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Qayta urinish'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Compact, inline error banner for use inside a list/sheet/card where a
/// full-surface [ErrorView] would be too heavy. Shows the mapped message with
/// an optional inline **"Qayta urinish"** action.
class InlineErrorView extends StatelessWidget {
  const InlineErrorView({
    this.error,
    this.message,
    this.onRetry,
    super.key,
  });

  /// The caught error; mapped to an Uzbek message when [message] is not given.
  final Object? error;

  /// Explicit message that overrides [error] mapping when provided.
  final String? message;

  /// Retry callback; the action is hidden when null.
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final text = message ?? mapErrorToMessage(error);
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        color: DesignTokens.errorRed.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        border: Border.all(
          color: DesignTokens.errorRed.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline,
            size: DesignTokens.iconSm,
            color: DesignTokens.errorRed,
          ),
          const SizedBox(width: DesignTokens.spacingSm),
          Expanded(
            child: Text(
              text,
              style: DesignTokens.body2.copyWith(color: DesignTokens.textDark),
            ),
          ),
          if (onRetry != null)
            TextButton(
              onPressed: onRetry,
              child: const Text('Qayta urinish'),
            ),
        ],
      ),
    );
  }
}
