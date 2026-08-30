library modalora;

import 'dart:async';
import 'package:flutter/material.dart';

// Core exports
export 'src/core/config.dart';
export 'src/core/overlay_controller.dart';
export 'src/core/position.dart';
export 'src/core/responsive.dart';

// Theme exports
export 'src/theme/animation_theme.dart';
export 'src/theme/bottom_sheet_theme.dart';
export 'src/theme/dialog_theme.dart';
export 'src/theme/menu_theme.dart';
export 'src/theme/modalora_theme.dart';
export 'src/theme/modalora_theme_data.dart';
export 'src/theme/overlay_theme.dart';
export 'src/theme/popup_theme.dart';
export 'src/theme/snackbar_theme.dart';

// Animation exports
export 'src/animation/animation_builder.dart';
export 'src/animation/modalora_animation.dart';
export 'src/animation/spring_curve.dart';

// Component exports
export 'src/components/bottom_sheet/bottom_sheet_route.dart';
export 'src/components/bottom_sheet/modalora_bottom_sheet.dart';
export 'src/components/dialog/dialog_route.dart';
export 'src/components/dialog/modalora_dialog.dart';
export 'src/components/menu/menu_item.dart';
export 'src/components/menu/modalora_menu.dart';
export 'src/components/overlay/loading_indicator.dart';
export 'src/components/overlay/modalora_overlay.dart';
export 'src/components/popup/modalora_popup.dart';
export 'src/components/popup/popup_route.dart';
export 'src/components/snackbar/modalora_snackbar.dart';
export 'src/components/snackbar/snackbar_queue.dart';
export 'src/components/tilt/modalora_hologram_dialog.dart';
export 'src/components/tilt/modalora_tilt_card.dart';

// Utility exports
export 'src/utils/backdrop_filter.dart';
export 'src/utils/key_finder.dart';

import 'src/animation/modalora_animation.dart';
import 'src/components/bottom_sheet/bottom_sheet_route.dart';
import 'src/components/bottom_sheet/modalora_bottom_sheet.dart';
import 'src/components/dialog/dialog_route.dart';
import 'src/components/dialog/modalora_dialog.dart';
import 'src/components/menu/menu_item.dart';
import 'src/components/menu/modalora_menu.dart';
import 'src/components/overlay/modalora_overlay.dart';
import 'src/components/popup/modalora_popup.dart';
import 'src/components/popup/popup_route.dart';
import 'src/components/snackbar/modalora_snackbar.dart';
import 'src/components/snackbar/snackbar_queue.dart';
import 'src/components/tilt/modalora_hologram_dialog.dart';
import 'src/components/tilt/modalora_tilt_card.dart';
import 'src/core/config.dart';
import 'src/core/overlay_controller.dart';
import 'src/core/position.dart';
import 'src/core/responsive.dart';
import 'src/theme/modalora_theme.dart';
import 'src/theme/modalora_theme_data.dart';
import 'src/utils/key_finder.dart';

/// Top-level developer facade for the entire Modalora Overlay Experience System.
///
/// Provides a unified, luxury API for displaying Dialogs, BottomSheets, ActionSheets,
/// Popups, Menus, Snackbars, Loading Overlays, and Full-Screen Blockers.
class Modalora {
  Modalora._();

  /// Globally configures the Modalora experience (themes, navigator keys, breakpoints).
  static void configure({
    GlobalKey<NavigatorState>? navigatorKey,
    ModaloraThemeData? theme,
    ModaloraBreakpoints? breakpoints,
    ModaloraAdaptiveMode? adaptiveMode,
  }) {
    ModaloraConfig.configure(
      navigatorKey: navigatorKey,
      theme: theme,
      breakpoints: breakpoints,
      adaptiveMode: adaptiveMode,
    );
  }

