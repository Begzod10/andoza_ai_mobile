import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamir_uy_mobile_flutter/models/api/api.dart';
import 'package:tamir_uy_mobile_flutter/providers/apartment_provider.dart';
import 'package:tamir_uy_mobile_flutter/screens/home/home_with_projects_screen.dart';

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

void main() {
  testWidgets('HomeWithProjectsScreen renders an overridden apartment name',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          apartmentsProvider
              .overrideWith((ref) async => [_apartment('Mening kvartiram')]),
        ],
        child: const MaterialApp(
          home: Scaffold(body: HomeWithProjectsScreen()),
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
        child: const MaterialApp(
          home: Scaffold(body: HomeWithProjectsScreen()),
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
