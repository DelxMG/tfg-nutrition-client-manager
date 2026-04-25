import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/data/models/client_summary.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';

class ClientSummaryCards extends StatelessWidget {
  final ClientSummary summary;

  const ClientSummaryCards({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final weight = summary.latestMeasurement?.weight;
    final bodyFat = summary.latestMeasurement?.bodyFat;
    final heightCm = summary.client.height;
    final bmi = summary.bmi;

    return Row(
      children: [
        _MetricCard(
          icon: Icons.monitor_weight_outlined,
          label: 'Peso actual',
          value: weight != null ? '${weight.toStringAsFixed(1)} kg' : '—',
        ),
        const SizedBox(width: 12),
        _MetricCard(
          icon: Icons.height,
          label: 'Altura',
          value: heightCm != null ? '$heightCm cm' : '—',
        ),
        const SizedBox(width: 12),
        _MetricCard(
          icon: Icons.calculate_outlined,
          label: 'IMC',
          value: bmi != null ? bmi.toStringAsFixed(1) : '—',
          badge: bmi != null ? _bmiBadge(bmi) : null,
        ),
        const SizedBox(width: 12),
        _MetricCard(
          icon: Icons.water_drop_outlined,
          label: 'Grasa corporal',
          value: bodyFat != null ? '${bodyFat.toStringAsFixed(1)} %' : '—',
        ),
      ],
    );
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
  final _BmiLabel? badge;

  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: clientsBorderRadius,
          border: Border.all(color: clientsBorderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 15, color: clientsMutedTextColor),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: clientsMutedTextColor,
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
                    color: clientsHeadingColor,
                  ),
                ),
                if (badge != null) ...[
                  const SizedBox(width: 8),
                  badge!,
                ],
              ],
            ),
          ],
        ),
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
