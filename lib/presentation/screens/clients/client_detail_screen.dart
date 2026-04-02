import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';

class ClientDetailScreen extends StatelessWidget {
  final int clientId;

  const ClientDetailScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clientsBgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: clientsHeadingColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Detalle del cliente',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: clientsHeadingColor,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: clientsBorderColor),
        ),
      ),
      body: Center(
        child: Text(
          'Cliente #$clientId',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: clientsMutedTextColor,
          ),
        ),
      ),
    );
  }
}
