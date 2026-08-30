import 'package:flutter/material.dart';
import '../animation/modalora_animation.dart';

/// Complete theme tokens for Modalora BottomSheets.
class ModaloraBottomSheetTheme {
  const ModaloraBottomSheetTheme({
    this.backgroundColor,
    this.surfaceColor,
    this.barrierColor,
    this.barrierBlur = 4.0,
    this.barrierDismissible = true,
    this.borderRadius = const BorderRadius.vertical(top: Radius.circular(28.0)),
    this.border,
    this.borderWidth = 1.0,
    this.borderColor,
    this.boxShadow = const [
      BoxShadow(color: Color(0x33000000), blurRadius: 32, offset: Offset(0, -6)),
    ],
    this.elevation = 16.0,
    this.surfaceBlur = 20.0,
    this.padding = const EdgeInsets.all(20.0),
    this.margin,
    this.minHeight,
    this.maxHeight,
    this.initialSize = 0.55,
    this.minChildSize = 0.25,
    this.maxChildSize = 0.92,
    this.snapPoints = const [0.35, 0.6, 0.9],
    this.snap = true,
    this.isDraggable = true,
    this.showDragHandle = true,
    this.dragHandleColor,
    this.dragHandleWidth = 42.0,
    this.dragHandleHeight = 5.0,
    this.dragHandleBorderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.dragHandlePadding = const EdgeInsets.symmetric(vertical: 12.0),
    this.titleStyle,
    this.messageStyle,
    this.animation = const ModaloraAnimation(type: ModaloraAnimationType.slide, slideDirection: ModaloraSlideDirection.fromBottom),
    this.enableDrag = true,
    this.isScrollControlled = true,
    this.useSafeArea = true,
    this.alignment = Alignment.bottomCenter,
  });

  final AlignmentGeometry alignment;
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
  final EdgeInsetsGeometry? margin;
  final double? minHeight;
  final double? maxHeight;
  final double initialSize;
  final double minChildSize;
  final double maxChildSize;
  final List<double> snapPoints;
  final bool snap;
  final bool isDraggable;
  final bool showDragHandle;
  final Color? dragHandleColor;
  final double dragHandleWidth;
  final double dragHandleHeight;
  final BorderRadius dragHandleBorderRadius;
  final EdgeInsetsGeometry dragHandlePadding;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final ModaloraAnimation animation;
  final bool enableDrag;
  final bool isScrollControlled;
  final bool useSafeArea;

  ModaloraBottomSheetTheme copyWith({
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
    double? minHeight,
    double? maxHeight,
    double? initialSize,
    double? minChildSize,
    double? maxChildSize,
    List<double>? snapPoints,
    bool? snap,
    bool? isDraggable,
    bool? showDragHandle,
    Color? dragHandleColor,
    double? dragHandleWidth,
    double? dragHandleHeight,
    BorderRadius? dragHandleBorderRadius,
    EdgeInsetsGeometry? dragHandlePadding,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    ModaloraAnimation? animation,
    bool? enableDrag,
    bool? isScrollControlled,
    bool? useSafeArea,
    AlignmentGeometry? alignment,
  }) {
    return ModaloraBottomSheetTheme(
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
      minHeight: minHeight ?? this.minHeight,
      maxHeight: maxHeight ?? this.maxHeight,
      initialSize: initialSize ?? this.initialSize,
      minChildSize: minChildSize ?? this.minChildSize,
      maxChildSize: maxChildSize ?? this.maxChildSize,
      snapPoints: snapPoints ?? this.snapPoints,
      snap: snap ?? this.snap,
      isDraggable: isDraggable ?? this.isDraggable,
      showDragHandle: showDragHandle ?? this.showDragHandle,
      dragHandleColor: dragHandleColor ?? this.dragHandleColor,
      dragHandleWidth: dragHandleWidth ?? this.dragHandleWidth,
      dragHandleHeight: dragHandleHeight ?? this.dragHandleHeight,
      dragHandleBorderRadius: dragHandleBorderRadius ?? this.dragHandleBorderRadius,
      dragHandlePadding: dragHandlePadding ?? this.dragHandlePadding,
      titleStyle: titleStyle ?? this.titleStyle,
      messageStyle: messageStyle ?? this.messageStyle,
      animation: animation ?? this.animation,
      enableDrag: enableDrag ?? this.enableDrag,
      isScrollControlled: isScrollControlled ?? this.isScrollControlled,
      useSafeArea: useSafeArea ?? this.useSafeArea,
      alignment: alignment ?? this.alignment,
    );
  }
}
