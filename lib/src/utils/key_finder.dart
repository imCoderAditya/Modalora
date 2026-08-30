import 'package:flutter/widgets.dart';

/// Helper utility to resolve global physical screen coordinates and bounding [Rect]s for Flutter widgets.
class ModaloraKeyFinder {
  const ModaloraKeyFinder._();

  /// Extracts the global physical [Rect] screen bounding box for a given [BuildContext].
  static Rect? getRect(BuildContext context) {
    final renderObject = context.findRenderObject();
    if (renderObject is RenderBox && renderObject.hasSize) {
      final translation = renderObject.getTransformTo(null).getTranslation();
      final size = renderObject.size;
      return Rect.fromLTWH(translation.x, translation.y, size.width, size.height);
    }
    return null;
  }

  /// Extracts the global physical [Rect] screen bounding box for a given [GlobalKey].
  static Rect? getRectFromKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      return getRect(context);
    }
    return null;
  }
}
