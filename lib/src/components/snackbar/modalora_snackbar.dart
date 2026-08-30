import 'dart:async';
import 'package:flutter/material.dart';
import '../../animation/modalora_animation.dart';
import '../../core/position.dart';
import '../../theme/modalora_theme.dart';
import '../../utils/backdrop_filter.dart';

/// Prebuilt, highly customizable Modalora Snackbar / Toast widget.
///
/// Supports progress countdown bars, action buttons, swipe-to-dismiss gestures,
/// frosted glassmorphic styling, and intelligent queue management.
class ModaloraSnackbarWidget extends StatefulWidget {
  /// Creates a Modalora snackbar toast widget.
  const ModaloraSnackbarWidget({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.action,
    this.actionLabel,
    this.onActionPressed,
    this.child,
    this.duration = const Duration(seconds: 4),
    this.position = ModaloraPosition.topCenter,
    this.width,
    this.minWidth,
    this.maxWidth,
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
    this.actionStyle,
    this.iconSize,
    this.iconColor,
    this.iconBackgroundColor,
    this.showCloseButton,
    this.closeIconColor,
    this.showProgressBar,
    this.progressBarColor,
    this.progressBarHeight,
    this.dismissOnSwipe,
    this.animation,
    required this.onDismiss,
  });

  /// The primary toast title headline.
  final String? title;

  /// The secondary supporting description message.
  final String? message;

  /// Optional leading icon widget.
  final Widget? icon;

  /// Custom action widget.
  final Widget? action;

  /// Text label for default action button capsule.
  final String? actionLabel;

  /// Callback executed when the action button is tapped.
  final VoidCallback? onActionPressed;

  /// Custom content widget replacing standard title/message row.
  final Widget? child;

  /// Display lifetime before auto-dismissal.
  final Duration duration;

  /// Screen position anchor (e.g. [ModaloraPosition.topCenter]).
  final ModaloraPosition position;

  /// Explicit toast container width.
  final double? width;

  /// Minimum width constraint.
  final double? minWidth;

  /// Maximum width constraint.
  final double? maxWidth;

  /// Inner padding inside the toast card.
  final EdgeInsetsGeometry? padding;

  /// Outer margin surrounding the toast card.
  final EdgeInsetsGeometry? margin;

  /// Background color override.
  final Color? backgroundColor;

  /// Frosted glass surface tint color.
  final Color? surfaceColor;

  /// Corner radius of the toast card.
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

  /// Material elevation depth.
  final double? elevation;

  /// Custom typography style for title.
  final TextStyle? titleStyle;

  /// Custom typography style for message.
  final TextStyle? messageStyle;

  /// Custom typography style for action button label.
  final TextStyle? actionStyle;

  /// Icon dimensions.
  final double? iconSize;

  /// Color tint for leading icon.
  final Color? iconColor;

  /// Background color for icon circle capsule.
  final Color? iconBackgroundColor;

  /// Whether to render a right-aligned close cross button.
  final bool? showCloseButton;

  /// Color tint for close cross icon.
  final Color? closeIconColor;

  /// Whether to display a bottom countdown timer progress bar.
  final bool? showProgressBar;

  /// Color tint for progress indicator.
  final Color? progressBarColor;

  /// Height / thickness of the progress bar.
  final double? progressBarHeight;

  /// Whether horizontal swipe gestures dismiss the snackbar immediately.
  final bool? dismissOnSwipe;

  /// Custom entrance animation settings.
  final ModaloraAnimation? animation;

  /// Callback invoked when the toast finishes its lifetime or is dismissed.
  final VoidCallback onDismiss;

  @override
  State<ModaloraSnackbarWidget> createState() => _ModaloraSnackbarWidgetState();
}

