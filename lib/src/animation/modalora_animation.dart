import 'package:flutter/widgets.dart';
import 'spring_curve.dart';

/// Supported built-in animation archetypes for entrance and exit transitions.
enum ModaloraAnimationType {
  /// Simple linear/eased opacity fade.
  fade,

  /// Scale zoom in/out transition.
  scale,

  /// Directional slide translation.
  slide,

  /// Combined opacity fade and scale zoom (default for Dialogs and Popups).
  fadeScale,

  /// Combined opacity fade and directional slide (default for Snackbars).
  fadeSlide,

  /// Physics-based spring bounce transition with mass, stiffness, and damping.
  spring,

  /// Instantaneous presentation with zero animation duration.
  none,

  /// Fully customizable transition powered by a custom builder callback.
  custom;
}

/// Slide direction vectors for slide-based transitions.
enum ModaloraSlideDirection {
  /// Translates downwards from top screen edge.
  fromTop,

  /// Translates upwards from bottom screen edge.
  fromBottom,

  /// Translates rightwards from left screen edge.
  fromLeft,

  /// Translates leftwards from right screen edge.
  fromRight;

  /// Returns the corresponding unit offset vector.
  Offset get offset {
    switch (this) {
      case ModaloraSlideDirection.fromTop:
        return const Offset(0, -1);
      case ModaloraSlideDirection.fromBottom:
        return const Offset(0, 1);
      case ModaloraSlideDirection.fromLeft:
        return const Offset(-1, 0);
      case ModaloraSlideDirection.fromRight:
        return const Offset(1, 0);
    }
  }
}

/// Custom builder typedef for user-defined animated transitions.
typedef ModaloraAnimationTransitionBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
);

/// Comprehensive, reusable animation configuration object.
///
/// Encapsulates durations, easing curves, scale ranges, translation offsets,
/// and spring physics presets for all Modalora presentation routes.
class ModaloraAnimation {
  /// Creates an animation configuration instance.
  const ModaloraAnimation({
    this.type = ModaloraAnimationType.fadeScale,
    this.duration = const Duration(milliseconds: 320),
    this.reverseDuration = const Duration(milliseconds: 240),
    this.curve = Curves.easeOutCubic,
    this.reverseCurve = Curves.easeInCubic,
    this.delay = Duration.zero,
    this.slideDirection = ModaloraSlideDirection.fromBottom,
    this.scaleBegin = 0.88,
    this.scaleEnd = 1.0,
    this.slideOffset = const Offset(0, 0.15),
    this.rotationBegin = 0.0,
    this.customBuilder,
  });

  /// The archetype animation algorithm to apply.
  final ModaloraAnimationType type;

  /// Duration of the forward entrance transition.
  final Duration duration;

  /// Duration of the reverse exit transition.
  final Duration reverseDuration;

  /// Easing curve of the forward entrance.
  final Curve curve;

  /// Easing curve of the reverse exit.
  final Curve reverseCurve;

  /// Optional delay before starting the animation.
  final Duration delay;

  /// Direction when using slide animations.
  final ModaloraSlideDirection slideDirection;

  /// Initial scale ratio at the beginning of entrance.
  final double scaleBegin;

  /// Target scale ratio at the end of entrance.
  final double scaleEnd;

  /// Slide translation vector for slide transitions.
  final Offset slideOffset;

  /// Initial rotation angle in radians.
  final double rotationBegin;

  /// Custom transition builder callback for [ModaloraAnimationType.custom].
  final ModaloraAnimationTransitionBuilder? customBuilder;

  /// Simple fade transition constructor.
  factory ModaloraAnimation.fade({
    Duration duration = const Duration(milliseconds: 250),
    Duration reverseDuration = const Duration(milliseconds: 200),
    Curve curve = Curves.easeOut,
    Curve reverseCurve = Curves.easeIn,
  }) {
    return ModaloraAnimation(
      type: ModaloraAnimationType.fade,
      duration: duration,
      reverseDuration: reverseDuration,
      curve: curve,
      reverseCurve: reverseCurve,
    );
  }

