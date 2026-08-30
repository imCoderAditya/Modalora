import 'package:flutter/widgets.dart';

/// Screen positioning anchors used across Modalora components (Popups, Snackbars, Overlays).
enum ModaloraPosition {
  /// Top center anchor.
  top,

  /// Top center anchor.
  topCenter,

  /// Top left anchor.
  topLeft,

  /// Top right anchor.
  topRight,

  /// Bottom center anchor.
  bottom,

  /// Bottom center anchor.
  bottomCenter,

  /// Bottom left anchor.
  bottomLeft,

  /// Bottom right anchor.
  bottomRight,

  /// Screen center anchor.
  center,

  /// Center left anchor.
  left,

  /// Center right anchor.
  right,

  /// User-defined custom coordinate offset.
  custom;

  /// Returns the corresponding standard Flutter [Alignment].
  Alignment toAlignment() {
    switch (this) {
      case ModaloraPosition.top:
      case ModaloraPosition.topCenter:
        return Alignment.topCenter;
      case ModaloraPosition.topLeft:
        return Alignment.topLeft;
      case ModaloraPosition.topRight:
        return Alignment.topRight;
      case ModaloraPosition.bottom:
      case ModaloraPosition.bottomCenter:
        return Alignment.bottomCenter;
      case ModaloraPosition.bottomLeft:
        return Alignment.bottomLeft;
      case ModaloraPosition.bottomRight:
        return Alignment.bottomRight;
      case ModaloraPosition.center:
        return Alignment.center;
      case ModaloraPosition.left:
        return Alignment.centerLeft;
      case ModaloraPosition.right:
        return Alignment.centerRight;
      case ModaloraPosition.custom:
        return Alignment.center;
    }
  }

  /// Whether this position is located at the top half of the screen.
  bool get isTop =>
      this == ModaloraPosition.top ||
      this == ModaloraPosition.topCenter ||
      this == ModaloraPosition.topLeft ||
      this == ModaloraPosition.topRight;

  /// Whether this position is located at the bottom half of the screen.
  bool get isBottom =>
      this == ModaloraPosition.bottom ||
      this == ModaloraPosition.bottomCenter ||
      this == ModaloraPosition.bottomLeft ||
      this == ModaloraPosition.bottomRight;
}

/// Anchor positioning for targeting popups and contextual menus relative to a target element.
enum ModaloraPopupAnchor {
  /// Above the target widget.
  top,

  /// Below the target widget.
  bottom,

  /// To the left of the target widget.
  left,

  /// To the right of the target widget.
  right,

  /// Above and aligned with the left edge of the target widget.
  topLeft,

  /// Above and aligned with the right edge of the target widget.
  topRight,

  /// Below and aligned with the left edge of the target widget.
  bottomLeft,

  /// Below and aligned with the right edge of the target widget.
  bottomRight,

  /// Centered directly over the target widget.
  center;
}
