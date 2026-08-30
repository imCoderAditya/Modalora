import 'package:flutter/material.dart';
import '../../theme/modalora_theme.dart';
import '../../utils/backdrop_filter.dart';

/// Prebuilt, highly customizable Modalora BottomSheet widget.
///
/// Features Apple-grade frosted glass container, drag handle indicators,
/// edge-to-edge screen anchoring, safe-inset cushioning, and interactive draggable scroll physics.
class ModaloraBottomSheetWidget extends StatelessWidget {
  /// Creates a customizable Modalora bottom sheet widget.
  const ModaloraBottomSheetWidget({
    super.key,
    this.title,
    this.message,
    this.child,
    this.header,
    this.footer,
    this.showDragHandle,
    this.dragHandleColor,
    this.dragHandleWidth,
    this.dragHandleHeight,
    this.dragHandleBorderRadius,
    this.height,
    this.minHeight,
    this.maxHeight,
    this.initialSize,
    this.minChildSize,
    this.maxChildSize,
    this.snapPoints,
    this.snap,
    this.isDraggable,
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
    this.useSafeArea = true,
    this.alignment,
  });

  /// The primary bottom sheet headline title.
  final String? title;

  /// The supporting description message.
  final String? message;

  /// Main body content widget.
  final Widget? child;

  /// Custom top header widget (rendered below drag handle, above title).
  final Widget? header;

  /// Custom bottom footer widget (rendered at the bottom of the sheet).
  final Widget? footer;

  /// Whether to display the top pill drag handle.
  final bool? showDragHandle;

  /// Color tint of the drag handle bar.
  final Color? dragHandleColor;

  /// Width of the drag handle pill.
  final double? dragHandleWidth;

  /// Height / thickness of the drag handle pill.
  final double? dragHandleHeight;

  /// Corner radius of the drag handle pill.
  final BorderRadius? dragHandleBorderRadius;

  /// Explicit height of the bottom sheet container.
  final double? height;

  /// Minimum height constraint.
  final double? minHeight;

  /// Maximum height constraint.
  final double? maxHeight;

  /// Initial fractional size (0.0 to 1.0) when used with draggable scrollable sheet.
  final double? initialSize;

  /// Minimum fractional size (0.0 to 1.0) for draggable sheet.
  final double? minChildSize;

  /// Maximum fractional size (0.0 to 1.0) for draggable sheet.
  final double? maxChildSize;

  /// Snap point fractions for multistage expansion.
  final List<double>? snapPoints;

  /// Whether draggable sheet snaps between snapPoints.
  final bool? snap;

  /// Whether user can drag up/down to expand/collapse.
  final bool? isDraggable;

  /// Inner padding inside the sheet container.
  final EdgeInsetsGeometry? padding;

  /// Outer margin surrounding the sheet.
  final EdgeInsetsGeometry? margin;

  /// Background color of the container.
  final Color? backgroundColor;

  /// Frosted glass surface tint color.
  final Color? surfaceColor;

  /// Rounded corner radius for the sheet (defaults to top rounded corners).
  final BorderRadius? borderRadius;

  /// Explicit box border.
  final BoxBorder? border;

  /// Border outline width.
  final double? borderWidth;

  /// Border outline color.
  final Color? borderColor;

  /// Drop shadows cast beneath the sheet surface.
  final List<BoxShadow>? boxShadow;

  /// Backdrop blur sigma value for frosted glassmorphism.
  final double? surfaceBlur;

  /// Material elevation depth.
  final double? elevation;

  /// Custom text style for title.
  final TextStyle? titleStyle;

  /// Custom text style for message body.
  final TextStyle? messageStyle;

  /// Whether to automatically absorb bottom safe-area home indicators into inner padding.
  final bool useSafeArea;

  /// Screen alignment (defaults to [Alignment.bottomCenter]).
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    // 1. Resolve ambient theme hierarchy
    final theme = ModaloraTheme.of(context);
    final sheetTheme = theme.bottomSheetTheme;

    // 2. Resolve background and surface colors
    final effectiveBg = surfaceColor ??
        backgroundColor ??
        sheetTheme.surfaceColor ??
        sheetTheme.backgroundColor ??
        theme.surfaceColor;

    // 3. Resolve corner radius, borders, and shadows
    final effectiveRadius = borderRadius ?? sheetTheme.borderRadius;
    final effectiveBorderColor =
        borderColor ?? sheetTheme.borderColor ?? theme.borderColor;
    final effectiveBorderWidth = borderWidth ?? sheetTheme.borderWidth;
    final effectiveBorder = border ??
        Border.all(color: effectiveBorderColor, width: effectiveBorderWidth);
    final effectiveShadow = boxShadow ?? sheetTheme.boxShadow;
    final effectiveBlur = surfaceBlur ?? sheetTheme.surfaceBlur;
    final effectivePadding = padding ?? sheetTheme.padding;

