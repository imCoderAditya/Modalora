import 'package:flutter/material.dart';
import '../animation/modalora_animation.dart';
import '../core/position.dart';

/// Complete theme tokens for Modalora Snackbars and Toasts.
class ModaloraSnackbarTheme {
  const ModaloraSnackbarTheme({
    this.backgroundColor,
    this.surfaceColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(16.0)),
    this.border,
    this.borderWidth = 1.0,
    this.borderColor,
    this.boxShadow = const [
      BoxShadow(color: Color(0x33000000), blurRadius: 20, offset: Offset(0, 8)),
      BoxShadow(color: Color(0x0D000000), blurRadius: 6, offset: Offset(0, 2)),
    ],
    this.elevation = 6.0,
    this.surfaceBlur = 16.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.minWidth = 280.0,
    this.maxWidth = 420.0,
    this.position = ModaloraPosition.topCenter,
    this.duration = const Duration(seconds: 4),
    this.titleStyle,
    this.messageStyle,
    this.actionStyle,
    this.iconSize = 22.0,
    this.iconColor,
    this.iconBackgroundColor,
    this.showCloseButton = true,
    this.closeIconColor,
    this.showProgressBar = true,
    this.progressBarColor,
    this.progressBarHeight = 3.0,
    this.dismissOnSwipe = true,
    this.animation = const ModaloraAnimation(type: ModaloraAnimationType.fadeSlide, slideDirection: ModaloraSlideDirection.fromTop),
    this.maxVisibleCount = 3,
    this.spacing = 10.0,
  });

  final Color? backgroundColor;
  final Color? surfaceColor;
  final BorderRadius borderRadius;
  final BoxBorder? border;
  final double borderWidth;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;
  final double elevation;
  final double surfaceBlur;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double minWidth;
  final double maxWidth;
  final ModaloraPosition position;
  final Duration duration;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final TextStyle? actionStyle;
  final double iconSize;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final bool showCloseButton;
  final Color? closeIconColor;
  final bool showProgressBar;
  final Color? progressBarColor;
  final double progressBarHeight;
  final bool dismissOnSwipe;
  final ModaloraAnimation animation;
  final int maxVisibleCount;
  final double spacing;

  ModaloraSnackbarTheme copyWith({
    Color? backgroundColor,
    Color? surfaceColor,
    BorderRadius? borderRadius,
    BoxBorder? border,
    double? borderWidth,
    Color? borderColor,
    List<BoxShadow>? boxShadow,
    double? elevation,
    double? surfaceBlur,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? minWidth,
    double? maxWidth,
    ModaloraPosition? position,
    Duration? duration,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    TextStyle? actionStyle,
    double? iconSize,
    Color? iconColor,
    Color? iconBackgroundColor,
    bool? showCloseButton,
    Color? closeIconColor,
    bool? showProgressBar,
    Color? progressBarColor,
    double? progressBarHeight,
    bool? dismissOnSwipe,
    ModaloraAnimation? animation,
    int? maxVisibleCount,
    double? spacing,
  }) {
    return ModaloraSnackbarTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      borderWidth: borderWidth ?? this.borderWidth,
      borderColor: borderColor ?? this.borderColor,
      boxShadow: boxShadow ?? this.boxShadow,
      elevation: elevation ?? this.elevation,
      surfaceBlur: surfaceBlur ?? this.surfaceBlur,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      minWidth: minWidth ?? this.minWidth,
      maxWidth: maxWidth ?? this.maxWidth,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      titleStyle: titleStyle ?? this.titleStyle,
      messageStyle: messageStyle ?? this.messageStyle,
      actionStyle: actionStyle ?? this.actionStyle,
      iconSize: iconSize ?? this.iconSize,
      iconColor: iconColor ?? this.iconColor,
      iconBackgroundColor: iconBackgroundColor ?? this.iconBackgroundColor,
      showCloseButton: showCloseButton ?? this.showCloseButton,
      closeIconColor: closeIconColor ?? this.closeIconColor,
      showProgressBar: showProgressBar ?? this.showProgressBar,
      progressBarColor: progressBarColor ?? this.progressBarColor,
      progressBarHeight: progressBarHeight ?? this.progressBarHeight,
      dismissOnSwipe: dismissOnSwipe ?? this.dismissOnSwipe,
      animation: animation ?? this.animation,
      maxVisibleCount: maxVisibleCount ?? this.maxVisibleCount,
      spacing: spacing ?? this.spacing,
    );
  }
}
