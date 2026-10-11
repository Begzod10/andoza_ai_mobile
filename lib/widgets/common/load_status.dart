import 'package:flutter/material.dart';

import '../../config/design_tokens.dart';
import 'error_view.dart';

/// What to show instead of a list whose source hasn't delivered yet, so an
/// empty list is never mistaken for "there is nothing here": a spinner while
/// loading, [ErrorView] with retry when the request failed. Returns null once
/// the list has data — or is genuinely, successfully empty — and the caller
/// renders its own content (or its own "no results" text).
Widget? loadStatus({
  required bool isEmpty,
  required bool loading,
  required Object? error,
  required VoidCallback onRetry,
}) {
  if (!isEmpty) return null;
  if (error != null) return ErrorView(error: error, onRetry: onRetry);
  if (loading) {
    return const Padding(
      padding: EdgeInsets.all(DesignTokens.spacingXl),
      child: Center(child: CircularProgressIndicator()),
    );
  }
  return null;
}
