import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';

const _kTabs = [
  'Resumen',
  'Mediciones',
  'Notas',
  'Cálculos',
  'Planes',
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
          for (int i = 0; i < _kTabs.length; i++)
            _TabItem(
              label: _kTabs[i],
              isActive: i == activeIndex,
              isEnabled: i <= 1,
              onTap: i <= 1 ? () => onTabChanged(i) : null,
            ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isEnabled;
  final VoidCallback? onTap;

  const _TabItem({
    required this.label,
    required this.isActive,
    required this.isEnabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(right: 2),
      child: InkWell(
        borderRadius: clientsBorderRadius,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          height: 36,
          decoration: BoxDecoration(
            color: isActive ? cs.surfaceContainer : Colors.transparent,
            borderRadius: clientsBorderRadius,
            border: isActive ? Border.all(color: cs.outlineVariant) : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: isActive
                  ? cs.onSurface
                  : cs.onSurfaceVariant.withValues(alpha: isEnabled ? 1.0 : 0.55),
            ),
          ),
        ),
      ),
    );
  }
}
