import 'package:flutter/material.dart';
import '../animation/modalora_animation.dart';

/// Complete theme tokens for Modalora Dialogs.
class ModaloraDialogTheme {
  const ModaloraDialogTheme({
    this.backgroundColor,
    this.surfaceColor,
    this.barrierColor,
    this.barrierBlur = 6.0,
    this.barrierDismissible = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(24.0)),
    this.border,
    this.borderWidth = 1.0,
    this.borderColor,
    this.boxShadow = const [
      BoxShadow(color: Color(0x26000000), blurRadius: 28, offset: Offset(0, 14), spreadRadius: -4),
      BoxShadow(color: Color(0x0F000000), blurRadius: 10, offset: Offset(0, 4)),
    ],
    this.elevation = 8.0,
    this.surfaceBlur = 16.0,
    this.padding = const EdgeInsets.all(24.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
    this.minWidth = 280.0,
    this.maxWidth = 480.0,
    this.minHeight,
    this.maxHeight,
    this.alignment = Alignment.center,
    this.titleStyle,
    this.messageStyle,
    this.iconSize = 28.0,
    this.iconColor,
    this.iconBackgroundColor,
    this.iconPadding = const EdgeInsets.all(12.0),
    this.iconBorderRadius = const BorderRadius.all(Radius.circular(16.0)),
    this.buttonSpacing = 12.0,
    this.primaryButtonBackgroundColor,
    this.primaryButtonTextColor,
    this.secondaryButtonBackgroundColor,
    this.secondaryButtonTextColor,
    this.destructiveButtonBackgroundColor,
    this.destructiveButtonTextColor,
    this.buttonBorderRadius = const BorderRadius.all(Radius.circular(14.0)),
    this.buttonPadding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 13.0),
    this.animation = const ModaloraAnimation(type: ModaloraAnimationType.fadeScale),
    this.closeOnTapOutside = true,
    this.useSafeArea = true,
  });

  final Color? backgroundColor;
  final Color? surfaceColor;
  final Color? barrierColor;
  final double barrierBlur;
  final bool barrierDismissible;
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
  final double? minHeight;
  final double? maxHeight;
  final Alignment alignment;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final double iconSize;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final EdgeInsetsGeometry iconPadding;
  final BorderRadius iconBorderRadius;
  final double buttonSpacing;
  final Color? primaryButtonBackgroundColor;
  final Color? primaryButtonTextColor;
  final Color? secondaryButtonBackgroundColor;
  final Color? secondaryButtonTextColor;
  final Color? destructiveButtonBackgroundColor;
  final Color? destructiveButtonTextColor;
  final BorderRadius buttonBorderRadius;
  final EdgeInsetsGeometry buttonPadding;
  final ModaloraAnimation animation;
  final bool closeOnTapOutside;
  final bool useSafeArea;

  ModaloraDialogTheme copyWith({
    Color? backgroundColor,
    Color? surfaceColor,
    Color? barrierColor,
    double? barrierBlur,
    bool? barrierDismissible,
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
    Alignment? alignment,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    double? iconSize,
    Color? iconColor,
    Color? iconBackgroundColor,
    EdgeInsetsGeometry? iconPadding,
    BorderRadius? iconBorderRadius,
    double? buttonSpacing,
    Color? primaryButtonBackgroundColor,
    Color? primaryButtonTextColor,
    Color? secondaryButtonBackgroundColor,
    Color? secondaryButtonTextColor,
    Color? destructiveButtonBackgroundColor,
    Color? destructiveButtonTextColor,
    BorderRadius? buttonBorderRadius,
    EdgeInsetsGeometry? buttonPadding,
    ModaloraAnimation? animation,
    bool? closeOnTapOutside,
    bool? useSafeArea,
  }) {
    return ModaloraDialogTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      barrierColor: barrierColor ?? this.barrierColor,
      barrierBlur: barrierBlur ?? this.barrierBlur,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
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
      alignment: alignment ?? this.alignment,
      titleStyle: titleStyle ?? this.titleStyle,
      messageStyle: messageStyle ?? this.messageStyle,
      iconSize: iconSize ?? this.iconSize,
      iconColor: iconColor ?? this.iconColor,
      iconBackgroundColor: iconBackgroundColor ?? this.iconBackgroundColor,
      iconPadding: iconPadding ?? this.iconPadding,
      iconBorderRadius: iconBorderRadius ?? this.iconBorderRadius,
      buttonSpacing: buttonSpacing ?? this.buttonSpacing,
      primaryButtonBackgroundColor: primaryButtonBackgroundColor ?? this.primaryButtonBackgroundColor,
      primaryButtonTextColor: primaryButtonTextColor ?? this.primaryButtonTextColor,
      secondaryButtonBackgroundColor: secondaryButtonBackgroundColor ?? this.secondaryButtonBackgroundColor,
      secondaryButtonTextColor: secondaryButtonTextColor ?? this.secondaryButtonTextColor,
      destructiveButtonBackgroundColor: destructiveButtonBackgroundColor ?? this.destructiveButtonBackgroundColor,
      destructiveButtonTextColor: destructiveButtonTextColor ?? this.destructiveButtonTextColor,
      buttonBorderRadius: buttonBorderRadius ?? this.buttonBorderRadius,
      buttonPadding: buttonPadding ?? this.buttonPadding,
      animation: animation ?? this.animation,
      closeOnTapOutside: closeOnTapOutside ?? this.closeOnTapOutside,
      useSafeArea: useSafeArea ?? this.useSafeArea,
    );
  }
}
