import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modalora/modalora.dart';

void main() {
  testWidgets('Modalora.dialog renders title, message and responds to action tap', (tester) async {
    bool confirmed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  Modalora.dialog(
                    context: context,
                    title: 'Confirm Delete',
                    message: 'Are you sure you want to delete this?',
                    primaryAction: ModaloraButton(
                      label: 'Delete',
                      variant: ModaloraButtonVariant.destructive,
                      onPressed: () {
                        confirmed = true;
                        Navigator.of(context).pop();
                      },
                    ),
                    secondaryAction: const ModaloraButton(
                      label: 'Cancel',
                      variant: ModaloraButtonVariant.secondary,
                    ),
                  );
                },
                child: const Text('Open Dialog'),
              );
            },
          ),
        ),
      ),
    );

    // Tap button to open dialog
    await tester.tap(find.text('Open Dialog'));
    await tester.pumpAndSettle();

    // Verify dialog contents are rendered
    expect(find.text('Confirm Delete'), findsOneWidget);
    expect(find.text('Are you sure you want to delete this?'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);

    // Tap Delete button
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(confirmed, isTrue);
    expect(find.text('Confirm Delete'), findsNothing);
  });

  testWidgets('Modalora.dialog renders custom widget child', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  Modalora.dialog(
                    context: context,
                    child: const Text('Completely Custom Content', key: Key('custom-content')),
                  );
                },
                child: const Text('Open Custom Dialog'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open Custom Dialog'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('custom-content')), findsOneWidget);
    expect(find.text('Completely Custom Content'), findsOneWidget);
  });
}
