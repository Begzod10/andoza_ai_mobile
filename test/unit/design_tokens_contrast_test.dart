import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/config/design_tokens.dart';

/// WCAG 2.x contrast ratio between two opaque colours.
double contrast(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
}

/// Muted/hint text is still body text people must read: WCAG AA wants
/// 4.5:1 against the surfaces it sits on (white cards, the light scaffold).
void main() {
  const surfaces = {
    'white': DesignTokens.white,
    'backgroundLight': DesignTokens.backgroundLight,
  };

  for (final s in surfaces.entries) {
    test('textMuted passes WCAG AA on ${s.key}', () {
      expect(contrast(DesignTokens.textMuted, s.value), greaterThanOrEqualTo(4.5));
    });

    test('input hint text passes WCAG AA on ${s.key}', () {
      final hint = AndozaTheme.lightTheme().inputDecorationTheme.hintStyle!.color!;
      expect(contrast(hint, s.value), greaterThanOrEqualTo(4.5));
    });
  }

  test('textMuted stays lighter than textGray so the hierarchy survives', () {
    expect(
      DesignTokens.textMuted.computeLuminance(),
      greaterThan(DesignTokens.textGray.computeLuminance()),
    );
  });
}
