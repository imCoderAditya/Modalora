import 'dart:ui';
import 'package:flutter/material.dart';
import '../../animation/animation_builder.dart';
import '../../animation/modalora_animation.dart';
import '../../core/overlay_controller.dart';
import '../../theme/modalora_theme.dart';
import '../../utils/backdrop_filter.dart';
import 'loading_indicator.dart';

/// Prebuilt loading overlay content card with animated indicator, title, and optional message.
class ModaloraLoadingCard extends StatelessWidget {
  /// Creates a modal loading card.
  const ModaloraLoadingCard({
    super.key,
    this.title,
    this.message,
    this.indicator,
    this.indicatorColor,
    this.indicatorSize,
    this.backgroundColor,
    this.surfaceColor,
    this.borderRadius,
    this.border,
    this.borderWidth,
    this.borderColor,
    this.boxShadow,
    this.surfaceBlur,
    this.padding,
    this.titleStyle,
    this.messageStyle,
  });

  /// The headline text (e.g. 'Loading...').
  final String? title;

  /// The supporting message text.
  final String? message;

  /// Custom animated indicator widget.
  final Widget? indicator;

  /// Color tint for default spinner indicator.
  final Color? indicatorColor;

  /// Spinner size dimension.
  final double? indicatorSize;

  /// Background color override.
  final Color? backgroundColor;

  /// Frosted glass surface tint color.
  final Color? surfaceColor;

  /// Corner radius of the card.
  final BorderRadius? borderRadius;

  /// Explicit box border.
  final BoxBorder? border;

  /// Border outline width.
  final double? borderWidth;

  /// Border outline color.
  final Color? borderColor;

  /// Drop shadows.
  final List<BoxShadow>? boxShadow;

  /// Backdrop blur sigma value.
  final double? surfaceBlur;

  /// Internal padding.
  final EdgeInsetsGeometry? padding;

  /// Custom title typography style.
  final TextStyle? titleStyle;

  /// Custom message typography style.
  final TextStyle? messageStyle;

  @override
  Widget build(BuildContext context) {
    // 1. Resolve ambient theme hierarchy
    final theme = ModaloraTheme.of(context);
    final overlayTheme = theme.overlayTheme;

    // 2. Resolve background and surface colors
    final effectiveBg = surfaceColor ??
        backgroundColor ??
        overlayTheme.surfaceColor ??
        overlayTheme.backgroundColor ??
        theme.surfaceColor;

    // 3. Resolve border, radius, shadow, and blur
    final effectiveRadius = borderRadius ?? overlayTheme.borderRadius;
    final effectiveBorderColor = borderColor ?? overlayTheme.borderColor ?? theme.borderColor;
    final effectiveBorderWidth = borderWidth ?? overlayTheme.borderWidth;
    final effectiveBorder = border ?? Border.all(color: effectiveBorderColor, width: effectiveBorderWidth);
    final effectiveShadow = boxShadow ?? overlayTheme.boxShadow;
    final effectiveBlur = surfaceBlur ?? overlayTheme.blur;
    final effectivePadding = padding ?? overlayTheme.padding;

    // 4. Resolve typography styles
    final effectiveTitleStyle = (overlayTheme.titleStyle ??
            TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: theme.textColor))
        .merge(titleStyle);

    final effectiveMessageStyle = (overlayTheme.messageStyle ??
            TextStyle(fontSize: 13.5, color: theme.textSecondaryColor))
        .merge(messageStyle);

