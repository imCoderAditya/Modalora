import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modalora/modalora.dart';

void main() {
  testWidgets('Modalora.loading shows spinner and dismisses via handle', (tester) async {
    ModaloraOverlayHandle? handle;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  handle = Modalora.loading(
                    context: context,
                    title: 'Synchronizing...',
                    message: 'Please wait a moment',
                  );
                },
                child: const Text('Start Sync'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Start Sync'));
    await tester.pump();

    expect(find.text('Synchronizing...'), findsOneWidget);
    expect(find.text('Please wait a moment'), findsOneWidget);

    expect(handle, isNotNull);
    await handle!.dismiss();
    await tester.pumpAndSettle();

    expect(find.text('Synchronizing...'), findsNothing);
  });
}
