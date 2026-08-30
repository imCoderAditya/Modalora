import 'dart:ui';
import 'package:flutter/material.dart';

/// A reusable glassmorphic container with configurable blur, surface tint, and border.
///
/// Combines [ClipRRect], [BackdropFilter], [RepaintBoundary], and [BoxDecoration]
/// to render stutter-free 60fps/120fps frosted glass surfaces.
class ModaloraGlassContainer extends StatelessWidget {
  /// Creates a glassmorphic container instance.
  const ModaloraGlassContainer({
    super.key,
    required this.child,
    this.blur = 0.0,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.constraints,
    this.clipBehavior = Clip.antiAlias,
  });

  /// The child widget placed on top of the glass surface.
  final Widget child;

  /// Frosted blur intensity sigma value (sigmaX and sigmaY).
  final double blur;

  /// Background surface tint color.
  final Color? backgroundColor;

  /// Corner radius of the container.
  final BorderRadius? borderRadius;

  /// Explicit border outline.
  final BoxBorder? border;

  /// Drop shadow decorations.
  final List<BoxShadow>? boxShadow;

  /// Internal padding.
  final EdgeInsetsGeometry? padding;

  /// External margin.
  final EdgeInsetsGeometry? margin;

  /// Explicit width.
  final double? width;

  /// Explicit height.
  final double? height;

  /// Layout size constraints.
  final BoxConstraints? constraints;

  /// Clipping strategy.
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? BorderRadius.zero;

    // 1. Build the base decorated container with surface color and borders
    Widget content = Container(
      width: width,
      height: height,
      constraints: constraints,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: effectiveRadius,
        border: border,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: child,
      ),
    );

    // 2. Wrap in RepaintBoundary, ClipRRect, and BackdropFilter if blur is active
    if (blur > 0) {
      content = RepaintBoundary(
        child: ClipRRect(
          borderRadius: effectiveRadius,
          clipBehavior: clipBehavior,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: content,
          ),
        ),
      );
    }

    // 3. Wrap in outer shadow container or margin padding
    if (boxShadow != null && boxShadow!.isNotEmpty) {
      content = Container(
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: effectiveRadius,
          boxShadow: boxShadow,
        ),
        child: content,
      );
    } else if (margin != null) {
      content = Padding(
        padding: margin!,
        child: content,
      );
    }

    return content;
  }
}
