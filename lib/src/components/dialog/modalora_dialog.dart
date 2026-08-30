import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme/dialog_theme.dart';
import '../../theme/modalora_theme.dart';
import '../../utils/backdrop_filter.dart';

/// Style variants for standard Modalora dialog action buttons.
/// Determines default background, text color, borders, and shadows.
enum ModaloraButtonVariant {
  /// Prominent filled button styled with primary accent theme color.
  primary,

  /// Muted background button for neutral actions.
  secondary,

  /// High-contrast danger button for irreversible actions (e.g. Delete).
  destructive,

  /// Transparent background button with subtle border stroke.
  outlined,

  /// Clean borderless text button.
  text;
}

/// Action button specification for Modalora Dialogs, BottomSheets, and Overlays.
///
/// Encapsulates label, callbacks, loading indicators, custom styling overrides,
/// and expansion behavior.
class ModaloraButton {
  /// Creates an action button configuration.
  const ModaloraButton({
    required this.label,
    this.onPressed,
    this.variant = ModaloraButtonVariant.primary,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.isLoading = false,
    this.isExpanded = true,
  });

  /// The text label displayed inside the button.
  final String label;

  /// Callback executed when the button is tapped.
  /// If null, tapping pops the current Navigator route.
  final VoidCallback? onPressed;

  /// Visual style variant (primary, secondary, destructive, outlined, text).
  final ModaloraButtonVariant variant;

  /// Optional leading icon widget.
  final Widget? icon;

  /// Custom background color override.
  final Color? backgroundColor;

  /// Custom text and icon color override.
  final Color? textColor;

  /// Custom corner border radius override.
  final BorderRadius? borderRadius;

  /// Custom internal padding override.
  final EdgeInsetsGeometry? padding;

  /// Whether to display an inline circular loading spinner instead of label/icon.
  final bool isLoading;

  /// Whether the button expands to fill available horizontal flex space in row layouts.
  final bool isExpanded;
}

/// Layout arrangement strategy for dialog action buttons.
enum ModaloraButtonLayout {
  /// Arrange buttons side-by-side in a horizontal Row.
  horizontal,

  /// Stack buttons vertically in a Column.
  vertical,

  /// Automatically switches to vertical stack if there are more than 2 buttons.
  auto;
}

/// Prebuilt, highly customizable Modalora Dialog widget.
///
/// Features hardware-accelerated frosted glass backdrop, customizable headers,
/// dynamic action buttons, auto-close timer indicators, and fluid responsiveness.
class ModaloraDialogWidget extends StatefulWidget {
  /// Creates a Modalora dialog widget instance.
  const ModaloraDialogWidget({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.child,
    this.actions,
    this.primaryAction,
    this.secondaryAction,
    this.destructiveAction,
    this.buttonLayout = ModaloraButtonLayout.horizontal,
    this.buttonSpacing,
    this.width,
    this.height,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.padding,
    this.margin,
    this.alignment,
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
    this.iconSize,
    this.iconColor,
    this.iconBackgroundColor,
    this.iconPadding,
    this.iconBorderRadius,
    this.autoCloseDuration,
  });

  /// The primary dialog headline text.
  final String? title;

  /// The secondary supporting description text.
  final String? message;

  /// Optional icon widget displayed above the title.
  final Widget? icon;

  /// Custom content widget rendered inside the dialog body.
  final Widget? child;

  /// Explicit list of action buttons.
  final List<ModaloraButton>? actions;

  /// Convenient primary action button configuration.
  final ModaloraButton? primaryAction;

  /// Convenient secondary action button configuration.
  final ModaloraButton? secondaryAction;

  /// Convenient destructive action button configuration.
  final ModaloraButton? destructiveAction;

  /// Layout orientation for action buttons (horizontal, vertical, or auto).
  final ModaloraButtonLayout buttonLayout;

  /// Spacing between action buttons.
  final double? buttonSpacing;

  /// Explicit width for the dialog container.
  final double? width;

