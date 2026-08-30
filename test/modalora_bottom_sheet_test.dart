import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modalora/modalora.dart';

void main() {
  testWidgets('Modalora.bottomSheet renders with title, message and custom content', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  Modalora.bottomSheet(
                    context: context,
                    title: 'Filter Options',
                    message: 'Select your preferred sorting criteria',
                    child: const Text('Filter list child widget'),
                  );
                },
                child: const Text('Open Sheet'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open Sheet'));
    await tester.pumpAndSettle();

    expect(find.text('Filter Options'), findsOneWidget);
    expect(find.text('Select your preferred sorting criteria'), findsOneWidget);
    expect(find.text('Filter list child widget'), findsOneWidget);
  });
}
