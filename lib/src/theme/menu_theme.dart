import 'package:flutter/material.dart';
import '../animation/modalora_animation.dart';

/// Complete theme tokens for Modalora Menu Items.
class ModaloraMenuItemTheme {
  const ModaloraMenuItemTheme({
    this.height = 40.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.textStyle,
    this.subtitleStyle,
    this.shortcutStyle,
    this.iconSize = 18.0,
    this.iconColor,
    this.hoverColor,
    this.pressedColor,
    this.selectedBackgroundColor,
    this.selectedTextColor,
    this.destructiveColor = const Color(0xFFEF4444),
    this.disabledOpacity = 0.4,
  });

  final double height;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final TextStyle? textStyle;
  final TextStyle? subtitleStyle;
  final TextStyle? shortcutStyle;
  final double iconSize;
  final Color? iconColor;
  final Color? hoverColor;
  final Color? pressedColor;
  final Color? selectedBackgroundColor;
  final Color? selectedTextColor;
  final Color destructiveColor;
  final double disabledOpacity;

  ModaloraMenuItemTheme copyWith({
    double? height,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    TextStyle? textStyle,
    TextStyle? subtitleStyle,
    TextStyle? shortcutStyle,
    double? iconSize,
    Color? iconColor,
    Color? hoverColor,
    Color? pressedColor,
    Color? selectedBackgroundColor,
    Color? selectedTextColor,
    Color? destructiveColor,
    double? disabledOpacity,
  }) {
    return ModaloraMenuItemTheme(
      height: height ?? this.height,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      textStyle: textStyle ?? this.textStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
      shortcutStyle: shortcutStyle ?? this.shortcutStyle,
      iconSize: iconSize ?? this.iconSize,
      iconColor: iconColor ?? this.iconColor,
      hoverColor: hoverColor ?? this.hoverColor,
      pressedColor: pressedColor ?? this.pressedColor,
      selectedBackgroundColor: selectedBackgroundColor ?? this.selectedBackgroundColor,
      selectedTextColor: selectedTextColor ?? this.selectedTextColor,
      destructiveColor: destructiveColor ?? this.destructiveColor,
      disabledOpacity: disabledOpacity ?? this.disabledOpacity,
    );
  }
}

/// Complete theme tokens for Modalora Menus (Dropdown, Context, Right-click, Nested).
class ModaloraMenuTheme {
  const ModaloraMenuTheme({
    this.backgroundColor,
    this.surfaceColor,
    this.barrierColor = Colors.transparent,
    this.borderRadius = const BorderRadius.all(Radius.circular(16.0)),
    this.border,
    this.borderWidth = 1.0,
    this.borderColor,
    this.boxShadow = const [
      BoxShadow(color: Color(0x33000000), blurRadius: 24, offset: Offset(0, 10)),
      BoxShadow(color: Color(0x0D000000), blurRadius: 6, offset: Offset(0, 2)),
    ],
    this.elevation = 8.0,
    this.surfaceBlur = 16.0,
    this.padding = const EdgeInsets.all(6.0),
    this.margin = const EdgeInsets.all(8.0),
    this.minWidth = 200.0,
    this.maxWidth = 320.0,
    this.dividerColor,
    this.dividerHeight = 1.0,
    this.itemTheme = const ModaloraMenuItemTheme(),
    this.animation = const ModaloraAnimation(type: ModaloraAnimationType.fadeScale, scaleBegin: 0.95),
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
  final double minWidth;
  final double maxWidth;
  final Color? dividerColor;
  final double dividerHeight;
  final ModaloraMenuItemTheme itemTheme;
  final ModaloraAnimation animation;

  ModaloraMenuTheme copyWith({
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
    Color? dividerColor,
    double? dividerHeight,
    ModaloraMenuItemTheme? itemTheme,
    ModaloraAnimation? animation,
  }) {
    return ModaloraMenuTheme(
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
      dividerColor: dividerColor ?? this.dividerColor,
      dividerHeight: dividerHeight ?? this.dividerHeight,
      itemTheme: itemTheme ?? this.itemTheme,
      animation: animation ?? this.animation,
    );
  }
}
