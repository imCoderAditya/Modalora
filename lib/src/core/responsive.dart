import 'package:flutter/widgets.dart';

/// Supported device form factors for adaptive modal rendering.
enum ModaloraDeviceType {
  /// Mobile handheld phones (width <= 600dp).
  mobile,

  /// Tablets and foldables (600dp < width <= 1024dp).
  tablet,

  /// Desktop monitors and laptops (width > 1024dp).
  desktop,

  /// Browser canvas.
  web;
}

/// Defines responsive viewport width breakpoints.
class ModaloraBreakpoints {
  /// Creates responsive screen width breakpoint thresholds.
  const ModaloraBreakpoints({
    this.mobileMax = 600,
    this.tabletMax = 1024,
  });

  /// Maximum screen width considered as mobile (default: 600.0).
  final double mobileMax;

  /// Maximum screen width considered as tablet (default: 1024.0).
  final double tabletMax;

  /// Resolves the current device type category for a given [BuildContext].
  ModaloraDeviceType resolve(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= mobileMax) {
      return ModaloraDeviceType.mobile;
    } else if (width <= tabletMax) {
      return ModaloraDeviceType.tablet;
    } else {
      return ModaloraDeviceType.desktop;
    }
  }
}

/// Strategy for adaptive modal presentations.
enum ModaloraAdaptiveMode {
  /// Automatic conversion: BottomSheet on Mobile, Centered Dialog on Tablet/Desktop.
  auto,

  /// Always use bottom sheet regardless of screen size.
  bottomSheet,

  /// Always use center dialog regardless of screen size.
  dialog,

  /// Side drawer modal on large screens, bottom sheet on mobile.
  sidePanelOnDesktop;
}
