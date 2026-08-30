import 'package:flutter/material.dart';

import '../../utils/backdrop_filter.dart';
import 'modalora_tilt_card.dart';

/// An interactive 3D Hologram Dialog widget featuring real-time pointer/gyro
/// tilt, pulsing orbital ring, glass specular reflection, and action buttons.
class Modalora3DHologramDialog extends StatefulWidget {
  /// Creates a [Modalora3DHologramDialog].
  const Modalora3DHologramDialog({
    super.key,
    this.title = '3D Hologram Engine',
    this.message =
        'Drag or move your cursor across this card to experience real-time 3D perspective gyro tilting and specular light reflections.',
    this.icon = Icons.view_in_ar_rounded,
    this.accentColor = const Color(0xFF06B6D4),
    this.secondaryAccentColor = const Color(0xFF8B5CF6),
    this.primaryActionText = 'Explore 3D',
    this.secondaryActionText = 'Dismiss',
    this.onPrimaryAction,
    this.onSecondaryAction,
    this.maxWidth = 340.0,
    this.features = const [
      Modalora3DFeature(icon: Icons.threed_rotation_rounded, label: '3D Tilt'),
      Modalora3DFeature(icon: Icons.flare_rounded, label: 'Specular Glare'),
      Modalora3DFeature(icon: Icons.blur_on_rounded, label: 'Frosted Glass'),
    ],
  });

  /// Primary headline title text.
  final String title;

  /// Secondary description message.
  final String message;

  /// Header icon displayed inside the pulsing orbital hologram ring.
  final IconData icon;

  /// Primary glowing accent color. Defaults to cyan (`0xFF06B6D4`).
  final Color accentColor;

  /// Secondary gradient accent color. Defaults to purple (`0xFF8B5CF6`).
  final Color secondaryAccentColor;

  /// Label for the primary elevated action button.
  final String primaryActionText;

  /// Label for the secondary outlined dismiss button.
  final String secondaryActionText;

  /// Callback when primary action button is pressed.
  final VoidCallback? onPrimaryAction;

  /// Callback when secondary action button is pressed.
  final VoidCallback? onSecondaryAction;

  /// Maximum card width constraint. Defaults to `340.0`.
  final double maxWidth;

  /// Feature chips displayed inside the glass capsule.
  final List<Modalora3DFeature> features;

  @override
  State<Modalora3DHologramDialog> createState() =>
      _Modalora3DHologramDialogState();
}

class _Modalora3DHologramDialogState extends State<Modalora3DHologramDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Modalora3DTiltCard(
      child: ModaloraGlassContainer(
        constraints: BoxConstraints(maxWidth: widget.maxWidth),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        backgroundColor: isDark
            ? const Color(0xFF0F172A).withValues(alpha: 0.82)
            : Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(28.0),
        blur: 16.0,
        border: Border.all(
          color: widget.accentColor.withValues(alpha: 0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.accentColor.withValues(alpha: 0.3),
            blurRadius: 32.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: widget.secondaryAccentColor.withValues(alpha: 0.25),
            blurRadius: 48.0,
            spreadRadius: 4.0,
          ),
        ],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 3D Glowing Hologram Ring
            AnimatedBuilder(
              animation: _pulseCtrl,
              builder: (context, child) {
                final scale = 1.0 + (_pulseCtrl.value * 0.08);
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          widget.accentColor,
                          widget.secondaryAccentColor
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: widget.accentColor.withValues(alpha: 0.6),
                          blurRadius: 24.0,
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.icon,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 18),

            // Hologram 3D Title
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  widget.accentColor,
                  widget.secondaryAccentColor,
                  Colors.white,
                ],
              ).createShader(bounds),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              widget.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.0,
                color:
                    isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),

            // Feature Highlights in Glass Capsules (Responsive Wrap)
            if (widget.features.isNotEmpty)
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(14),
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 6,
                  children: widget.features
                      .map((f) => _FeatureChip(
                            icon: f.icon,
                            label: f.label,
                            accentColor: widget.accentColor,
                          ))
                      .toList(),
                ),
              ),
            const SizedBox(height: 22),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor:
                          isDark ? Colors.white : const Color(0xFF0F172A),
                      side: BorderSide(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.15)
                            : Colors.black.withValues(alpha: 0.15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (widget.onSecondaryAction != null) {
                        widget.onSecondaryAction!();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      widget.secondaryActionText,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.accentColor,
                      foregroundColor: Colors.white,
                      elevation: 8,
                      shadowColor: widget.accentColor.withValues(alpha: 0.5),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (widget.onPrimaryAction != null) {
                        widget.onPrimaryAction!();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      widget.primaryActionText,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Feature metadata chip displayed inside [Modalora3DHologramDialog].
class Modalora3DFeature {
  /// Creates a [Modalora3DFeature].
  const Modalora3DFeature({required this.icon, required this.label});

  /// The icon displayed on the chip.
  final IconData icon;

  /// The text label displayed on the chip.
  final String label;
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({
    required this.icon,
    required this.label,
    required this.accentColor,
  });

  final IconData icon;
  final String label;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: accentColor),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: Color(0xFFCBD5E1),
          ),
        ),
      ],
    );
  }
}
