import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/data/models/client_summary.dart';
import 'package:nutritrack/data/repositories/client_summary_repository.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/detail/client_detail_header.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/detail/client_detail_tabs.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/detail/client_summary_cards.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/detail/client_summary_sections.dart';

class ClientDetailContent extends StatefulWidget {
  final int clientId;
  final VoidCallback onBack;

  const ClientDetailContent({
    super.key,
    required this.clientId,
    required this.onBack,
  });

  @override
  State<ClientDetailContent> createState() => _ClientDetailContentState();
}

class _ClientDetailContentState extends State<ClientDetailContent> {
  late final ClientSummaryRepository _repo;
  late final Future<ClientSummary?> _summaryFuture;

  @override
  void initState() {
    super.initState();
    // The AppDatabase instance is already open in ClientsScreen; here we open
    // a second connection only for this widget's lifetime. This is acceptable
    // for a desktop app but can be unified later via DI when desired.
    _repo = ClientSummaryRepository(AppDatabase());
    _summaryFuture = _repo.getClientSummary(widget.clientId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ClientSummary?>(
      future: _summaryFuture,
      builder: (context, snapshot) {
        // ── Loading ───────────────────────────────────────────────────────────
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // ── Error ─────────────────────────────────────────────────────────────
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error al cargar el cliente',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: clientsMutedTextColor,
              ),
            ),
          );
        }

        // ── Client not found ──────────────────────────────────────────────────
        final summary = snapshot.data;
        if (summary == null) {
          return Center(
            child: Text(
              'Cliente no encontrado',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: clientsMutedTextColor,
              ),
            ),
          );
        }

        // ── Content ───────────────────────────────────────────────────────────
        return _ClientDetailBody(summary: summary, onBack: widget.onBack);
      },
    );
  }
}

// ── Body (only rendered when data is ready) ───────────────────────────────────

class _ClientDetailBody extends StatelessWidget {
  final ClientSummary summary;
  final VoidCallback onBack;

  const _ClientDetailBody({required this.summary, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header: back + avatar + name + meta + edit button
        ClientDetailHeader(client: summary.client, onBack: onBack),
        const SizedBox(height: 18),

        // Tabs bar
        const ClientDetailTabs(),
        const SizedBox(height: 18),

        // Scrollable content area
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Metric cards row
                ClientSummaryCards(summary: summary),
                const SizedBox(height: 16),

                // Info sections: personal / objetivo / anamnesis
                ClientSummarySections(summary: summary),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
