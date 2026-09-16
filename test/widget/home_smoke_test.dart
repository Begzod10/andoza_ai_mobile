import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamir_uy_mobile_flutter/models/api/api.dart';
import 'package:tamir_uy_mobile_flutter/models/user_model.dart';
import 'package:tamir_uy_mobile_flutter/providers/apartment_provider.dart';
import 'package:tamir_uy_mobile_flutter/providers/auth_provider.dart';
import 'package:tamir_uy_mobile_flutter/screens/home/home_with_projects_screen.dart';

import '../support/localized_pump.dart';

Apartment _apartment(String name) => Apartment(
      id: 'srv-1',
      userId: 'user-1',
      name: name,
      address: 'Chilonzor',
      createdAt: DateTime(2026, 1, 1),
      renovationStage: 1,
      rooms: [
        RoomOut(
          id: 'room-1',
          apartmentId: 'srv-1',
          name: 'Xona',
          updatedAt: DateTime(2026, 1, 1),
        ),
      ],
    );

/// Minimal auth notifier that starts in an arbitrary fixed [AuthState], so
/// tests can drive the greeting from [authStateProvider] without a repository.
class _FixedAuthNotifier extends StateNotifier<AuthState> implements AuthNotifier {
  _FixedAuthNotifier(super.state);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('greeting reads the name from authStateProvider (no re-fetch)',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          apartmentsProvider.overrideWith((ref) async => <Apartment>[]),
          authStateProvider.overrideWith(
            (ref) => _FixedAuthNotifier(
              const AuthAuthenticated(
                user: User(id: 'u-1', firstName: 'Begzod'),
                token: 't',
              ),
            ),
          ),
        ],
        child: wrapLocalized(
          const Scaffold(body: HomeWithProjectsScreen()),
          withProviderScope: false,
        ),
      ),
    );
    // HomeEmptyBody runs an infinite story-ring animation, so pump fixed frames
    // instead of settling.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    // The greeting shows the name straight from the auth session.
    expect(find.text('Salom, Begzod! 👋'), findsOneWidget);
  });

  testWidgets('HomeWithProjectsScreen renders an overridden apartment name',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          apartmentsProvider
              .overrideWith((ref) async => [_apartment('Mening kvartiram')]),
        ],
        child: wrapLocalized(
          const Scaffold(body: HomeWithProjectsScreen()),
          withProviderScope: false,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // The active-project card shows the apartment's name and the resume CTA.
    expect(find.text('Mening kvartiram'), findsOneWidget);
    expect(find.text('Davom etish'), findsOneWidget);
  });

  testWidgets('HomeWithProjectsScreen shows the empty state with no projects',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          apartmentsProvider.overrideWith((ref) async => <Apartment>[]),
        ],
        child: wrapLocalized(
          const Scaffold(body: HomeWithProjectsScreen()),
          withProviderScope: false,
        ),
      ),
    );
    // The empty state (HomeEmptyBody) runs an infinite story-ring animation,
    // so pumpAndSettle would never terminate — pump fixed frames instead to
    // let the overridden future resolve.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    // No crash, and the resume CTA is absent because there is no active card.
    expect(find.text('Davom etish'), findsNothing);
  });
}
