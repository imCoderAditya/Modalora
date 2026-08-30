import '../animation/modalora_animation.dart';

/// Theme tokens defining default animations across all Modalora overlays.
class ModaloraAnimationTheme {
  const ModaloraAnimationTheme({
    this.dialogAnimation = const ModaloraAnimation(type: ModaloraAnimationType.fadeScale),
    this.bottomSheetAnimation = const ModaloraAnimation(type: ModaloraAnimationType.slide, slideDirection: ModaloraSlideDirection.fromBottom),
    this.popupAnimation = const ModaloraAnimation(type: ModaloraAnimationType.fadeScale, scaleBegin: 0.95),
    this.menuAnimation = const ModaloraAnimation(type: ModaloraAnimationType.fadeScale, scaleBegin: 0.96),
    this.snackbarAnimation = const ModaloraAnimation(type: ModaloraAnimationType.fadeSlide, slideDirection: ModaloraSlideDirection.fromTop),
    this.overlayAnimation = const ModaloraAnimation(type: ModaloraAnimationType.fade),
  });

  final ModaloraAnimation dialogAnimation;
  final ModaloraAnimation bottomSheetAnimation;
  final ModaloraAnimation popupAnimation;
  final ModaloraAnimation menuAnimation;
  final ModaloraAnimation snackbarAnimation;
  final ModaloraAnimation overlayAnimation;

  ModaloraAnimationTheme copyWith({
    ModaloraAnimation? dialogAnimation,
    ModaloraAnimation? bottomSheetAnimation,
    ModaloraAnimation? popupAnimation,
    ModaloraAnimation? menuAnimation,
    ModaloraAnimation? snackbarAnimation,
    ModaloraAnimation? overlayAnimation,
  }) {
    return ModaloraAnimationTheme(
      dialogAnimation: dialogAnimation ?? this.dialogAnimation,
      bottomSheetAnimation: bottomSheetAnimation ?? this.bottomSheetAnimation,
      popupAnimation: popupAnimation ?? this.popupAnimation,
      menuAnimation: menuAnimation ?? this.menuAnimation,
      snackbarAnimation: snackbarAnimation ?? this.snackbarAnimation,
      overlayAnimation: overlayAnimation ?? this.overlayAnimation,
    );
  }
}
