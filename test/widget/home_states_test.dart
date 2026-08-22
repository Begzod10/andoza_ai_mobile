import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/screens/home/home_empty_screen.dart';
import 'package:tamir_uy_mobile_flutter/screens/home/home_with_projects_screen.dart';
import 'package:tamir_uy_mobile_flutter/utils/error_mapper.dart';
import 'package:tamir_uy_mobile_flutter/widgets/common/error_view.dart';

/// Wraps the screen under test with a [ProviderScope] that overrides the
/// derived [projectsProvider] with a fixed [AsyncValue], so the screen's
/// loading / error / data branches can be exercised without any network.
Future<void> _pumpWithProjects(
  WidgetTester tester,
  AsyncValue<List<ProjectItem>> value,
) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [projectsProvider.overrideWithValue(value)],
      child: const MaterialApp(
        home: Scaffold(body: HomeWithProjectsScreen()),
      ),
    ),
  );
}

ProjectItem _project(String name) => ProjectItem(
      id: 'p-1',
      name: name,
      location: 'Chilonzor',
      roomCount: 1,
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  testWidgets('loading state shows a progress indicator', (tester) async {
    await _pumpWithProjects(tester, const AsyncLoading());
    // Do NOT settle: a CircularProgressIndicator animates forever.
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('error state shows ErrorView with title, message and retry',
      (tester) async {
    final error = DioException(
      requestOptions: RequestOptions(path: '/apartments'),
      type: DioExceptionType.connectionError,
    );
    await _pumpWithProjects(
      tester,
      AsyncError(error, StackTrace.current),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ErrorView), findsOneWidget);
    expect(find.text('Loyihalarni yuklab bo\'lmadi'), findsOneWidget);
    expect(find.text(errorNoInternet), findsOneWidget);

    // The retry button is present and tapping it does not throw.
    final retry = find.widgetWithText(ElevatedButton, 'Qayta urinish');
    expect(retry, findsOneWidget);
    await tester.tap(retry);
    await tester.pump();
  });

  testWidgets('data state renders the active project and resume CTA',
      (tester) async {
    await _pumpWithProjects(
      tester,
      AsyncData([_project('Mening loyiham')]),
    );
    await tester.pumpAndSettle();

    expect(find.text('Mening loyiham'), findsOneWidget);
    expect(find.text('Davom etish'), findsOneWidget);
    expect(find.byType(ErrorView), findsNothing);
  });

  testWidgets('empty data renders the empty body (no resume CTA)',
      (tester) async {
    await _pumpWithProjects(tester, const AsyncData(<ProjectItem>[]));
    // HomeEmptyBody runs an infinite story-ring animation, so pump fixed
    // frames instead of settling.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.byType(HomeEmptyBody), findsOneWidget);
    expect(find.text('Davom etish'), findsNothing);
  });
}
