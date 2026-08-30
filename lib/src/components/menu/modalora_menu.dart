import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../animation/modalora_animation.dart';
import '../../core/position.dart';
import '../../theme/modalora_theme.dart';
import '../../utils/backdrop_filter.dart';
import '../popup/popup_route.dart';
import 'menu_item.dart';

/// Prebuilt, highly customizable Modalora Menu container widget.
///
/// Encapsulates a glassmorphic container displaying a vertical list of menu items,
/// submenus, shortcut chips, and custom dividers.
class ModaloraMenuWidget extends StatelessWidget {
  /// Creates a Modalora menu container widget.
  const ModaloraMenuWidget({
    super.key,
    required this.items,
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
    this.dividerColor,
    this.onCloseMenu,
    this.onOpenSubMenu,
  });

  /// The list of menu items and dividers.
  final List<ModaloraMenuEntry> items;

  /// Explicit menu width.
  final double? width;

  /// Minimum width constraint.
  final double? minWidth;

  /// Maximum width constraint.
  final double? maxWidth;

  /// Inner padding surrounding the menu list.
  final EdgeInsetsGeometry? padding;

  /// Outer margin surrounding the menu card.
  final EdgeInsetsGeometry? margin;

  /// Container background color.
  final Color? backgroundColor;

  /// Glassmorphic surface color tint.
  final Color? surfaceColor;

  /// Corner radius of the menu container.
  final BorderRadius? borderRadius;

  /// Explicit box border.
  final BoxBorder? border;

  /// Border outline width.
  final double? borderWidth;

  /// Border outline color.
  final Color? borderColor;

  /// Drop shadows cast beneath the menu card.
  final List<BoxShadow>? boxShadow;

  /// Backdrop blur sigma value.
  final double? surfaceBlur;

  /// Elevation depth.
  final double? elevation;

  /// Custom divider separator line color.
  final Color? dividerColor;

  /// Callback executed when the menu should be dismissed.
  final VoidCallback? onCloseMenu;

  /// Callback executed when a submenu item is triggered.
  final void Function(BuildContext context, ModaloraMenuItem item)? onOpenSubMenu;

  @override
  Widget build(BuildContext context) {
    // 1. Resolve ambient theme hierarchy
    final theme = ModaloraTheme.of(context);
    final menuTheme = theme.menuTheme;

    // 2. Resolve background and surface colors
    final effectiveBg = surfaceColor ??
        backgroundColor ??
        menuTheme.surfaceColor ??
        menuTheme.backgroundColor ??
        theme.surfaceColor;

    // 3. Resolve border, radius, shadow, and blur
    final effectiveRadius = borderRadius ?? menuTheme.borderRadius;
    final effectiveBorderColor = borderColor ?? menuTheme.borderColor ?? theme.borderColor;
    final effectiveBorderWidth = borderWidth ?? menuTheme.borderWidth;
    final effectiveBorder = border ?? Border.all(color: effectiveBorderColor, width: effectiveBorderWidth);
    final effectiveShadow = boxShadow ?? menuTheme.boxShadow;
    final effectiveBlur = surfaceBlur ?? menuTheme.surfaceBlur;
    final effectivePadding = padding ?? menuTheme.padding;
    final effectiveMargin = margin ?? menuTheme.margin;
    final effectiveMinWidth = minWidth ?? menuTheme.minWidth;
    final effectiveMaxWidth = maxWidth ?? menuTheme.maxWidth;
    final effectiveDividerColor = dividerColor ?? menuTheme.dividerColor ?? theme.dividerColor;

    // 4. Build the glassmorphic menu card
    return Material(
      type: MaterialType.transparency,
      child: ModaloraGlassContainer(
        width: width,
        constraints: BoxConstraints(
          minWidth: effectiveMinWidth,
          maxWidth: effectiveMaxWidth,
        ),
        margin: effectiveMargin,
        padding: effectivePadding,
        backgroundColor: effectiveBg,
        borderRadius: effectiveRadius,
        border: effectiveBorder,
        boxShadow: effectiveShadow,
        blur: effectiveBlur,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Render each menu entry (item or separator divider)
              for (final entry in items) ...[
                if (entry is ModaloraMenuItem)
                  ModaloraMenuItemWidget(
                    item: entry,
                    onCloseMenu: onCloseMenu ?? () => Navigator.of(context).maybePop(),
                    onOpenSubMenu: onOpenSubMenu,
                  )
                else if (entry is ModaloraMenuDivider)
                  Container(
                    margin: entry.margin,
                    height: entry.height,
                    color: entry.color ?? effectiveDividerColor,
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// A region wrapper that handles right-click (desktop/web) and long-press (mobile) to trigger a Modalora context menu.
class ModaloraContextMenuRegion extends StatelessWidget {
  /// Creates a context menu trigger region.
  const ModaloraContextMenuRegion({
    super.key,
    required this.items,
    required this.child,
    this.animation,
    this.borderRadius,
    this.backgroundColor,
  });

  /// Menu entries displayed inside the context menu.
  final List<ModaloraMenuEntry> items;

  /// The interactive child widget wrapped by this region.
  final Widget child;

  /// Custom animation configuration.
  final ModaloraAnimation? animation;

  /// Corner radius override.
  final BorderRadius? borderRadius;

  /// Background color override.
  final Color? backgroundColor;

  /// Spawns the context menu at the tap/pointer coordinates.
  void _showMenu(BuildContext context, Offset globalPosition) {
    final theme = ModaloraTheme.of(context);
    final animationConfig = animation ?? theme.menuTheme.animation;
    final targetRect = Rect.fromCenter(center: globalPosition, width: 2, height: 2);

    Navigator.of(context, rootNavigator: true).push(
      ModaloraPopupRoute(
        targetRect: targetRect,
        anchor: ModaloraPopupAnchor.bottomRight,
        animationConfig: animationConfig,
        builder: (context, _) => ModaloraMenuWidget(
          items: items,
          borderRadius: borderRadius,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      // Handles desktop / web secondary (right-click) button press
      onPointerDown: (event) {
        if (event.kind == PointerDeviceKind.mouse && event.buttons == kSecondaryMouseButton) {
          _showMenu(context, event.position);
        }
      },
      // Handles mobile / touch long-press gesture
      child: GestureDetector(
        onLongPressStart: (details) {
          _showMenu(context, details.globalPosition);
        },
        child: child,
      ),
    );
  }
}
