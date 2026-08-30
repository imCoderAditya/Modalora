import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modalora/modalora.dart';

void main() {
  testWidgets('Modalora3DTiltCard renders child and handles pointer tilt', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Modalora3DTiltCard(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Text('3D Content'),
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('3D Content'), findsOneWidget);

    // Simulate pointer hover/move
    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);
    await gesture.moveTo(tester.getCenter(find.text('3D Content')));
    await tester.pump(const Duration(milliseconds: 150));

    expect(find.text('3D Content'), findsOneWidget);
    await gesture.removePointer();
  });

  testWidgets('Modalora.hologram opens and renders 3D Hologram dialog', (tester) async {
    final navigatorKey = GlobalKey<NavigatorState>();
    Modalora.configure(navigatorKey: navigatorKey);

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  Modalora.hologram(
                    context: context,
                    title: 'Hologram Test',
                    message: '3D Test Message',
                  );
                },
                child: const Text('Open Hologram'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open Hologram'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Hologram Test'), findsOneWidget);
    expect(find.text('3D Test Message'), findsOneWidget);
    expect(find.text('Explore 3D'), findsOneWidget);
    expect(find.text('Dismiss'), findsOneWidget);

    await tester.tap(find.text('Dismiss'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Hologram Test'), findsNothing);
  });
}
