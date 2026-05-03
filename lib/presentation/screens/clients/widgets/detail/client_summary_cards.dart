import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/data/models/client_summary.dart';
import 'package:nutritrack/presentation/layout/responsive_utils.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';

class ClientSummaryCards extends StatelessWidget {
  final ClientSummary summary;
  final List<Measurement> allMeasurements;

  const ClientSummaryCards({
    super.key,
    required this.summary,
    required this.allMeasurements,
  });

  @override
  Widget build(BuildContext context) {
    final weight = summary.latestMeasurement?.weight;
    final bodyFat = summary.latestMeasurement?.bodyFat;
    final muscleMass = summary.latestMeasurement?.muscleMass;
    final bmi = summary.bmi;
    final weightDelta = _calcWeightDelta(allMeasurements);

    final cards = [
      _MetricCard(
        icon: Icons.monitor_weight_outlined,
        label: 'Peso actual',
        value: weight != null ? '${weight.toStringAsFixed(1)} kg' : '—',
        subtitle: weightDelta != null ? _formatDelta(weightDelta) : null,
      ),
      _MetricCard(
        icon: Icons.calculate_outlined,
        label: 'IMC',
        value: bmi != null ? bmi.toStringAsFixed(1) : '—',
        badge: bmi != null ? _bmiBadge(bmi) : null,
      ),
      _MetricCard(
        icon: Icons.water_drop_outlined,
        label: 'Grasa corporal',
        value: bodyFat != null ? '${bodyFat.toStringAsFixed(1)} %' : '—',
      ),
      _MetricCard(
        icon: Icons.fitness_center_outlined,
        label: 'Masa muscular',
        value: muscleMass != null
            ? '${muscleMass.toStringAsFixed(1)} kg'
            : '—',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (isCompactWidth(constraints.maxWidth)) {
          final cardWidth = (constraints.maxWidth - 12) / 2;
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final card in cards) SizedBox(width: cardWidth, child: card),
            ],
          );
        }

        return Row(
          children: [
            for (int i = 0; i < cards.length; i++) ...[
              Expanded(child: cards[i]),
              if (i < cards.length - 1) const SizedBox(width: 12),
            ],
          ],
        );
      },
    );
  }

  double? _calcWeightDelta(List<Measurement> measurements) {
    if (measurements.length < 2) return null;
    final latest = measurements.first.weight;
    final oldest = measurements.last.weight;
    if (latest == null || oldest == null) return null;
    return latest - oldest;
  }

  String _formatDelta(double delta) {
    final sign = delta >= 0 ? '+' : '';
    return '$sign${delta.toStringAsFixed(1)} kg desde inicio';
  }

  _BmiLabel _bmiBadge(double bmi) {
    if (bmi < 18.5) return const _BmiLabel('Bajo peso', Color(0xFF4A90D9));
    if (bmi < 25.0) return const _BmiLabel('Normal', Color(0xFF0FA37F));
    if (bmi < 30.0) return const _BmiLabel('Sobrepeso', Color(0xFFE3A12A));
    return const _BmiLabel('Obesidad', Color(0xFFD94A4A));
  }
}

// ── Single metric card ────────────────────────────────────────────────────────

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? subtitle;
  final _BmiLabel? badge;

  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
    this.subtitle,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
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
              Icon(icon, size: 15, color: cs.onSurfaceVariant),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                ),
              ),
              if (badge != null) ...[
                const SizedBox(width: 8),
                badge!,
              ],
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── BMI classification badge ──────────────────────────────────────────────────

class _BmiLabel extends StatelessWidget {
  final String text;
  final Color color;

  const _BmiLabel(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: clientsChipBorderRadius,
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