  /// Displays a polished, highly customizable Modalora Dialog.
  ///
  /// Supports title, message, custom widget children, primary/secondary/destructive actions,
  /// auto-close progress indicators, and custom spring/fade transitions.
  static Future<T?> dialog<T>({
    BuildContext? context,
    String? title,
    String? message,
    Widget? icon,
    Widget? child,
    List<ModaloraButton>? actions,
    ModaloraButton? primaryAction,
    ModaloraButton? secondaryAction,
    ModaloraButton? destructiveAction,
    String? primaryActionText,
    VoidCallback? onPrimaryAction,
    String? secondaryActionText,
    VoidCallback? onSecondaryAction,
    String? destructiveActionText,
    VoidCallback? onDestructiveAction,
    ModaloraButtonLayout buttonLayout = ModaloraButtonLayout.horizontal,
    double? buttonSpacing,
    double? width,
    double? height,
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Alignment? alignment,
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
    double? surfaceBlur,
    double? elevation,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    double? iconSize,
    Color? iconColor,
    Color? iconBackgroundColor,
    EdgeInsetsGeometry? iconPadding,
    BorderRadius? iconBorderRadius,
    Duration? autoCloseDuration,
    ModaloraAnimation? animation,
    bool useRootNavigator = true,
  }) {
    // 1. Resolve context with fallback to globally configured navigatorKey
    final effectiveContext = context ?? ModaloraConfig.navigatorKey?.currentContext;
    if (effectiveContext == null) {
      throw StateError(
        'Modalora: No valid BuildContext found. Pass a context or set ModaloraConfig.configure(navigatorKey: ...)',
      );
    }

    // 2. Resolve ambient theme tokens
    final theme = ModaloraTheme.of(effectiveContext);
    final dialogTheme = theme.dialogTheme;
    final anim = animation ?? dialogTheme.animation;

    // 3. Assemble convenience action buttons
    final effectivePrimaryAction = primaryAction ??
        (primaryActionText != null
            ? ModaloraButton(
                label: primaryActionText,
                variant: ModaloraButtonVariant.primary,
                onPressed: onPrimaryAction,
              )
            : null);

    final effectiveSecondaryAction = secondaryAction ??
        (secondaryActionText != null
            ? ModaloraButton(
                label: secondaryActionText,
                variant: ModaloraButtonVariant.secondary,
                onPressed: onSecondaryAction,
              )
            : null);

    final effectiveDestructiveAction = destructiveAction ??
        (destructiveActionText != null
            ? ModaloraButton(
                label: destructiveActionText,
                variant: ModaloraButtonVariant.destructive,
                onPressed: onDestructiveAction,
              )
            : null);

    // 4. Push custom ModaloraDialogRoute onto Navigator
    return Navigator.of(effectiveContext, rootNavigator: useRootNavigator).push<T>(
      ModaloraDialogRoute<T>(
        barrierColor: barrierColor ?? dialogTheme.barrierColor ?? theme.barrierColor,
        barrierBlur: barrierBlur ?? dialogTheme.barrierBlur,
        barrierDismissible: barrierDismissible ?? dialogTheme.barrierDismissible,
        animationConfig: anim,
        builder: (ctx) => ModaloraTheme(
          data: theme,
          child: ModaloraDialogWidget(
            title: title,
            message: message,
            icon: icon,
            child: child,
            actions: actions,
            primaryAction: effectivePrimaryAction,
            secondaryAction: effectiveSecondaryAction,
            destructiveAction: effectiveDestructiveAction,
            buttonLayout: buttonLayout,
            buttonSpacing: buttonSpacing,
            width: width,
            height: height,
            minWidth: minWidth,
            maxWidth: maxWidth,
            minHeight: minHeight,
            maxHeight: maxHeight,
            padding: padding,
            margin: margin,
            alignment: alignment,
            backgroundColor: backgroundColor,
            surfaceColor: surfaceColor,
            borderRadius: borderRadius,
            border: border,
            borderWidth: borderWidth,
            borderColor: borderColor,
            boxShadow: boxShadow,
            surfaceBlur: surfaceBlur,
            elevation: elevation,
            titleStyle: titleStyle,
            messageStyle: messageStyle,
            iconSize: iconSize,
            iconColor: iconColor,
            iconBackgroundColor: iconBackgroundColor,
            iconPadding: iconPadding,
            iconBorderRadius: iconBorderRadius,
            autoCloseDuration: autoCloseDuration,
          ),
        ),
      ),
    );
  }

