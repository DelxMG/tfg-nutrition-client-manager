import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/application/providers/theme_provider.dart';
import 'package:nutritrack/presentation/layout/app_constants.dart';
import 'package:nutritrack/presentation/layout/responsive_utils.dart';

class AppTopBar extends ConsumerWidget {
  const AppTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final cs = Theme.of(context).colorScheme;

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        border: Border(
          bottom: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.3)),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final leftWidth = 24.0 + 32.0 + 8.0;
          final rightWidth = 24.0 + 56.0;

          final showTitle = isDesktopWidth(constraints.maxWidth);

          return Stack(
            children: [
              // ── Logo (izquierda) ─────────────────────────────────────────
              Positioned(
                left: 24,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: appBrandColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.show_chart,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),

              // ── Texto centrado — solo en desktop ─────────────────────────
              if (showTitle)
                Positioned(
                  left: leftWidth,
                  right: rightWidth,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Text(
                      'NutriTrack',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface,
                      ),
                    ),
                  ),
                ),

              // ── Toggle theme (derecha) ───────────────────────────────────
              Positioned(
                right: 24,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: cs.outlineVariant),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _ThemeIcon(
                          icon: Icons.light_mode_outlined,
                          isActive: !isDark,
                          onTap: () => ref.read(themeProvider.notifier).state =
                              ThemeMode.light,
                        ),
                        _ThemeIcon(
                          icon: Icons.dark_mode_outlined,
                          isActive: isDark,
                          onTap: () => ref.read(themeProvider.notifier).state =
                              ThemeMode.dark,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ThemeIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _ThemeIcon({
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isActive
              ? appBrandColor.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isActive ? appBrandColor : cs.onSurfaceVariant,
        ),
      ),
    );
  }
}
