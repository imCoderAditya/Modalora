import 'dart:math' as math;
import 'package:flutter/animation.dart';

/// A physics-inspired damped harmonic oscillator spring simulation curve for bouncy, organic transitions.
///
/// Models realistic physical spring equations with damping, stiffness, and mass coefficients.
class ModaloraSpringCurve extends Curve {
  /// Creates a spring curve with custom physical coefficients.
  const ModaloraSpringCurve({
    this.damping = 12.0,
    this.stiffness = 180.0,
    this.mass = 1.0,
  });

  /// Damping coefficient determining how quickly oscillations settle to rest.
  final double damping;

  /// Spring stiffness coefficient determining resistance and oscillation frequency.
  final double stiffness;

  /// Mass of the simulated body.
  final double mass;

  /// Default gentle bounce spring curve.
  static const ModaloraSpringCurve gentle = ModaloraSpringCurve(
    damping: 15.0,
    stiffness: 140.0,
    mass: 1.0,
  );

  /// Snappy responsive spring curve with minimal oscillation.
  static const ModaloraSpringCurve snappy = ModaloraSpringCurve(
    damping: 20.0,
    stiffness: 280.0,
    mass: 1.0,
  );

  /// Bouncy exaggerated spring curve with energetic overshoot.
  static const ModaloraSpringCurve bouncy = ModaloraSpringCurve(
    damping: 8.0,
    stiffness: 160.0,
    mass: 1.0,
  );

  @override
  double transformInternal(double t) {
    // Clamp boundary values
    if (t <= 0.0) return 0.0;
    if (t >= 1.0) return 1.0;

    // Calculate natural frequency (omega0) and damping ratio (zeta)
    final omega0 = math.sqrt(stiffness / mass);
    final zeta = damping / (2 * math.sqrt(stiffness * mass));

    if (zeta < 1.0) {
      // Under-damped system with organic spring oscillation
      final omegaD = omega0 * math.sqrt(1.0 - zeta * zeta);
      final decay = math.exp(-zeta * omega0 * t);
      final sinTerm = math.sin(omegaD * t);
      final cosTerm = math.cos(omegaD * t);
      return 1.0 - decay * (cosTerm + (zeta / math.sqrt(1.0 - zeta * zeta)) * sinTerm);
    } else {
      // Critically damped or over-damped system without oscillation
      final decay = math.exp(-omega0 * t);
      return 1.0 - decay * (1.0 + omega0 * t);
    }
  }
}
