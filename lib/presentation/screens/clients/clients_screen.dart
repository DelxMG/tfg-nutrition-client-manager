import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutritrack/application/providers/database_provider.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/domain/enums.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/client_detail_content.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/client_form_dialog.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/clients_filters_bar.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/clients_page_header.dart';
import 'package:nutritrack/presentation/layout/responsive_utils.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/clients_table.dart';

class ClientsScreen extends ConsumerStatefulWidget {
  const ClientsScreen({super.key});

  @override
  ConsumerState<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends ConsumerState<ClientsScreen> {
  String search = '';
  ClientStatus? statusFilter;
  int? selectedClientId;

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(clientRepositoryProvider);

    final hPad = context.isCompact ? 12.0 : clientsHorizontalPadding;
    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, 20, hPad, 18),
      child: StreamBuilder<List<Client>>(
        stream: repository.watchClients(search: search, status: statusFilter),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final clients = snapshot.data!;

          if (selectedClientId != null) {
            return ClientDetailContent(
              clientId: selectedClientId!,
              onBack: () => setState(() => selectedClientId = null),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClientsPageHeader(
                count: clients.length,
                onNewClientPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => ClientFormDialog(repository: repository),
                  );
                },
              ),
              const SizedBox(height: 18),
              ClientsFiltersBar(
                search: search,
                statusFilter: statusFilter,
                onSearchChanged: (value) => setState(() => search = value),
                onStatusChanged: (status) =>
                    setState(() => statusFilter = status),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ClientsTable(
                  clients: clients,
                  onClientTap: (clientId) =>
                      setState(() => selectedClientId = clientId),
                  onDeleteClient: (clientId) =>
                      repository.deleteClient(clientId),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