  /// Explicit height for the dialog container.
  final double? height;

  /// Minimum width constraint.
  final double? minWidth;

  /// Maximum width constraint.
  final double? maxWidth;

  /// Minimum height constraint.
  final double? minHeight;

  /// Maximum height constraint.
  final double? maxHeight;

  /// Inner padding around dialog content.
  final EdgeInsetsGeometry? padding;

  /// Outer margin surrounding the dialog container.
  final EdgeInsetsGeometry? margin;

  /// Alignment within the screen viewport (defaults to [Alignment.center]).
  final Alignment? alignment;

  /// Background color of the glass container.
  final Color? backgroundColor;

  /// Surface color override for the dialog container.
  final Color? surfaceColor;

  /// Corner radius for the dialog container.
  final BorderRadius? borderRadius;

  /// Explicit box border.
  final BoxBorder? border;

  /// Border line width.
  final double? borderWidth;

  /// Border line color.
  final Color? borderColor;

  /// Drop shadows cast by the dialog card.
  final List<BoxShadow>? boxShadow;

  /// Backdrop blur sigma value applied behind the dialog surface.
  final double? surfaceBlur;

  /// Elevation depth for the dialog card.
  final double? elevation;

  /// Custom text style for the title headline.
  final TextStyle? titleStyle;

  /// Custom text style for the message body.
  final TextStyle? messageStyle;

  /// Size of the header icon.
  final double? iconSize;

  /// Color tint of the header icon.
  final Color? iconColor;

  /// Background color for the icon squircle container.
  final Color? iconBackgroundColor;

  /// Internal padding for the icon squircle container.
  final EdgeInsetsGeometry? iconPadding;

  /// Corner radius for the icon squircle container.
  final BorderRadius? iconBorderRadius;

  /// If provided, automatically dismisses the dialog after this duration with a live progress bar.
  final Duration? autoCloseDuration;

  @override
  State<ModaloraDialogWidget> createState() => _ModaloraDialogWidgetState();
}

