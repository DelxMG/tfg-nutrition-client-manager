import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: clientsTopBarHeight,
      padding: const EdgeInsets.fromLTRB(22, 14, 24, 14),
      decoration: const BoxDecoration(
        color: clientsBgColor,
        border: Border(
          bottom: BorderSide(color: clientsBorderColor),
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
              borderRadius: clientsBorderRadius,
              border: Border.all(color: clientsInputBorderColor),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, size: 16, color: clientsMutedTextColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Buscar clientes, planes...',
                    style: GoogleFonts.inter(
                      color: clientsMutedTextColor,
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
