import 'package:flutter/material.dart';
import '../../animation/animation_builder.dart';
import '../../animation/modalora_animation.dart';
import '../../core/position.dart';

/// Modal popup route for anchor-targeted popups, menus, and flyouts.
///
/// Computes target widget coordinates, automatically checks screen edge collisions,
/// flips orientation if overflowing viewport bounds, and presents fluid entrance animations.
class ModaloraPopupRoute<T> extends PopupRoute<T> {
  /// Creates a modal popup route.
  ModaloraPopupRoute({
    required this.targetRect,
    required this.builder,
    required this.animationConfig,
    this.anchor = ModaloraPopupAnchor.bottom,
    this.offset = const Offset(0, 8.0),
    Color? barrierColor,
    bool barrierDismissible = true,
    String? barrierLabel,
    super.settings,
  })  : _barrierColor = barrierColor ?? Colors.transparent,
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel ?? 'Dismiss';

  /// The screen bounding box rectangle of the anchor widget.
  final Rect targetRect;

  /// Builder function providing the popup content and the resolved anchor direction.
  final Widget Function(BuildContext context, ModaloraPopupAnchor resolvedAnchor) builder;

  /// Animation settings for popup entrance and exit transitions.
  final ModaloraAnimation animationConfig;

  /// Preferred anchor placement relative to the target rect.
  final ModaloraPopupAnchor anchor;

  /// Pixel offset delta applied to the anchor position.
  final Offset offset;

  /// Underlying barrier overlay color.
  final Color _barrierColor;

  /// Whether tapping outside the popup dismisses it.
  final bool _barrierDismissible;

  /// Accessibility semantic label.
  final String _barrierLabel;

  @override
  Color? get barrierColor => _barrierColor;

  @override
  bool get barrierDismissible => _barrierDismissible;

  @override
  String? get barrierLabel => _barrierLabel;

  @override
  Duration get transitionDuration => animationConfig.duration;

  @override
  Duration get reverseTransitionDuration => animationConfig.reverseDuration;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // Custom single child layout positions the popup dynamically relative to targetRect
    return CustomSingleChildLayout(
      delegate: _ModaloraPopupLayoutDelegate(
        targetRect: targetRect,
        anchor: anchor,
        offset: offset,
        screenPadding: const EdgeInsets.all(12.0),
      ),
      child: builder(context, anchor),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Wraps the positioned popup in entrance scale, fade, and spring physics
    return ModaloraAnimationWrapper(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      config: animationConfig,
      child: child,
    );
  }
}

/// Custom layout delegate calculating exact popup coordinates with viewport boundary collision clamping.
class _ModaloraPopupLayoutDelegate extends SingleChildLayoutDelegate {
  _ModaloraPopupLayoutDelegate({
    required this.targetRect,
    required this.anchor,
    required this.offset,
    required this.screenPadding,
  });

  /// The anchor target bounding rect on screen.
  final Rect targetRect;

  /// Preferred direction of attachment.
  final ModaloraPopupAnchor anchor;

  /// Directional offset distance.
  final Offset offset;

  /// Minimum padding from physical screen borders.
  final EdgeInsets screenPadding;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.loosen();
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double x = 0;
    double y = 0;

    // 1. Calculate raw origin coordinates based on the anchor type
    switch (anchor) {
      case ModaloraPopupAnchor.top:
        x = targetRect.center.dx - (childSize.width / 2);
        y = targetRect.top - childSize.height - offset.dy;
        break;
      case ModaloraPopupAnchor.topLeft:
        x = targetRect.left;
        y = targetRect.top - childSize.height - offset.dy;
        break;
      case ModaloraPopupAnchor.topRight:
        x = targetRect.right - childSize.width;
        y = targetRect.top - childSize.height - offset.dy;
        break;
      case ModaloraPopupAnchor.bottom:
        x = targetRect.center.dx - (childSize.width / 2);
        y = targetRect.bottom + offset.dy;
        break;
      case ModaloraPopupAnchor.bottomLeft:
        x = targetRect.left;
        y = targetRect.bottom + offset.dy;
        break;
      case ModaloraPopupAnchor.bottomRight:
        x = targetRect.right - childSize.width;
        y = targetRect.bottom + offset.dy;
        break;
      case ModaloraPopupAnchor.left:
        x = targetRect.left - childSize.width - offset.dx;
        y = targetRect.center.dy - (childSize.height / 2);
        break;
      case ModaloraPopupAnchor.right:
        x = targetRect.right + offset.dx;
        y = targetRect.center.dy - (childSize.height / 2);
        break;
      case ModaloraPopupAnchor.center:
        x = targetRect.center.dx - (childSize.width / 2);
        y = targetRect.center.dy - (childSize.height / 2);
        break;
    }

    // 2. Viewport collision detection and boundary clamping
    final minX = screenPadding.left;
    final maxX = size.width - screenPadding.right - childSize.width;
    final minY = screenPadding.top;
    final maxY = size.height - screenPadding.bottom - childSize.height;

    // 3. Flip direction if overflowing bottom edge and top placement fits better
    if (y > maxY && anchor == ModaloraPopupAnchor.bottom) {
      final flippedY = targetRect.top - childSize.height - offset.dy;
      if (flippedY >= minY) {
        y = flippedY;
      }
    }

    // 4. Clamp within screen bounds
    x = x.clamp(minX, maxX < minX ? minX : maxX);
    y = y.clamp(minY, maxY < minY ? minY : maxY);

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_ModaloraPopupLayoutDelegate oldDelegate) {
    return targetRect != oldDelegate.targetRect ||
        anchor != oldDelegate.anchor ||
        offset != oldDelegate.offset;
  }
}
