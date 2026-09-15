import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/screens/auth/login_screen.dart';

import '../support/localized_pump.dart';

void main() {
  Widget wrap() => wrapLocalized(const LoginScreen());

  testWidgets('LoginScreen builds and shows its core (phone-OTP) fields', (tester) async {
    await tester.pumpWidget(wrap());
    await tester.pumpAndSettle();

    // Greeting + rebranded subtitle.
    expect(find.text('👋 Salom'), findsOneWidget);
    expect(find.text('Andoza AI-ga xush kelibsiz'), findsOneWidget);
    // Phone field (matched by its hint), the OTP submit, and the username fallback.
    expect(find.widgetWithText(TextField, '90 123 45 67'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'OTP Yuborish'), findsOneWidget);
    expect(find.textContaining('Username bilan kirish'), findsOneWidget);
  });

  testWidgets('OTP submit with an empty phone surfaces a validation error', (tester) async {
    await tester.pumpWidget(wrap());
    await tester.pumpAndSettle();

    // Empty phone fails validation before any network call → inline error.
    await tester.tap(find.widgetWithText(ElevatedButton, 'OTP Yuborish'));
    await tester.pump();

    expect(find.textContaining("Telefon raqam noto'g'ri"), findsOneWidget);
  });

  testWidgets('"Username bilan kirish" switches to the username/password form', (tester) async {
    await tester.pumpWidget(wrap());
    await tester.pumpAndSettle();

    final usernameBtn = find.textContaining('Username bilan kirish');
    await tester.ensureVisible(usernameBtn); // it's below the fold in the test viewport
    await tester.pumpAndSettle();
    await tester.tap(usernameBtn);
    await tester.pumpAndSettle();

    expect(find.text('Kirish'), findsWidgets); // heading + button
    expect(find.widgetWithText(TextField, 'Username'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Parol'), findsOneWidget);
  });
}
