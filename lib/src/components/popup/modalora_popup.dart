import 'package:flutter/material.dart';
import '../../core/position.dart';
import '../../theme/modalora_theme.dart';
import '../../utils/backdrop_filter.dart';

/// Prebuilt, highly customizable Modalora Popup container widget.
///
/// Designed for anchor-targeted tooltips, contextual flyouts, and floating cards.
/// Includes support for title, message, custom child widgets, and directional anchoring.
class ModaloraPopupWidget extends StatelessWidget {
  /// Creates a Modalora popup container widget.
  const ModaloraPopupWidget({
    super.key,
    this.title,
    this.message,
    this.child,
    this.width,
    this.height,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.surfaceColor,
    this.borderRadius,
    this.border,
    this.borderWidth,
    this.borderColor,
    this.boxShadow,
    this.surfaceBlur,
    this.elevation,
    this.titleStyle,
    this.messageStyle,
    this.anchor = ModaloraPopupAnchor.bottom,
    this.showArrow,
    this.arrowSize,
    this.arrowColor,
  });

  /// The popup title headline.
  final String? title;

  /// The popup description message.
  final String? message;

  /// Custom child widget embedded inside the popup.
  final Widget? child;

  /// Explicit width for the popup container.
  final double? width;

  /// Explicit height for the popup container.
  final double? height;

  /// Minimum width constraint.
  final double? minWidth;

  /// Maximum width constraint.
  final double? maxWidth;

  /// Minimum height constraint.
  final double? minHeight;

  /// Maximum height constraint.
  final double? maxHeight;

  /// Internal padding for the popup content.
  final EdgeInsetsGeometry? padding;

  /// External margin around the popup card.
  final EdgeInsetsGeometry? margin;

  /// Background color of the container.
  final Color? backgroundColor;

  /// Surface tint color for glassmorphism.
  final Color? surfaceColor;

  /// Corner radius of the popup card.
  final BorderRadius? borderRadius;

  /// Explicit box border.
  final BoxBorder? border;

  /// Border outline width.
  final double? borderWidth;

  /// Border outline color.
  final Color? borderColor;

  /// Drop shadow decorations.
  final List<BoxShadow>? boxShadow;

  /// Backdrop blur sigma value.
  final double? surfaceBlur;

  /// Elevation depth.
  final double? elevation;

  /// Custom typography style for title.
  final TextStyle? titleStyle;

  /// Custom typography style for message.
  final TextStyle? messageStyle;

  /// Directional anchor position relative to target widget.
  final ModaloraPopupAnchor anchor;

  /// Whether to render a pointing directional arrow.
  final bool? showArrow;

  /// Arrow dimensions.
  final Size? arrowSize;

  /// Color tint of the arrow pointer.
  final Color? arrowColor;

  @override
  Widget build(BuildContext context) {
    // 1. Resolve ambient theme hierarchy
    final theme = ModaloraTheme.of(context);
    final popupTheme = theme.popupTheme;

    // 2. Resolve background and surface colors
    final effectiveBg = surfaceColor ??
        backgroundColor ??
        popupTheme.surfaceColor ??
        popupTheme.backgroundColor ??
        theme.surfaceColor;

    // 3. Resolve border, radius, shadows, and blur
    final effectiveRadius = borderRadius ?? popupTheme.borderRadius;
    final effectiveBorderColor = borderColor ?? popupTheme.borderColor ?? theme.borderColor;
    final effectiveBorderWidth = borderWidth ?? popupTheme.borderWidth;
    final effectiveBorder = border ?? Border.all(color: effectiveBorderColor, width: effectiveBorderWidth);
    final effectiveShadow = boxShadow ?? popupTheme.boxShadow;
    final effectiveBlur = surfaceBlur ?? popupTheme.surfaceBlur;
    final effectivePadding = padding ?? popupTheme.padding;
    final effectiveMargin = margin ?? popupTheme.margin;
    final effectiveMaxWidth = maxWidth ?? popupTheme.maxWidth;
    final effectiveMaxHeight = maxHeight ?? popupTheme.maxHeight;

    // 4. Resolve typography
    final effectiveTitleStyle = (const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
    )).merge(titleStyle ?? TextStyle(color: theme.textColor));

    final effectiveMessageStyle = (const TextStyle(
      fontSize: 13.5,
    )).merge(messageStyle ?? TextStyle(color: theme.textSecondaryColor));

    // 5. Build the frosted glass popup container
    return Material(
      type: MaterialType.transparency,
      child: ModaloraGlassContainer(
        width: width,
        height: height,
        constraints: BoxConstraints(
          minWidth: minWidth ?? 0,
          maxWidth: effectiveMaxWidth,
          minHeight: minHeight ?? 0,
          maxHeight: effectiveMaxHeight,
        ),
        margin: effectiveMargin,
        padding: effectivePadding,
        backgroundColor: effectiveBg,
        borderRadius: effectiveRadius,
        border: effectiveBorder,
        boxShadow: effectiveShadow,
        blur: effectiveBlur,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Header
            if (title != null) ...[
              Text(title!, style: effectiveTitleStyle),
              if (message != null || child != null) const SizedBox(height: 6.0),
            ],
            // Message Body
            if (message != null) ...[
              Text(message!, style: effectiveMessageStyle),
            ],
            // Custom Child
            if (child != null) ...[
              if (title != null || message != null) const SizedBox(height: 10.0),
              child!,
            ],
          ],
        ),
      ),
    );
  }
}
