import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/data/models/client_summary.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:nutritrack/presentation/screens/clients/helpers/clients_formatters.dart';

/// Three info blocks rendered side-by-side on desktop.
class ClientSummarySections extends StatelessWidget {
  final ClientSummary summary;

  const ClientSummarySections({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final client = summary.client;
    final anamnesis = summary.anamnesis;

    final age = calculateClientAge(client.birthDate);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Información personal ──────────────────────────────────────────────
        Expanded(
          child: _InfoCard(
            title: 'Información personal',
            rows: [
              _InfoRow('Nombre', client.name),
              _InfoRow('Email', client.email ?? '—'),
              _InfoRow('Teléfono', client.phone ?? '—'),
              _InfoRow('Edad', age != null ? '$age años' : '—'),
              _InfoRow('Género', client.sex?.label ?? '—'),
              _InfoRow('Ocupación', anamnesis?.occupation ?? '—'),
              _InfoRow('Fecha de inicio', formatDate(client.createdAt)),
            ],
          ),
        ),
        const SizedBox(width: 14),
        // ── Objetivo y actividad ──────────────────────────────────────────────
        Expanded(
          child: _InfoCard(
            title: 'Objetivo y actividad',
            rows: [
              _InfoRow('Objetivo', anamnesis?.objective ?? '—'),
              _InfoRow(
                'Nivel de actividad',
                anamnesis?.physicalActivity?.label ?? '—',
              ),
              _InfoRow('Última visita', formatDate(summary.lastVisit)),
            ],
          ),
        ),
        const SizedBox(width: 14),
        // ── Anamnesis ─────────────────────────────────────────────────────────
        Expanded(
          child: _InfoCard(
            title: 'Anamnesis',
            rows: [
              _InfoRow(
                'Alergias e intolerancias',
                anamnesis?.allergies ?? '—',
                multiline: true,
              ),
              _InfoRow(
                'Condiciones médicas',
                anamnesis?.pathologies ?? '—',
                multiline: true,
              ),
              _InfoRow(
                'Observaciones',
                anamnesis?.observations ?? '—',
                multiline: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Info card ─────────────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  final String title;
  final List<_InfoRow> rows;

  const _InfoCard({required this.title, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: clientsBorderRadius,
        border: Border.all(color: clientsBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: clientsHeadingColor,
              letterSpacing: 0.1,
            ),
          ),
          const SizedBox(height: 14),
          for (final row in rows) ...[
            _InfoRowWidget(row: row),
            if (row != rows.last)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(height: 1, thickness: 1, color: Color(0xFFF0F0EC)),
              ),
          ],
        ],
      ),
    );
  }
}

// ── Single row inside a card ──────────────────────────────────────────────────

class _InfoRow {
  final String label;
  final String value;
  final bool multiline;

  const _InfoRow(this.label, this.value, {this.multiline = false});
}

class _InfoRowWidget extends StatelessWidget {
  final _InfoRow row;

  const _InfoRowWidget({required this.row});

  @override
  Widget build(BuildContext context) {
    final isEmpty = row.value == '—';

    if (row.multiline) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            row.label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: clientsMutedTextColor,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            row.value,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: isEmpty ? clientsMutedTextColor : clientsBodyTextColor,
              height: 1.5,
            ),
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            row.label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: clientsMutedTextColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            row.value,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isEmpty ? clientsMutedTextColor : clientsBodyTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
