import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modalora/modalora.dart';

void main() {
  testWidgets('Modalora.menu renders menu items and triggers item tap', (tester) async {
    bool copyTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    Modalora.menu(
                      context: context,
                      items: [
                        ModaloraMenuItem(
                          title: 'Copy',
                          icon: const Icon(Icons.copy),
                          shortcut: '⌘C',
                          onTap: () {
                            copyTapped = true;
                          },
                        ),
                        const ModaloraMenuDivider(),
                        const ModaloraMenuItem(
                          title: 'Delete',
                          icon: Icon(Icons.delete),
                          isDestructive: true,
                        ),
                      ],
                    );
                  },
                  child: const Text('Open Menu'),
                );
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open Menu'));
    await tester.pumpAndSettle();

    expect(find.text('Copy'), findsOneWidget);
    expect(find.text('⌘C'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);

    await tester.tap(find.text('Copy'));
    await tester.pumpAndSettle();

    expect(copyTapped, isTrue);
    expect(find.text('Copy'), findsNothing);
  });
}
