import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/data/db/tables/clients.dart';
import 'package:nutritrack/data/repositories/client_repository.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/clients_filters_bar.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/clients_page_header.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/clients_sidebar.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/clients_table.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/client_form_dialog.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/clients_top_bar.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  late AppDatabase db;
  late ClientRepository repository;

  String search = '';
  ClientStatus? statusFilter;
  bool isSidebarCollapsed = false;

  @override
  void initState() {
    super.initState();
    db = AppDatabase();
    repository = ClientRepository(db);
  }

  @override
  void dispose() {
    db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.interTextTheme(Theme.of(context).textTheme);

    return Theme(
      data: Theme.of(context).copyWith(textTheme: textTheme),
      child: Scaffold(
        backgroundColor: clientsBgColor,
        body: Row(
          children: [
            ClientsSidebar(
              isCollapsed: isSidebarCollapsed,
              onCollapse: () {
                setState(() {
                  isSidebarCollapsed = true;
                });
              },
              onExpand: () {
                setState(() {
                  isSidebarCollapsed = false;
                });
              },
            ),
            Expanded(
              child: Column(
                children: [
                  const ClientsTopBar(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(clientsHorizontalPadding, 20, 24, 18),
                      child: StreamBuilder<List<Client>>(
                        stream: repository.watchClients(
                          search: search,
                          status: statusFilter,
                        ),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final clients = snapshot.data!;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClientsPageHeader(
                                count: clients.length,
                                onNewClientPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => ClientFormDialog(
                                      repository: repository,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 18),
                              ClientsFiltersBar(
                                search: search,
                                statusFilter: statusFilter,
                                onSearchChanged: (value) {
                                  setState(() {
                                    search = value;
                                  });
                                },
                                onStatusChanged: (status) {
                                  setState(() {
                                    statusFilter = status;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              Expanded(
                                child: ClientsTable(
                                  clients: clients,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}