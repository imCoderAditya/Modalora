import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modalora_example/main.dart';

void main() {
  testWidgets('ModaloraShowcaseApp builds and displays interactive sections', (tester) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const ModaloraShowcaseApp());
    await tester.pumpAndSettle();

    expect(find.text('Modalora'), findsOneWidget);
    expect(find.text('1. Modern BottomSheet Studio'), findsOneWidget);
    expect(find.text('2. Dialog & Modal Engine'), findsOneWidget);
    expect(find.text('Standard Modal'), findsOneWidget);
    expect(find.text('Apple iOS Share Sheet'), findsOneWidget);

    // Tap Section 1 Share Sheet
    await tester.tap(find.text('Open Share Sheet'));
    await tester.pumpAndSettle();

    expect(find.text('Share Document'), findsOneWidget);
    expect(find.text('AirDrop'), findsOneWidget);

    // Tap outside to dismiss
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(find.text('Share Document'), findsNothing);
  });
}
