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
  /// Index of the active tab. Only 0 (Resumen) is functional for now.
  final int activeIndex;

  const ClientDetailTabs({super.key, this.activeIndex = 0});

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
              isEnabled: i == 0,
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

  const _TabItem({
    required this.label,
    required this.isActive,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2),
      child: InkWell(
        borderRadius: clientsBorderRadius,
        onTap: isEnabled ? () {} : null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          height: 36,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: clientsBorderRadius,
            border: isActive
                ? Border.all(color: clientsBorderColor)
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: isActive
                  ? clientsHeadingColor
                  : clientsMutedTextColor.withValues(alpha: isEnabled ? 1.0 : 0.55),
            ),
          ),
        ),
      ),
    );
  }
}
