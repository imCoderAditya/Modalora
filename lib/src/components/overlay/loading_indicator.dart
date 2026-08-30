import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A luxury, high-precision orbital gradient loading spinner for Modalora Overlays.
///
/// Features smooth continuous rotation, a gradient sweep arc with rounded caps,
/// a subtle circular track, and a pulsing central glow core.
class ModaloraLoadingSpinner extends StatefulWidget {
  /// Creates an orbital loading spinner.
  const ModaloraLoadingSpinner({
    super.key,
    this.size = 48.0,
    this.strokeWidth = 3.5,
    this.color,
  });

  /// The diameter size of the spinner.
  final double size;

  /// The stroke line thickness of the rotating arc.
  final double strokeWidth;

  /// The primary color tint for the spinner.
  final Color? color;

  @override
  State<ModaloraLoadingSpinner> createState() => _ModaloraLoadingSpinnerState();
}

class _ModaloraLoadingSpinnerState extends State<ModaloraLoadingSpinner>
    with SingleTickerProviderStateMixin {
  /// Infinite ticker controller driving continuous 360-degree rotation
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor = widget.color ?? Theme.of(context).colorScheme.primary;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: CustomPaint(
            painter: _ModaloraOrbitalSpinnerPainter(
              progress: _controller.value,
              color: effectiveColor,
              strokeWidth: widget.strokeWidth,
            ),
          ),
        );
      },
    );
  }
}

/// Custom painter rendering orbital arc geometry with smooth alpha gradient sweeps.
class _ModaloraOrbitalSpinnerPainter extends CustomPainter {
  _ModaloraOrbitalSpinnerPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // 1. Subtle background circular track
    final trackPaint = Paint()
      ..color = color.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, trackPaint);

    // 2. Glowing animated orbital sweep arc
    final startAngle = progress * 2 * math.pi;
    final sweepAngle = math.pi * 1.3;

    final arcPaint = Paint()
      ..shader = SweepGradient(
        colors: [
          color.withValues(alpha: 0.0),
          color.withValues(alpha: 0.4),
          color,
        ],
        stops: const [0.0, 0.5, 1.0],
        transform: GradientRotation(startAngle),
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      arcPaint,
    );

    // 3. Central pulsing glow core for high-end aesthetic feel
    final pulseScale = 0.5 + 0.5 * math.sin(progress * 2 * math.pi);
    final corePaint = Paint()
      ..color = color.withValues(alpha: 0.15 + 0.15 * pulseScale);
    canvas.drawCircle(center, radius * 0.45 * pulseScale, corePaint);
  }

  @override
  bool shouldRepaint(covariant _ModaloraOrbitalSpinnerPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
