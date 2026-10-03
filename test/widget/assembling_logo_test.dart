import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/widgets/brand/assembling_logo.dart';

Widget _at(double t) => MaterialApp(
      home: Scaffold(
        body: Center(
          child: AssemblingLogo(
            progress: AlwaysStoppedAnimation(t),
            idle: const AlwaysStoppedAnimation(0.5),
          ),
        ),
      ),
    );

void main() {
  testWidgets('builds at every stage of the assembly without errors', (tester) async {
    for (final t in [0.0, 0.1, 0.35, 0.6, 0.85, 0.95, 1.0]) {
      await tester.pumpWidget(_at(t));
      expect(tester.takeException(), isNull, reason: 'progress $t');
    }
  });

  testWidgets('the tools are around the ladder midway and gone once it is built', (tester) async {
    await tester.pumpWidget(_at(0.4));
    expect(find.byType(Icon), findsNWidgets(AssemblingLogo.tools.length));

    await tester.pumpWidget(_at(1.0));
    expect(find.byType(Icon), findsNothing);
  });
}
