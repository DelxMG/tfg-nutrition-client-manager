import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/presentation/layout/app_constants.dart';

class AppSidebar extends StatelessWidget {
  final bool isCollapsed;
  final VoidCallback onCollapse;
  final VoidCallback onExpand;

  const AppSidebar({
    super.key,
    required this.isCollapsed,
    required this.onCollapse,
    required this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      width: isCollapsed ? 72 : 222,
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        border: Border(
          right: BorderSide(color: cs.outlineVariant),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: appTopBarHeight,
            padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 0 : 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: cs.outlineVariant),
              ),
            ),
            child: isCollapsed
                ? Center(child: _buildLogoIcon())
                : Row(
                    children: [
                      _buildLogoIcon(),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'NutriTrack',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                height: 1.1,
                                color: cs.onSurface,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'PRO',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                height: 1,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        borderRadius: appChipBorderRadius,
                        onTap: onCollapse,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            Icons.chevron_left,
                            size: appIconSize,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 8),
          _SidebarItem(
            icon: Icons.people_alt_outlined,
            label: 'Clientes',
            selected: true,
            isCollapsed: isCollapsed,
          ),
          _SidebarItem(
            icon: Icons.straighten,
            label: 'Mediciones',
            isCollapsed: isCollapsed,
          ),
          _SidebarItem(
            icon: Icons.note_alt_outlined,
            label: 'Notas',
            isCollapsed: isCollapsed,
          ),
          _SidebarItem(
            icon: Icons.calculate_outlined,
            label: 'Cálculos',
            isCollapsed: isCollapsed,
          ),
          _SidebarItem(
            icon: Icons.assignment_outlined,
            label: 'Planes',
            isCollapsed: isCollapsed,
          ),
          const Spacer(),
          if (!isCollapsed)
            Container(
              height: 52,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: cs.outlineVariant)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: InkWell(
                borderRadius: appBorderRadius,
                onTap: onCollapse,
                child: SizedBox(
                  height: 52,
                  child: Row(
                    children: [
                      Icon(
                        Icons.chevron_left,
                        size: appIconSize,
                        color: cs.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Colapsar',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            Container(
              height: 52,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: cs.outlineVariant)),
              ),
              child: Center(
                child: InkWell(
                  borderRadius: appChipBorderRadius,
                  onTap: onExpand,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      Icons.chevron_right,
                      size: appIconSize,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLogoIcon() {
    return Container(
      width: 34,
      height: 34,
      decoration: const BoxDecoration(
        color: appBrandColor,
        borderRadius: appBorderRadius,
      ),
      child: const Icon(
        Icons.show_chart,
        color: Colors.white,
        size: appIconSize,
      ),
    );
  }
}

// ── Sidebar nav item ──────────────────────────────────────────────────────────

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final bool isCollapsed;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isCollapsed,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: InkWell(
        borderRadius: appBorderRadius,
        onTap: () {},
        child: Container(
          height: appButtonHeight,
          padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 0 : 14),
          decoration: BoxDecoration(
            color: selected ? cs.primaryContainer : Colors.transparent,
            borderRadius: appBorderRadius,
          ),
          child: Row(
            mainAxisAlignment:
                isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: appIconSize,
                color: selected ? appBrandColor : cs.onSurfaceVariant,
              ),
              if (!isCollapsed) ...[
                const SizedBox(width: 12),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    color: selected ? appBrandColor : cs.onSurface,
                    height: 1,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
