import 'package:flutter/widgets.dart';
import '../theme/modalora_theme_data.dart';
import 'responsive.dart';

/// Global configuration singleton registry for the Modalora Overlay Experience System.
///
/// Stores global navigator keys for contextless modal dispatching, default themes,
/// responsive screen breakpoints, and adaptive presentation modes.
class ModaloraConfig {
  ModaloraConfig._();

  /// Internal global navigator key reference.
  static GlobalKey<NavigatorState>? _navigatorKey;

  /// Internal global theme override reference.
  static ModaloraThemeData? _theme;

  /// Internal responsive device breakpoint configurations.
  static ModaloraBreakpoints _breakpoints = const ModaloraBreakpoints();

  /// Internal adaptive modal presentation strategy.
  static ModaloraAdaptiveMode _adaptiveMode = ModaloraAdaptiveMode.auto;

  /// Global Navigator key used for context-free overlay invocations.
  static GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  /// Globally configured [ModaloraThemeData] theme applied across all dialogs, sheets, and menus.
  static ModaloraThemeData? get theme => _theme;

  /// Globally configured screen breakpoints for responsive mobile/tablet/desktop branching.
  static ModaloraBreakpoints get breakpoints => _breakpoints;

  /// Globally configured adaptive modal presentation strategy (auto, bottomSheet, dialog).
  static ModaloraAdaptiveMode get adaptiveMode => _adaptiveMode;

  /// Globally configures default runtime settings for Modalora.
  static void configure({
    GlobalKey<NavigatorState>? navigatorKey,
    ModaloraThemeData? theme,
    ModaloraBreakpoints? breakpoints,
    ModaloraAdaptiveMode? adaptiveMode,
  }) {
    if (navigatorKey != null) _navigatorKey = navigatorKey;
    if (theme != null) _theme = theme;
    if (breakpoints != null) _breakpoints = breakpoints;
    if (adaptiveMode != null) _adaptiveMode = adaptiveMode;
  }

  /// Resets all global configurations back to default out-of-the-box state.
  static void reset() {
    _navigatorKey = null;
    _theme = null;
    _breakpoints = const ModaloraBreakpoints();
    _adaptiveMode = ModaloraAdaptiveMode.auto;
  }
}
