import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientsTopBar extends StatelessWidget {
  const ClientsTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      padding: const EdgeInsets.fromLTRB(22, 14, 24, 14),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F8F6),
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E2DD)),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 300,
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1ED),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE3E3DE)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search,
                  size: 16,
                  color: Color(0xFF7A7A73),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Buscar clientes, planes...',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF7A7A73),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}