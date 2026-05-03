import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/domain/enums.dart';
import 'package:nutritrack/presentation/layout/responsive_utils.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';

class ClientsFiltersBar extends StatefulWidget {
  final String search;
  final ClientStatus? statusFilter;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<ClientStatus?> onStatusChanged;

  const ClientsFiltersBar({
    super.key,
    required this.search,
    required this.statusFilter,
    required this.onSearchChanged,
    required this.onStatusChanged,
  });

  @override
  State<ClientsFiltersBar> createState() => _ClientsFiltersBarState();
}

class _ClientsFiltersBarState extends State<ClientsFiltersBar> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.search);
  }

  @override
  void didUpdateWidget(ClientsFiltersBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.search != _searchController.text) {
      _searchController.text = widget.search;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return context.isCompact ? _buildCompact(context) : _buildDesktop(context);
  }

  Widget _buildDesktop(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      children: [
        SizedBox(
          width: 280,
          height: 42,
          child: _searchField(cs),
        ),
        const SizedBox(width: 12),
        Icon(Icons.filter_alt_outlined, size: clientsIconSize, color: cs.onSurfaceVariant),
        const SizedBox(width: 12),
        ..._filterChips(),
      ],
    );
  }

  Widget _buildCompact(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 42, child: _searchField(cs)),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Icon(Icons.filter_alt_outlined, size: clientsIconSize, color: cs.onSurfaceVariant),
              const SizedBox(width: 8),
              ..._filterChips(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _searchField(ColorScheme cs) {
    return TextField(
      controller: _searchController,
      style: GoogleFonts.inter(fontSize: 14, color: cs.onSurface),
      decoration: InputDecoration(
        hintText: 'Buscar por nombre, email...',
        hintStyle: GoogleFonts.inter(fontSize: 14, color: cs.onSurfaceVariant),
        prefixIcon: Icon(Icons.search, size: clientsIconSize, color: cs.onSurfaceVariant),
        filled: true,
        fillColor: cs.surfaceContainerHighest,
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        border: OutlineInputBorder(
          borderRadius: clientsBorderRadius,
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: clientsBorderRadius,
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: clientsBorderRadius,
          borderSide: BorderSide(color: cs.primary.withValues(alpha: 0.7)),
        ),
      ),
      onChanged: widget.onSearchChanged,
    );
  }

  List<Widget> _filterChips() => [
        _FilterChip(
          label: 'Todos',
          selected: widget.statusFilter == null,
          onTap: () => widget.onStatusChanged(null),
        ),
        _FilterChip(
          label: 'Activo',
          selected: widget.statusFilter == ClientStatus.active,
          onTap: () => widget.onStatusChanged(ClientStatus.active),
        ),
        _FilterChip(
          label: 'Inactivo',
          selected: widget.statusFilter == ClientStatus.inactive,
          onTap: () => widget.onStatusChanged(ClientStatus.inactive),
        ),
        _FilterChip(
          label: 'Pendiente',
          selected: widget.statusFilter == ClientStatus.pending,
          onTap: () => widget.onStatusChanged(ClientStatus.pending),
        ),
      ];
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        borderRadius: clientsChipBorderRadius,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? cs.primaryContainer : Colors.transparent,
            borderRadius: clientsChipBorderRadius,
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: selected ? cs.primary : cs.onSurface,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
