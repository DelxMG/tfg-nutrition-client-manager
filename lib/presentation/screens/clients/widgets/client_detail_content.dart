import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';

class ClientDetailContent extends StatelessWidget {
  final int clientId;
  final VoidCallback onBack;

  const ClientDetailContent({
    super.key,
    required this.clientId,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back, size: 16),
          label: Text(
            'Volver',
            style: GoogleFonts.inter(fontSize: 14),
          ),
          style: TextButton.styleFrom(
            foregroundColor: clientsBrandColor,
            padding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Detalle del cliente',
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF22221F),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'ID: $clientId',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: clientsMutedTextColor,
          ),
        ),
      ],
    );
  }
}
