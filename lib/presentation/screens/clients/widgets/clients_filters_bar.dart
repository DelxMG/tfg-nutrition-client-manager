import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/data/db/tables/clients.dart';

class ClientsFiltersBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 280,
          height: 42,
          child: TextField(
            controller: TextEditingController(text: search)
              ..selection = TextSelection.collapsed(offset: search.length),
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
            onChanged: onSearchChanged,
          ),
        ),
        const SizedBox(width: 12),
        const Icon(
          Icons.filter_alt_outlined,
          size: 18,
          color: Color(0xFF7A7A73),
        ),
        const SizedBox(width: 12),
        _FilterChip(
          label: 'Todos',
          selected: statusFilter == null,
          onTap: () => onStatusChanged(null),
        ),
        _FilterChip(
          label: 'Activo',
          selected: statusFilter == ClientStatus.active,
          onTap: () => onStatusChanged(ClientStatus.active),
        ),
        _FilterChip(
          label: 'Inactivo',
          selected: statusFilter == ClientStatus.inactive,
          onTap: () => onStatusChanged(ClientStatus.inactive),
        ),
        _FilterChip(
          label: 'Pendiente',
          selected: statusFilter == ClientStatus.pending,
          onTap: () => onStatusChanged(ClientStatus.pending),
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
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFDCEFE9) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: selected
                  ? const Color(0xFF0FA37F)
                  : const Color(0xFF5B5B55),
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}