    // 4. Resolve typography styles
    final effectiveTitleStyle = (sheetTheme.titleStyle ??
            TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: theme.textColor,
            ))
        .merge(titleStyle);

    final effectiveMessageStyle = (sheetTheme.messageStyle ??
            TextStyle(
              fontSize: 14.5,
              color: theme.textSecondaryColor,
            ))
        .merge(messageStyle);

    // 5. Resolve drag handle pill dimensions and styling
    final effectiveShowDrag = showDragHandle ?? sheetTheme.showDragHandle;
    final effectiveDragColor = dragHandleColor ??
        sheetTheme.dragHandleColor ??
        (theme.isDark
            ? Colors.white.withValues(alpha: 0.25)
            : Colors.black.withValues(alpha: 0.2));
    final effectiveDragWidth = dragHandleWidth ?? sheetTheme.dragHandleWidth;
    final effectiveDragHeight = dragHandleHeight ?? sheetTheme.dragHandleHeight;
    final effectiveDragRadius =
        dragHandleBorderRadius ?? sheetTheme.dragHandleBorderRadius;

    // 6. Build the interior column structure
    Widget sheetContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Drag Handle Pill Indicator
        if (effectiveShowDrag)
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 12.0),
              width: effectiveDragWidth,
              height: effectiveDragHeight,
              decoration: BoxDecoration(
                color: effectiveDragColor,
                borderRadius: effectiveDragRadius,
              ),
            ),
          ),

        // Optional Top Header Slot
        if (header != null) header!,

        // Title Headline
        if (title != null) ...[
          Text(
            title!,
            style: effectiveTitleStyle.copyWith(letterSpacing: -0.4),
          ),
          if (message != null || child != null) const SizedBox(height: 8.0),
        ],

        // Message Body
        if (message != null) ...[
          Text(
            message!,
            style: effectiveMessageStyle.copyWith(height: 1.45),
          ),
          if (child != null) const SizedBox(height: 16.0),
        ],

        // Main Custom Child Body
        if (child != null) child!,

        // Optional Bottom Footer Slot
        if (footer != null) ...[
          const SizedBox(height: 16.0),
          footer!,
        ],
      ],
    );

    // 7. Calculate device safe-area insets to ensure edge-to-edge flush bottom look
    final bottomInset =
        useSafeArea ? MediaQuery.paddingOf(context).bottom : 0.0;
    final EdgeInsets resolvedPadding = (effectivePadding is EdgeInsets)
        ? (effectivePadding)
            .copyWith(bottom: (effectivePadding).bottom + bottomInset)
        : effectivePadding.add(EdgeInsets.only(bottom: bottomInset))
            as EdgeInsets;

    // 8. Resolve final viewport alignment
    final effectiveAlignment = alignment ?? sheetTheme.alignment;

    // 9. Wrap in hardware-accelerated glass container
    Widget sheet = Align(
      alignment: effectiveAlignment,
      child: Material(
        type: MaterialType.transparency,
        child: ModaloraGlassContainer(
          width: double.infinity,
          height: height,
          constraints: BoxConstraints(
            minHeight: minHeight ?? 0,
            maxHeight: maxHeight ?? MediaQuery.of(context).size.height * 0.9,
          ),
          padding: resolvedPadding,
          margin: margin,
          backgroundColor: effectiveBg,
          borderRadius: effectiveRadius,
          border: effectiveBorder,
          boxShadow: effectiveShadow,
          blur: effectiveBlur,
          child: sheetContent,
        ),
      ),
    );

    return sheet;
  }
}

/// Action item configuration for [ModaloraActionSheetWidget].
class ModaloraActionSheetItem {
  /// Creates an action item for the action sheet.
  const ModaloraActionSheetItem({
    required this.title,
    this.icon,
    this.isDestructive = false,
    this.onTap,
  });

  /// The display title for the action row.
  final String title;

  /// Optional leading icon widget.
  final Widget? icon;

  /// Whether this is a high-risk destructive action (rendered in error red tint).
  final bool isDestructive;

  /// Callback executed when the action row is tapped.
  final VoidCallback? onTap;
}

/// A luxury iOS-style frosted action sheet widget with grouped actions and a separate cancel capsule.
class ModaloraActionSheetWidget extends StatelessWidget {
  /// Creates a frosted action sheet widget.
  const ModaloraActionSheetWidget({
    super.key,
    this.title,
    this.message,
    required this.actions,
    this.cancelText = 'Cancel',
    this.onCancel,
  });

  /// Optional title headline.
  final String? title;

  /// Optional message description.
  final String? message;

  /// List of grouped action options.
  final List<ModaloraActionSheetItem> actions;

  /// Text for the bottom cancel button capsule.
  final String cancelText;

  /// Callback triggered when cancel button is tapped.
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = ModaloraTheme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Grouped Action Options Card
        Container(
          decoration: BoxDecoration(
            color: theme.isDark
                ? Colors.white.withValues(alpha: 0.06)
                : Colors.black.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: theme.borderColor),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header title and message row
              if (title != null || message != null) ...[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Column(
                    children: [
                      if (title != null)
                        Text(
                          title!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: theme.textColor,
                          ),
                        ),
                      if (title != null && message != null)
                        const SizedBox(height: 4),
                      if (message != null)
                        Text(
                          message!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: theme.textSecondaryColor,
                          ),
                        ),
                    ],
                  ),
                ),
                const Divider(height: 1),
              ],
              // Action items with divider separators
              for (int i = 0; i < actions.length; i++) ...[
                if (i > 0) const Divider(height: 1),
                _buildActionItem(context, theme, actions[i]),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        // 2. Separate Cancel Button Capsule
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).maybePop();
            if (onCancel != null) onCancel!();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.isDark
                ? const Color(0xFF27272A)
                : const Color(0xFFE2E8F0),
            foregroundColor: theme.textColor,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: Text(
            cancelText,
            style: TextStyle(
                fontSize: 15.5,
                fontWeight: FontWeight.w700,
                color: theme.textColor),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  /// Builds an individual action row with ink ripple response.
  Widget _buildActionItem(BuildContext context, ModaloraThemeData theme,
      ModaloraActionSheetItem item) {
    final color = item.isDestructive ? theme.errorColor : theme.textColor;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          Navigator.of(context).maybePop();
          if (item.onTap != null) item.onTap!();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (item.icon != null) ...[
                IconTheme(
                  data: IconThemeData(size: 20, color: color),
                  child: item.icon!,
                ),
                const SizedBox(width: 10),
              ],
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                      item.isDestructive ? FontWeight.w700 : FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
