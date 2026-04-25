import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/domain/enums.dart';
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
    // Sync controller when the parent resets the search value externally
    // (e.g. a clear button), but only if the text actually changed to avoid
    // disturbing the cursor position during normal typing.
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
    return Row(
      children: [
        SizedBox(
          width: 280,
          height: 42,
          child: TextField(
            controller: _searchController,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF2A2A26),
            ),
            decoration: InputDecoration(
              hintText: 'Buscar por nombre, email...',
              hintStyle: GoogleFonts.inter(
                fontSize: 14,
                color: clientsMutedTextColor,
              ),
              prefixIcon: const Icon(
                Icons.search,
                size: clientsIconSize,
                color: clientsSecondaryIconColor,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(
                borderRadius: clientsBorderRadius,
                borderSide: const BorderSide(color: clientsInputBorderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: clientsBorderRadius,
                borderSide: const BorderSide(color: clientsInputBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: clientsBorderRadius,
                borderSide: const BorderSide(color: Color(0xFFCECEC7)),
              ),
            ),
            onChanged: widget.onSearchChanged,
          ),
        ),
        const SizedBox(width: 12),
        const Icon(
          Icons.filter_alt_outlined,
          size: clientsIconSize,
          color: clientsMutedTextColor,
        ),
        const SizedBox(width: 12),
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
      ],
    );
  }
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
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        borderRadius: clientsChipBorderRadius,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? clientsSelectedBgColor : Colors.transparent,
            borderRadius: clientsChipBorderRadius,
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: selected ? clientsBrandColor : const Color(0xFF5B5B55),
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
