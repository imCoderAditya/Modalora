import 'package:flutter/widgets.dart';
import 'modalora_animation.dart';

/// Wraps content in the configured [ModaloraAnimation] transitions.
///
/// Handles transformation synthesis across Fade, Scale, Slide, FadeScale,
/// FadeSlide, Spring physics, and custom transition builders.
class ModaloraAnimationWrapper extends StatelessWidget {
  /// Creates an animation wrapper widget.
  const ModaloraAnimationWrapper({
    super.key,
    required this.animation,
    required this.config,
    required this.child,
    this.secondaryAnimation,
  });

  /// Primary entrance/exit animation controller progress.
  final Animation<double> animation;

  /// Secondary transition animation (e.g., when covered by another route).
  final Animation<double>? secondaryAnimation;

  /// The animation configuration recipe.
  final ModaloraAnimation config;

  /// The child widget to be animated.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // 1. Pass-through without modifications if animation is disabled
    if (config.type == ModaloraAnimationType.none) {
      return child;
    }

    // 2. Delegate to custom transition builder if provided
    if (config.type == ModaloraAnimationType.custom && config.customBuilder != null) {
      return config.customBuilder!(
        context,
        animation,
        secondaryAnimation ?? kAlwaysDismissedAnimation,
        child,
      );
    }

    Widget current = child;

    // 3. Apply standard archetype transition transformations
    switch (config.type) {
      case ModaloraAnimationType.fade:
        current = FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0)
              .chain(CurveTween(curve: config.curve))
              .animate(animation),
          child: current,
        );
        break;

      case ModaloraAnimationType.scale:
        current = ScaleTransition(
          scale: Tween<double>(begin: config.scaleBegin, end: config.scaleEnd)
              .chain(CurveTween(curve: config.curve))
              .animate(animation),
          child: current,
        );
        break;

      case ModaloraAnimationType.slide:
        current = SlideTransition(
          position: Tween<Offset>(begin: config.slideOffset, end: Offset.zero)
              .chain(CurveTween(curve: config.curve))
              .animate(animation),
          child: current,
        );
        break;

      case ModaloraAnimationType.fadeScale:
        current = FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0)
              .chain(CurveTween(curve: Curves.easeOut))
              .animate(animation),
          child: ScaleTransition(
            scale: Tween<double>(begin: config.scaleBegin, end: config.scaleEnd)
                .chain(CurveTween(curve: config.curve))
                .animate(animation),
            child: current,
          ),
        );
        break;

      case ModaloraAnimationType.fadeSlide:
        current = FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0)
              .chain(CurveTween(curve: Curves.easeOut))
              .animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(begin: config.slideOffset, end: Offset.zero)
                .chain(CurveTween(curve: config.curve))
                .animate(animation),
            child: current,
          ),
        );
        break;

      case ModaloraAnimationType.spring:
        current = FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0)
              .chain(CurveTween(curve: const Interval(0.0, 0.4, curve: Curves.easeOut)))
              .animate(animation),
          child: ScaleTransition(
            scale: Tween<double>(begin: config.scaleBegin, end: config.scaleEnd)
                .chain(CurveTween(curve: config.curve))
                .animate(animation),
            child: current,
          ),
        );
        break;

      case ModaloraAnimationType.none:
      case ModaloraAnimationType.custom:
        break;
    }

    // 4. Optionally apply rotation transition if specified
    if (config.rotationBegin != 0.0) {
      current = RotationTransition(
        turns: Tween<double>(begin: config.rotationBegin, end: 0.0)
            .chain(CurveTween(curve: config.curve))
            .animate(animation),
        child: current,
      );
    }

    return current;
  }
}