  /// Scale transition constructor.
  factory ModaloraAnimation.scale({
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 220),
    Curve curve = Curves.easeOutBack,
    Curve reverseCurve = Curves.easeInBack,
    double scaleBegin = 0.85,
  }) {
    return ModaloraAnimation(
      type: ModaloraAnimationType.scale,
      duration: duration,
      reverseDuration: reverseDuration,
      curve: curve,
      reverseCurve: reverseCurve,
      scaleBegin: scaleBegin,
    );
  }

  /// Slide transition constructor.
  factory ModaloraAnimation.slide({
    Duration duration = const Duration(milliseconds: 320),
    Duration reverseDuration = const Duration(milliseconds: 250),
    Curve curve = Curves.easeOutCubic,
    Curve reverseCurve = Curves.easeInCubic,
    ModaloraSlideDirection direction = ModaloraSlideDirection.fromBottom,
    Offset? customOffset,
  }) {
    return ModaloraAnimation(
      type: ModaloraAnimationType.slide,
      duration: duration,
      reverseDuration: reverseDuration,
      curve: curve,
      reverseCurve: reverseCurve,
      slideDirection: direction,
      slideOffset: customOffset ?? direction.offset,
    );
  }

  /// Combined Fade + Scale transition constructor (default for Dialogs and Popups).
  factory ModaloraAnimation.fadeScale({
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 220),
    Curve curve = Curves.easeOutCubic,
    Curve reverseCurve = Curves.easeInCubic,
    double scaleBegin = 0.92,
  }) {
    return ModaloraAnimation(
      type: ModaloraAnimationType.fadeScale,
      duration: duration,
      reverseDuration: reverseDuration,
      curve: curve,
      reverseCurve: reverseCurve,
      scaleBegin: scaleBegin,
    );
  }

  /// Combined Fade + Slide transition constructor (default for Snackbars).
  factory ModaloraAnimation.fadeSlide({
    Duration duration = const Duration(milliseconds: 320),
    Duration reverseDuration = const Duration(milliseconds: 240),
    Curve curve = Curves.easeOutCubic,
    Curve reverseCurve = Curves.easeInCubic,
    ModaloraSlideDirection direction = ModaloraSlideDirection.fromBottom,
    Offset? customOffset,
  }) {
    return ModaloraAnimation(
      type: ModaloraAnimationType.fadeSlide,
      duration: duration,
      reverseDuration: reverseDuration,
      curve: curve,
      reverseCurve: reverseCurve,
      slideDirection: direction,
      slideOffset: customOffset ?? (direction == ModaloraSlideDirection.fromBottom ? const Offset(0, 0.25) : const Offset(0, -0.25)),
    );
  }

  /// Physics-based spring transition constructor.
  factory ModaloraAnimation.spring({
    Duration duration = const Duration(milliseconds: 450),
    Duration reverseDuration = const Duration(milliseconds: 250),
    ModaloraSpringCurve curve = ModaloraSpringCurve.gentle,
    double scaleBegin = 0.82,
  }) {
    return ModaloraAnimation(
      type: ModaloraAnimationType.spring,
      duration: duration,
      reverseDuration: reverseDuration,
      curve: curve,
      reverseCurve: Curves.easeInCubic,
      scaleBegin: scaleBegin,
    );
  }

  /// Instantaneous zero-animation constructor.
  factory ModaloraAnimation.none() {
    return const ModaloraAnimation(
      type: ModaloraAnimationType.none,
      duration: Duration.zero,
      reverseDuration: Duration.zero,
    );
  }

  /// Fully custom animation builder constructor.
  factory ModaloraAnimation.custom({
    required ModaloraAnimationTransitionBuilder builder,
    Duration duration = const Duration(milliseconds: 320),
    Duration reverseDuration = const Duration(milliseconds: 240),
  }) {
    return ModaloraAnimation(
      type: ModaloraAnimationType.custom,
      duration: duration,
      reverseDuration: reverseDuration,
      customBuilder: builder,
    );
  }

  /// Creates a clone with selectively overridden parameters.
  ModaloraAnimation copyWith({
    ModaloraAnimationType? type,
    Duration? duration,
    Duration? reverseDuration,
    Curve? curve,
    Curve? reverseCurve,
    Duration? delay,
    ModaloraSlideDirection? slideDirection,
    double? scaleBegin,
    double? scaleEnd,
    Offset? slideOffset,
    double? rotationBegin,
    ModaloraAnimationTransitionBuilder? customBuilder,
  }) {
    return ModaloraAnimation(
      type: type ?? this.type,
      duration: duration ?? this.duration,
      reverseDuration: reverseDuration ?? this.reverseDuration,
      curve: curve ?? this.curve,
      reverseCurve: reverseCurve ?? this.reverseCurve,
      delay: delay ?? this.delay,
      slideDirection: slideDirection ?? this.slideDirection,
      scaleBegin: scaleBegin ?? this.scaleBegin,
      scaleEnd: scaleEnd ?? this.scaleEnd,
      slideOffset: slideOffset ?? this.slideOffset,
      rotationBegin: rotationBegin ?? this.rotationBegin,
      customBuilder: customBuilder ?? this.customBuilder,
    );
  }
}
