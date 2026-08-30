import 'package:flutter/material.dart';
import '../../theme/modalora_theme.dart';

/// Base abstract class for entries rendered within a Modalora Menu.
abstract class ModaloraMenuEntry {
  /// Base constructor.
  const ModaloraMenuEntry();
}

/// A standard interactive item inside a Modalora Menu.
///
/// Supports icons, subtitles, keyboard shortcut tags, sub-menu expansion arrows,
/// selection states, disable states, and destructive red styling.
class ModaloraMenuItem extends ModaloraMenuEntry {
  /// Creates a menu item entry.
  const ModaloraMenuItem({
    required this.title,
    this.subtitle,
    this.icon,
    this.shortcut,
    this.trailing,
    this.onTap,
    this.isSelected = false,
    this.isDisabled = false,
    this.isDestructive = false,
    this.subItems,
    this.height,
    this.padding,
  });

  /// The primary title label.
  final String title;

  /// Optional supporting subtitle text.
  final String? subtitle;

  /// Optional leading icon widget.
  final Widget? icon;

  /// Keyboard shortcut text displayed inside a keycap pill (e.g. '⌘C').
  final String? shortcut;

  /// Custom trailing widget (replaces default submenu chevron if present).
  final Widget? trailing;

  /// Callback executed when the item is tapped.
  final VoidCallback? onTap;

  /// Whether the item is currently active / selected.
  final bool isSelected;

  /// Whether the item is disabled and non-interactive.
  final bool isDisabled;

  /// Whether this is a destructive action (styled in error red).
  final bool isDestructive;

  /// Nested child menu entries for multi-level cascading submenus.
  final List<ModaloraMenuEntry>? subItems;

  /// Minimum height constraint.
  final double? height;

  /// Internal padding override.
  final EdgeInsetsGeometry? padding;
}

/// A visual separator line divider inside a Modalora Menu.
class ModaloraMenuDivider extends ModaloraMenuEntry {
  /// Creates a menu separator divider.
  const ModaloraMenuDivider({
    this.height = 1.0,
    this.color,
    this.margin = const EdgeInsets.symmetric(vertical: 4.0),
  });

  /// Divider stroke thickness.
  final double height;

  /// Divider line color override.
  final Color? color;

  /// Margin spacing surrounding the divider.
  final EdgeInsetsGeometry margin;
}

/// Widget representation of a single interactive [ModaloraMenuItem].
class ModaloraMenuItemWidget extends StatefulWidget {
  /// Creates a menu item widget.
  const ModaloraMenuItemWidget({
    super.key,
    required this.item,
    this.onCloseMenu,
    this.onOpenSubMenu,
  });

  /// The underlying menu item data model.
  final ModaloraMenuItem item;

  /// Callback to dismiss parent menu.
  final VoidCallback? onCloseMenu;

  /// Callback to spawn child submenu.
  final void Function(BuildContext context, ModaloraMenuItem item)? onOpenSubMenu;

  @override
  State<ModaloraMenuItemWidget> createState() => _ModaloraMenuItemWidgetState();
}

class _ModaloraMenuItemWidgetState extends State<ModaloraMenuItemWidget> {
  /// Hover state tracker for pointer devices
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // 1. Resolve ambient theme hierarchy
    final theme = ModaloraTheme.of(context);
    final itemTheme = theme.menuTheme.itemTheme;
    final item = widget.item;

    Color fg;
    Color? bg;

    // 2. Resolve interactive foreground and background state colors
    if (item.isDisabled) {
      fg = theme.textColor.withValues(alpha: itemTheme.disabledOpacity);
    } else if (item.isDestructive) {
      fg = itemTheme.destructiveColor;
    } else if (item.isSelected) {
      fg = itemTheme.selectedTextColor ?? theme.primaryColor;
      bg = itemTheme.selectedBackgroundColor ?? theme.primaryColor.withValues(alpha: 0.15);
    } else if (_isHovered) {
      fg = theme.textColor;
      bg = itemTheme.hoverColor ?? (theme.isDark ? const Color(0xFF27272A) : const Color(0xFFF1F5F9));
    } else {
      fg = theme.textColor;
    }

    // 3. Resolve typography styles
    final effectiveTextStyle = (itemTheme.textStyle ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)).copyWith(color: fg);
    final effectiveSubtitleStyle = (itemTheme.subtitleStyle ?? const TextStyle(fontSize: 12)).copyWith(color: fg.withValues(alpha: 0.7));
    final effectiveShortcutStyle = (itemTheme.shortcutStyle ?? const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)).copyWith(color: fg.withValues(alpha: 0.6));

    final effectiveRadius = itemTheme.borderRadius;
    final effectivePadding = item.padding ?? itemTheme.padding;
    final effectiveHeight = item.height ?? itemTheme.height;

    // 4. Build mouse hover region and ink well
    return MouseRegion(
      onEnter: item.isDisabled ? null : (_) {
        setState(() => _isHovered = true);
        if (item.subItems != null && item.subItems!.isNotEmpty && widget.onOpenSubMenu != null) {
          widget.onOpenSubMenu!(context, item);
        }
      },
      onExit: item.isDisabled ? null : (_) => setState(() => _isHovered = false),
      child: Material(
        color: bg ?? Colors.transparent,
        borderRadius: effectiveRadius,
        child: InkWell(
          onTap: item.isDisabled
              ? null
              : () {
                  if (item.onTap != null) item.onTap!();
                  if (item.subItems == null && widget.onCloseMenu != null) {
                    widget.onCloseMenu!();
                  }
                },
          borderRadius: effectiveRadius,
          child: Container(
            constraints: BoxConstraints(minHeight: effectiveHeight),
            padding: effectivePadding,
            child: Row(
              children: [
                // Leading Icon
                if (item.icon != null) ...[
                  IconTheme(
                    data: IconThemeData(
                      size: itemTheme.iconSize,
                      color: item.isDisabled ? fg : (item.isDestructive ? itemTheme.destructiveColor : (item.isSelected ? fg : itemTheme.iconColor ?? fg)),
                    ),
                    child: item.icon!,
                  ),
                  const SizedBox(width: 12),
                ],
                // Title and Subtitle Column
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: effectiveTextStyle),
                      if (item.subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(item.subtitle!, style: effectiveSubtitleStyle),
                      ],
                    ],
                  ),
                ),
                // Keyboard Shortcut Keycap Pill
                if (item.shortcut != null) ...[
                  const SizedBox(width: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: theme.isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : Colors.black.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: theme.isDark
                            ? Colors.white.withValues(alpha: 0.12)
                            : Colors.black.withValues(alpha: 0.08),
                        width: 0.8,
                      ),
                    ),
                    child: Text(
                      item.shortcut!,
                      style: effectiveShortcutStyle.copyWith(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ],
                // Trailing Widget or Submenu Arrow
                if (item.trailing != null) ...[
                  const SizedBox(width: 8),
                  item.trailing!,
                ] else if (item.subItems != null && item.subItems!.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Icon(Icons.chevron_right_rounded, size: 18, color: fg.withValues(alpha: 0.6)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
