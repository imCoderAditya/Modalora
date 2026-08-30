import 'package:flutter/widgets.dart';
import 'config.dart';

/// A lightweight handle returned when presenting an overlay, allowing programmatic dismissal.
class ModaloraOverlayHandle {
  /// Creates an overlay handle instance.
  ModaloraOverlayHandle({
    required this.id,
    required Future<void> Function() onDismiss,
  }) : _onDismiss = onDismiss;

  /// Unique UUID string identifying this overlay presentation instance.
  final String id;

  /// Private dismissal handler callback.
  final Future<void> Function() _onDismiss;

  /// Whether this handle has already been dismissed.
  bool _isDismissed = false;

  /// Returns true if this overlay has already been dismissed.
  bool get isDismissed => _isDismissed;

  /// Programmatically dismisses this overlay instance.
  Future<void> dismiss() async {
    if (_isDismissed) return;
    _isDismissed = true;
    await _onDismiss();
  }
}

/// Global registry and lifecycle controller for active Modalora overlays.
class ModaloraOverlayController {
  ModaloraOverlayController._();

  /// Active handles registry keyed by unique instance ID.
  static final Map<String, ModaloraOverlayHandle> _activeHandles = {};

  /// Registered listeners triggered when [dismissAll] executes.
  static final List<void Function()> _dismissAllListeners = [];

  /// Registers an active overlay handle into the global registry.
  static void register(ModaloraOverlayHandle handle) {
    _activeHandles[handle.id] = handle;
  }

  /// Unregisters an active overlay handle from the global registry.
  static void unregister(String id) {
    _activeHandles.remove(id);
  }

  /// Registers a listener callback triggered during [dismissAll].
  static void addDismissListener(void Function() listener) {
    _dismissAllListeners.add(listener);
  }

  /// Removes a registered dismiss listener callback.
  static void removeDismissListener(void Function() listener) {
    _dismissAllListeners.remove(listener);
  }

  /// Programmatically dismisses all currently visible overlays and active blockers.
  static Future<void> dismissAll() async {
    final handles = List<ModaloraOverlayHandle>.from(_activeHandles.values);
    _activeHandles.clear();

    for (final handle in handles) {
      try {
        await handle.dismiss();
      } catch (_) {}
    }

    for (final listener in List<void Function()>.from(_dismissAllListeners)) {
      try {
        listener();
      } catch (_) {}
    }
  }

  /// Resolves an [OverlayState] from either explicit [BuildContext] or global [ModaloraConfig.navigatorKey].
  static OverlayState? resolveOverlayState([BuildContext? context]) {
    // 1. Check passed BuildContext
    if (context != null) {
      final overlay = Overlay.maybeOf(context, rootOverlay: true);
      if (overlay != null) return overlay;
    }

    // 2. Check global navigatorKey context fallback
    final navContext = ModaloraConfig.navigatorKey?.currentContext;
    if (navContext != null) {
      final overlay = Overlay.maybeOf(navContext, rootOverlay: true);
      if (overlay != null) return overlay;
    }

    return null;
  }
}
