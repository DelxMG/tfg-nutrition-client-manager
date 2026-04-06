import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/domain/enums.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:nutritrack/presentation/screens/clients/helpers/clients_formatters.dart';

class ClientDetailHeader extends StatelessWidget {
  final Client client;
  final VoidCallback onBack;

  const ClientDetailHeader({
    super.key,
    required this.client,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final initials = getClientInitials(client.name);

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: clientsBorderColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          TextButton.icon(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back, size: 15),
            label: Text(
              'Volver a clientes',
              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            style: TextButton.styleFrom(
              foregroundColor: clientsMutedTextColor,
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar
              CircleAvatar(
                radius: 26,
                backgroundColor: const Color(0xFFDCEFE9),
                child: Text(
                  initials,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: clientsBrandColor,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Name + meta
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          client.name,
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: clientsHeadingColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        _StatusBadge(status: client.status),
                      ],
                    ),
                    const SizedBox(height: 4),
                    _MetaRow(
                      items: [
                        if (client.email != null) client.email!,
                        if (client.phone != null) client.phone!,
                        'Desde ${formatDate(client.createdAt)}',
                      ],
                    ),
                  ],
                ),
              ),
              // Edit button (visual only)
              OutlinedButton.icon(
                onPressed: null,
                icon: const Icon(Icons.edit_outlined, size: 15),
                label: Text(
                  'Editar',
                  style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: clientsBodyTextColor,
                  disabledForegroundColor: clientsBodyTextColor.withOpacity(0.6),
                  side: const BorderSide(color: clientsBorderColor),
                  shape: const RoundedRectangleBorder(borderRadius: clientsBorderRadius),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                  minimumSize: const Size(0, clientsButtonHeight),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Status badge ──────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final ClientStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: status.color.withOpacity(0.12),
        borderRadius: clientsChipBorderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: status.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            status.label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: status.color,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Meta row (email · phone · date) ──────────────────────────────────────────

class _MetaRow extends StatelessWidget {
  final List<String> items;

  const _MetaRow({required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 0,
      children: [
        for (int i = 0; i < items.length; i++) ...[
          Text(
            items[i],
            style: GoogleFonts.inter(
              fontSize: 13,
              color: clientsMutedTextColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (i < items.length - 1)
            Text(
              '  ·  ',
              style: GoogleFonts.inter(fontSize: 13, color: clientsBorderColor),
            ),
        ],
      ],
    );
  }
}
