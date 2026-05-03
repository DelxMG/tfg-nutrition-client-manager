import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/presentation/layout/responsive_utils.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';

class ClientsPageHeader extends StatelessWidget {
  final int count;
  final VoidCallback onNewClientPressed;

  const ClientsPageHeader({
    super.key,
    required this.count,
    required this.onNewClientPressed,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final button = SizedBox(
      height: clientsButtonHeight,
      child: ElevatedButton.icon(
        onPressed: onNewClientPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: clientsBorderRadius,
          ),
        ),
        icon: const Icon(Icons.add, size: 16),
        label: Text(
          'Nuevo cliente',
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );

    final titleBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Clientes',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            height: 1.1,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$count clientes registrados',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: cs.onSurfaceVariant.withValues(alpha: 0.8),
          ),
        ),
      ],
    );

    if (context.isCompact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleBlock,
          const SizedBox(height: 12),
          Align(alignment: Alignment.centerRight, child: button),
        ],
      );
    }

    return Row(
      children: [titleBlock, const Spacer(), button],
    );
  }
}
