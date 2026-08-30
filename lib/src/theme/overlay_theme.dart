import 'package:flutter/material.dart';
import '../animation/modalora_animation.dart';

/// Complete theme tokens for Modalora Fullscreen / Blocking / Loading Overlays.
class ModaloraOverlayTheme {
  const ModaloraOverlayTheme({
    this.backgroundColor,
    this.surfaceColor,
    this.barrierColor,
    this.blur = 10.0,
    this.opacity = 0.5,
    this.borderRadius = const BorderRadius.all(Radius.circular(24.0)),
    this.border,
    this.borderWidth = 1.0,
    this.borderColor,
    this.boxShadow = const [
      BoxShadow(color: Color(0x33000000), blurRadius: 28, offset: Offset(0, 12)),
    ],
    this.elevation = 8.0,
    this.padding = const EdgeInsets.all(28.0),
    this.margin = const EdgeInsets.all(24.0),
    this.indicatorColor,
    this.indicatorSize = 44.0,
    this.indicatorStrokeWidth = 3.5,
    this.titleStyle,
    this.messageStyle,
    this.animation = const ModaloraAnimation(type: ModaloraAnimationType.fade),
    this.dismissible = false,
  });

  final Color? backgroundColor;
  final Color? surfaceColor;
  final Color? barrierColor;
  final double blur;
  final double opacity;
  final BorderRadius borderRadius;
  final BoxBorder? border;
  final double borderWidth;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? indicatorColor;
  final double indicatorSize;
  final double indicatorStrokeWidth;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final ModaloraAnimation animation;
  final bool dismissible;

  ModaloraOverlayTheme copyWith({
    Color? backgroundColor,
    Color? surfaceColor,
    Color? barrierColor,
    double? blur,
    double? opacity,
    BorderRadius? borderRadius,
    BoxBorder? border,
    double? borderWidth,
    Color? borderColor,
    List<BoxShadow>? boxShadow,
    double? elevation,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? indicatorColor,
    double? indicatorSize,
    double? indicatorStrokeWidth,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    ModaloraAnimation? animation,
    bool? dismissible,
  }) {
    return ModaloraOverlayTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      barrierColor: barrierColor ?? this.barrierColor,
      blur: blur ?? this.blur,
      opacity: opacity ?? this.opacity,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      borderWidth: borderWidth ?? this.borderWidth,
      borderColor: borderColor ?? this.borderColor,
      boxShadow: boxShadow ?? this.boxShadow,
      elevation: elevation ?? this.elevation,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      indicatorStrokeWidth: indicatorStrokeWidth ?? this.indicatorStrokeWidth,
      titleStyle: titleStyle ?? this.titleStyle,
      messageStyle: messageStyle ?? this.messageStyle,
      animation: animation ?? this.animation,
      dismissible: dismissible ?? this.dismissible,
    );
  }
}
