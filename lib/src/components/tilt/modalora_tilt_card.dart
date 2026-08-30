import 'package:flutter/material.dart';

/// An ultra-premium, interactive 3D Perspective Tilt Card with dynamic
/// specular glare reflection sheen and pointer/touch tracking.
///
/// Wraps any widget and transforms it in 3D Matrix4 perspective space when
/// the user hovers, touches, or drags across the card surface.
class Modalora3DTiltCard extends StatefulWidget {
  /// Creates a [Modalora3DTiltCard].
  const Modalora3DTiltCard({
    super.key,
    required this.child,
    this.maxTilt = 0.25,
    this.perspective = 0.0018,
    this.glareColor = Colors.white,
    this.glareIntensity = 0.35,
    this.borderRadius = const BorderRadius.all(Radius.circular(24.0)),
    this.duration = const Duration(milliseconds: 120),
    this.curve = Curves.easeOut,
    this.reverse = false,
  });

  /// The child widget rendered inside the 3D perspective tilt container.
  final Widget child;

  /// Maximum angular tilt magnitude in radians. Defaults to `0.25`.
  final double maxTilt;

  /// 3D perspective distortion depth coefficient in Matrix4 (entry 3, 2).
  /// Defaults to `0.0018`.
  final double perspective;

  /// Color of the dynamic radial specular light glare sheen.
  final Color glareColor;

  /// Opacity multiplier for the specular light glare. Defaults to `0.35`.
  final double glareIntensity;

  /// Border radius applied to clip the specular glare overlay.
  final BorderRadius borderRadius;

  /// Animation smoothing duration when pointer updates.
  final Duration duration;

  /// Animation smoothing curve. Defaults to [Curves.easeOut].
  final Curve curve;

  /// Whether to reverse tilt direction relative to pointer position.
  final bool reverse;

  @override
  State<Modalora3DTiltCard> createState() => _Modalora3DTiltCardState();
}

class _Modalora3DTiltCardState extends State<Modalora3DTiltCard> {
  double _tiltX = 0.0;
  double _tiltY = 0.0;
  Offset _localPos = Offset.zero;
  bool _isHovered = false;

  void _onPointerMove(PointerEvent event, Size size) {
    if (size.width == 0 || size.height == 0) return;
    setState(() {
      _isHovered = true;
      _localPos = event.localPosition;
      final dx = (_localPos.dx / size.width) - 0.5;
      final dy = (_localPos.dy / size.height) - 0.5;
      final factor = widget.reverse ? -1.0 : 1.0;
      _tiltX = dy * widget.maxTilt * factor;
      _tiltY = -dx * widget.maxTilt * factor;
    });
  }

  void _onPointerExit() {
    setState(() {
      _isHovered = false;
      _tiltX = 0.0;
      _tiltY = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);

        return MouseRegion(
          onExit: (_) => _onPointerExit(),
          child: Listener(
            onPointerMove: (e) => _onPointerMove(e, size),
            onPointerDown: (e) => _onPointerMove(e, size),
            onPointerUp: (_) => _onPointerExit(),
            child: AnimatedContainer(
              duration: widget.duration,
              curve: widget.curve,
              transformAlignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, widget.perspective)
                ..rotateX(_tiltX)
                ..rotateY(_tiltY),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  widget.child,
                  // Dynamic 3D Specular Glare Reflection Sheen
                  if (_isHovered && widget.glareIntensity > 0)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 150),
                          opacity: _isHovered ? widget.glareIntensity : 0.0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: widget.borderRadius,
                              gradient: RadialGradient(
                                center: Alignment(
                                  size.width > 0
                                      ? ((_localPos.dx / size.width) * 2) - 1
                                      : 0,
                                  size.height > 0
                                      ? ((_localPos.dy / size.height) * 2) - 1
                                      : 0,
                                ),
                                radius: 0.8,
                                colors: [
                                  widget.glareColor.withValues(alpha: 0.6),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
