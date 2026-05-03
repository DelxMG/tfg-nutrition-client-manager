import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:nutritrack/presentation/screens/clients/helpers/clients_formatters.dart';

class ClientsTable extends StatelessWidget {
  final List<Client> clients;
  final ValueChanged<int> onClientTap;

  const ClientsTable({
    super.key,
    required this.clients,
    required this.onClientTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        children: [
          _buildTableHeader(cs),
          Divider(height: 1, thickness: 1, color: cs.outlineVariant),
          Expanded(
            child: clients.isEmpty
                ? Center(
                    child: Text(
                      'No hay clientes',
                      style: GoogleFonts.inter(
                        color: cs.onSurfaceVariant,
                        fontSize: 14,
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: clients.length,
                    separatorBuilder: (_, _) => Divider(
                      height: 1,
                      thickness: 1,
                      color: cs.outlineVariant,
                    ),
                    itemBuilder: (context, index) {
                      final client = clients[index];
                      return _ClientRow(client: client, onTap: onClientTap);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(ColorScheme cs) {
    return Container(
      height: clientsButtonHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: _buildSortableHeader('CLIENTE', cs)),
          Expanded(flex: 2, child: _buildSortableHeader('ESTADO', cs)),
          Expanded(flex: 2, child: _buildSortableHeader('OBJETIVO', cs)),
          Expanded(child: _buildPlainHeader('EDAD', cs)),
          Expanded(child: _buildPlainHeader('PESO', cs)),
          Expanded(flex: 2, child: _buildSortableHeader('ÚLTIMA VISITA', cs)),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _buildPlainHeader(String label, ColorScheme cs) {
    return Text(label, style: _headerTextStyle(cs));
  }

  Widget _buildSortableHeader(String label, ColorScheme cs) {
    return Row(
      children: [
        Flexible(
          child: Text(
            label,
            style: _headerTextStyle(cs),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 4),
        Icon(Icons.unfold_more, size: 14, color: cs.onSurfaceVariant),
      ],
    );
  }
}

class _ClientRow extends StatefulWidget {
  final Client client;
  final ValueChanged<int> onTap;

  const _ClientRow({required this.client, required this.onTap});

  @override
  State<_ClientRow> createState() => _ClientRowState();
}

class _ClientRowState extends State<_ClientRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final initials = getClientInitials(widget.client.name);
    final age = calculateClientAge(widget.client.birthDate);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        color: _hovered
            ? cs.primary.withValues(alpha: 0.06)
            : Colors.transparent,
        child: InkWell(
          onTap: () => widget.onTap(widget.client.clientId),
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
                              widget.client.name,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                                color: cs.onSurface,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.client.email ?? 'Sin email',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w400,
                                height: 1.1,
                                color: cs.onSurfaceVariant,
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
                          color: widget.client.status.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.client.status.label,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: cs.onSurface,
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
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    age?.toString() ?? '—',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: cs.onSurface,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '—',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: cs.onSurfaceVariant,
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
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                  child: Icon(
                    Icons.chevron_right,
                    size: 17,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

TextStyle _headerTextStyle(ColorScheme cs) => GoogleFonts.inter(
  fontSize: 12,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.7,
  color: cs.onSurfaceVariant,
);
