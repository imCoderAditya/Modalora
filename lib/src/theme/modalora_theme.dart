import 'package:flutter/material.dart';
import '../core/config.dart';
import 'modalora_theme_data.dart';
export 'modalora_theme_data.dart';

/// InheritedWidget providing [ModaloraThemeData] down the widget tree.
class ModaloraTheme extends InheritedWidget {
  const ModaloraTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The theme data provided to descendant widgets.
  final ModaloraThemeData data;

  /// Retrieves the ambient [ModaloraThemeData].
  ///
  /// Priority:
  /// 1. Nearest ancestor [ModaloraTheme] widget.
  /// 2. Global [ModaloraConfig.theme].
  /// 3. Ambient Flutter [Theme.of(context).brightness].
  /// 4. Fallback matching system [MediaQuery.platformBrightnessOf(context)].
  static ModaloraThemeData of(BuildContext? context) {
    if (context != null) {
      try {
        final inherited = context.dependOnInheritedWidgetOfExactType<ModaloraTheme>();
        if (inherited != null) {
          return inherited.data;
        }
      } catch (_) {}
    }

    if (ModaloraConfig.theme != null) {
      return ModaloraConfig.theme!;
    }

    if (context != null) {
      try {
        final materialTheme = Theme.of(context);
        return materialTheme.brightness == Brightness.dark
            ? ModaloraThemeData.dark()
            : ModaloraThemeData.light();
      } catch (_) {}

      try {
        final brightness = MediaQuery.maybePlatformBrightnessOf(context) ??
            MediaQuery.maybeOf(context)?.platformBrightness;
        if (brightness != null) {
          return brightness == Brightness.dark
              ? ModaloraThemeData.dark()
              : ModaloraThemeData.light();
        }
      } catch (_) {}
    }

    return ModaloraThemeData.dark();
  }

  @override
  bool updateShouldNotify(ModaloraTheme oldWidget) => data != oldWidget.data;
}
