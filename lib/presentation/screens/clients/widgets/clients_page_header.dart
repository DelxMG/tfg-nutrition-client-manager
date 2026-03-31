import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Clientes',
              style: GoogleFonts.inter(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                height: 1.08,
                color: const Color(0xFF20201D),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '$count clientes registrados',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF7A7A73),
              ),
            ),
          ],
        ),
        const Spacer(),
        SizedBox(
          height: 40,
          child: ElevatedButton.icon(
            onPressed: onNewClientPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0FA37F),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(Icons.add, size: 16),
            label: Text(
              'Nuevo cliente',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}