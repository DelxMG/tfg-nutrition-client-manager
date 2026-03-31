import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      width: isCollapsed ? 72 : 222,
      decoration: const BoxDecoration(
        color: Color(0xFFF4F4F2),
        border: Border(
          right: BorderSide(color: Color(0xFFE2E2DD)),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 74,
            padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 0 : 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFE2E2DD)),
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
                                color: const Color(0xFF20201D),
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
                        borderRadius: BorderRadius.circular(8),
                        onTap: onCollapse,
                        child: const Padding(
                          padding: EdgeInsets.all(6),
                          child: Icon(
                            Icons.chevron_left,
                            size: 18,
                            color: Color(0xFF6F6F68),
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
                  top: BorderSide(color: Color(0xFFE2E2DD)),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onCollapse,
                child: SizedBox(
                  height: 52,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chevron_left,
                        size: 18,
                        color: Color(0xFF6F6F68),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Colapsar',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF6F6F68),
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
                  top: BorderSide(color: Color(0xFFE2E2DD)),
                ),
              ),
              child: Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: onExpand,
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: Color(0xFF6F6F68),
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
      decoration: BoxDecoration(
        color: const Color(0xFF0FA37F),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.show_chart,
        color: Colors.white,
        size: 18,
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
        borderRadius: BorderRadius.circular(10),
        onTap: () {},
        child: Container(
          height: 40,
          padding: EdgeInsets.symmetric(
            horizontal: isCollapsed ? 0 : 14,
          ),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFDCEFE9) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: isCollapsed
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 18,
                color: selected
                    ? const Color(0xFF0FA37F)
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
                        ? const Color(0xFF0FA37F)
                        : const Color(0xFF4D4D47),
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