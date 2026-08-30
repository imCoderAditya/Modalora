import 'package:flutter/material.dart';
import 'animation_theme.dart';
import 'bottom_sheet_theme.dart';
import 'dialog_theme.dart';
import 'menu_theme.dart';
import 'overlay_theme.dart';
import 'popup_theme.dart';
import 'snackbar_theme.dart';

/// Complete, centralized theme specification for the entire Modalora Overlay Experience System.
class ModaloraThemeData {
  const ModaloraThemeData({
    required this.brightness,
    required this.primaryColor,
    required this.primaryVariant,
    required this.accentColor,
    required this.backgroundColor,
    required this.surfaceColor,
    required this.cardColor,
    required this.barrierColor,
    required this.textColor,
    required this.textSecondaryColor,
    required this.borderColor,
    required this.dividerColor,
    required this.errorColor,
    required this.successColor,
    required this.warningColor,
    required this.infoColor,
    this.fontFamily,
    this.defaultBorderRadius = const BorderRadius.all(Radius.circular(20.0)),
    this.defaultElevation = 8.0,
    this.defaultBlur = 16.0,
    this.defaultPadding = const EdgeInsets.all(20.0),
    this.defaultMargin = const EdgeInsets.all(16.0),
    this.defaultSpacing = 12.0,
    this.dialogTheme = const ModaloraDialogTheme(),
    this.bottomSheetTheme = const ModaloraBottomSheetTheme(),
    this.popupTheme = const ModaloraPopupTheme(),
    this.menuTheme = const ModaloraMenuTheme(),
    this.snackbarTheme = const ModaloraSnackbarTheme(),
    this.overlayTheme = const ModaloraOverlayTheme(),
    this.animationTheme = const ModaloraAnimationTheme(),
  });

  final Brightness brightness;
  final Color primaryColor;
  final Color primaryVariant;
  final Color accentColor;
  final Color backgroundColor;
  final Color surfaceColor;
  final Color cardColor;
  final Color barrierColor;
  final Color textColor;
  final Color textSecondaryColor;
  final Color borderColor;
  final Color dividerColor;
  final Color errorColor;
  final Color successColor;
  final Color warningColor;
  final Color infoColor;
  final String? fontFamily;
  final BorderRadius defaultBorderRadius;
  final double defaultElevation;
  final double defaultBlur;
  final EdgeInsetsGeometry defaultPadding;
  final EdgeInsetsGeometry defaultMargin;
  final double defaultSpacing;

  final ModaloraDialogTheme dialogTheme;
  final ModaloraBottomSheetTheme bottomSheetTheme;
  final ModaloraPopupTheme popupTheme;
  final ModaloraMenuTheme menuTheme;
  final ModaloraSnackbarTheme snackbarTheme;
  final ModaloraOverlayTheme overlayTheme;
  final ModaloraAnimationTheme animationTheme;

  bool get isDark => brightness == Brightness.dark;

