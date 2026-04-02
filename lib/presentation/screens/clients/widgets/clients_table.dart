import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:nutritrack/presentation/screens/clients/helpers/clients_formatters.dart';

class ClientsTable extends StatelessWidget {
  final List<Client> clients;

  const ClientsTable({
    super.key,
    required this.clients,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: clientsBorderColor),
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
                        color: clientsMutedTextColor,
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
                      return _ClientRow(client: client);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      height: clientsButtonHeight,
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
}

class _ClientRow extends StatelessWidget {
  final Client client;

  const _ClientRow({required this.client});

  @override
  Widget build(BuildContext context) {
    final initials = getClientInitials(client.name);
    final age = calculateClientAge(client.birthDate);

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
                        color: clientsBrandColor,
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
                            color: clientsMutedTextColor,
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
                      color: client.status.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    client.status.label,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: clientsBodyTextColor,
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
                  color: clientsMutedTextColor,
                ),
              ),
            ),
            Expanded(
              child: Text(
                age?.toString() ?? '—',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: clientsBodyTextColor,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '—',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: clientsMutedTextColor,
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
                  color: clientsMutedTextColor,
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
}

final TextStyle _headerStyle = GoogleFonts.inter(
  fontSize: 12,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.7,
  color: clientsMutedTextColor,
);