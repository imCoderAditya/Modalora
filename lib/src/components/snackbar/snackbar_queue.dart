import 'package:flutter/widgets.dart';
import '../../core/position.dart';

/// Representation of an active or queued snackbar instance.
///
/// Holds the entry identifier, target screen position, custom builder lambda, and lifetime duration.
class ModaloraSnackbarEntry {
  /// Creates a snackbar entry configuration.
  ModaloraSnackbarEntry({
    required this.id,
    required this.position,
    required this.builder,
    required this.duration,
  });

  /// Unique UUID string identifying this toast entry.
  final String id;

  /// Target screen alignment position.
  final ModaloraPosition position;

  /// Builder lambda constructing the toast widget.
  final Widget Function(BuildContext context, VoidCallback onDismiss) builder;

  /// Duration before auto-dismissal.
  final Duration duration;
}

/// Global queue controller that manages snackbar stacking, position queues, and overlay lifecycle.
class ModaloraSnackbarQueue extends ChangeNotifier {
  ModaloraSnackbarQueue._();

  /// Singleton instance of the snackbar queue.
  static final ModaloraSnackbarQueue instance = ModaloraSnackbarQueue._();

  /// Map associating each screen position with its active list of toast entries.
  final Map<ModaloraPosition, List<ModaloraSnackbarEntry>> _queues = {};

  /// Global overlay entry host hosting the snackbar position stacks.
  OverlayEntry? _overlayEntry;

  /// Gets all active snackbars for a given screen position.
  List<ModaloraSnackbarEntry> getEntriesFor(ModaloraPosition position) {
    return _queues[position] ?? const [];
  }

  /// Adds a snackbar entry and ensures the overlay host is mounted.
  void add(ModaloraSnackbarEntry entry, OverlayState overlayState, int maxVisible) {
    final list = _queues.putIfAbsent(entry.position, () => []);
    list.add(entry);

    // Evict oldest snackbar if exceeding maxVisible limit
    if (list.length > maxVisible) {
      list.removeAt(0);
    }

    _ensureOverlay(overlayState);
    notifyListeners();
  }

  /// Removes a snackbar entry by its unique ID and cleans up empty overlays.
  void remove(String id) {
    bool removed = false;
    for (final key in _queues.keys) {
      final list = _queues[key]!;
      final countBefore = list.length;
      list.removeWhere((e) => e.id == id);
      if (list.length != countBefore) {
        removed = true;
      }
    }

    if (removed) {
      notifyListeners();
      _cleanupIfEmpty();
    }
  }

  /// Clears all active snackbars across all screen positions.
  void clearAll() {
    _queues.clear();
    notifyListeners();
    _cleanupIfEmpty();
  }

  /// Mounts the overlay entry to Flutter's OverlayState if not already mounted.
  void _ensureOverlay(OverlayState overlayState) {
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
        builder: (context) => _ModaloraSnackbarOverlayHost(queue: this),
      );
      overlayState.insert(_overlayEntry!);
    }
  }

  /// Unmounts the overlay host from Flutter's tree when all queues are empty.
  void _cleanupIfEmpty() {
    bool hasAny = false;
    for (final list in _queues.values) {
      if (list.isNotEmpty) {
        hasAny = true;
        break;
      }
    }

    if (!hasAny && _overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }
}

/// Overlay host widget rendering multi-directional snackbar stacks.
class _ModaloraSnackbarOverlayHost extends StatelessWidget {
  const _ModaloraSnackbarOverlayHost({required this.queue});

  final ModaloraSnackbarQueue queue;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: queue,
      builder: (context, _) {
        return Stack(
          children: [
            for (final position in ModaloraPosition.values)
              if (queue.getEntriesFor(position).isNotEmpty)
                _buildPositionStack(context, position, queue.getEntriesFor(position)),
          ],
        );
      },
    );
  }

  /// Builds an individual vertical position stack for a specific screen anchor.
  Widget _buildPositionStack(
    BuildContext context,
    ModaloraPosition position,
    List<ModaloraSnackbarEntry> entries,
  ) {
    final alignment = position.toAlignment();

    return SafeArea(
      child: Align(
        alignment: alignment,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            verticalDirection: position.isTop ? VerticalDirection.down : VerticalDirection.up,
            children: [
              for (final entry in entries)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  key: ValueKey(entry.id),
                  child: entry.builder(context, () => queue.remove(entry.id)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