class _ModaloraSnackbarWidgetState extends State<ModaloraSnackbarWidget>
    with SingleTickerProviderStateMixin {
  /// Controller driving the linear countdown timer progress bar
  late AnimationController _controller;

  /// Timer triggering auto-dismissal upon duration expiry
  Timer? _dismissTimer;

  @override
  void initState() {
    super.initState();
    // 1. Initialize linear progress animation
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _controller.forward();

    // 2. Schedule auto-dismissal
    _dismissTimer = Timer(widget.duration, () {
      if (mounted) {
        widget.onDismiss();
      }
    });
  }

  @override
  void dispose() {
    // Clean up timer and animation controller to prevent memory leaks
    _dismissTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Resolve ambient theme hierarchy
    final theme = ModaloraTheme.of(context);
    final snackTheme = theme.snackbarTheme;

    // 2. Resolve background and surface colors
    final effectiveBg = widget.surfaceColor ??
        widget.backgroundColor ??
        snackTheme.surfaceColor ??
        snackTheme.backgroundColor ??
        (theme.isDark ? const Color(0xF227272A) : const Color(0xEB1E293B));

    // 3. Resolve border, radius, shadow, and blur
    final effectiveRadius = widget.borderRadius ?? snackTheme.borderRadius;
    final effectiveBorderColor = widget.borderColor ?? snackTheme.borderColor ?? theme.borderColor;
    final effectiveBorderWidth = widget.borderWidth ?? snackTheme.borderWidth;
    final effectiveBorder = widget.border ?? Border.all(color: effectiveBorderColor, width: effectiveBorderWidth);
    final effectiveShadow = widget.boxShadow ?? snackTheme.boxShadow;
    final effectiveBlur = widget.surfaceBlur ?? snackTheme.surfaceBlur;
    final effectivePadding = widget.padding ?? snackTheme.padding;
    final effectiveMinWidth = widget.minWidth ?? snackTheme.minWidth;
    final effectiveMaxWidth = widget.maxWidth ?? snackTheme.maxWidth;

    // 4. Resolve typography styles
    final effectiveTitleStyle = (snackTheme.titleStyle ??
            const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white))
        .merge(widget.titleStyle);

    final effectiveMessageStyle = (snackTheme.messageStyle ??
            const TextStyle(fontSize: 13.5, color: Color(0xFFE2E8F0)))
        .merge(widget.messageStyle);

    final effectiveActionStyle = (snackTheme.actionStyle ??
            TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: theme.accentColor))
        .merge(widget.actionStyle);

    // 5. Resolve icon, close button, and progress bar options
    final effectiveIconColor = widget.iconColor ?? snackTheme.iconColor ?? theme.primaryVariant;
    final effectiveShowClose = widget.showCloseButton ?? snackTheme.showCloseButton;
    final effectiveShowProgress = widget.showProgressBar ?? snackTheme.showProgressBar;
    final effectiveProgressColor = widget.progressBarColor ?? snackTheme.progressBarColor ?? theme.primaryVariant;
    final effectiveProgressHeight = widget.progressBarHeight ?? snackTheme.progressBarHeight;
    final effectiveDismissOnSwipe = widget.dismissOnSwipe ?? snackTheme.dismissOnSwipe;

    // 6. Build the inner row content
    Widget content = widget.child ??
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Leading Icon Circle
            if (widget.icon != null) ...[
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: widget.iconBackgroundColor ?? effectiveIconColor.withValues(alpha: 0.16),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: effectiveIconColor.withValues(alpha: 0.3),
                    width: 1.0,
                  ),
                ),
                child: IconTheme(
                  data: IconThemeData(
                    size: widget.iconSize ?? snackTheme.iconSize,
                    color: effectiveIconColor,
                  ),
                  child: widget.icon!,
                ),
              ),
              const SizedBox(width: 12),
            ],
            // Title & Message Column
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.title != null) ...[
                    Text(
                      widget.title!,
                      style: effectiveTitleStyle.copyWith(
                        letterSpacing: -0.2,
                      ),
                    ),
                    if (widget.message != null) const SizedBox(height: 2.5),
                  ],
                  if (widget.message != null) ...[
                    Text(
                      widget.message!,
                      style: effectiveMessageStyle.copyWith(
                        height: 1.35,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Action Button Capsule
            if (widget.action != null) ...[
              const SizedBox(width: 12),
              widget.action!,
            ] else if (widget.actionLabel != null) ...[
              const SizedBox(width: 12),
              Material(
                color: theme.isDark ? Colors.white.withValues(alpha: 0.12) : Colors.black.withValues(alpha: 0.08),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: theme.isDark ? Colors.white.withValues(alpha: 0.18) : Colors.black.withValues(alpha: 0.12),
                    width: 0.8,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    if (widget.onActionPressed != null) widget.onActionPressed!();
                    widget.onDismiss();
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      widget.actionLabel!,
                      style: effectiveActionStyle.copyWith(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            // Close Cross Icon Button
            if (effectiveShowClose) ...[
              const SizedBox(width: 8),
              Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: widget.onDismiss,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.close_rounded,
                      size: 16,
                      color: widget.closeIconColor ?? snackTheme.closeIconColor ?? const Color(0xFF94A3B8),
                    ),
                  ),
                ),
              ),
            ],
          ],
        );

    // 7. Wrap in frosted glass container with optional countdown bar
    Widget toast = Material(
      type: MaterialType.transparency,
      child: ModaloraGlassContainer(
        width: widget.width,
        constraints: BoxConstraints(
          minWidth: effectiveMinWidth,
          maxWidth: effectiveMaxWidth,
        ),
        margin: widget.margin ?? snackTheme.margin,
        padding: effectivePadding,
        backgroundColor: effectiveBg,
        borderRadius: effectiveRadius,
        border: effectiveBorder,
        boxShadow: effectiveShadow,
        blur: effectiveBlur,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            content,
            // Linear Progress Indicator
            if (effectiveShowProgress) ...[
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return LinearProgressIndicator(
                      value: 1.0 - _controller.value,
                      backgroundColor: Colors.white.withValues(alpha: 0.12),
                      valueColor: AlwaysStoppedAnimation<Color>(effectiveProgressColor),
                      minHeight: effectiveProgressHeight,
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );

    // 8. Wrap in swipe-to-dismiss gesture detector if enabled
    if (effectiveDismissOnSwipe) {
      toast = Dismissible(
        key: UniqueKey(),
        onDismissed: (_) => widget.onDismiss(),
        direction: DismissDirection.horizontal,
        child: toast,
      );
    }

    return toast;
  }
}
