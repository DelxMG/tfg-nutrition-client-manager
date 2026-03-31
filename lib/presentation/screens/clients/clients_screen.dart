import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/data/db/tables/clients.dart';
import 'package:nutritrack/data/repositories/client_repository.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  late AppDatabase db;
  late ClientRepository repository;

  String search = '';
  ClientStatus? statusFilter = null;
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
        backgroundColor: const Color(0xFFF8F8F6),
        body: Row(
          children: [
            _buildSidebar(),
            Expanded(
              child: Column(
                children: [
                  _buildTopBar(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(22, 20, 24, 18),
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
                              _buildPageHeader(clients.length),
                              const SizedBox(height: 18),
                              _buildFiltersBar(),
                              const SizedBox(height: 16),
                              Expanded(
                                child: _buildClientsTable(clients),
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

  Widget _buildSidebar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      width: isSidebarCollapsed ? 72 : 222,
      decoration: const BoxDecoration(
        color: Color(0xFFF4F4F2),
        border: Border(
          right: BorderSide(color: Color(0xFFE2E2DD)),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 74,
            padding: EdgeInsets.symmetric(horizontal: isSidebarCollapsed ? 0 : 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFE2E2DD)),
              ),
            ),
            child: isSidebarCollapsed
                ? Center(
                    child: _buildLogoIcon(),
                  )
                : Row(
                    children: [
                      _buildLogoIcon(),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'NutriTrack',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                height: 1.1,
                                color: const Color(0xFF20201D),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'PRO',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                height: 1,
                                color: const Color(0xFF7C7C75),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          setState(() {
                            isSidebarCollapsed = true;
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(6),
                          child: Icon(
                            Icons.chevron_left,
                            size: 18,
                            color: Color(0xFF6F6F68),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 8),
          _buildSidebarItem(
            icon: Icons.people_alt_outlined,
            label: 'Clientes',
            selected: true,
          ),
          _buildSidebarItem(
            icon: Icons.straighten,
            label: 'Mediciones',
          ),
          _buildSidebarItem(
            icon: Icons.note_alt_outlined,
            label: 'Notas',
          ),
          _buildSidebarItem(
            icon: Icons.calculate_outlined,
            label: 'Cálculos',
          ),
          _buildSidebarItem(
            icon: Icons.assignment_outlined,
            label: 'Planes',
          ),
          const Spacer(),
          if (!isSidebarCollapsed)
            Container(
              height: 52,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFE2E2DD)),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  setState(() {
                    isSidebarCollapsed = true;
                  });
                },
                child: SizedBox(
                  height: 52,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chevron_left,
                        size: 18,
                        color: Color(0xFF6F6F68),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Colapsar',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF6F6F68),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            Container(
              height: 52,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFE2E2DD)),
                ),
              ),
              child: Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    setState(() {
                      isSidebarCollapsed = false;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: Color(0xFF6F6F68),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLogoIcon() {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFF0FA37F),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.show_chart,
        color: Colors.white,
        size: 18,
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String label,
    bool selected = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {},
        child: Container(
          height: 40,
          padding: EdgeInsets.symmetric(
            horizontal: isSidebarCollapsed ? 0 : 14,
          ),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFDCEFE9) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: isSidebarCollapsed
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 18,
                color: selected
                    ? const Color(0xFF0FA37F)
                    : const Color(0xFF66665F),
              ),
              if (!isSidebarCollapsed) ...[
                const SizedBox(width: 12),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    color: selected
                        ? const Color(0xFF0FA37F)
                        : const Color(0xFF4D4D47),
                    height: 1,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
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

  Widget _buildPageHeader(int count) {
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
            onPressed: () {
              // TODO: alta de cliente
            },
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

  Widget _buildFiltersBar() {
    return Row(
      children: [
        SizedBox(
          width: 280,
          height: 42,
          child: TextField(
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF2A2A26),
            ),
            decoration: InputDecoration(
              hintText: 'Buscar por nombre, email...',
              hintStyle: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF7A7A73),
              ),
              prefixIcon: const Icon(
                Icons.search,
                size: 18,
                color: Color(0xFF6F6F68),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE3E3DE)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE3E3DE)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFCECEC7)),
              ),
            ),
            onChanged: (value) {
              setState(() {
                search = value;
              });
            },
          ),
        ),
        const SizedBox(width: 12),
        const Icon(
          Icons.filter_alt_outlined,
          size: 18,
          color: Color(0xFF7A7A73),
        ),
        const SizedBox(width: 12),
        _buildFilterText('Todos', null),
        _buildFilterText('Activo', ClientStatus.active),
        _buildFilterText('Inactivo', ClientStatus.inactive),
        _buildFilterText('Pendiente', ClientStatus.pending),
      ],
    );
  }

  Widget _buildFilterText(String label, ClientStatus? status) {
    final isSelected = statusFilter == status;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          setState(() {
            statusFilter = status;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFDCEFE9) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: isSelected
                  ? const Color(0xFF0FA37F)
                  : const Color(0xFF5B5B55),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClientsTable(List<Client> clients) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E2DD)),
      ),
      child: Column(
        children: [
          _buildTableHeader(),
          const Divider(height: 1, thickness: 1, color: Color(0xFFE9E9E3)),
          Expanded(
            child: clients.isEmpty
                ? Center(
                    child: Text(
                      'No hay clientes',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF7A7A73),
                        fontSize: 14,
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: clients.length,
                    separatorBuilder: (_, _) => const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFE9E9E3),
                    ),
                    itemBuilder: (context, index) {
                      final client = clients[index];
                      return _buildClientRow(client);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xFFF7F7F4),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: _buildSortableHeader('CLIENTE'),
          ),
          Expanded(
            flex: 2,
            child: _buildSortableHeader('ESTADO'),
          ),
          Expanded(
            flex: 2,
            child: _buildSortableHeader('OBJETIVO'),
          ),
          Expanded(
            child: _buildPlainHeader('EDAD'),
          ),
          Expanded(
            child: _buildPlainHeader('PESO'),
          ),
          Expanded(
            flex: 2,
            child: _buildSortableHeader('ÚLTIMA VISITA'),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _buildPlainHeader(String label) {
    return Text(
      label,
      style: _headerStyle,
    );
  }

  Widget _buildSortableHeader(String label) {
    return Row(
      children: [
        Flexible(
          child: Text(
            label,
            style: _headerStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(
          Icons.unfold_more,
          size: 14,
          color: Color(0xFF8A8A84),
        ),
      ],
    );
  }

  Widget _buildClientRow(Client client) {
    final initials = _getInitials(client.name);
    final age = _calculateAge(client.birthDate);

    return InkWell(
      onTap: () {},
      child: Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: const Color(0xFFE7F4F0),
                    child: Text(
                      initials,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0FA37F),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          client.name,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.1,
                            color: const Color(0xFF22221F),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          client.email ?? 'Sin email',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w400,
                            height: 1.1,
                            color: const Color(0xFF7A7A73),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: _statusColor(client.status),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _statusText(client.status),
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF4D4D47),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                '—',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF7A7A73),
                ),
              ),
            ),
            Expanded(
              child: Text(
                age?.toString() ?? '—',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF4D4D47),
                ),
              ),
            ),
            Expanded(
              child: Text(
                '—',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF7A7A73),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                '—',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF7A7A73),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
              child: Icon(
                Icons.chevron_right,
                size: 17,
                color: Color(0xFFB0B0AA),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';

    final parts = trimmed.split(' ').where((part) => part.isNotEmpty).toList();

    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }

    return parts.first.substring(0, 1).toUpperCase();
  }

  int? _calculateAge(DateTime? birthDate) {
    if (birthDate == null) return null;

    final now = DateTime.now();
    int age = now.year - birthDate.year;

    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  String _statusText(ClientStatus status) {
    switch (status) {
      case ClientStatus.active:
        return 'Activo';
      case ClientStatus.inactive:
        return 'Inactivo';
      case ClientStatus.pending:
        return 'Pendiente';
    }
  }

  Color _statusColor(ClientStatus status) {
    switch (status) {
      case ClientStatus.active:
        return const Color(0xFF0FA37F);
      case ClientStatus.inactive:
        return const Color(0xFFB6B6AF);
      case ClientStatus.pending:
        return const Color(0xFFE3A12A);
    }
  }
}

final TextStyle _headerStyle = GoogleFonts.inter(
  fontSize: 12,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.7,
  color: const Color(0xFF7A7A73),
);