import 'package:flutter/material.dart';
import '../animation/modalora_animation.dart';
import '../core/position.dart';

/// Complete theme tokens for Modalora Popups and tooltips.
class ModaloraPopupTheme {
  const ModaloraPopupTheme({
    this.backgroundColor,
    this.surfaceColor,
    this.barrierColor = Colors.transparent,
    this.borderRadius = const BorderRadius.all(Radius.circular(16.0)),
    this.border,
    this.borderWidth = 1.0,
    this.borderColor,
    this.boxShadow = const [
      BoxShadow(color: Color(0x26000000), blurRadius: 20, offset: Offset(0, 8)),
      BoxShadow(color: Color(0x0D000000), blurRadius: 6, offset: Offset(0, 2)),
    ],
    this.elevation = 6.0,
    this.surfaceBlur = 12.0,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(12.0),
    this.minWidth,
    this.maxWidth = 360.0,
    this.minHeight,
    this.maxHeight = 400.0,
    this.anchor = ModaloraPopupAnchor.bottom,
    this.offset = const Offset(0, 8.0),
    this.showArrow = true,
    this.arrowSize = const Size(12.0, 6.0),
    this.arrowColor,
    this.animation = const ModaloraAnimation(type: ModaloraAnimationType.fadeScale, scaleBegin: 0.94),
    this.dismissOnTapOutside = true,
  });

  final Color? backgroundColor;
  final Color? surfaceColor;
  final Color? barrierColor;
  final BorderRadius borderRadius;
  final BoxBorder? border;
  final double borderWidth;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;
  final double elevation;
  final double surfaceBlur;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double? minWidth;
  final double maxWidth;
  final double? minHeight;
  final double maxHeight;
  final ModaloraPopupAnchor anchor;
  final Offset offset;
  final bool showArrow;
  final Size arrowSize;
  final Color? arrowColor;
  final ModaloraAnimation animation;
  final bool dismissOnTapOutside;

  ModaloraPopupTheme copyWith({
    Color? backgroundColor,
    Color? surfaceColor,
    Color? barrierColor,
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
    double? minHeight,
    double? maxHeight,
    ModaloraPopupAnchor? anchor,
    Offset? offset,
    bool? showArrow,
    Size? arrowSize,
    Color? arrowColor,
    ModaloraAnimation? animation,
    bool? dismissOnTapOutside,
  }) {
    return ModaloraPopupTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      barrierColor: barrierColor ?? this.barrierColor,
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
      minHeight: minHeight ?? this.minHeight,
      maxHeight: maxHeight ?? this.maxHeight,
      anchor: anchor ?? this.anchor,
      offset: offset ?? this.offset,
      showArrow: showArrow ?? this.showArrow,
      arrowSize: arrowSize ?? this.arrowSize,
      arrowColor: arrowColor ?? this.arrowColor,
      animation: animation ?? this.animation,
      dismissOnTapOutside: dismissOnTapOutside ?? this.dismissOnTapOutside,
    );
  }
}
