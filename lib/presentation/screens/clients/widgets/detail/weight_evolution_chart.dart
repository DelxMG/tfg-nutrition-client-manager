import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/presentation/layout/responsive_utils.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';

class WeightEvolutionChart extends StatelessWidget {
  final List<Measurement> measurements;

  const WeightEvolutionChart({super.key, required this.measurements});

  @override
  Widget build(BuildContext context) {
    final withWeight = measurements.where((m) => m.weight != null).toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    return switch (withWeight.length) {
      0 => const _EmptyState(),
      1 => _SinglePoint(measurement: withWeight.first),
      _ => _LineChart(measurements: withWeight),
    };
  }
}

// ── Shared header row ─────────────────────────────────────────────────────────

class _ChartHeader extends StatelessWidget {
  const _ChartHeader();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(Icons.show_chart, size: 15, color: cs.onSurfaceVariant),
        const SizedBox(width: 6),
        Text(
          'Evolución del peso',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: cs.onSurface,
          ),
        ),
      ],
    );
  }
}

// ── Empty state (no weight data in any measurement) ───────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: clientsBorderRadius,
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ChartHeader(),
          const SizedBox(height: 32),
          Center(
            child: Text(
              'Sin datos de peso disponibles.',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Single data point ─────────────────────────────────────────────────────────

class _SinglePoint extends StatelessWidget {
  final Measurement measurement;

  const _SinglePoint({required this.measurement});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final d = measurement.date;
    final dateStr =
        '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: clientsBorderRadius,
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ChartHeader(),
          const SizedBox(height: 32),
          Center(
            child: Column(
              children: [
                Text(
                  '${measurement.weight!.toStringAsFixed(1)} kg',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: cs.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dateStr,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Añade más mediciones para ver la evolución.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: cs.onSurfaceVariant.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Line chart ────────────────────────────────────────────────────────────────

String _fmtDate(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}';

String _fmtDateFull(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

class _LineChart extends StatelessWidget {
  final List<Measurement> measurements;

  const _LineChart({required this.measurements});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final n = measurements.length;

    final spots = List.generate(
      n,
      (i) => FlSpot(i.toDouble(), measurements[i].weight!),
    );

    final weights = measurements.map((m) => m.weight!);
    final minW = weights.reduce((a, b) => a < b ? a : b);
    final maxW = weights.reduce((a, b) => a > b ? a : b);
    final rawPad = (maxW - minW) * 0.2;
    final pad = rawPad < 2.0 ? 2.0 : rawPad;
    final yMin = minW - pad;
    final yMax = maxW + pad;
    final yRange = yMax - yMin;
    final rawStep = yRange / 4;
    final yStep = rawStep < 0.5 ? 0.5 : rawStep.ceilToDouble();

    // Desktop: show every nth label so ~4 labels appear
    final labelEvery = n <= 5 ? n : (n / 4).ceil().clamp(1, n);

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = isCompactWidth(constraints.maxWidth);

        // Compact: wider x margins so edge labels aren't clipped at the border
        final xMargin = compact ? 0.5 : 0.15;
        final xMin = -xMargin;
        final xMax = (n - 1).toDouble() + xMargin;

        // Compact: show only first, middle, last label to avoid crowding
        final compactIdxs = <int>{0, (n - 1) ~/ 2, n - 1};

        return Container(
          padding: compact
              ? const EdgeInsets.fromLTRB(20, 16, 20, 12)
              : const EdgeInsets.fromLTRB(20, 16, 16, 8),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: clientsBorderRadius,
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ChartHeader(),
              const SizedBox(height: 16),
              SizedBox(
                height: compact ? 160 : 200,
                child: LineChart(
                  LineChartData(
                    minX: xMin,
                    maxX: xMax,
                    minY: yMin,
                    maxY: yMax,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: yStep,
                      getDrawingHorizontalLine: (_) => FlLine(
                        color: cs.outlineVariant.withValues(alpha: 0.5),
                        strokeWidth: 1,
                        dashArray: [4, 4],
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: yStep,
                          reservedSize: 42,
                          getTitlesWidget: (value, meta) {
                            if (value == meta.min || value == meta.max) {
                              return const SizedBox();
                            }
                            return Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Text(
                                value.toStringAsFixed(1),
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: cs.onSurfaceVariant,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          reservedSize: 28,
                          getTitlesWidget: (value, _) {
                            final idx = value.round();
                            if (idx < 0 || idx >= n) return const SizedBox();

                            final show = compact
                                ? compactIdxs.contains(idx)
                                : (idx == 0 ||
                                    idx == n - 1 ||
                                    (n > 3 && idx % labelEvery == 0));
                            if (!show) return const SizedBox();

                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                _fmtDate(measurements[idx].date),
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  color: cs.onSurfaceVariant,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipColor: (_) => cs.surfaceContainerHigh,
                        tooltipRoundedRadius: 8,
                        getTooltipItems: (spots) => spots.map((spot) {
                          final m = measurements[spot.x.round()];
                          return LineTooltipItem(
                            '${_fmtDateFull(m.date)}\n',
                            GoogleFonts.inter(
                              fontSize: 11,
                              color: cs.onSurfaceVariant,
                            ),
                            children: [
                              TextSpan(
                                text: '${m.weight!.toStringAsFixed(1)} kg',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: cs.onSurface,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        curveSmoothness: 0.3,
                        color: cs.primary,
                        barWidth: 2,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (_, _, _, _) => FlDotCirclePainter(
                            radius: 3.5,
                            color: cs.primary,
                            strokeWidth: 1.5,
                            strokeColor: cs.surface,
                          ),
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          color: cs.primary.withValues(alpha: 0.06),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
