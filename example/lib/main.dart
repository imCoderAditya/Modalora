import 'package:flutter/material.dart';
import 'package:modalora/modalora.dart';

void main() {
  runApp(const ModaloraShowcaseApp());
}

class ModaloraShowcaseApp extends StatefulWidget {
  const ModaloraShowcaseApp({super.key});

  @override
  State<ModaloraShowcaseApp> createState() => _ModaloraShowcaseAppState();
}

class _ModaloraShowcaseAppState extends State<ModaloraShowcaseApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int _themeModeIndex =
      1; // 0: Light, 1: Dark (Obsidian), 2: Emerald, 3: Violet

  ModaloraThemeData _getTheme() {
    switch (_themeModeIndex) {
      case 0:
        return ModaloraThemeData.light();
      case 1:
        return ModaloraThemeData.dark();
      case 2:
        return ModaloraThemeData.emerald();
      case 3:
      default:
        return ModaloraThemeData.violet();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = _getTheme();
    Modalora.configure(
      navigatorKey: _navigatorKey,
      theme: themeData,
    );

    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Modalora — Design System Showroom',
      debugShowCheckedModeBanner: false,
      themeMode: _themeModeIndex == 0 ? ThemeMode.light : ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: themeData.backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: themeData.primaryColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return ModaloraTheme(
          data: themeData,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: ShowcaseHomeScreen(
        currentThemeIndex: _themeModeIndex,
        onThemeChanged: (index) => setState(() => _themeModeIndex = index),
      ),
    );
  }
}

class ShowcaseHomeScreen extends StatelessWidget {
  const ShowcaseHomeScreen({
    super.key,
    required this.currentThemeIndex,
    required this.onThemeChanged,
  });

