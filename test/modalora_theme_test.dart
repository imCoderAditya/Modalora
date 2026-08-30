import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modalora/modalora.dart';

void main() {
  group('ModaloraThemeData', () {
    test('light theme creates expected default palette', () {
      final lightTheme = ModaloraThemeData.light();
      expect(lightTheme.brightness, Brightness.light);
      expect(lightTheme.isDark, isFalse);
      expect(lightTheme.primaryColor, const Color(0xFF4F46E5));
      expect(lightTheme.dialogTheme.titleStyle?.fontWeight, FontWeight.w700);
      expect(lightTheme.bottomSheetTheme.showDragHandle, isTrue);
    });

    test('dark theme creates expected default palette', () {
      final darkTheme = ModaloraThemeData.dark();
      expect(darkTheme.brightness, Brightness.dark);
      expect(darkTheme.isDark, isTrue);
      expect(darkTheme.backgroundColor, const Color(0xFF09090B));
      expect(darkTheme.surfaceColor, const Color(0xF018181B));
    });

    test('copyWith properly overrides individual fields', () {
      final base = ModaloraThemeData.dark();
      final customized = base.copyWith(
        primaryColor: Colors.amber,
        defaultElevation: 20.0,
      );

      expect(customized.primaryColor, Colors.amber);
      expect(customized.defaultElevation, 20.0);
      expect(customized.backgroundColor, base.backgroundColor);
    });
  });

  group('ModaloraTheme InheritedWidget and Priority Cascade', () {
    testWidgets('resolves nearest ModaloraTheme over global config', (tester) async {
      ModaloraConfig.configure(
        theme: ModaloraThemeData.light(primaryColor: Colors.red),
      );

      final localTheme = ModaloraThemeData.dark(primaryColor: Colors.green);

      late ModaloraThemeData resolvedTheme;

      await tester.pumpWidget(
        MaterialApp(
          home: ModaloraTheme(
            data: localTheme,
            child: Builder(
              builder: (context) {
                resolvedTheme = ModaloraTheme.of(context);
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      expect(resolvedTheme.primaryColor, Colors.green);
      expect(resolvedTheme.isDark, isTrue);

      ModaloraConfig.reset();
    });
  });
}
