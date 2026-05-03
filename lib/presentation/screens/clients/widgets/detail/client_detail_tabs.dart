import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';

const _kTabLabels = ['Resumen', 'Mediciones', 'Notas', 'Cálculos', 'Planes'];
const _kTabIcons  = <IconData>[
  Icons.summarize_outlined,
  Icons.straighten,
  Icons.note_alt_outlined,
  Icons.calculate_outlined,
  Icons.assignment_outlined,
];

class ClientDetailTabs extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onTabChanged;

  const ClientDetailTabs({
    super.key,
    this.activeIndex = 0,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: Row(
        children: [
          for (int i = 0; i < _kTabLabels.length; i++)
            _TabItem(
              label:     _kTabLabels[i],
              icon:      _kTabIcons[i],
              isActive:  i == activeIndex,
              isEnabled: i <= 4,
              onTap:     i <= 4 ? () => onTabChanged(i) : null,
            ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String    label;
  final IconData  icon;
  final bool      isActive;
  final bool      isEnabled;
  final VoidCallback? onTap;

  const _TabItem({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.isEnabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs    = Theme.of(context).colorScheme;
    final color = isActive
        ? cs.onSurface
        : cs.onSurfaceVariant.withValues(alpha: isEnabled ? 1.0 : 0.55);

    return Padding(
      padding: const EdgeInsets.only(right: 2),
      child: InkWell(
        borderRadius: clientsBorderRadius,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 36,
          decoration: BoxDecoration(
            color: isActive ? cs.surfaceContainer : Colors.transparent,
            borderRadius: clientsBorderRadius,
            border: isActive ? Border.all(color: cs.outlineVariant) : null,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 15, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
