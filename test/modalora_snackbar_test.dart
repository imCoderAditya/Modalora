import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modalora/modalora.dart';

void main() {
  testWidgets('Modalora.snackbar queues and displays toast message', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  Modalora.snackbar(
                    context: context,
                    title: 'Update Available',
                    message: 'A new version has been downloaded.',
                    actionLabel: 'Restart',
                  );
                },
                child: const Text('Trigger Toast'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Trigger Toast'));
    // Pump enough for the entrance transition without expiring the 4-second auto-close timer
    await tester.pump(const Duration(milliseconds: 350));

    expect(find.text('Update Available'), findsOneWidget);
    expect(find.text('A new version has been downloaded.'), findsOneWidget);
    expect(find.text('Restart'), findsOneWidget);

    await Modalora.dismissAll();
    await tester.pumpAndSettle();
    expect(find.text('Update Available'), findsNothing);
  });
}
