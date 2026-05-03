import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/data/models/client_summary.dart';
import 'package:nutritrack/presentation/layout/responsive_utils.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:nutritrack/presentation/screens/clients/helpers/clients_formatters.dart';

class ClientSummarySections extends StatelessWidget {
  final ClientSummary summary;

  const ClientSummarySections({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final client = summary.client;
    final anamnesis = summary.anamnesis;
    final age = calculateClientAge(client.birthDate);

    final personalInfo = _InfoCard(
      icon: Icons.person_outline,
      title: 'Información personal',
      rows: [
        _InfoRow('Nombre completo', client.name),
        _InfoRow('Email', client.email ?? '—'),
        _InfoRow('Teléfono', client.phone ?? '—'),
        _InfoRow('Edad', age != null ? '$age años' : '—'),
        _InfoRow('Género', client.sex?.label ?? '—'),
        _InfoRow(
          'Altura',
          client.height != null ? '${client.height} cm' : '—',
        ),
        _InfoRow('Ocupación', anamnesis?.occupation ?? '—'),
        _InfoRow('Fecha de inicio', formatDate(client.createdAt)),
      ],
    );

    final objetivoCard = _InfoCard(
      icon: Icons.flag_outlined,
      title: 'Objetivo y actividad',
      rows: [
        _InfoRow('Objetivo', anamnesis?.objective ?? '—'),
        _InfoRow(
          'Nivel de actividad',
          anamnesis?.physicalActivity?.label ?? '—',
        ),
        _InfoRow('Suplementos', anamnesis?.supplements ?? '—'),
        _InfoRow('Última visita', formatDate(summary.lastVisit)),
      ],
    );

    final anamnesisCard = _InfoCard(
      icon: Icons.medical_information_outlined,
      title: 'Anamnesis',
      rows: [
        _InfoRow('Fecha de anamnesis', formatDate(anamnesis?.date)),
        _InfoRow('Alergias e intolerancias', anamnesis?.allergies ?? '—'),
        _InfoRow('Condiciones médicas', anamnesis?.pathologies ?? '—'),
        _InfoRow('Observaciones', anamnesis?.observations ?? '—'),
      ],
    );

    if (context.isCompact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          personalInfo,
          const SizedBox(height: 14),
          objetivoCard,
          const SizedBox(height: 14),
          anamnesisCard,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column (~60 %): personal info
        Expanded(flex: 6, child: personalInfo),
        const SizedBox(width: 14),
        // Right column (~40 %): goal + anamnesis stacked
        Expanded(
          flex: 4,
          child: Column(
            children: [
              objetivoCard,
              const SizedBox(height: 14),
              anamnesisCard,
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData? icon;
  final String title;
  final List<_InfoRow> rows;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: clientsBorderRadius,
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: cs.onSurfaceVariant),
                const SizedBox(width: 8),
              ],
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(height: 1, thickness: 1, color: cs.outlineVariant),
          const SizedBox(height: 12),
          for (int i = 0; i < rows.length; i++) ...[
            _InfoRowWidget(row: rows[i]),
            if (i < rows.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _InfoRow {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);
}

class _InfoRowWidget extends StatelessWidget {
  final _InfoRow row;

  const _InfoRowWidget({required this.row});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isEmpty = row.value == '—';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          row.label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: cs.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            row.value,
            textAlign: TextAlign.end,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isEmpty ? cs.onSurfaceVariant : cs.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