  /// Displays a modal BottomSheet with glassmorphism backdrop and edge-to-edge layout.
  static Future<T?> bottomSheet<T>({
    BuildContext? context,
    String? title,
    String? message,
    Widget? child,
    Widget? header,
    Widget? footer,
    bool? showDragHandle,
    Color? dragHandleColor,
    double? dragHandleWidth,
    double? dragHandleHeight,
    BorderRadius? dragHandleBorderRadius,
    double? height,
    double? minHeight,
    double? maxHeight,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
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
    double? surfaceBlur,
    double? elevation,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    ModaloraAnimation? animation,
    AlignmentGeometry? alignment,
    bool useSafeArea = true,
    bool useRootNavigator = true,
  }) {
    final effectiveContext = context ?? ModaloraConfig.navigatorKey?.currentContext;
    if (effectiveContext == null) {
      throw StateError(
        'Modalora: No valid BuildContext found. Pass a context or set ModaloraConfig.configure(navigatorKey: ...)',
      );
    }

    final theme = ModaloraTheme.of(effectiveContext);
    final sheetTheme = theme.bottomSheetTheme;
    final anim = animation ?? sheetTheme.animation;
    final effectiveAlignment = alignment ?? sheetTheme.alignment;

    return Navigator.of(effectiveContext, rootNavigator: useRootNavigator).push<T>(
      ModaloraBottomSheetRoute<T>(
        barrierColor: barrierColor ?? sheetTheme.barrierColor ?? theme.barrierColor,
        barrierBlur: barrierBlur ?? sheetTheme.barrierBlur,
        barrierDismissible: barrierDismissible ?? sheetTheme.barrierDismissible,
        animationConfig: anim,
        alignment: effectiveAlignment,
        builder: (ctx) => ModaloraTheme(
          data: theme,
          child: ModaloraBottomSheetWidget(
            title: title,
            message: message,
            child: child,
            header: header,
            footer: footer,
            showDragHandle: showDragHandle,
            dragHandleColor: dragHandleColor,
            dragHandleWidth: dragHandleWidth,
            dragHandleHeight: dragHandleHeight,
            dragHandleBorderRadius: dragHandleBorderRadius,
            height: height,
            minHeight: minHeight,
            maxHeight: maxHeight,
            padding: padding,
            margin: margin,
            backgroundColor: backgroundColor,
            surfaceColor: surfaceColor,
            borderRadius: borderRadius,
            border: border,
            borderWidth: borderWidth,
            borderColor: borderColor,
            boxShadow: boxShadow,
            surfaceBlur: surfaceBlur,
            elevation: elevation,
            titleStyle: titleStyle,
            messageStyle: messageStyle,
            alignment: effectiveAlignment,
            useSafeArea: useSafeArea,
          ),
        ),
      ),
    );
  }

  /// Displays an Apple-style modal ActionSheet with grouped options and a separate cancel button.
  static Future<T?> actionSheet<T>({
    BuildContext? context,
    String? title,
    String? message,
    required List<ModaloraActionSheetItem> actions,
    String cancelText = 'Cancel',
    VoidCallback? onCancel,
    double? barrierBlur,
    bool barrierDismissible = true,
    AlignmentGeometry? alignment,
  }) {
    return bottomSheet<T>(
      context: context,
      barrierBlur: barrierBlur,
      barrierDismissible: barrierDismissible,
      alignment: alignment,
      showDragHandle: false,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: ModaloraActionSheetWidget(
        title: title,
        message: message,
        actions: actions,
        cancelText: cancelText,
        onCancel: onCancel,
      ),
    );
  }

  /// Displays an anchor-targeted popup / tooltip.
  static Future<T?> popup<T>({
    BuildContext? context,
    GlobalKey? anchorKey,
    Rect? targetRect,
    String? title,
    String? message,
    Widget? child,
    ModaloraPopupAnchor anchor = ModaloraPopupAnchor.bottom,
    Offset offset = const Offset(0, 8.0),
    double? width,
    double? height,
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    Color? surfaceColor,
    Color? barrierColor,
    bool barrierDismissible = true,
    BorderRadius? borderRadius,
    BoxBorder? border,
    double? borderWidth,
    Color? borderColor,
    List<BoxShadow>? boxShadow,
    double? surfaceBlur,
    double? elevation,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    ModaloraAnimation? animation,
    bool useRootNavigator = true,
  }) {
    final effectiveContext = context ?? ModaloraConfig.navigatorKey?.currentContext;
    if (effectiveContext == null) {
      throw StateError(
        'Modalora: No valid BuildContext found. Pass a context or set ModaloraConfig.configure(navigatorKey: ...)',
      );
    }

    Rect? rect = targetRect;
    if (rect == null && anchorKey != null) {
      rect = ModaloraKeyFinder.getRectFromKey(anchorKey);
    }
    if (rect == null && context != null) {
      rect = ModaloraKeyFinder.getRect(context);
    }
    if (rect == null) {
      final size = MediaQuery.of(effectiveContext).size;
      rect = Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 1, height: 1);
    }

