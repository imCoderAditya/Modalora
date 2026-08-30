# Changelog

## 1.0.1

* Added **3D Spatial Hologram & Perspective Tilt Engine**:
  * `Modalora.hologram` (1-line interactive 3D Hologram Modal with glowing orbital ring and specular light reflection).
  * `Modalora.dialog3D` (transform any custom Flutter widget into an interactive 3D tilt card).
  * `Modalora3DTiltCard` (spatial Matrix4 tilt container with dynamic pointer and gyro tracking).
* Enhanced **Frosted Glass (Glassmorphism)** across all components with hardware-accelerated `ModaloraGlassContainer`.
* Added customizable `alignment` across BottomSheets and TopSheets (`Alignment.bottomCenter`, `Alignment.topCenter`).
* Updated complete documentation, live phone simulator, and starter guides.

## 1.0.0

* Initial release of **Modalora — Full Customization Design System for Flutter**.
* Core components:
  * `Modalora.dialog` (modern cards, spring physics, auto-close timers, action buttons).
  * `Modalora.bottomSheet` (snap points, drag physics, glassmorphic blur).
  * `Modalora.popup` (8 anchor positions, edge collision clamping).
  * `Modalora.menu` & `ModaloraContextMenuRegion` (context menu, right-click, shortcuts, nested flyouts).
  * `Modalora.snackbar` (multi-position stack, countdown progress bar, swipe to dismiss).
  * `Modalora.overlay` & `Modalora.loading` (fullscreen blocking overlay with programmatic handle control).
* Centralized theme system with `ModaloraThemeData`, `ModaloraTheme`, and independent light/dark presets.
* Comprehensive animation engine with `ModaloraAnimation` and `ModaloraSpringCurve`.
