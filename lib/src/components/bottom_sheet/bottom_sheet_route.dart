import 'dart:ui';
import 'package:flutter/material.dart';
import '../../animation/modalora_animation.dart';

/// Modal popup route for presenting sliding BottomSheets with customizable glassmorphism backdrops.
///
/// Handles backdrop blur transitions, barrier dimming, barrier dismissal taps,
/// and smooth hardware-accelerated slide-up motion anchored by the specified [alignment].
class ModaloraBottomSheetRoute<T> extends PopupRoute<T> {
  /// Creates a modal bottom sheet route.
  ModaloraBottomSheetRoute({
    required this.builder,
    required this.animationConfig,
    this.barrierBlur = 4.0,
    Color? barrierColor,
    bool barrierDismissible = true,
    String? barrierLabel,
    this.alignment = Alignment.bottomCenter,
    super.settings,
  })  : _barrierColor = barrierColor ?? const Color(0x66000000),
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel ?? 'Dismiss';

  /// Widget builder function that constructs the bottom sheet content.
  final WidgetBuilder builder;

  /// Animation configuration specifying duration, reverse duration, and transition curves.
  final ModaloraAnimation animationConfig;

  /// Sigma blur value applied to the backdrop filter behind the bottom sheet.
  final double barrierBlur;

  /// Private color backing the barrier dimming overlay.
  final Color _barrierColor;

  /// Whether tapping the modal barrier dismisses the route.
  final bool _barrierDismissible;

  /// Accessibility semantic label for the barrier.
  final String _barrierLabel;

  /// Viewport alignment for the bottom sheet (defaults to [Alignment.bottomCenter]).
  final AlignmentGeometry alignment;

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
    // Wrap the sheet widget in Semantics for accessibility routing
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: builder(context),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Stack(
      children: [
        // 1. Frosted Backdrop Blur Layer with Fade In/Out Transition
        if (barrierBlur > 0.0)
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

        // 2. Hardware-Accelerated Sliding Animation Anchored to Viewport Alignment
        Align(
          alignment: alignment,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0), // Starts below viewport
              end: Offset.zero,              // Glides to rest position
            ).chain(CurveTween(curve: animationConfig.curve)).animate(animation),
            child: child,
          ),
        ),
      ],
    );
  }
}