class _ModaloraDialogWidgetState extends State<ModaloraDialogWidget>
    with SingleTickerProviderStateMixin {
  /// Timer managing programmatic dismissal on auto-close.
  Timer? _autoCloseTimer;

  /// Controller driving the linear countdown timer progress bar.
  AnimationController? _autoCloseController;

  @override
  void initState() {
    super.initState();
    // Initialize auto-close countdown timer and animation controller if specified
    if (widget.autoCloseDuration != null) {
      _autoCloseController = AnimationController(
        vsync: this,
        duration: widget.autoCloseDuration!,
      )..forward();

      _autoCloseTimer = Timer(widget.autoCloseDuration!, () {
        if (mounted) {
          Navigator.of(context).maybePop();
        }
      });
    }
  }

  @override
  void dispose() {
    // Cancel active timer and release ticker resources to prevent memory leaks
    _autoCloseTimer?.cancel();
    _autoCloseController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Resolve ambient theme hierarchy: widget properties -> component theme -> global theme -> default fallback
    final theme = ModaloraTheme.of(context);
    final dialogTheme = theme.dialogTheme;

    // Resolve surface and background colors
    final effectiveBg = widget.surfaceColor ??
        widget.backgroundColor ??
        dialogTheme.surfaceColor ??
        dialogTheme.backgroundColor ??
        theme.surfaceColor;

    // Resolve border styling and corner radius
    final effectiveRadius = widget.borderRadius ?? dialogTheme.borderRadius;
    final effectiveBorderColor = widget.borderColor ?? dialogTheme.borderColor ?? theme.borderColor;
    final effectiveBorderWidth = widget.borderWidth ?? dialogTheme.borderWidth;
    final effectiveBorder = widget.border ?? Border.all(color: effectiveBorderColor, width: effectiveBorderWidth);

    // Resolve shadow, blur, and layout dimensions
    final effectiveShadow = widget.boxShadow ?? dialogTheme.boxShadow;
    final effectiveBlur = widget.surfaceBlur ?? dialogTheme.surfaceBlur;
    final effectivePadding = widget.padding ?? dialogTheme.padding;
    final effectiveMargin = widget.margin ?? dialogTheme.margin;
    final effectiveMinWidth = widget.minWidth ?? dialogTheme.minWidth;
    final effectiveMaxWidth = widget.maxWidth ?? dialogTheme.maxWidth;

    // Resolve typography styling
    final effectiveTitleStyle = (dialogTheme.titleStyle ??
            TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: theme.textColor,
            ))
        .merge(widget.titleStyle);

    final effectiveMessageStyle = (dialogTheme.messageStyle ??
            TextStyle(
              fontSize: 14.5,
              color: theme.textSecondaryColor,
            ))
        .merge(widget.messageStyle);

    // Resolve icon container visual tokens
    final effectiveIconBg = widget.iconBackgroundColor ??
        dialogTheme.iconBackgroundColor ??
        theme.primaryColor.withValues(alpha: 0.12);

    final effectiveIconColor = widget.iconColor ?? dialogTheme.iconColor ?? theme.primaryColor;
    final effectiveIconSize = widget.iconSize ?? dialogTheme.iconSize;
    final effectiveSpacing = widget.buttonSpacing ?? dialogTheme.buttonSpacing;

    // Assemble action buttons list from explicit actions or convenience action helpers
    final buttonList = <ModaloraButton>[];
    if (widget.actions != null) {
      buttonList.addAll(widget.actions!);
    } else {
      if (widget.secondaryAction != null) buttonList.add(widget.secondaryAction!);
      if (widget.destructiveAction != null) buttonList.add(widget.destructiveAction!);
      if (widget.primaryAction != null) buttonList.add(widget.primaryAction!);
    }

    // Determine layout orientation for buttons
    final isVertical = widget.buttonLayout == ModaloraButtonLayout.vertical ||
        (widget.buttonLayout == ModaloraButtonLayout.auto && buttonList.length > 2);

    return Align(
      alignment: widget.alignment ?? dialogTheme.alignment,
      child: Material(
        type: MaterialType.transparency,
        child: ModaloraGlassContainer(
          width: widget.width,
          height: widget.height,
          constraints: BoxConstraints(
            minWidth: effectiveMinWidth,
            maxWidth: effectiveMaxWidth,
            minHeight: widget.minHeight ?? 0,
            maxHeight: widget.maxHeight ?? double.infinity,
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Icon Squircle Header
              if (widget.icon != null) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: widget.iconPadding ?? dialogTheme.iconPadding,
                    decoration: BoxDecoration(
                      color: effectiveIconBg,
                      borderRadius: widget.iconBorderRadius ?? dialogTheme.iconBorderRadius,
                      border: Border.all(
                        color: effectiveIconColor.withValues(alpha: 0.25),
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: effectiveIconColor.withValues(alpha: 0.2),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconTheme(
                      data: IconThemeData(
                        size: effectiveIconSize,
                        color: effectiveIconColor,
                      ),
                      child: widget.icon!,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],

              // 2. Title Headline
              if (widget.title != null) ...[
                Text(
                  widget.title!,
                  style: effectiveTitleStyle.copyWith(
                    letterSpacing: -0.4,
                  ),
                ),
                if (widget.message != null || widget.child != null)
                  const SizedBox(height: 8.0),
              ],

              // 3. Message Body
              if (widget.message != null) ...[
                Text(
                  widget.message!,
                  style: effectiveMessageStyle.copyWith(
                    height: 1.45,
                  ),
                ),
              ],

              // 4. Custom Body Child
              if (widget.child != null) ...[
                if (widget.title != null || widget.message != null)
                  const SizedBox(height: 16.0),
                widget.child!,
              ],

              // 5. Action Buttons Row/Column
              if (buttonList.isNotEmpty) ...[
                const SizedBox(height: 24.0),
                if (isVertical)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < buttonList.length; i++) ...[
                        if (i > 0) SizedBox(height: effectiveSpacing),
                        _buildButton(context, buttonList[i], dialogTheme, theme),
                      ],
                    ],
                  )
                else
                  Row(
                    children: [
                      for (int i = 0; i < buttonList.length; i++) ...[
                        if (i > 0) SizedBox(width: effectiveSpacing),
                        Expanded(
                          flex: buttonList[i].isExpanded ? 1 : 0,
                          child: _buildButton(context, buttonList[i], dialogTheme, theme),
                        ),
                      ],
                    ],
                  ),
              ],

              // 6. Auto-close Countdown Progress Indicator
              if (_autoCloseController != null) ...[
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: AnimatedBuilder(
                    animation: _autoCloseController!,
                    builder: (context, _) {
                      return LinearProgressIndicator(
                        value: 1.0 - _autoCloseController!.value,
                        backgroundColor: Colors.white.withValues(alpha: 0.1),
                        valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
                        minHeight: 3.0,
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a styled, interactive action button based on the [ModaloraButtonVariant].
  Widget _buildButton(
    BuildContext context,
    ModaloraButton button,
    ModaloraDialogTheme dialogTheme,
    dynamic theme,
  ) {
    Color bg;
    Color fg;
    BorderSide? borderSide;
    List<BoxShadow>? shadow;

    // Resolve color styling per button variant
    switch (button.variant) {
      case ModaloraButtonVariant.primary:
        bg = button.backgroundColor ?? dialogTheme.primaryButtonBackgroundColor ?? theme.primaryColor;
        fg = button.textColor ?? dialogTheme.primaryButtonTextColor ?? Colors.white;
        shadow = [
          BoxShadow(
            color: bg.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ];
        break;

      case ModaloraButtonVariant.secondary:
        bg = button.backgroundColor ??
            dialogTheme.secondaryButtonBackgroundColor ??
            (theme.isDark ? const Color(0xFF27272A) : const Color(0xFFF1F5F9));
        fg = button.textColor ?? dialogTheme.secondaryButtonTextColor ?? theme.textColor;
        borderSide = BorderSide(
          color: theme.isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.08),
          width: 0.8,
        );
        break;

      case ModaloraButtonVariant.destructive:
        bg = button.backgroundColor ?? dialogTheme.destructiveButtonBackgroundColor ?? theme.errorColor;
        fg = button.textColor ?? dialogTheme.destructiveButtonTextColor ?? Colors.white;
        shadow = [
          BoxShadow(
            color: bg.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ];
        break;

      case ModaloraButtonVariant.outlined:
        bg = button.backgroundColor ?? Colors.transparent;
        fg = button.textColor ?? theme.textColor;
        borderSide = BorderSide(color: theme.borderColor, width: 1.0);
        break;

      case ModaloraButtonVariant.text:
        bg = button.backgroundColor ?? Colors.transparent;
        fg = button.textColor ?? theme.primaryColor;
        break;
    }

    final radius = button.borderRadius ?? dialogTheme.buttonBorderRadius;
    final padding = button.padding ?? dialogTheme.buttonPadding;

    Widget btnWidget = Material(
      color: bg,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: borderSide ?? BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: button.isLoading
            ? null
            : () {
                if (button.onPressed != null) {
                  button.onPressed!();
                } else {
                  Navigator.of(context).maybePop();
                }
              },
        borderRadius: radius,
        child: Padding(
          padding: padding,
          child: Center(
            child: button.isLoading
                ? SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor: AlwaysStoppedAnimation<Color>(fg),
                    ),
                  )
                : FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (button.icon != null) ...[
                          IconTheme(
                            data: IconThemeData(size: 18, color: fg),
                            child: button.icon!,
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          button.label,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: fg,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );

    // Apply glow box shadow if configured
    if (shadow != null && shadow.isNotEmpty) {
      btnWidget = Container(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: shadow,
        ),
        child: btnWidget,
      );
    }

    return btnWidget;
  }
}
