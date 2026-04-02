import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';

class ClientsSidebar extends StatelessWidget {
  final bool isCollapsed;
  final VoidCallback onCollapse;
  final VoidCallback onExpand;

  const ClientsSidebar({
    super.key,
    required this.isCollapsed,
    required this.onCollapse,
    required this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      width: isCollapsed ? clientsSidebarCollapsedWidth : clientsSidebarExpandedWidth,
      decoration: const BoxDecoration(
        color: Color(0xFFF4F4F2),
        border: Border(
          right: BorderSide(color: clientsBorderColor),
        ),
      ),
      child: Column(
        children: [
          Container(
          height: clientsTopBarHeight,
          padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 0 : 10),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: clientsBorderColor),
            ),
          ),
            child: isCollapsed
                ? Center(
                    child: _buildLogoIcon(),
                  )
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
                                color: clientsHeadingColor,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'PRO',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                height: 1,
                                color: const Color(0xFF7C7C75),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
          borderRadius: clientsChipBorderRadius,
          onTap: onCollapse,
          child: const Padding(
            padding: EdgeInsets.all(6),
            child: Icon(
              Icons.chevron_left,
              size: clientsIconSize,
              color: clientsSecondaryIconColor,
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
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: clientsBorderColor),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: InkWell(
                borderRadius: clientsBorderRadius,
                onTap: onCollapse,
                child: SizedBox(
                  height: 52,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chevron_left,
                        size: clientsIconSize,
                        color: clientsSecondaryIconColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Colapsar',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: clientsSecondaryIconColor,
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
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: clientsBorderColor),
                ),
              ),
              child: Center(
                child: InkWell(
                  borderRadius: clientsChipBorderRadius,
                  onTap: onExpand,
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      Icons.chevron_right,
                      size: clientsIconSize,
                      color: clientsSecondaryIconColor,
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
        color: clientsBrandColor,
        borderRadius: clientsBorderRadius,
      ),
      child: const Icon(
        Icons.show_chart,
        color: Colors.white,
        size: clientsIconSize,
      ),
    );
  }
}

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: InkWell(
        borderRadius: clientsBorderRadius,
        onTap: () {},
        child: Container(
          height: clientsButtonHeight,
          padding: EdgeInsets.symmetric(
            horizontal: isCollapsed ? 0 : 14,
          ),
          decoration: BoxDecoration(
            color: selected ? clientsSelectedBgColor : Colors.transparent,
            borderRadius: clientsBorderRadius,
          ),
          child: Row(
            mainAxisAlignment: isCollapsed
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: clientsIconSize,
                color: selected
                    ? clientsBrandColor
                    : const Color(0xFF66665F),
              ),
              if (!isCollapsed) ...[
                const SizedBox(width: 12),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    color: selected
                        ? clientsBrandColor
                        : clientsBodyTextColor,
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