    final theme = ModaloraTheme.of(effectiveContext);
    final popupTheme = theme.popupTheme;
    final anim = animation ?? popupTheme.animation;

    return Navigator.of(effectiveContext, rootNavigator: useRootNavigator).push<T>(
      ModaloraPopupRoute<T>(
        targetRect: rect,
        anchor: anchor,
        offset: offset,
        barrierColor: barrierColor ?? popupTheme.barrierColor,
        barrierDismissible: barrierDismissible,
        animationConfig: anim,
        builder: (ctx, resolvedAnchor) => ModaloraTheme(
          data: theme,
          child: ModaloraPopupWidget(
            title: title,
            message: message,
            child: child,
            anchor: resolvedAnchor,
            width: width,
            height: height,
            minWidth: minWidth,
            maxWidth: maxWidth,
            minHeight: minHeight,
            maxHeight: maxHeight,
            padding: padding,
            margin: margin,
            backgroundColor: backgroundColor,
            surfaceColor: surfaceColor,
            borderRadius: borderRadius,
            border: border,
            borderWidth: borderWidth,
            borderColor: borderColor,
            boxShadow: boxShadow,
            surfaceBlur: surfaceBlur,
            elevation: elevation,
            titleStyle: titleStyle,
            messageStyle: messageStyle,
          ),
        ),
      ),
    );
  }

  /// Displays a customizable Menu anchored to a widget or target position.
  static Future<T?> menu<T>({
    BuildContext? context,
    GlobalKey? anchorKey,
    Rect? targetRect,
    required List<ModaloraMenuEntry> items,
    ModaloraPopupAnchor anchor = ModaloraPopupAnchor.bottom,
    Offset offset = const Offset(0, 6.0),
    double? width,
    double? minWidth,
    double? maxWidth,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    Color? surfaceColor,
    BorderRadius? borderRadius,
    BoxBorder? border,
    double? borderWidth,
    Color? borderColor,
    List<BoxShadow>? boxShadow,
    double? surfaceBlur,
    double? elevation,
    Color? dividerColor,
    ModaloraAnimation? animation,
    bool useRootNavigator = true,
  }) {
    final effectiveContext = context ?? ModaloraConfig.navigatorKey?.currentContext;
    if (effectiveContext == null) {
      throw StateError(
        'Modalora: No valid BuildContext found. Pass a context or set ModaloraConfig.configure(navigatorKey: ...)',
      );
    }

    Rect? rect = targetRect;
    if (rect == null && anchorKey != null) {
      rect = ModaloraKeyFinder.getRectFromKey(anchorKey);
    }
    if (rect == null && context != null) {
      rect = ModaloraKeyFinder.getRect(context);
    }
    if (rect == null) {
      final size = MediaQuery.of(effectiveContext).size;
      rect = Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 1, height: 1);
    }

    final theme = ModaloraTheme.of(effectiveContext);
    final menuTheme = theme.menuTheme;
    final anim = animation ?? menuTheme.animation;

    return Navigator.of(effectiveContext, rootNavigator: useRootNavigator).push<T>(
      ModaloraPopupRoute<T>(
        targetRect: rect,
        anchor: anchor,
        offset: offset,
        barrierColor: menuTheme.barrierColor,
        animationConfig: anim,
        builder: (ctx, _) => ModaloraTheme(
          data: theme,
          child: ModaloraMenuWidget(
            items: items,
            width: width,
            minWidth: minWidth,
            maxWidth: maxWidth,
            padding: padding,
            margin: margin,
            backgroundColor: backgroundColor,
            surfaceColor: surfaceColor,
            borderRadius: borderRadius,
            border: border,
            borderWidth: borderWidth,
            borderColor: borderColor,
            boxShadow: boxShadow,
            surfaceBlur: surfaceBlur,
            elevation: elevation,
            dividerColor: dividerColor,
          ),
        ),
      ),
    );
  }

  /// Displays a floating Snackbar/Toast notification.
  static String snackbar({
    BuildContext? context,
    String? title,
    String? message,
    Widget? icon,
    Widget? action,
    String? actionLabel,
    VoidCallback? onActionPressed,
    Widget? child,
    Duration duration = const Duration(seconds: 4),
    ModaloraPosition? position,
    double? width,
    double? minWidth,
    double? maxWidth,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    Color? surfaceColor,
    BorderRadius? borderRadius,
    BoxBorder? border,
    double? borderWidth,
    Color? borderColor,
    List<BoxShadow>? boxShadow,
    double? surfaceBlur,
    double? elevation,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    TextStyle? actionStyle,
    double? iconSize,
    Color? iconColor,
    Color? iconBackgroundColor,
    bool? showCloseButton,
    Color? closeIconColor,
    bool? showProgressBar,
    Color? progressBarColor,
    double? progressBarHeight,
    bool? dismissOnSwipe,
    ModaloraAnimation? animation,
  }) {
    final overlayState = ModaloraOverlayController.resolveOverlayState(context);
    if (overlayState == null) {
      throw StateError(
        'Modalora: Unable to find OverlayState. Ensure your MaterialApp has a Navigator or pass a valid BuildContext.',
      );
    }

    final theme = ModaloraTheme.of(context);
    final snackTheme = theme.snackbarTheme;
    final pos = position ?? snackTheme.position;
    final id = UniqueKey().toString();

    final entry = ModaloraSnackbarEntry(
      id: id,
      position: pos,
      duration: duration,
      builder: (ctx, dismiss) => ModaloraTheme(
        data: theme,
        child: ModaloraSnackbarWidget(
          title: title,
          message: message,
          icon: icon,
          action: action,
          actionLabel: actionLabel,
          onActionPressed: onActionPressed,
          child: child,
          duration: duration,
          position: pos,
          width: width,
          minWidth: minWidth,
          maxWidth: maxWidth,
          padding: padding,
          margin: margin,
          backgroundColor: backgroundColor,
          surfaceColor: surfaceColor,
          borderRadius: borderRadius,
          border: border,
          borderWidth: borderWidth,
          borderColor: borderColor,
          boxShadow: boxShadow,
          surfaceBlur: surfaceBlur,
          elevation: elevation,
          titleStyle: titleStyle,
          messageStyle: messageStyle,
          actionStyle: actionStyle,
          iconSize: iconSize,
          iconColor: iconColor,
          iconBackgroundColor: iconBackgroundColor,
          showCloseButton: showCloseButton,
          closeIconColor: closeIconColor,
          showProgressBar: showProgressBar,
          progressBarColor: progressBarColor,
          progressBarHeight: progressBarHeight,
          dismissOnSwipe: dismissOnSwipe,
          animation: animation,
          onDismiss: dismiss,
        ),
      ),
    );

    ModaloraSnackbarQueue.instance.add(entry, overlayState, snackTheme.maxVisibleCount);
    return id;
  }

  /// Displays a custom or blocking overlay. Returns a [ModaloraOverlayHandle] to dismiss programmatically.
  static ModaloraOverlayHandle overlay({
    BuildContext? context,
    required Widget child,
    double blur = 10.0,
    double opacity = 0.5,
    Color? barrierColor,
    bool dismissible = false,
    ModaloraAnimation? animation,
  }) {
    final effectiveContext = context ?? ModaloraConfig.navigatorKey?.currentContext;
    final overlayState = ModaloraOverlayController.resolveOverlayState(effectiveContext);
    if (overlayState == null) {
      throw StateError('Modalora: Unable to resolve OverlayState for overlay.');
    }

    final theme = ModaloraTheme.of(effectiveContext);
    final id = UniqueKey().toString();
    late OverlayEntry entry;

    Future<void> dismiss() async {
      try {
        entry.remove();
      } catch (_) {}
      ModaloraOverlayController.unregister(id);
    }

    final handle = ModaloraOverlayHandle(id: id, onDismiss: dismiss);
    ModaloraOverlayController.register(handle);

    entry = OverlayEntry(
      builder: (ctx) => ModaloraTheme(
        data: theme,
        child: ModaloraOverlayHostWidget(
          blur: blur,
          opacity: opacity,
          barrierColor: barrierColor,
          dismissible: dismissible,
          onDismiss: () => handle.dismiss(),
          animation: animation ?? const ModaloraAnimation(type: ModaloraAnimationType.fade),
          child: child,
        ),
      ),
    );

    overlayState.insert(entry);
    return handle;
  }

  /// Displays a fullscreen blocking loading spinner with message.
  static ModaloraOverlayHandle loading({
    BuildContext? context,
    String? title = 'Loading...',
    String? message,
    Widget? indicator,
    Color? indicatorColor,
    double? indicatorSize,
    double blur = 10.0,
    double opacity = 0.5,
    Color? backgroundColor,
    Color? surfaceColor,
    BorderRadius? borderRadius,
    BoxBorder? border,
    List<BoxShadow>? boxShadow,
  }) {
    return overlay(
      context: context,
      blur: blur,
      opacity: opacity,
      child: ModaloraLoadingCard(
        title: title,
        message: message,
        indicator: indicator,
        indicatorColor: indicatorColor,
        indicatorSize: indicatorSize,
        backgroundColor: backgroundColor,
        surfaceColor: surfaceColor,
        borderRadius: borderRadius,
        border: border,
        boxShadow: boxShadow,
      ),
    );
  }

  /// Displays a luxury, pre-styled full-screen glassmorphic overlay modal or security shield.
  static ModaloraOverlayHandle fullScreen({
    BuildContext? context,
    Widget? icon,
    IconData? iconData,
    String? title,
    String? message,
    Widget? child,
    String? primaryActionText,
    VoidCallback? onPrimaryAction,
    String? secondaryActionText,
    VoidCallback? onSecondaryAction,
    List<Widget>? actions,
    double blur = 20.0,
    double opacity = 0.6,
    bool dismissible = true,
    Color? barrierColor,
    Color? surfaceColor,
    BorderRadius? borderRadius,
    BoxBorder? border,
    List<BoxShadow>? boxShadow,
    ModaloraAnimation? animation,
  }) {
    late ModaloraOverlayHandle handle;
    handle = overlay(
      context: context,
      blur: blur,
      opacity: opacity,
      barrierColor: barrierColor,
      dismissible: dismissible,
      animation: animation ?? const ModaloraAnimation(type: ModaloraAnimationType.fadeScale),
      child: ModaloraFullScreenCard(
        icon: icon,
        iconData: iconData,
        title: title,
        message: message,
        primaryActionText: primaryActionText,
        onPrimaryAction: onPrimaryAction ?? () => handle.dismiss(),
        secondaryActionText: secondaryActionText,
        onSecondaryAction: onSecondaryAction != null
            ? () {
                onSecondaryAction();
                handle.dismiss();
              }
            : null,
        actions: actions,
        surfaceColor: surfaceColor,
        borderRadius: borderRadius,
        border: border,
        boxShadow: boxShadow,
        child: child,
      ),
    );
    return handle;
  }

  /// Programmatically dismisses all active Modalora overlays, popups, and snackbars.
  static Future<void> dismissAll([BuildContext? context]) async {
    await ModaloraOverlayController.dismissAll();
    ModaloraSnackbarQueue.instance.clearAll();
    if (context != null) {
      Navigator.of(context, rootNavigator: true).maybePop();
    }
  }

  /// Adaptive presentation helper: renders BottomSheet on Mobile, Centered Dialog on Tablet/Desktop.
  static Future<T?> adaptive<T>({
    BuildContext? context,
    required Widget child,
    String? title,
    String? message,
    List<ModaloraButton>? actions,
    ModaloraAdaptiveMode? mode,
  }) {
    final effectiveContext = context ?? ModaloraConfig.navigatorKey?.currentContext;
    if (effectiveContext == null) {
      throw StateError(
        'Modalora: No valid BuildContext found. Pass a context or set ModaloraConfig.configure(navigatorKey: ...)',
      );
    }

    final effectiveMode = mode ?? ModaloraConfig.adaptiveMode;
    final deviceType = ModaloraConfig.breakpoints.resolve(effectiveContext);

    if (effectiveMode == ModaloraAdaptiveMode.bottomSheet ||
        (effectiveMode == ModaloraAdaptiveMode.auto && deviceType == ModaloraDeviceType.mobile)) {
      return bottomSheet<T>(
        context: effectiveContext,
        title: title,
        message: message,
        child: child,
        footer: actions != null && actions.isNotEmpty
            ? Row(
                children: actions.map((b) => Expanded(child: ModaloraButtonWidget(button: b))).toList(),
              )
            : null,
      );
    } else {
      return dialog<T>(
        context: effectiveContext,
        title: title,
        message: message,
        child: child,
        actions: actions,
      );
    }
  }

  /// Displays an interactive 3D Hologram Dialog with real-time gyro/pointer tilt
  /// and specular light reflections.
  ///
  /// ```dart
  /// await Modalora.hologram(
  ///   title: '3D Hologram Engine',
  ///   message: 'Tilt with your mouse or finger in real-time!',
  ///   primaryActionText: 'Explore',
  /// );
  /// ```
  static Future<T?> hologram<T>({
    BuildContext? context,
    String title = '3D Hologram Engine',
    String message =
        'Drag or move your cursor across this card to experience real-time 3D perspective gyro tilting and specular light reflections.',
    IconData icon = Icons.view_in_ar_rounded,
    Color accentColor = const Color(0xFF06B6D4),
    Color secondaryAccentColor = const Color(0xFF8B5CF6),
    String primaryActionText = 'Explore 3D',
    String secondaryActionText = 'Dismiss',
    VoidCallback? onPrimaryAction,
    VoidCallback? onSecondaryAction,
    List<Modalora3DFeature> features = const [
      Modalora3DFeature(icon: Icons.threed_rotation_rounded, label: '3D Tilt'),
      Modalora3DFeature(icon: Icons.flare_rounded, label: 'Specular Glare'),
      Modalora3DFeature(icon: Icons.blur_on_rounded, label: 'Frosted Glass'),
    ],
    double surfaceBlur = 16.0,
    double barrierBlur = 12.0,
    bool barrierDismissible = true,
  }) {
    final effectiveContext = context ?? ModaloraConfig.navigatorKey?.currentContext;
    if (effectiveContext == null) {
      throw FlutterError(
        'Modalora: No valid BuildContext found. Pass a context or set ModaloraConfig.configure(navigatorKey: ...)',
      );
    }

    return dialog<T>(
      context: effectiveContext,
      surfaceBlur: surfaceBlur,
      barrierBlur: barrierBlur,
      barrierDismissible: barrierDismissible,
      child: Modalora3DHologramDialog(
        title: title,
        message: message,
        icon: icon,
        accentColor: accentColor,
        secondaryAccentColor: secondaryAccentColor,
        primaryActionText: primaryActionText,
        secondaryActionText: secondaryActionText,
        onPrimaryAction: onPrimaryAction,
        onSecondaryAction: onSecondaryAction,
        features: features,
      ),
    );
  }

  /// Displays any custom widget inside an interactive 3D perspective tilt modal.
  ///
  /// ```dart
  /// await Modalora.dialog3D(
  ///   child: MyCustomCard(),
  ///   maxTilt: 0.3,
  /// );
  /// ```
  static Future<T?> dialog3D<T>({
    BuildContext? context,
    required Widget child,
    double maxTilt = 0.25,
    double perspective = 0.0018,
    Color glareColor = Colors.white,
    double glareIntensity = 0.35,
    double surfaceBlur = 16.0,
    double barrierBlur = 12.0,
    bool barrierDismissible = true,
  }) {
    final effectiveContext = context ?? ModaloraConfig.navigatorKey?.currentContext;
    if (effectiveContext == null) {
      throw FlutterError(
        'Modalora: No valid BuildContext found. Pass a context or set ModaloraConfig.configure(navigatorKey: ...)',
      );
    }

    return dialog<T>(
      context: effectiveContext,
      surfaceBlur: surfaceBlur,
      barrierBlur: barrierBlur,
      barrierDismissible: barrierDismissible,
      child: Modalora3DTiltCard(
        maxTilt: maxTilt,
        perspective: perspective,
        glareColor: glareColor,
        glareIntensity: glareIntensity,
        child: child,
      ),
    );
  }
}

/// Helper wrapper for button rendering
class ModaloraButtonWidget extends StatelessWidget {
  const ModaloraButtonWidget({super.key, required this.button});
  final ModaloraButton button;

  @override
  Widget build(BuildContext context) {
    final theme = ModaloraTheme.of(context);
    final dialogTheme = theme.dialogTheme;
    final radius = button.borderRadius ?? dialogTheme.buttonBorderRadius;
    final padding = button.padding ?? dialogTheme.buttonPadding;

    return Material(
      color: button.backgroundColor ?? dialogTheme.primaryButtonBackgroundColor ?? theme.primaryColor,
      borderRadius: radius,
      child: InkWell(
        onTap: button.onPressed ?? () => Navigator.of(context).maybePop(),
        borderRadius: radius,
        child: Padding(
          padding: padding,
          child: Center(
            child: Text(
              button.label,
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
                color: button.textColor ?? dialogTheme.primaryButtonTextColor ?? Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
