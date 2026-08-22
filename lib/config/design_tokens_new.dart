import 'package:flutter/material.dart';

/// AndozaAI Design Tokens
/// Central design system for consistent styling across all screens
class DesignTokens {
  // Color Palette
  static const Color primaryBlue = Color(0xFF1E3A8A);
  static const Color accentOrange = Color(0xFFF97316);
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color darkBg = Color(0xFF1A2340);
  static const Color textGray = Color(0xFF5A6785);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color white = Color(0xFFFFFFFF);
  static const Color errorRed = Color(0xFFEF4444);
  static const Color successGreen = Color(0xFF10B981);
  static const Color warningYellow = Color(0xFFFCD34D);
  static const Color borderGray = Color(0xFFE2E8F0);
  static const Color dividerGray = Color(0xFFCBD5E1);
  static const Color disabledGray = Color(0xFF94A3B8);
  static const Color shadowGray = Color(0xFF0F172A);

  // Typography
  static const String fontFamily = 'Poppins';

  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textDark,
    height: 1.2,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textDark,
    height: 1.2,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textDark,
    height: 1.3,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textDark,
    height: 1.4,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textDark,
    height: 1.4,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: textGray,
    height: 1.5,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textGray,
    height: 1.5,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textGray,
    height: 1.4,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: white,
    height: 1.5,
  );

  // Spacing
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingXxl = 48.0;

  // Border Radius
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radiusFull = 999.0;

  // Shadow
  static const BoxShadow shadowSm = BoxShadow(
    color: Color.fromRGBO(15, 23, 42, 0.08),
    blurRadius: 4.0,
    offset: Offset(0, 1),
  );

  static const BoxShadow shadowMd = BoxShadow(
    color: Color.fromRGBO(15, 23, 42, 0.12),
    blurRadius: 8.0,
    offset: Offset(0, 2),
  );

  static const BoxShadow shadowLg = BoxShadow(
    color: Color.fromRGBO(15, 23, 42, 0.16),
    blurRadius: 16.0,
    offset: Offset(0, 4),
  );

  // Animation Duration
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // Button Sizes
  static const double buttonHeightLarge = 56.0;
  static const double buttonHeightMedium = 48.0;
  static const double buttonHeightSmall = 40.0;
  static const double buttonHeightXs = 32.0;

  // Icon Sizes
  static const double iconXs = 16.0;
  static const double iconSm = 20.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;
  static const double iconXxl = 64.0;
}

/// Theme Data for the app
class AndozaTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: DesignTokens.backgroundLight,
      primaryColor: DesignTokens.primaryBlue,
      colorScheme: ColorScheme.light(
        primary: DesignTokens.primaryBlue,
        secondary: DesignTokens.accentOrange,
        tertiary: DesignTokens.accentOrange,
        surface: DesignTokens.white,
        error: DesignTokens.errorRed,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: DesignTokens.backgroundLight,
        foregroundColor: DesignTokens.textDark,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: DesignTokens.heading3,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DesignTokens.primaryBlue,
          foregroundColor: DesignTokens.white,
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacingLg,
            vertical: DesignTokens.spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          ),
          textStyle: DesignTokens.button,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: DesignTokens.primaryBlue,
          textStyle: DesignTokens.button,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: DesignTokens.primaryBlue,
          side: const BorderSide(color: DesignTokens.primaryBlue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          ),
          textStyle: DesignTokens.button,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DesignTokens.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingMd,
          vertical: DesignTokens.spacingMd,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          borderSide: const BorderSide(color: DesignTokens.borderGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          borderSide: const BorderSide(color: DesignTokens.borderGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          borderSide: const BorderSide(
            color: DesignTokens.primaryBlue,
            width: 2,
          ),
        ),
        hintStyle: DesignTokens.body2.copyWith(
          color: DesignTokens.disabledGray,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: DesignTokens.borderGray,
        disabledColor: DesignTokens.disabledGray,
        selectedColor: DesignTokens.primaryBlue,
        padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spacingSm),
        labelStyle: DesignTokens.body2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: DesignTokens.darkBg,
      primaryColor: DesignTokens.primaryBlue,
      colorScheme: ColorScheme.dark(
        primary: DesignTokens.primaryBlue,
        secondary: DesignTokens.accentOrange,
        tertiary: DesignTokens.accentOrange,
        surface: const Color(0xFF1E2139),
        error: DesignTokens.errorRed,
      ),
    );
  }
}
