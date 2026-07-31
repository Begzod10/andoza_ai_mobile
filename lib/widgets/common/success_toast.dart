import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';

/// Reusable success toast notification
class SuccessToast {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: DesignTokens.white,
              size: 20,
            ),
            const SizedBox(width: DesignTokens.spacing12),
            Expanded(
              child: Text(
                message,
                style: DesignTokens.bodyMedium.copyWith(
                  color: DesignTokens.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: DesignTokens.success,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(DesignTokens.spacing16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
