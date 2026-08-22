import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/utils/error_mapper.dart';
import 'package:tamir_uy_mobile_flutter/widgets/common/error_view.dart';

/// Pumps [child] inside the minimal Material context these views need
/// (they render ElevatedButton/TextButton, which require a Material ancestor).
Future<void> _pump(WidgetTester tester, Widget child) {
  return tester.pumpWidget(
    MaterialApp(home: Scaffold(body: child)),
  );
}

DioException _connectionError() => DioException(
      requestOptions: RequestOptions(path: '/x'),
      type: DioExceptionType.connectionError,
    );

void main() {
  group('ErrorView', () {
    testWidgets('maps a DioException to its Uzbek user message', (tester) async {
      await _pump(tester, ErrorView(error: _connectionError()));
      await tester.pumpAndSettle();

      expect(find.text(errorNoInternet), findsOneWidget);
    });

    testWidgets('an explicit message overrides error mapping', (tester) async {
      await _pump(
        tester,
        ErrorView(error: _connectionError(), message: 'Custom message'),
      );
      await tester.pumpAndSettle();

      expect(find.text('Custom message'), findsOneWidget);
      expect(find.text(errorNoInternet), findsNothing);
    });

    testWidgets('renders the optional title above the message', (tester) async {
      await _pump(
        tester,
        const ErrorView(message: 'Body', title: 'Something broke'),
      );
      await tester.pumpAndSettle();

      expect(find.text('Something broke'), findsOneWidget);
      expect(find.text('Body'), findsOneWidget);
    });

    testWidgets('hides the retry button when onRetry is null', (tester) async {
      await _pump(tester, const ErrorView(message: 'Body'));
      await tester.pumpAndSettle();

      expect(find.text('Qayta urinish'), findsNothing);
      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('shows a retry button that fires the callback', (tester) async {
      var retries = 0;
      await _pump(
        tester,
        ErrorView(message: 'Body', onRetry: () => retries++),
      );
      await tester.pumpAndSettle();

      expect(find.widgetWithText(ElevatedButton, 'Qayta urinish'),
          findsOneWidget);
      await tester.tap(find.text('Qayta urinish'));
      await tester.pump();

      expect(retries, 1);
    });
  });

  group('InlineErrorView', () {
    testWidgets('renders the mapped message', (tester) async {
      await _pump(tester, InlineErrorView(error: _connectionError()));
      await tester.pumpAndSettle();

      expect(find.text(errorNoInternet), findsOneWidget);
    });

    testWidgets('an explicit message overrides error mapping', (tester) async {
      await _pump(
        tester,
        InlineErrorView(error: _connectionError(), message: 'Inline custom'),
      );
      await tester.pumpAndSettle();

      expect(find.text('Inline custom'), findsOneWidget);
      expect(find.text(errorNoInternet), findsNothing);
    });

    testWidgets('hides the retry action when onRetry is null', (tester) async {
      await _pump(tester, const InlineErrorView(message: 'Body'));
      await tester.pumpAndSettle();

      expect(find.byType(TextButton), findsNothing);
    });

    testWidgets('shows an inline retry action that fires the callback',
        (tester) async {
      var retries = 0;
      await _pump(
        tester,
        InlineErrorView(message: 'Body', onRetry: () => retries++),
      );
      await tester.pumpAndSettle();

      expect(
          find.widgetWithText(TextButton, 'Qayta urinish'), findsOneWidget);
      await tester.tap(find.text('Qayta urinish'));
      await tester.pump();

      expect(retries, 1);
    });
  });
}