  final int currentThemeIndex;
  final ValueChanged<int> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = ModaloraTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.surfaceColor,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: theme.borderColor,
            height: 1.0,
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [theme.primaryColor, theme.accentColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: theme.primaryColor.withValues(alpha: 0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.layers_rounded,
                  color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            Text(
              'Modalora',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                fontSize: 16,
                color: theme.textColor,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: theme.primaryColor.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: theme.primaryColor.withValues(alpha: 0.3)),
              ),
              child: Text(
                'v1.0 Pro',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: theme.primaryColor,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Builder(
            builder: (btnContext) {
              final String currentLabel = switch (currentThemeIndex) {
                0 => 'Light Crystal',
                1 => 'Midnight Obsidian',
                2 => 'Cyber Emerald',
                _ => 'Cyberpunk Violet',
              };
              final IconData currentIcon = switch (currentThemeIndex) {
                0 => Icons.light_mode_rounded,
                1 => Icons.dark_mode_rounded,
                2 => Icons.eco_rounded,
                _ => Icons.auto_awesome_rounded,
              };

              return Padding(
                padding: const EdgeInsets.only(right: 14.0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Modalora.menu(
                        context: btnContext,
                        items: [
                          ModaloraMenuItem(
                            title: 'Light Crystal',
                            subtitle: 'Frosted clean glass & crisp slate',
                            icon: const Icon(Icons.light_mode_rounded,
                                color: Color(0xFFF59E0B)),
                            isSelected: currentThemeIndex == 0,
                            onTap: () => onThemeChanged(0),
                          ),
                          ModaloraMenuItem(
                            title: 'Midnight Obsidian',
                            subtitle: 'Deep obsidian zinc & neon indigo',
                            icon: const Icon(Icons.dark_mode_rounded,
                                color: Color(0xFF818CF8)),
                            isSelected: currentThemeIndex == 1,
                            onTap: () => onThemeChanged(1),
                          ),
                          ModaloraMenuItem(
                            title: 'Cyber Emerald',
                            subtitle: 'Forest obsidian & radiant amber',
                            icon: const Icon(Icons.eco_rounded,
                                color: Color(0xFF10B981)),
                            isSelected: currentThemeIndex == 2,
                            onTap: () => onThemeChanged(2),
                          ),
                          ModaloraMenuItem(
                            title: 'Cyberpunk Violet',
                            subtitle: 'Electric purple & neon fuchsia',
                            icon: const Icon(Icons.auto_awesome_rounded,
                                color: Color(0xFFA78BFA)),
                            isSelected: currentThemeIndex == 3,
                            onTap: () => onThemeChanged(3),
                          ),
                        ],
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                        color: theme.isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.black.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: theme.borderColor),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(currentIcon,
                              size: 16, color: theme.primaryColor),
                          const SizedBox(width: 6),
                          Text(
                            currentLabel,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: theme.textColor,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.keyboard_arrow_down_rounded,
                              size: 16, color: theme.textSecondaryColor),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        children: [
          RepaintBoundary(child: _buildHeroHeader(context, theme)),
          const SizedBox(height: 36.0),

          // 1. BOTTOM SHEETS (TOP PRIORITY)
          _buildSectionHeader(
            theme,
            icon: Icons.vertical_align_bottom_rounded,
            title: '1. Modern BottomSheet Studio',
            subtitle:
                'Apple-style floating sheets, physics drag handles, options grids, and interactive media sheets.',
          ),
          const SizedBox(height: 16.0),
          RepaintBoundary(child: _buildBottomSheetGrid(context, theme)),
          const SizedBox(height: 36.0),

          // 2. DIALOGS
          _buildSectionHeader(
            theme,
            icon: Icons.window_rounded,
            title: '2. Dialog & Modal Engine',
            subtitle:
                'Rich cards, physics springs, destructive alerts, custom interactive forms & auto-close timers.',
          ),
          const SizedBox(height: 16.0),
          RepaintBoundary(child: _buildDialogGrid(context, theme)),
          const SizedBox(height: 36.0),

          // 3. POPUPS & TOOLTIPS
          _buildSectionHeader(
            theme,
            icon: Icons.near_me_rounded,
            title: '3. Smart Targeted Popups & Tooltips',
            subtitle:
                'Viewport collision detection, custom anchor pointing (Top, Bottom, Left, Right) & profile popovers.',
          ),
          const SizedBox(height: 16.0),
          RepaintBoundary(child: _buildPopupGrid(context, theme)),
          const SizedBox(height: 36.0),

          // 4. MENUS & CONTEXT MENUS
          _buildSectionHeader(
            theme,
            icon: Icons.menu_open_rounded,
            title: '4. Command Menus & Context Menus',
            subtitle:
                'Raycast / Linear style command flyouts, keyboard shortcut badges, submenus, and right-click canvas.',
          ),
          const SizedBox(height: 16.0),
          RepaintBoundary(child: _buildMenuGrid(context, theme)),
          const SizedBox(height: 36.0),

          // 5. SNACKBARS & TOASTS
          _buildSectionHeader(
            theme,
            icon: Icons.notifications_active_rounded,
            title: '5. Floating Dynamic Island Snackbars',
            subtitle:
                'Multi-position stackable toasts, live countdown progress bars, interactive action buttons, and queues.',
          ),
          const SizedBox(height: 16.0),
          RepaintBoundary(child: _buildSnackbarGrid(context, theme)),
          const SizedBox(height: 36.0),

          // 6. OVERLAYS & LOADERS
          _buildSectionHeader(
            theme,
            icon: Icons.blur_on_rounded,
            title: '6. Glassmorphism Loaders & Overlays',
            subtitle:
                'Heavy sigma glass shields, orbital spinning spinners, and programmatic handle-based dismiss.',
          ),
          const SizedBox(height: 16.0),
          RepaintBoundary(child: _buildOverlayGrid(context, theme)),
          const SizedBox(height: 60.0),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HERO SECTION
  // ---------------------------------------------------------------------------
  Widget _buildHeroHeader(BuildContext context, ModaloraThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(26.0),
      decoration: BoxDecoration(
        color: theme.surfaceColor,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: theme.borderColor),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor
                .withValues(alpha: theme.isDark ? 0.12 : 0.06),
            blurRadius: 36,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.primaryColor.withValues(alpha: 0.2),
                      theme.accentColor.withValues(alpha: 0.2)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: theme.primaryColor.withValues(alpha: 0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bolt_rounded,
                        size: 14, color: theme.accentColor),
                    const SizedBox(width: 4),
                    Text(
                      'NEXT-GEN FLUTTER OVERLAY SYSTEM',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                        color: theme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Text(
            'Beautiful by default.\nCompletely customizable by choice.',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.8,
              height: 1.25,
              color: theme.textColor,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            'A production-ready design system for Flutter. Zero boilerplate required for world-class UI, with 100% control over physics, colors, blur, animations, and responsive layout.',
            style: TextStyle(
              fontSize: 14.0,
              color: theme.textSecondaryColor,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              _buildFeatureBadge(theme, '⚡ 60fps Physics Spring'),
              _buildFeatureBadge(theme, '💎 Heavy Sigma Glass'),
              _buildFeatureBadge(theme, '🎯 Target Anchor Pinning'),
              _buildFeatureBadge(theme, '📱 Adaptive Screen Breakpoints'),
              _buildFeatureBadge(theme, '🍞 Dynamic Island Toasts'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureBadge(ModaloraThemeData theme, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: theme.isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.black.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: theme.borderColor),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          color: theme.textColor.withValues(alpha: 0.85),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    ModaloraThemeData theme, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: theme.primaryColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 18, color: theme.primaryColor),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: theme.textColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(
          subtitle,
          style: TextStyle(
              fontSize: 13.5, color: theme.textSecondaryColor, height: 1.4),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 1. DIALOG SYSTEM SHOWCASE
  // ---------------------------------------------------------------------------
  Widget _buildDialogGrid(BuildContext context, ModaloraThemeData theme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth > 760
            ? 3
            : (constraints.maxWidth > 500 ? 2 : 1);
        final cardWidth = cols == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - (cols - 1) * 14.0) / cols;

        return Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: [
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Standard Modal',
                description:
                    'Dual actions, frosted backdrop blur, and illuminated icon.',
                icon: Icons.check_circle_outline_rounded,
                accentColor: theme.primaryColor,
                buttonLabel: 'Open Dialog',
                onTap: () {
                  Modalora.dialog(
                    context: context,
                    icon: const Icon(Icons.rocket_launch_rounded),
                    title: 'Upgrade to Modalora Pro',
                    message:
                        'Unlock unlimited overlay presets, advanced animation curves, and priority developer support.',
                    primaryActionText: 'Upgrade Now',
                    secondaryActionText: 'Maybe Later',
                    onPrimaryAction: () {
                      Modalora.snackbar(
                        context: context,
                        title: 'Welcome to Pro! 🎉',
                        message:
                            'Your license key has been activated successfully.',
                        icon: const Icon(Icons.verified_rounded),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Physics Spring Bounce',
                description:
                    'Real mass, damping & stiffness simulation bounce curves.',
                icon: Icons.animation_rounded,
                accentColor: theme.accentColor,
                buttonLabel: 'Launch Spring',
                onTap: () {
                  Modalora.dialog(
                    context: context,
                    icon: const Icon(Icons.auto_awesome_rounded),
                    title: 'Spring Physics Simulation',
                    message:
                        'This dialog renders with real mass, damping, and stiffness spring physics curves for an ultra fluid organic feel.',
                    primaryActionText: 'Awesome!',
                    animation: ModaloraAnimation.spring(),
                  );
                },
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: '3D Hologram Engine',
                description:
                    'Dynamic 3D gyro tilt, specular light sheen, and pulsing core ring.',
                icon: Icons.view_in_ar_rounded,
                accentColor: const Color(0xFF06B6D4),
                buttonLabel: 'Launch 3D Hologram',
                onTap: () {
                  Modalora.hologram(
                    context: context,
                    title: '3D Hologram Engine',
                    message:
                        'Drag or move your cursor across this card to experience real-time 3D perspective gyro tilting and specular light reflections.',
                    primaryActionText: 'Explore 3D',
                    secondaryActionText: 'Dismiss',
                    onPrimaryAction: () {
                      Navigator.of(context).pop();
                      Modalora.snackbar(
                        context: context,
                        title: '3D Hologram Activated! 🚀',
                        message:
                            'Custom 3D Matrix4 perspective was rendered successfully.',
                        icon: const Icon(Icons.auto_awesome_rounded),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: '3D Custom Tilt Card',
                description:
                    'Wraps any custom widget inside a 3D perspective tilt modal.',
                icon: Icons.threed_rotation_rounded,
                accentColor: const Color(0xFFA855F7),
                buttonLabel: 'Launch Custom 3D',
                onTap: () {
                  Modalora.dialog3D(
                    context: context,
                    maxTilt: 0.3,
                    child: Container(
                      padding: const EdgeInsets.all(24.0),
                      constraints: const BoxConstraints(maxWidth: 320),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1E1B4B), Color(0xFF312E81)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24.0),
                        border: Border.all(
                          color: const Color(0xFFA855F7).withValues(alpha: 0.5),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFA855F7).withValues(alpha: 0.35),
                            blurRadius: 32.0,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.stars_rounded,
                              size: 48, color: Color(0xFFA855F7)),
                          const SizedBox(height: 12),
                          const Text(
                            'Custom 3D Widget',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Any Flutter widget can be transformed into an interactive 3D card with Modalora.dialog3D()!',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12.5, color: Color(0xFFC7D2FE)),
                          ),
                          const SizedBox(height: 18),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFA855F7),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Awesome!'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Destructive Confirm',
                description:
                    'Alert shield with coral red theme overrides and safe confirm.',
                icon: Icons.delete_forever_rounded,
                accentColor: theme.errorColor,
                buttonLabel: 'Delete Warning',
                onTap: () {
                  Modalora.dialog(
                    context: context,
                    icon: const Icon(Icons.warning_amber_rounded),
                    iconColor: theme.errorColor,
                    iconBackgroundColor:
                        theme.errorColor.withValues(alpha: 0.15),
                    title: 'Delete Repository?',
                    message:
                        'This action is irreversible. All branches, pull requests, and commit history will be permanently deleted.',
                    destructiveActionText: 'Delete Permanently',
                    secondaryActionText: 'Cancel',
                    buttonLayout: ModaloraButtonLayout.vertical,
                    onDestructiveAction: () {
                      Modalora.snackbar(
                        context: context,
                        title: 'Repository Deleted',
                        message: 'Resource was removed from server.',
                        icon: const Icon(Icons.delete_outline_rounded),
                        backgroundColor:
                            theme.errorColor.withValues(alpha: 0.9),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Interactive Form Dialog',
                description:
                    'Custom rich widget tree with embedded form controls.',
                icon: Icons.credit_card_rounded,
                accentColor: theme.successColor,
                buttonLabel: 'Pay Card Form',
                onTap: () {
                  Modalora.dialog(
                    context: context,
                    title: 'Confirm Payment',
                    message:
                        'Please review your invoice details before proceeding.',
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.black.withValues(alpha: 0.03),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.borderColor),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Plan: Modalora Team',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: theme.textColor)),
                              Text('\$49/mo',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: theme.primaryColor,
                                      fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.lock_outline_rounded,
                                  size: 14, color: theme.textSecondaryColor),
                              const SizedBox(width: 6),
                              Text('256-bit End-to-End Encrypted',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: theme.textSecondaryColor)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    primaryActionText: 'Confirm & Pay \$49',
                    secondaryActionText: 'Cancel',
                  );
                },
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Auto-Close Timer',
                description:
                    'Auto-dismisses in 3 seconds with animated timer bar.',
                icon: Icons.timer_outlined,
                accentColor: const Color(0xFFF59E0B),
                buttonLabel: '3s Auto-Timer',
                onTap: () {
                  Modalora.dialog(
                    context: context,
                    icon: const Icon(Icons.sync_rounded),
                    title: 'Syncing in Progress...',
                    message:
                        'Synchronizing local cache with cloud server. This dialog will auto-close in 3 seconds.',
                    autoCloseDuration: const Duration(seconds: 3),
                    primaryActionText: 'Dismiss Now',
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // 2. BOTTOMSHEET SYSTEM SHOWCASE
  // ---------------------------------------------------------------------------
  Widget _buildBottomSheetGrid(BuildContext context, ModaloraThemeData theme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth > 760
            ? 3
            : (constraints.maxWidth > 500 ? 2 : 1);
        final cardWidth = cols == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - (cols - 1) * 14.0) / cols;

        return Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: [
            // 1. Apple iOS Share Sheet
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Apple iOS Share Sheet',
                description:
                    'Recent contacts row, AirDrop, Messages, and quick system actions.',
                icon: Icons.share_rounded,
                accentColor: theme.primaryColor,
                buttonLabel: 'Open Share Sheet',
                onTap: () {
                  Modalora.bottomSheet(
                    // context: context,
                    title: 'Share Document',
                    message: 'Send project link or export asset to your team.',
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        // Recent contacts
                        SizedBox(
                          height: 72,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _buildContactAvatar(
                                  theme, 'Sarah', Colors.purpleAccent, 'S'),
                              _buildContactAvatar(
                                  theme, 'Liam', Colors.blueAccent, 'L'),
                              _buildContactAvatar(
                                  theme, 'Elena', Colors.amberAccent, 'E'),
                              _buildContactAvatar(
                                  theme, 'David', Colors.tealAccent, 'D'),
                              _buildContactAvatar(
                                  theme, 'Maya', Colors.pinkAccent, 'M'),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14),
                        const Divider(height: 1),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildShareAction(theme,
                                Icons.airplanemode_active_rounded, 'AirDrop'),
                            _buildShareAction(
                                theme, Icons.message_rounded, 'Messages'),
                            _buildShareAction(
                                theme, Icons.mail_outline_rounded, 'Mail'),
                            _buildShareAction(
                                theme, Icons.copy_rounded, 'Copy Link'),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 2. Biometric Checkout / Apple Pay
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Biometric Pay Checkout',
                description:
                    'Apple Pay order breakdown, credit card preview, and Face ID trigger.',
                icon: Icons.credit_card_rounded,
                accentColor: const Color(0xFF10B981),
                buttonLabel: 'Apple Pay Sheet',
                onTap: () {
                  Modalora.bottomSheet(
                    // context: context,
                    title: 'Apple Pay Checkout',
                    message: 'Confirm payment for Modalora Pro Subscription.',
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.isDark
                                ? Colors.white.withValues(alpha: 0.05)
                                : Colors.black.withValues(alpha: 0.04),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: theme.borderColor),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Modalora Enterprise Pro',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: theme.textColor)),
                                  Text('\$89.00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: theme.textColor)),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Cloud Edge Compute Tax',
                                      style: TextStyle(
                                          fontSize: 12.5,
                                          color: theme.textSecondaryColor)),
                                  Text('\$7.12',
                                      style: TextStyle(
                                          fontSize: 12.5,
                                          color: theme.textSecondaryColor)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Divider(height: 1),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: theme.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: const Text('VISA',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white)),
                                      ),
                                      const SizedBox(width: 8),
                                      Text('•••• 4242',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: theme.textColor)),
                                    ],
                                  ),
                                  Text('\$96.12',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w900,
                                          color: theme.primaryColor)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).maybePop();
                              Modalora.snackbar(
                                context: context,
                                title: 'Payment Confirmed',
                                message:
                                    'Transaction #TX-98402 processed via Apple Pay.',
                                icon: const Icon(Icons.check_circle_rounded),
                                position: ModaloraPosition.topCenter,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.fingerprint_rounded,
                                    size: 22, color: Colors.white),
                                SizedBox(width: 8),
                                Text('Pay with Face ID',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 3. Studio Hi-Fi Media Player
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Studio Hi-Fi Audio Sheet',
                description:
                    'Dynamic soundwave spectrum, album art glow, and track scrubber.',
                icon: Icons.music_note_rounded,
                accentColor: theme.successColor,
                buttonLabel: 'Audio Player',
                onTap: () {
                  Modalora.bottomSheet(
                    context: context,
                    title: 'Now Playing',
                    message: 'Modalora Soundwaves • Cyberpunk Lounge Hi-Fi',
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 12),
                        Container(
                          height: 110,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                theme.primaryColor,
                                theme.accentColor,
                                Colors.indigoAccent
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    theme.primaryColor.withValues(alpha: 0.35),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                right: 16,
                                top: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.4),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text('LOSSLESS 24-BIT',
                                      style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white)),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  12,
                                  (index) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    width: 4,
                                    height: 16.0 + (index % 4) * 12.0,
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.white.withValues(alpha: 0.9),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        // Track scrubber bar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('02:14',
                                style: TextStyle(
                                    fontSize: 11.5,
                                    color: theme.textSecondaryColor,
                                    fontWeight: FontWeight.w600)),
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                height: 4,
                                decoration: BoxDecoration(
                                  color: theme.isDark
                                      ? Colors.white24
                                      : Colors.black12,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: 0.58,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: theme.primaryColor,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text('03:45',
                                style: TextStyle(
                                    fontSize: 11.5,
                                    color: theme.textSecondaryColor,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.shuffle_rounded,
                                    color: theme.textSecondaryColor, size: 22)),
                            const SizedBox(width: 8),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.skip_previous_rounded,
                                    color: theme.textColor, size: 28)),
                            const SizedBox(width: 14),
                            Container(
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.primaryColor
                                        .withValues(alpha: 0.4),
                                    blurRadius: 16,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.play_arrow_rounded,
                                      color: Colors.white, size: 32)),
                            ),
                            const SizedBox(width: 14),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.skip_next_rounded,
                                    color: theme.textColor, size: 28)),
                            const SizedBox(width: 8),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.repeat_rounded,
                                    color: theme.textSecondaryColor, size: 22)),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 4. Smart Filters & Parameter Studio
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Smart Parameter Studio',
                description:
                    'Segmented pills, filter chips, and adaptive hardware switches.',
                icon: Icons.tune_rounded,
                accentColor: theme.accentColor,
                buttonLabel: 'Filter Sheet',
                onTap: () {
                  Modalora.bottomSheet(
                    context: context,
                    title: 'Filter & Search Settings',
                    message:
                        'Customize render pipeline and build channel preferences.',
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildFilterChip(theme, 'All Items', true),
                            _buildFilterChip(theme, 'High Priority', false),
                            _buildFilterChip(theme, 'Experimental', false),
                            _buildFilterChip(theme, 'WebGL 2.0', true),
                          ],
                        ),
                        const SizedBox(height: 14),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: true,
                          onChanged: (_) {},
                          title: Text('Include Pre-releases',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: theme.textColor)),
                          subtitle: Text('Show beta and RC builds',
                              style: TextStyle(
                                  color: theme.textSecondaryColor,
                                  fontSize: 12)),
                        ),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: false,
                          onChanged: (_) {},
                          title: Text('Hardware Acceleration',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: theme.textColor)),
                          subtitle: Text('Enable Vulkan / Metal backend',
                              style: TextStyle(
                                  color: theme.textSecondaryColor,
                                  fontSize: 12)),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).maybePop(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Apply 4 Filters',
                                style: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 5. Team Collaborators & Permissions
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Team & Collaboration',
                description:
                    'Role permission pills, collaborator avatars, and invite links.',
                icon: Icons.group_outlined,
                accentColor: const Color(0xFF8B5CF6),
                buttonLabel: 'Team Access',
                onTap: () {
                  Modalora.bottomSheet(
                    context: context,
                    title: 'Project Collaborators',
                    message: 'Manage workspace member access and invitations.',
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 8),
                        _buildMemberRow(theme, 'Alex Rivers',
                            'alex@modalora.dev', 'Owner', theme.primaryColor),
                        const SizedBox(height: 8),
                        _buildMemberRow(theme, 'Sophia Chen', 'sophia@acme.ai',
                            'Editor', theme.accentColor),
                        const SizedBox(height: 8),
                        _buildMemberRow(theme, 'Marcus Vance',
                            'marcus@design.io', 'Viewer', Colors.grey),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.isDark
                                ? Colors.white.withValues(alpha: 0.05)
                                : Colors.black.withValues(alpha: 0.04),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: theme.borderColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.link_rounded,
                                      color: theme.primaryColor, size: 20),
                                  const SizedBox(width: 8),
                                  Text('modalora.dev/join/x849f2',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: theme.textColor)),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).maybePop();
                                  Modalora.snackbar(
                                    context: context,
                                    title: 'Link Copied',
                                    message: 'Invite link copied to clipboard.',
                                    icon: const Icon(Icons.copy_rounded),
                                    position: ModaloraPosition.topCenter,
                                  );
                                },
                                child: const Text('Copy',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 6. Interactive Drag & Snap Search
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Draggable Snap Explorer',
                description:
                    'Multi-snap sheet with physics drag handle and live component search.',
                icon: Icons.drag_handle_rounded,
                accentColor: const Color(0xFFEC4899),
                buttonLabel: 'Snap Explorer',
                onTap: () {
                  Modalora.bottomSheet(
                    context: context,
                    title: 'Component Explorer',
                    message:
                        'Drag the handle up or down to adjust bottom sheet height.',
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Search overlays, dialogs & toasts...',
                            hintStyle: TextStyle(
                                fontSize: 13, color: theme.textSecondaryColor),
                            prefixIcon: Icon(Icons.search_rounded,
                                color: theme.primaryColor, size: 20),
                            filled: true,
                            fillColor: theme.isDark
                                ? Colors.white.withValues(alpha: 0.05)
                                : Colors.black.withValues(alpha: 0.03),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: theme.borderColor)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: theme.borderColor)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color:
                                    theme.primaryColor.withValues(alpha: 0.15),
                                shape: BoxShape.circle),
                            child: Icon(Icons.bolt_rounded,
                                color: theme.primaryColor, size: 20),
                          ),
                          title: Text('Spring Physics Modals',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: theme.textColor,
                                  fontSize: 14)),
                          subtitle: Text(
                              'Sub-pixel damping with zero frame drops',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: theme.textSecondaryColor)),
                          trailing: Icon(Icons.chevron_right_rounded,
                              color: theme.textSecondaryColor),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color:
                                    theme.accentColor.withValues(alpha: 0.15),
                                shape: BoxShape.circle),
                            child: Icon(Icons.blur_on_rounded,
                                color: theme.accentColor, size: 20),
                          ),
                          title: Text('Heavy Sigma Glassmorphism',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: theme.textColor,
                                  fontSize: 14)),
                          subtitle: Text(
                              'Hardware-accelerated isolated backdrop layer',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: theme.textSecondaryColor)),
                          trailing: Icon(Icons.chevron_right_rounded,
                              color: theme.textSecondaryColor),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 7. Multi-Step Stepper Sheet (StatefulBuilder)
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Multi-Step Stepper Sheet',
                description:
                    'Dynamic stateful 3-step setup flow with live progress & validation.',
                icon: Icons.linear_scale_rounded,
                accentColor: const Color(0xFF6366F1),
                buttonLabel: 'Launch Stepper',
                onTap: () {
                  int currentStep = 1;
                  String workspaceName = 'Antigravity Studio';
                  bool notifyTeam = true;

                  Modalora.bottomSheet(
                    context: context,
                    title: 'Workspace Onboarding',
                    message: 'Complete setup in 3 quick interactive steps.',
                    child: StatefulBuilder(
                      builder: (ctx, setModalState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            // Progress bar
                            Row(
                              children: [
                                for (int i = 1; i <= 3; i++) ...[
                                  if (i > 1) const SizedBox(width: 6),
                                  Expanded(
                                    child: Container(
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: i <= currentStep
                                            ? theme.primaryColor
                                            : (theme.isDark
                                                ? Colors.white12
                                                : Colors.black12),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (currentStep == 1) ...[
                              Text('Step 1: Name Your Project',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.5,
                                      color: theme.textColor)),
                              const SizedBox(height: 8),
                              TextField(
                                onChanged: (v) =>
                                    setModalState(() => workspaceName = v),
                                decoration: InputDecoration(
                                  hintText: workspaceName,
                                  filled: true,
                                  fillColor: theme.isDark
                                      ? Colors.white.withValues(alpha: 0.05)
                                      : Colors.black.withValues(alpha: 0.03),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide:
                                          BorderSide(color: theme.borderColor)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide:
                                          BorderSide(color: theme.borderColor)),
                                ),
                              ),
                            ] else if (currentStep == 2) ...[
                              Text('Step 2: Team Notifications',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.5,
                                      color: theme.textColor)),
                              const SizedBox(height: 8),
                              SwitchListTile.adaptive(
                                contentPadding: EdgeInsets.zero,
                                value: notifyTeam,
                                onChanged: (v) =>
                                    setModalState(() => notifyTeam = v),
                                title: Text('Broadcast to Slack',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: theme.textColor)),
                                subtitle: Text('Post release notes to #general',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: theme.textSecondaryColor)),
                              ),
                            ] else ...[
                              Center(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                          color: theme.successColor
                                              .withValues(alpha: 0.15),
                                          shape: BoxShape.circle),
                                      child: Icon(Icons.rocket_launch_rounded,
                                          size: 36, color: theme.successColor),
                                    ),
                                    const SizedBox(height: 10),
                                    Text('Ready to Deploy "$workspaceName"',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 15.5,
                                            color: theme.textColor)),
                                    const SizedBox(height: 4),
                                    Text('All cluster environments configured.',
                                        style: TextStyle(
                                            fontSize: 12.5,
                                            color: theme.textSecondaryColor)),
                                  ],
                                ),
                              ),
                            ],
                            const SizedBox(height: 18),
                            Row(
                              children: [
                                if (currentStep > 1) ...[
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () =>
                                          setModalState(() => currentStep--),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 13),
                                        side: BorderSide(
                                            color: theme.borderColor),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                      child: Text('Back',
                                          style: TextStyle(
                                              color: theme.textColor,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                ],
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (currentStep < 3) {
                                        setModalState(() => currentStep++);
                                      } else {
                                        Navigator.of(context).maybePop();
                                        Modalora.snackbar(
                                          context: context,
                                          title: 'Workspace Initialized',
                                          message:
                                              'Successfully deployed "$workspaceName" to edge network.',
                                          icon: const Icon(
                                              Icons.check_circle_rounded),
                                          position: ModaloraPosition.topCenter,
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.primaryColor,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 13),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                    ),
                                    child: Text(
                                        currentStep < 3
                                            ? 'Continue'
                                            : 'Finish & Launch',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700)),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            // 8. 5-Star Interactive Rating Sheet (StatefulBuilder)
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: '5-Star Feedback Studio',
                description:
                    'Stateful interactive rating with dynamic emojis and feedback tag chips.',
                icon: Icons.star_rate_rounded,
                accentColor: const Color(0xFFF59E0B),
                buttonLabel: 'Rate Experience',
                onTap: () {
                  int rating = 5;
                  final selectedTags = <String>{'Buttery Smooth', 'Luxury UI'};

                  Modalora.bottomSheet(
                    context: context,
                    title: 'Rate Your Experience',
                    message: 'How was your experience building with Modalora?',
                    child: StatefulBuilder(
                      builder: (ctx, setRatingState) {
                        final emojis = ['😡', '😕', '😐', '😊', '🤩'];
                        final tagOptions = [
                          'Buttery Smooth',
                          'Luxury UI',
                          'Zero Lag',
                          'Physics Feel',
                          'Custom Glass'
                        ];

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 12),
                            Text(emojis[rating - 1],
                                style: const TextStyle(fontSize: 44)),
                            const SizedBox(height: 8),
                            // Star selector row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(5, (index) {
                                final starNum = index + 1;
                                final isFilled = starNum <= rating;
                                return IconButton(
                                  onPressed: () =>
                                      setRatingState(() => rating = starNum),
                                  icon: Icon(
                                    isFilled
                                        ? Icons.star_rounded
                                        : Icons.star_outline_rounded,
                                    color: isFilled
                                        ? const Color(0xFFF59E0B)
                                        : theme.textSecondaryColor,
                                    size: 36,
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 14),
                            // Feedback tag chips
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              alignment: WrapAlignment.center,
                              children: tagOptions.map((tag) {
                                final isSelected = selectedTags.contains(tag);
                                return InkWell(
                                  onTap: () => setRatingState(() {
                                    if (isSelected) {
                                      selectedTags.remove(tag);
                                    } else {
                                      selectedTags.add(tag);
                                    }
                                  }),
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? theme.primaryColor
                                          : (theme.isDark
                                              ? Colors.white
                                                  .withValues(alpha: 0.06)
                                              : Colors.black
                                                  .withValues(alpha: 0.04)),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: isSelected
                                              ? theme.primaryColor
                                              : theme.borderColor),
                                    ),
                                    child: Text(
                                      tag,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: isSelected
                                            ? Colors.white
                                            : theme.textColor,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).maybePop();
                                  Modalora.snackbar(
                                    context: context,
                                    title: 'Review Submitted ($rating★)',
                                    message:
                                        'Thank you for your feedback! Your review helps us improve.',
                                    icon: const Icon(Icons.star_rounded),
                                    position: ModaloraPosition.topCenter,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.primaryColor,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14)),
                                ),
                                child: const Text('Submit Review',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15)),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            // 9. Apple Destructive ActionSheet
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Apple ActionSheet',
                description:
                    'Grouped modal actions with destructive styling and separated cancel capsule.',
                icon: Icons.more_horiz_rounded,
                accentColor: theme.errorColor,
                buttonLabel: 'Action Sheet',
                onTap: () {
                  Modalora.actionSheet(
                    context: context,
                    title: 'Asset Management',
                    message:
                        'Select an operation to perform on "Production Build #104".',
                    actions: [
                      ModaloraActionSheetItem(
                        title: 'Duplicate Workspace',
                        icon: const Icon(Icons.copy_rounded),
                        onTap: () {
                          Modalora.snackbar(
                            context: context,
                            title: 'Workspace Duplicated',
                            message:
                                'Created copy "Production Build #104 (Copy)".',
                            icon: const Icon(Icons.copy_rounded),
                            position: ModaloraPosition.topCenter,
                          );
                        },
                      ),
                      ModaloraActionSheetItem(
                        title: 'Archive Project',
                        icon: const Icon(Icons.archive_outlined),
                        onTap: () {
                          Modalora.snackbar(
                            context: context,
                            title: 'Project Archived',
                            message: 'Moved project to deep cold archive.',
                            icon: const Icon(Icons.archive_rounded),
                            position: ModaloraPosition.topCenter,
                          );
                        },
                      ),
                      ModaloraActionSheetItem(
                        title: 'Delete Permanently',
                        icon: const Icon(Icons.delete_forever_rounded),
                        isDestructive: true,
                        onTap: () {
                          Modalora.snackbar(
                            context: context,
                            title: 'Asset Deleted',
                            message:
                                'Project and all active edge replicas were removed.',
                            icon: const Icon(Icons.delete_outline_rounded),
                            position: ModaloraPosition.topCenter,
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),

            // 10. Date & Time Schedule Picker Sheet
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Schedule & Time Picker',
                description:
                    'Quick presets (Today, Tomorrow, Custom) and time slot selector chips.',
                icon: Icons.calendar_month_rounded,
                accentColor: const Color(0xFF06B6D4),
                buttonLabel: 'Schedule Sheet',
                onTap: () {
                  String selectedPreset = 'Tomorrow';
                  String selectedTime = '02:00 PM';

                  Modalora.bottomSheet(
                    context: context,
                    title: 'Schedule Deployment',
                    message: 'Select execution window for cloud deployment.',
                    child: StatefulBuilder(
                      builder: (ctx, setScheduleState) {
                        final presets = [
                          'Today',
                          'Tomorrow',
                          'This Friday',
                          'Next Mon'
                        ];
                        final timeSlots = [
                          '09:00 AM',
                          '02:00 PM',
                          '06:30 PM',
                          '11:00 PM'
                        ];

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text('Date Window',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: theme.textColor)),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children: presets.map((preset) {
                                final isSelected = preset == selectedPreset;
                                return ChoiceChip(
                                  label: Text(preset),
                                  selected: isSelected,
                                  onSelected: (_) => setScheduleState(
                                      () => selectedPreset = preset),
                                  selectedColor: theme.primaryColor,
                                  labelStyle: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : theme.textColor,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 14),
                            Text('Available Time Slots',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: theme.textColor)),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: timeSlots.map((slot) {
                                final isSelected = slot == selectedTime;
                                return ChoiceChip(
                                  label: Text(slot),
                                  selected: isSelected,
                                  onSelected: (_) => setScheduleState(
                                      () => selectedTime = slot),
                                  selectedColor: theme.accentColor,
                                  labelStyle: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : theme.textColor,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).maybePop();
                                  Modalora.snackbar(
                                    context: context,
                                    title: 'Deployment Scheduled',
                                    message:
                                        'Set for $selectedPreset at $selectedTime UTC.',
                                    icon: const Icon(Icons.alarm_on_rounded),
                                    position: ModaloraPosition.topCenter,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.primaryColor,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14)),
                                ),
                                child: const Text('Confirm Schedule',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15)),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            // 11. Theme & Neon Palette Customizer Sheet
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Theme & Neon Palette',
                description:
                    'Real-time color swatch picker with glass sheen and instant preview.',
                icon: Icons.palette_rounded,
                accentColor: const Color(0xFFF43F5E),
                buttonLabel: 'Palette Sheet',
                onTap: () {
                  Color activeColor = theme.primaryColor;
                  final palette = [
                    const Color(0xFF6366F1), // Indigo
                    const Color(0xFF8B5CF6), // Purple
                    const Color(0xFFEC4899), // Pink
                    const Color(0xFF10B981), // Emerald
                    const Color(0xFF06B6D4), // Cyan
                    const Color(0xFFF59E0B), // Amber
                  ];

                  Modalora.bottomSheet(
                    context: context,
                    title: 'Brand Accent Palette',
                    message: 'Select your preferred primary accent hue.',
                    child: StatefulBuilder(
                      builder: (ctx, setPaletteState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 14),
                            // Swatches
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: palette.map((c) {
                                final isSelected =
                                    c.toARGB32() == activeColor.toARGB32();
                                return GestureDetector(
                                  onTap: () =>
                                      setPaletteState(() => activeColor = c),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: isSelected ? 46 : 38,
                                    height: isSelected ? 46 : 38,
                                    decoration: BoxDecoration(
                                      color: c,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.transparent,
                                        width: 3,
                                      ),
                                      boxShadow: [
                                        if (isSelected)
                                          BoxShadow(
                                            color: c.withValues(alpha: 0.6),
                                            blurRadius: 14,
                                            spreadRadius: 2,
                                          ),
                                      ],
                                    ),
                                    child: isSelected
                                        ? const Icon(Icons.check_rounded,
                                            color: Colors.white, size: 22)
                                        : null,
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: activeColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                    color: activeColor.withValues(alpha: 0.3)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                        color: activeColor,
                                        shape: BoxShape.circle),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Active Hex: #${activeColor.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: theme.textColor),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 18),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).maybePop();
                                  Modalora.snackbar(
                                    context: context,
                                    title: 'Theme Updated',
                                    message:
                                        'Accent color changed across current session.',
                                    icon: const Icon(Icons.color_lens_rounded),
                                    position: ModaloraPosition.topCenter,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: activeColor,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14)),
                                ),
                                child: const Text('Apply Palette',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15)),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            // 12. E-Commerce Cart & Quantity Modifier Sheet
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Cart & Quantity Stepper',
                description:
                    'Dynamic order modifier with real-time price tally and item counters.',
                icon: Icons.shopping_bag_outlined,
                accentColor: const Color(0xFF10B981),
                buttonLabel: 'Cart Stepper',
                onTap: () {
                  int licenseCount = 3;
                  const int pricePerLicense = 29;

                  Modalora.bottomSheet(
                    context: context,
                    title: 'Modify Seat Licenses',
                    message: 'Adjust active developer seats for your team.',
                    child: StatefulBuilder(
                      builder: (ctx, setCartState) {
                        final total = licenseCount * pricePerLicense;

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: theme.isDark
                                    ? Colors.white.withValues(alpha: 0.05)
                                    : Colors.black.withValues(alpha: 0.04),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: theme.borderColor),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Pro Developer Seat',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: theme.textColor,
                                              fontSize: 14.5)),
                                      Text('\$$pricePerLicense / seat / month',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: theme.textSecondaryColor)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: licenseCount > 1
                                            ? () => setCartState(
                                                () => licenseCount--)
                                            : null,
                                        icon: const Icon(Icons
                                            .remove_circle_outline_rounded),
                                        color: theme.textColor,
                                      ),
                                      Text('$licenseCount',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                              color: theme.textColor)),
                                      IconButton(
                                        onPressed: () =>
                                            setCartState(() => licenseCount++),
                                        icon: const Icon(
                                            Icons.add_circle_outline_rounded),
                                        color: theme.primaryColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Monthly Billing:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: theme.textSecondaryColor)),
                                Text('\$$total.00',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20,
                                        color: theme.primaryColor)),
                              ],
                            ),
                            const SizedBox(height: 18),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).maybePop();
                                  Modalora.snackbar(
                                    context: context,
                                    title: 'Plan Updated ($licenseCount Seats)',
                                    message:
                                        'Your updated monthly billing is \$$total.00.',
                                    icon: const Icon(
                                        Icons.shopping_cart_checkout_rounded),
                                    position: ModaloraPosition.topCenter,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.primaryColor,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14)),
                                ),
                                child: const Text('Update Subscription',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15)),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContactAvatar(
      ModaloraThemeData theme, String name, Color bg, String initial) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: bg,
            child: Text(initial,
                style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 15)),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: theme.textColor)),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
      ModaloraThemeData theme, String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: isSelected
            ? theme.primaryColor
            : (theme.isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.black.withValues(alpha: 0.04)),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: isSelected ? theme.primaryColor : theme.borderColor),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          color: isSelected ? Colors.white : theme.textColor,
        ),
      ),
    );
  }

  Widget _buildMemberRow(ModaloraThemeData theme, String name, String email,
      String role, Color badgeColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.black.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: badgeColor.withValues(alpha: 0.2),
                child: Text(name[0],
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: badgeColor,
                        fontSize: 13)),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: theme.textColor,
                          fontSize: 13.5)),
                  Text(email,
                      style: TextStyle(
                          fontSize: 11.5, color: theme.textSecondaryColor)),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: badgeColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(role,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: badgeColor)),
          ),
        ],
      ),
    );
  }

  Widget _buildShareAction(
      ModaloraThemeData theme, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: theme.isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.06),
            shape: BoxShape.circle,
            border: Border.all(color: theme.borderColor),
          ),
          child: Icon(icon, size: 22, color: theme.textColor),
        ),
        const SizedBox(height: 6),
        Text(label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: theme.textSecondaryColor)),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 3. POPUP & TOOLTIP SHOWCASE
  // ---------------------------------------------------------------------------
  Widget _buildPopupGrid(BuildContext context, ModaloraThemeData theme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth > 760
            ? 3
            : (constraints.maxWidth > 500 ? 2 : 1);
        final cardWidth = cols == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - (cols - 1) * 14.0) / cols;

        return Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: [
            SizedBox(
              width: cardWidth,
              child: Builder(
                builder: (btnCtx) => _buildInteractiveCard(
                  theme: theme,
                  title: 'Bottom Anchor Tooltip',
                  description:
                      'Targeted directly below clicked element with collision clamping.',
                  icon: Icons.arrow_drop_down_circle_outlined,
                  accentColor: theme.primaryColor,
                  buttonLabel: 'Trigger Popup',
                  onTap: () {
                    Modalora.popup(
                      context: btnCtx,
                      anchor: ModaloraPopupAnchor.bottom,
                      title: 'Anchor: Bottom',
                      message:
                          'Targeted directly below clicked button with collision auto-clamping.',
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: Builder(
                builder: (btnCtx) => _buildInteractiveCard(
                  theme: theme,
                  title: 'Top Anchor Tooltip',
                  description:
                      'Positioned above with smooth scale-in transition animation.',
                  icon: Icons.arrow_circle_up_outlined,
                  accentColor: theme.accentColor,
                  buttonLabel: 'Trigger Popup',
                  onTap: () {
                    Modalora.popup(
                      context: btnCtx,
                      anchor: ModaloraPopupAnchor.top,
                      title: 'Anchor: Top',
                      message:
                          'Positioned above with smooth scale-in animation.',
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: Builder(
                builder: (btnCtx) => _buildInteractiveCard(
                  theme: theme,
                  title: 'User Profile Popover',
                  description:
                      'Interactive user profile card with avatar and verified tag.',
                  icon: Icons.account_circle_outlined,
                  accentColor: theme.successColor,
                  buttonLabel: 'Show Profile',
                  onTap: () {
                    Modalora.popup(
                      context: btnCtx,
                      anchor: ModaloraPopupAnchor.bottom,
                      width: 260,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: theme.primaryColor,
                                child: const Icon(Icons.person_rounded,
                                    color: Colors.white),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('Alex Rivers',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: theme.textColor)),
                                      const SizedBox(width: 4),
                                      Icon(Icons.verified_rounded,
                                          size: 14, color: theme.accentColor),
                                    ],
                                  ),
                                  Text('@alexrivers',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: theme.textSecondaryColor)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                              'Lead Design Engineer working on Flutter overlay architectures.',
                              style: TextStyle(
                                  fontSize: 12.5,
                                  color: theme.textColor,
                                  height: 1.35)),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // 4. MENU & CONTEXT MENU SHOWCASE
  // ---------------------------------------------------------------------------
  Widget _buildMenuGrid(BuildContext context, ModaloraThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final cols = constraints.maxWidth > 760 ? 2 : 1;
            final cardWidth = cols == 1
                ? constraints.maxWidth
                : (constraints.maxWidth - (cols - 1) * 14.0) / cols;

            return Wrap(
              spacing: 14.0,
              runSpacing: 14.0,
              children: [
                SizedBox(
                  width: cardWidth,
                  child: Builder(
                    builder: (btnCtx) => _buildInteractiveCard(
                      theme: theme,
                      title: 'Raycast Command Menu',
                      description:
                          'macOS keyboard shortcut badges, category dividers & delete.',
                      icon: Icons.terminal_rounded,
                      accentColor: theme.primaryColor,
                      buttonLabel: 'Open Menu',
                      onTap: () {
                        Modalora.menu(
                          context: btnCtx,
                          items: [
                            ModaloraMenuItem(
                              title: 'Search Commands...',
                              icon: const Icon(Icons.search_rounded),
                              shortcut: '⌘K',
                              onTap: () {},
                            ),
                            const ModaloraMenuDivider(),
                            ModaloraMenuItem(
                              title: 'Duplicate Workspace',
                              icon: const Icon(Icons.copy_rounded),
                              shortcut: '⌘D',
                              onTap: () {},
                            ),
                            ModaloraMenuItem(
                              title: 'Export as SVG / PDF',
                              icon: const Icon(Icons.file_download_outlined),
                              shortcut: '⇧⌘E',
                              onTap: () {},
                            ),
                            const ModaloraMenuDivider(),
                            ModaloraMenuItem(
                              title: 'Delete Asset',
                              icon: const Icon(Icons.delete_outline_rounded),
                              shortcut: '⌫',
                              isDestructive: true,
                              onTap: () {},
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 16.0),
        ModaloraContextMenuRegion(
          items: [
            ModaloraMenuItem(
                title: 'Inspect Element',
                icon: const Icon(Icons.code_rounded),
                shortcut: '⌥⌘I',
                onTap: () {}),
            ModaloraMenuItem(
                title: 'Reload Page',
                icon: const Icon(Icons.refresh_rounded),
                shortcut: '⌘R',
                onTap: () {}),
            const ModaloraMenuDivider(),
            ModaloraMenuItem(
                title: 'Clear Cache & Restart',
                icon: const Icon(Icons.cleaning_services_rounded),
                isDestructive: true,
                onTap: () {}),
          ],
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22.0),
            decoration: BoxDecoration(
              color: theme.surfaceColor,
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(color: theme.borderColor),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.mouse_rounded,
                      color: theme.primaryColor, size: 24),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Interactive Context Menu Canvas',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: theme.textColor),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        'Right-click anywhere inside this container (or long-press on mobile) to trigger custom contextual flyout.',
                        style: TextStyle(
                            color: theme.textSecondaryColor,
                            fontSize: 13,
                            height: 1.35),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 5. SNACKBAR & TOAST SHOWCASE
  // ---------------------------------------------------------------------------
  Widget _buildSnackbarGrid(BuildContext context, ModaloraThemeData theme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth > 760
            ? 3
            : (constraints.maxWidth > 500 ? 2 : 1);
        final cardWidth = cols == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - (cols - 1) * 14.0) / cols;

        return Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: [
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Success Island Toast',
                description:
                    'Top-Center dynamic island pill with live countdown timer bar.',
                icon: Icons.check_circle_rounded,
                accentColor: theme.successColor,
                buttonLabel: 'Trigger Toast',
                onTap: () {
                  Modalora.snackbar(
                    context: context,
                    title: 'Build Deployed',
                    message:
                        'Production v1.0.4 is now live globally on edge network.',
                    icon: const Icon(Icons.cloud_done_rounded),
                    position: ModaloraPosition.topCenter,
                  );
                },
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Error Alert Toast',
                description:
                    'Bottom-Right alert toast with interactive Retry pill button.',
                icon: Icons.error_outline_rounded,
                accentColor: theme.errorColor,
                buttonLabel: 'Trigger Toast',
                onTap: () {
                  Modalora.snackbar(
                    context: context,
                    title: 'Connection Timed Out',
                    message:
                        'Failed to establish WebSocket connection with primary cluster.',
                    icon: const Icon(Icons.wifi_off_rounded),
                    actionLabel: 'Retry',
                    position: ModaloraPosition.bottomRight,
                    onActionPressed: () {},
                  );
                },
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Queue 3 Stacking Toasts',
                description:
                    'Multi-instance auto-queued toast notifications in stack.',
                icon: Icons.layers_rounded,
                accentColor: theme.primaryColor,
                buttonLabel: 'Spawn Stack',
                onTap: () {
                  for (int i = 1; i <= 3; i++) {
                    Future.delayed(Duration(milliseconds: i * 250), () {
                      if (context.mounted) {
                        Modalora.snackbar(
                          context: context,
                          title: 'Notification #$i',
                          message:
                              'Multi-instance auto-queued toast notification in stack.',
                          icon: const Icon(Icons.notifications_active_rounded),
                          position: ModaloraPosition.bottomCenter,
                        );
                      }
                    });
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // 6. OVERLAYS & LOADERS SHOWCASE
  // ---------------------------------------------------------------------------
  Widget _buildOverlayGrid(BuildContext context, ModaloraThemeData theme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth > 760 ? 2 : 1;
        final cardWidth = cols == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - (cols - 1) * 14.0) / cols;

        return Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: [
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Orbital Glass Spinner',
                description:
                    'Rotating sweep gradient ring with pulsing core & auto-dismiss.',
                icon: Icons.hourglass_top_rounded,
                accentColor: theme.primaryColor,
                buttonLabel: 'Launch Spinner',
                onTap: () {
                  final handle = Modalora.loading(
                    context: context,
                    title: 'Synthesizing Neural Graph...',
                    message: 'Auto-dismissing in 2.5 seconds',
                    blur: 16.0,
                  );

                  Future.delayed(const Duration(milliseconds: 2500), () {
                    handle.dismiss();
                  });
                },
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _buildInteractiveCard(
                theme: theme,
                title: 'Custom Fullscreen Shield',
                description:
                    'Heavy 20.0 sigma frosted glass shield with interactive dismiss.',
                icon: Icons.security_rounded,
                accentColor: theme.accentColor,
                buttonLabel: 'Show Shield',
                onTap: () {
                  Modalora.fullScreen(
                    context: context,
                    iconData: Icons.shield_rounded,
                    title: 'Security Shield Active',
                    message:
                        'This custom fullscreen overlay blurs the entire app. Tap outside or below to dismiss.',
                    primaryActionText: 'Dismiss Shield',
                    blur: 20.0,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // INTERACTIVE CARD WIDGET
  // ---------------------------------------------------------------------------
  Widget _buildInteractiveCard({
    required ModaloraThemeData theme,
    required String title,
    required String description,
    required IconData icon,
    required Color accentColor,
    required String buttonLabel,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: theme.surfaceColor,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: theme.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: theme.isDark ? 0.25 : 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, size: 20, color: accentColor),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: theme.textSecondaryColor.withValues(alpha: 0.5)),
                ],
              ),
              const SizedBox(height: 12.0),
              Text(
                title,
                style: TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                    color: theme.textColor,
                    letterSpacing: -0.3),
              ),
              const SizedBox(height: 4.0),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12.5,
                    color: theme.textSecondaryColor,
                    height: 1.35),
              ),
            ],
          ),
          Material(
            color: accentColor.withValues(alpha: 0.12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      buttonLabel,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: accentColor),
                    ),
                    const SizedBox(width: 6),
                    Icon(Icons.touch_app_rounded, size: 14, color: accentColor),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