    // 5. Build loading card with spinner and text
    return Material(
      type: MaterialType.transparency,
      child: ModaloraGlassContainer(
        constraints: const BoxConstraints(minWidth: 160, maxWidth: 320),
        padding: effectivePadding,
        backgroundColor: effectiveBg,
        borderRadius: effectiveRadius,
        border: effectiveBorder,
        boxShadow: effectiveShadow,
        blur: effectiveBlur,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Spinner Indicator
            indicator ??
                ModaloraLoadingSpinner(
                  size: indicatorSize ?? overlayTheme.indicatorSize,
                  strokeWidth: overlayTheme.indicatorStrokeWidth,
                  color: indicatorColor ?? overlayTheme.indicatorColor ?? theme.primaryColor,
                ),
            // Title Header
            if (title != null) ...[
              const SizedBox(height: 16),
              Text(
                title!,
                style: effectiveTitleStyle,
                textAlign: TextAlign.center,
              ),
            ],
            // Message Description
            if (message != null) ...[
              const SizedBox(height: 6),
              Text(
                message!,
                style: effectiveMessageStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A luxury, pre-styled glassmorphic card for full-screen overlays, security shields, and blocking modals.
class ModaloraFullScreenCard extends StatelessWidget {
  /// Creates a full screen modal card.
  const ModaloraFullScreenCard({
    super.key,
    this.icon,
    this.iconData,
    this.title,
    this.message,
    this.child,
    this.primaryActionText,
    this.onPrimaryAction,
    this.secondaryActionText,
    this.onSecondaryAction,
    this.actions,
    this.surfaceColor,
    this.borderRadius,
    this.border,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
    this.surfaceBlur,
    this.padding,
    this.margin,
    this.maxWidth = 420.0,
  });

  /// Custom icon widget.
  final Widget? icon;

  /// Convenience icon data.
  final IconData? iconData;

  /// Headline title text.
  final String? title;

  /// Description message text.
  final String? message;

  /// Custom content widget.
  final Widget? child;

  /// Label for primary action button.
  final String? primaryActionText;

  /// Callback for primary action.
  final VoidCallback? onPrimaryAction;

  /// Label for secondary action button.
  final String? secondaryActionText;

  /// Callback for secondary action.
  final VoidCallback? onSecondaryAction;

  /// Custom list of action buttons.
  final List<Widget>? actions;

  /// Frosted glass surface color.
  final Color? surfaceColor;

  /// Corner radius.
  final BorderRadius? borderRadius;

  /// Box border.
  final BoxBorder? border;

  /// Border outline color.
  final Color? borderColor;

  /// Border outline width.
  final double? borderWidth;

  /// Drop shadows.
  final List<BoxShadow>? boxShadow;

  /// Blur sigma.
  final double? surfaceBlur;

  /// Padding.
  final EdgeInsetsGeometry? padding;

  /// Margin.
  final EdgeInsetsGeometry? margin;

  /// Maximum card width.
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final theme = ModaloraTheme.of(context);
    final effectiveBg = surfaceColor ?? theme.surfaceColor;
    final effectiveRadius = borderRadius ?? BorderRadius.circular(24.0);
    final effectiveBorder = border ??
        Border.all(
          color: borderColor ?? theme.borderColor,
          width: borderWidth ?? 1.0,
        );
    final effectiveShadow = boxShadow ?? theme.dialogTheme.boxShadow;
    final effectiveBlur = surfaceBlur ?? theme.dialogTheme.surfaceBlur;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Material(
          type: MaterialType.transparency,
          child: ModaloraGlassContainer(
            margin: margin ?? const EdgeInsets.symmetric(horizontal: 24.0),
            padding: padding ?? const EdgeInsets.all(28.0),
            backgroundColor: effectiveBg,
            borderRadius: effectiveRadius,
            border: effectiveBorder,
            boxShadow: effectiveShadow,
            blur: effectiveBlur,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon Header
                if (icon != null)
                  icon!
                else if (iconData != null)
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [theme.primaryColor, theme.accentColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: theme.primaryColor.withValues(alpha: 0.35),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(iconData, size: 36, color: Colors.white),
                  ),
                if (icon != null || iconData != null) const SizedBox(height: 20),
                // Title Header
                if (title != null)
                  Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.4,
                      decoration: TextDecoration.none,
                      color: theme.textColor,
                    ),
                  ),
                if (title != null && message != null) const SizedBox(height: 8),
                // Message Body
                if (message != null)
                  Text(
                    message!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: theme.textSecondaryColor,
                      decoration: TextDecoration.none,
                      height: 1.4,
                    ),
                  ),
                // Custom Child Body
                if (child != null) ...[
                  if (title != null || message != null || icon != null || iconData != null)
                    const SizedBox(height: 16),
                  child!,
                ],
                // Action Buttons Row
                if (primaryActionText != null || secondaryActionText != null || (actions != null && actions!.isNotEmpty)) ...[
                  const SizedBox(height: 24),
                  if (actions != null && actions!.isNotEmpty)
                    Row(children: actions!.map((a) => Expanded(child: a)).toList())
                  else
                    Row(
                      children: [
                        if (secondaryActionText != null)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: onSecondaryAction ?? () => ModaloraOverlayController.dismissAll(),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: theme.textColor,
                                side: BorderSide(color: theme.borderColor),
                                padding: const EdgeInsets.symmetric(vertical: 13),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: Text(secondaryActionText!, style: const TextStyle(fontWeight: FontWeight.w600)),
                            ),
                          ),
                        if (secondaryActionText != null && primaryActionText != null)
                          const SizedBox(width: 12),
                        if (primaryActionText != null)
                          Expanded(
                            child: ElevatedButton(
                              onPressed: onPrimaryAction ?? () => ModaloraOverlayController.dismissAll(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 13),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: Text(primaryActionText!, style: const TextStyle(fontWeight: FontWeight.w700)),
                            ),
                          ),
                      ],
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A fullscreen backdrop route wrapper for displaying custom or loading overlays.
class ModaloraOverlayHostWidget extends StatefulWidget {
  /// Creates an overlay host widget.
  const ModaloraOverlayHostWidget({
    super.key,
    required this.child,
    this.blur = 10.0,
    this.opacity = 0.5,
    this.barrierColor,
    this.dismissible = false,
    this.onDismiss,
    this.animation = const ModaloraAnimation(type: ModaloraAnimationType.fade),
  });

  /// The overlay content child.
  final Widget child;

  /// Frosted backdrop blur sigma.
  final double blur;

  /// Barrier dimming opacity fraction.
  final double opacity;

  /// Explicit barrier color override.
  final Color? barrierColor;

  /// Whether tapping the barrier dismisses the overlay.
  final bool dismissible;

  /// Callback on barrier dismissal.
  final VoidCallback? onDismiss;

  /// Entrance/exit animation configuration.
  final ModaloraAnimation animation;

  @override
  State<ModaloraOverlayHostWidget> createState() => _ModaloraOverlayHostWidgetState();
}

class _ModaloraOverlayHostWidgetState extends State<ModaloraOverlayHostWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animation.duration,
      reverseDuration: widget.animation.reverseDuration,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBarrier = widget.barrierColor ?? Colors.black.withValues(alpha: widget.opacity);

    return Stack(
      children: [
        // 1. Frosted Backdrop Blur Barrier
        GestureDetector(
          onTap: widget.dismissible ? widget.onDismiss : null,
          child: FadeTransition(
            opacity: _controller,
            child: RepaintBoundary(
              child: Container(
                color: effectiveBarrier,
                child: widget.blur > 0
                    ? BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: widget.blur,
                          sigmaY: widget.blur,
                        ),
                        child: const SizedBox.expand(),
                      )
                    : const SizedBox.expand(),
              ),
            ),
          ),
        ),
        // 2. Animated Center Content
        Center(
          child: Material(
            type: MaterialType.transparency,
            child: DefaultTextStyle(
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              child: ModaloraAnimationWrapper(
                animation: _controller,
                config: widget.animation,
                child: widget.child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
