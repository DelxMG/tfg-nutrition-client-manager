import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/data/db/tables/clients.dart';
import 'package:nutritrack/presentation/layout/responsive_utils.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:nutritrack/presentation/screens/clients/helpers/clients_formatters.dart';

class ClientDetailHeader extends StatelessWidget {
  final Client client;
  final VoidCallback onBack;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;

  const ClientDetailHeader({
    super.key,
    required this.client,
    required this.onBack,
    this.onEditPressed,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final initials = getClientInitials(client.name);
    final compact = context.isCompact;

    final backButton = TextButton.icon(
      onPressed: onBack,
      icon: const Icon(Icons.arrow_back, size: 15),
      label: Text(
        'Volver a clientes',
        style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
      ),
      style: TextButton.styleFrom(
        foregroundColor: cs.onSurfaceVariant,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );

    final avatar = CircleAvatar(
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
    );

    final nameAndMeta = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  client.name,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
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
    );

    final editButton = OutlinedButton.icon(
      onPressed: onEditPressed,
      icon: const Icon(Icons.edit_outlined, size: 15),
      label: Text(
        'Editar',
        style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: cs.onSurface,
        disabledForegroundColor: cs.onSurface.withValues(alpha: 0.4),
        side: BorderSide(color: cs.outlineVariant),
        shape: const RoundedRectangleBorder(borderRadius: clientsBorderRadius),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
        minimumSize: const Size(0, clientsButtonHeight),
      ),
    );

    final deleteButton = _DeleteClientButton(
      onDelete: () => onDeletePressed?.call(),
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: cs.outlineVariant)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          backButton,
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              avatar,
              const SizedBox(width: 16),
              nameAndMeta,
              if (!compact) ...[
                editButton,
                const SizedBox(width: 8),
                deleteButton,
              ],
            ],
          ),
          if (compact) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [editButton, const SizedBox(width: 8), deleteButton],
            ),
          ],
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
    final cs = Theme.of(context).colorScheme;

    if (items.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 0,
      children: [
        for (int i = 0; i < items.length; i++) ...[
          Text(
            items[i],
            style: GoogleFonts.inter(
              fontSize: 13,
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (i < items.length - 1)
            Text(
              '  ·  ',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: cs.outlineVariant,
              ),
            ),
        ],
      ],
    );
  }
}

class _DeleteClientButton extends StatefulWidget {
  final VoidCallback onDelete;

  const _DeleteClientButton({required this.onDelete});

  @override
  State<_DeleteClientButton> createState() => _DeleteClientButtonState();
}

class _DeleteClientButtonState extends State<_DeleteClientButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const red = Color(0xFFD94A4A);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: OutlinedButton.icon(
        onPressed: widget.onDelete,
        icon: Icon(
          Icons.delete_outlined,
          size: 15,
          color: _hovered ? red : null,
        ),
        label: Text(
          'Eliminar',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: _hovered ? red : null,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: _hovered ? red : cs.onSurface,
          backgroundColor: _hovered
              ? red.withValues(alpha: 0.08)
              : Colors.transparent,
          side: BorderSide(color: _hovered ? red : cs.outlineVariant),
          shape: const RoundedRectangleBorder(
            borderRadius: clientsBorderRadius,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
          minimumSize: const Size(0, clientsButtonHeight),
        ),
      ),
    );
  }
}