  /// Curated light theme with crisp glass surfaces, smooth shadows, and vibrant indigo tones.
  factory ModaloraThemeData.light({
    Color primaryColor = const Color(0xFF4F46E5), // Indigo 600
    Color primaryVariant = const Color(0xFF6366F1),
    Color accentColor = const Color(0xFF06B6D4), // Cyan 500
    String? fontFamily,
  }) {
    const surfaceColor = Color(0xF2FFFFFF); // Translucent frosted white
    const backgroundColor = Color(0xFFF8FAFC); // Slate 50
    const cardColor = Color(0xFFFFFFFF);
    const barrierColor = Color(0x520F172A); // Slate 900 translucent
    const textColor = Color(0xFF0F172A); // Slate 900
    const textSecondaryColor = Color(0xFF64748B); // Slate 500
    const borderColor = Color(0x1E0F172A); // 12% Slate
    const dividerColor = Color(0x0F0F172A);
    const errorColor = Color(0xFFEF4444);
    const successColor = Color(0xFF10B981);
    const warningColor = Color(0xFFF59E0B);
    const infoColor = Color(0xFF3B82F6);

    return ModaloraThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      primaryVariant: primaryVariant,
      accentColor: accentColor,
      backgroundColor: backgroundColor,
      surfaceColor: surfaceColor,
      cardColor: cardColor,
      barrierColor: barrierColor,
      textColor: textColor,
      textSecondaryColor: textSecondaryColor,
      borderColor: borderColor,
      dividerColor: dividerColor,
      errorColor: errorColor,
      successColor: successColor,
      warningColor: warningColor,
      infoColor: infoColor,
      fontFamily: fontFamily,
      dialogTheme: ModaloraDialogTheme(
        backgroundColor: surfaceColor,
        surfaceColor: surfaceColor,
        barrierColor: barrierColor,
        borderColor: borderColor,
        titleStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textColor,
          fontFamily: fontFamily,
          letterSpacing: -0.3,
        ),
        messageStyle: TextStyle(
          fontSize: 14.5,
          color: textSecondaryColor,
          fontFamily: fontFamily,
          height: 1.45,
        ),
        primaryButtonBackgroundColor: primaryColor,
        primaryButtonTextColor: Colors.white,
        secondaryButtonBackgroundColor: const Color(0xFFF1F5F9),
        secondaryButtonTextColor: textColor,
        destructiveButtonBackgroundColor: errorColor,
        destructiveButtonTextColor: Colors.white,
        iconBackgroundColor: primaryColor.withValues(alpha: 0.12),
        iconColor: primaryColor,
      ),
      bottomSheetTheme: ModaloraBottomSheetTheme(
        backgroundColor: surfaceColor,
        surfaceColor: surfaceColor,
        barrierColor: barrierColor,
        borderColor: borderColor,
        dragHandleColor: const Color(0xFFCBD5E1),
        titleStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textColor,
          fontFamily: fontFamily,
          letterSpacing: -0.3,
        ),
        messageStyle: TextStyle(
          fontSize: 14.5,
          color: textSecondaryColor,
          fontFamily: fontFamily,
          height: 1.4,
        ),
      ),
      popupTheme: ModaloraPopupTheme(
        backgroundColor: surfaceColor,
        surfaceColor: surfaceColor,
        borderColor: borderColor,
        arrowColor: surfaceColor,
      ),
      menuTheme: ModaloraMenuTheme(
        backgroundColor: surfaceColor,
        surfaceColor: surfaceColor,
        borderColor: borderColor,
        dividerColor: dividerColor,
        itemTheme: ModaloraMenuItemTheme(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
            fontFamily: fontFamily,
          ),
          subtitleStyle: TextStyle(
            fontSize: 12,
            color: textSecondaryColor,
            fontFamily: fontFamily,
          ),
          shortcutStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textSecondaryColor,
            fontFamily: fontFamily,
          ),
          iconColor: textSecondaryColor,
          hoverColor: const Color(0xFFF1F5F9),
          pressedColor: const Color(0xFFE2E8F0),
          selectedBackgroundColor: primaryColor.withValues(alpha: 0.12),
          selectedTextColor: primaryColor,
          destructiveColor: errorColor,
        ),
      ),
      snackbarTheme: ModaloraSnackbarTheme(
        backgroundColor: const Color(0xEB1E293B), // Dark slate toast in light mode for punchy contrast
        surfaceColor: const Color(0xEB1E293B),
        borderColor: const Color(0x33FFFFFF),
        titleStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontFamily: fontFamily,
        ),
        messageStyle: TextStyle(
          fontSize: 13.5,
          color: const Color(0xFFE2E8F0),
          fontFamily: fontFamily,
        ),
        actionStyle: TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w600,
          color: accentColor,
          fontFamily: fontFamily,
        ),
        closeIconColor: const Color(0xFF94A3B8),
        progressBarColor: primaryVariant,
        iconColor: primaryVariant,
      ),
      overlayTheme: ModaloraOverlayTheme(
        backgroundColor: const Color(0xE6FFFFFF),
        surfaceColor: const Color(0xE6FFFFFF),
        barrierColor: barrierColor,
        borderColor: borderColor,
        indicatorColor: primaryColor,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor,
          fontFamily: fontFamily,
        ),
        messageStyle: TextStyle(
          fontSize: 13.5,
          color: textSecondaryColor,
          fontFamily: fontFamily,
        ),
      ),
    );
  }

  /// Curated dark theme with deep obsidian backdrop, vibrant luminous accents, and frosted glass.
  factory ModaloraThemeData.dark({
    Color primaryColor = const Color(0xFF6366F1), // Indigo 500
    Color primaryVariant = const Color(0xFF818CF8),
    Color accentColor = const Color(0xFF22D3EE), // Cyan 400
    String? fontFamily,
  }) {
    const surfaceColor = Color(0xF018181B); // Frosted Zinc 900
    const backgroundColor = Color(0xFF09090B); // Obsidian Zinc 950
    const cardColor = Color(0xFF18181B);
    const barrierColor = Color(0x80000000); // 50% true black barrier
    const textColor = Color(0xFFF4F4F5); // Zinc 100
    const textSecondaryColor = Color(0xFFA1A1AA); // Zinc 400
    const borderColor = Color(0x2EFFFFFF); // 18% crisp white border
    const dividerColor = Color(0x1EFFFFFF);
    const errorColor = Color(0xFFF87171);
    const successColor = Color(0xFF34D399);
    const warningColor = Color(0xFFFBBF24);
    const infoColor = Color(0xFF60A5FA);

    return ModaloraThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      primaryVariant: primaryVariant,
      accentColor: accentColor,
      backgroundColor: backgroundColor,
      surfaceColor: surfaceColor,
      cardColor: cardColor,
      barrierColor: barrierColor,
      textColor: textColor,
      textSecondaryColor: textSecondaryColor,
      borderColor: borderColor,
      dividerColor: dividerColor,
      errorColor: errorColor,
      successColor: successColor,
      warningColor: warningColor,
      infoColor: infoColor,
      fontFamily: fontFamily,
      dialogTheme: ModaloraDialogTheme(
        backgroundColor: surfaceColor,
        surfaceColor: surfaceColor,
        barrierColor: barrierColor,
        borderColor: borderColor,
        boxShadow: const [
          BoxShadow(color: Color(0x80000000), blurRadius: 36, offset: Offset(0, 16)),
          BoxShadow(color: Color(0x26000000), blurRadius: 12, offset: Offset(0, 4)),
        ],
        titleStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textColor,
          fontFamily: fontFamily,
          letterSpacing: -0.3,
        ),
        messageStyle: TextStyle(
          fontSize: 14.5,
          color: textSecondaryColor,
          fontFamily: fontFamily,
          height: 1.45,
        ),
        primaryButtonBackgroundColor: primaryColor,
        primaryButtonTextColor: Colors.white,
        secondaryButtonBackgroundColor: const Color(0xFF27272A),
        secondaryButtonTextColor: textColor,
        destructiveButtonBackgroundColor: const Color(0xFFDC2626),
        destructiveButtonTextColor: Colors.white,
        iconBackgroundColor: primaryColor.withValues(alpha: 0.18),
        iconColor: primaryVariant,
      ),
      bottomSheetTheme: ModaloraBottomSheetTheme(
        backgroundColor: surfaceColor,
        surfaceColor: surfaceColor,
        barrierColor: barrierColor,
        borderColor: borderColor,
        dragHandleColor: const Color(0xFF52525B),
        titleStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textColor,
          fontFamily: fontFamily,
          letterSpacing: -0.3,
        ),
        messageStyle: TextStyle(
          fontSize: 14.5,
          color: textSecondaryColor,
          fontFamily: fontFamily,
          height: 1.4,
        ),
      ),
      popupTheme: ModaloraPopupTheme(
        backgroundColor: surfaceColor,
        surfaceColor: surfaceColor,
        borderColor: borderColor,
        arrowColor: surfaceColor,
      ),
      menuTheme: ModaloraMenuTheme(
        backgroundColor: surfaceColor,
        surfaceColor: surfaceColor,
        borderColor: borderColor,
        dividerColor: dividerColor,
        itemTheme: ModaloraMenuItemTheme(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
            fontFamily: fontFamily,
          ),
          subtitleStyle: TextStyle(
            fontSize: 12,
            color: textSecondaryColor,
            fontFamily: fontFamily,
          ),
          shortcutStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textSecondaryColor,
            fontFamily: fontFamily,
          ),
          iconColor: textSecondaryColor,
          hoverColor: const Color(0xFF27272A),
          pressedColor: const Color(0xFF3F3F46),
          selectedBackgroundColor: primaryColor.withValues(alpha: 0.20),
          selectedTextColor: primaryVariant,
          destructiveColor: errorColor,
        ),
      ),
      snackbarTheme: ModaloraSnackbarTheme(
        backgroundColor: const Color(0xF227272A),
        surfaceColor: const Color(0xF227272A),
        borderColor: borderColor,
        titleStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontFamily: fontFamily,
        ),
        messageStyle: TextStyle(
          fontSize: 13.5,
          color: const Color(0xFFD4D4D8),
          fontFamily: fontFamily,
        ),
        actionStyle: TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w600,
          color: accentColor,
          fontFamily: fontFamily,
        ),
        closeIconColor: const Color(0xFFA1A1AA),
        progressBarColor: primaryVariant,
        iconColor: primaryVariant,
      ),
      overlayTheme: ModaloraOverlayTheme(
        backgroundColor: const Color(0xE618181B),
        surfaceColor: const Color(0xE618181B),
        barrierColor: barrierColor,
        borderColor: borderColor,
        indicatorColor: primaryVariant,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor,
          fontFamily: fontFamily,
        ),
        messageStyle: TextStyle(
          fontSize: 13.5,
          color: textSecondaryColor,
          fontFamily: fontFamily,
        ),
      ),
    );
  }

  /// Preset Cyber Emerald theme with deep forest obsidian backdrop and glowing green-amber neon accents.
  factory ModaloraThemeData.emerald({String? fontFamily}) {
    return ModaloraThemeData.dark(
      primaryColor: const Color(0xFF10B981), // Emerald 500
      primaryVariant: const Color(0xFF34D399),
      accentColor: const Color(0xFFF59E0B), // Amber 500
      fontFamily: fontFamily,
    ).copyWith(
      backgroundColor: const Color(0xFF04130F),
      surfaceColor: const Color(0xF209211B),
      cardColor: const Color(0xFF0C2A22),
      borderColor: const Color(0x3334D399),
      dialogTheme: const ModaloraDialogTheme(
        borderRadius: BorderRadius.all(Radius.circular(28.0)),
        surfaceBlur: 24.0,
        barrierBlur: 10.0,
      ),
    );
  }

  /// Preset Cyberpunk Violet theme with deep plum obsidian backdrop and electric cyan/fuchsia neon accents.
  factory ModaloraThemeData.violet({String? fontFamily}) {
    return ModaloraThemeData.dark(
      primaryColor: const Color(0xFF8B5CF6), // Violet 500
      primaryVariant: const Color(0xFFA78BFA),
      accentColor: const Color(0xFFEC4899), // Pink 500
      fontFamily: fontFamily,
    ).copyWith(
      backgroundColor: const Color(0xFF0B061A),
      surfaceColor: const Color(0xF2150D2E),
      cardColor: const Color(0xFF1D123D),
      borderColor: const Color(0x38A78BFA),
      dialogTheme: const ModaloraDialogTheme(
        borderRadius: BorderRadius.all(Radius.circular(28.0)),
        surfaceBlur: 24.0,
        barrierBlur: 12.0,
      ),
    );
  }

  ModaloraThemeData copyWith({
    Brightness? brightness,
    Color? primaryColor,
    Color? primaryVariant,
    Color? accentColor,
    Color? backgroundColor,
    Color? surfaceColor,
    Color? cardColor,
    Color? barrierColor,
    Color? textColor,
    Color? textSecondaryColor,
    Color? borderColor,
    Color? dividerColor,
    Color? errorColor,
    Color? successColor,
    Color? warningColor,
    Color? infoColor,
    String? fontFamily,
    BorderRadius? defaultBorderRadius,
    double? defaultElevation,
    double? defaultBlur,
    EdgeInsetsGeometry? defaultPadding,
    EdgeInsetsGeometry? defaultMargin,
    double? defaultSpacing,
    ModaloraDialogTheme? dialogTheme,
    ModaloraBottomSheetTheme? bottomSheetTheme,
    ModaloraPopupTheme? popupTheme,
    ModaloraMenuTheme? menuTheme,
    ModaloraSnackbarTheme? snackbarTheme,
    ModaloraOverlayTheme? overlayTheme,
    ModaloraAnimationTheme? animationTheme,
  }) {
    return ModaloraThemeData(
      brightness: brightness ?? this.brightness,
      primaryColor: primaryColor ?? this.primaryColor,
      primaryVariant: primaryVariant ?? this.primaryVariant,
      accentColor: accentColor ?? this.accentColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      cardColor: cardColor ?? this.cardColor,
      barrierColor: barrierColor ?? this.barrierColor,
      textColor: textColor ?? this.textColor,
      textSecondaryColor: textSecondaryColor ?? this.textSecondaryColor,
      borderColor: borderColor ?? this.borderColor,
      dividerColor: dividerColor ?? this.dividerColor,
      errorColor: errorColor ?? this.errorColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      infoColor: infoColor ?? this.infoColor,
      fontFamily: fontFamily ?? this.fontFamily,
      defaultBorderRadius: defaultBorderRadius ?? this.defaultBorderRadius,
      defaultElevation: defaultElevation ?? this.defaultElevation,
      defaultBlur: defaultBlur ?? this.defaultBlur,
      defaultPadding: defaultPadding ?? this.defaultPadding,
      defaultMargin: defaultMargin ?? this.defaultMargin,
      defaultSpacing: defaultSpacing ?? this.defaultSpacing,
      dialogTheme: dialogTheme ?? this.dialogTheme,
      bottomSheetTheme: bottomSheetTheme ?? this.bottomSheetTheme,
      popupTheme: popupTheme ?? this.popupTheme,
      menuTheme: menuTheme ?? this.menuTheme,
      snackbarTheme: snackbarTheme ?? this.snackbarTheme,
      overlayTheme: overlayTheme ?? this.overlayTheme,
      animationTheme: animationTheme ?? this.animationTheme,
    );
  }
}
