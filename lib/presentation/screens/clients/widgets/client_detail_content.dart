import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/application/providers/database_provider.dart';
import 'package:nutritrack/data/models/client_summary.dart';
import 'package:nutritrack/data/repositories/client_summary_repository.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/detail/client_detail_header.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/detail/client_detail_tabs.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/detail/client_summary_cards.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/detail/client_profile_form_dialog.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/detail/client_summary_sections.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/detail/measurements_tab.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/detail/notes_tab.dart';

class ClientDetailContent extends ConsumerStatefulWidget {
  final int clientId;
  final VoidCallback onBack;

  const ClientDetailContent({
    super.key,
    required this.clientId,
    required this.onBack,
  });

  @override
  ConsumerState<ClientDetailContent> createState() => _ClientDetailContentState();
}

class _ClientDetailContentState extends ConsumerState<ClientDetailContent> {
  late final ClientSummaryRepository _repo;
  late final Future<ClientSummary?> _summaryFuture;
  int _activeTab = 0;

  @override
  void initState() {
    super.initState();
    _repo = ref.read(clientSummaryRepositoryProvider);
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
        return _ClientDetailBody(
          summary: summary,
          onBack: widget.onBack,
          activeTab: _activeTab,
          onTabChanged: (i) => setState(() => _activeTab = i),
        );
      },
    );
  }
}

// ── Body (only rendered when data is ready) ───────────────────────────────────

class _ClientDetailBody extends ConsumerWidget {
  final ClientSummary summary;
  final VoidCallback onBack;
  final int activeTab;
  final ValueChanged<int> onTabChanged;

  const _ClientDetailBody({
    required this.summary,
    required this.onBack,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reactiveClient = ref
        .watch(clientByIdProvider(summary.client.clientId))
        .maybeWhen(data: (c) => c ?? summary.client, orElse: () => summary.client);

    final allMeasurements = ref
        .watch(clientMeasurementsProvider(summary.client.clientId))
        .value ?? [];
    final latestMeasurement = allMeasurements.firstOrNull;

    final reactiveAnamnesis = ref
        .watch(clientAnamnesisProvider(summary.client.clientId))
        .maybeWhen(data: (a) => a, orElse: () => summary.anamnesis);

    final reactiveSummary = ClientSummary(
      client: reactiveClient,
      anamnesis: reactiveAnamnesis,
      latestMeasurement: latestMeasurement,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClientDetailHeader(
          client: reactiveSummary.client,
          onBack: onBack,
          onEditPressed: () => showDialog<void>(
            context: context,
            builder: (_) => ClientProfileFormDialog(
              client: reactiveClient,
              anamnesis: reactiveAnamnesis,
              hasExistingMeasurements: allMeasurements.isNotEmpty,
              clientRepository: ref.read(clientRepositoryProvider),
              anamnesisRepository: ref.read(anamnesisRepositoryProvider),
              measurementRepository: ref.read(measurementRepositoryProvider),
            ),
          ),
        ),
        const SizedBox(height: 18),

        ClientDetailTabs(activeIndex: activeTab, onTabChanged: onTabChanged),
        const SizedBox(height: 18),

        Expanded(
          child: activeTab == 1
              ? MeasurementsTab(
                  clientId: reactiveSummary.client.clientId,
                  clientHeight: reactiveSummary.client.height,
                )
              : activeTab == 2
                  ? NotesTab(clientId: reactiveSummary.client.clientId)
                  : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClientSummaryCards(
                        summary: reactiveSummary,
                        allMeasurements: allMeasurements,
                      ),
                      const SizedBox(height: 16),
                      ClientSummarySections(summary: reactiveSummary),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
