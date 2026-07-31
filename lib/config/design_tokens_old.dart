import 'package:flutter/material.dart';

class DesignTokens {
  // AndozaAI Design System Colors
  static const Color primaryBlue = Color(0xFF1E3A8A);
  static const Color accentOrange = Color(0xFFF97316);
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color darkBg = Color(0xFF1A2340);
  static const Color textGray = Color(0xFF5A6785);
  static const Color textDark = Color(0xFF1A2340);

  // Legacy Colors (for compatibility)
  static const Color primary = Color(0xFF1E3A8A);
  static const Color primaryLight = Color(0xFFEEF1F8);
  static const Color primaryDark = Color(0xFF1E3A8A);

  static const Color secondary = Color(0xFFF97316);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFF9FAFB);
  static const Color surfaceDim = Color(0xFFF3F4F6);

  static const Color text = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);

  static const Color border = Color(0xFFE5E7EB);
  static const Color borderLight = Color(0xFFF3F4F6);

  // Spacing
  static const double spacing2 = 2.0;
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;

  // Typography
  static const TextStyle headingXL = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static const TextStyle headingLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static const TextStyle headingSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.5,
  );

  // Border radius
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusRound = 9999.0;

  // Shadows
  static final BoxShadow shadowSmall = BoxShadow(
    color: const Color(0x00000000).withOpacity(0.05),
    blurRadius: 2,
    offset: const Offset(0, 1),
  );

  static final BoxShadow shadowMedium = BoxShadow(
    color: const Color(0x00000000).withOpacity(0.1),
    blurRadius: 4,
    offset: const Offset(0, 2),
  );

  static final BoxShadow shadowLarge = BoxShadow(
    color: const Color(0x00000000).withOpacity(0.15),
    blurRadius: 8,
    offset: const Offset(0, 4),
  );
}

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: DesignTokens.primary,
      scaffoldBackgroundColor: DesignTokens.surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: DesignTokens.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: DesignTokens.text),
        titleTextStyle: DesignTokens.headingMedium,
      ),
      textTheme: const TextTheme(
        headlineLarge: DesignTokens.headingLarge,
        headlineMedium: DesignTokens.headingMedium,
        headlineSmall: DesignTokens.headingSmall,
        titleLarge: DesignTokens.bodyLarge,
        bodyLarge: DesignTokens.bodyLarge,
        bodyMedium: DesignTokens.bodyMedium,
        bodySmall: DesignTokens.bodySmall,
        labelMedium: DesignTokens.labelMedium,
      ),
      colorScheme: ColorScheme.light(
        primary: DesignTokens.primary,
        secondary: DesignTokens.secondary,
        error: DesignTokens.error,
        surface: DesignTokens.surface,
      ),
    );
  }
}
