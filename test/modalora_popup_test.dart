import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modalora/modalora.dart';

void main() {
  testWidgets('Modalora.popup renders anchored popup near target', (tester) async {
    final anchorKey = GlobalKey();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  key: anchorKey,
                  onPressed: () {
                    Modalora.popup(
                      context: context,
                      anchorKey: anchorKey,
                      title: 'Quick Info',
                      message: 'This is an anchored popup tooltip.',
                    );
                  },
                  child: const Text('Target Button'),
                );
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Target Button'));
    await tester.pumpAndSettle();

    expect(find.text('Quick Info'), findsOneWidget);
    expect(find.text('This is an anchored popup tooltip.'), findsOneWidget);
  });
}
