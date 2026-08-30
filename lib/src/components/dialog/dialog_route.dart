import 'dart:ui';
import 'package:flutter/material.dart';
import '../../animation/animation_builder.dart';
import '../../animation/modalora_animation.dart';

/// Modal dialog route with hardware-accelerated frosted glass backdrop blur and fluid animation physics.
///
/// Implements [PopupRoute] to provide seamless presentation of modal dialogs
/// with customizable entrance/exit animations (spring, zoom, slide, fade).
class ModaloraDialogRoute<T> extends PopupRoute<T> {
  /// Creates a modal dialog route.
  ModaloraDialogRoute({
    required this.builder,
    required this.animationConfig,
    this.barrierBlur = 6.0,
    Color? barrierColor,
    bool barrierDismissible = true,
    String? barrierLabel,
    super.settings,
  })  : _barrierColor = barrierColor ?? const Color(0x66000000),
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel ?? 'Dismiss';

  /// Builder function returning the dialog content widget.
  final WidgetBuilder builder;

  /// Animation parameters defining transition duration, curve, and animation type.
  final ModaloraAnimation animationConfig;

  /// Blur intensity sigma value for the frosted backdrop.
  final double barrierBlur;

  /// Underlying barrier overlay color.
  final Color _barrierColor;

  /// Whether tapping outside the dialog dismisses it.
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
    // Wrap the dialog in Semantics and Center alignment for optimal layout
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: Center(
        child: builder(context),
      ),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // 1. Wrap the dialog child in the configured animation transitions
    Widget result = ModaloraAnimationWrapper(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      config: animationConfig,
      child: child,
    );

    // 2. Render frosted backdrop blur layer if blur > 0
    if (barrierBlur > 0.0) {
      result = Stack(
        children: [
          FadeTransition(
            opacity: animation,
            child: RepaintBoundary(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: barrierBlur,
                  sigmaY: barrierBlur,
                ),
                child: const SizedBox.expand(),
              ),
            ),
          ),
          result,
        ],
      );
    }

    return result;
  }
}
