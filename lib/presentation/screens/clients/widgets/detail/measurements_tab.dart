import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/application/providers/database_provider.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/data/repositories/measurement_repository.dart';
import 'package:nutritrack/domain/services/bmi_calculator.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/detail/measurement_form_dialog.dart';

class MeasurementsTab extends ConsumerWidget {
  final int clientId;
  final int? clientHeight;

  const MeasurementsTab({
    super.key,
    required this.clientId,
    required this.clientHeight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final measurementsAsync = ref.watch(clientMeasurementsProvider(clientId));

    return measurementsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => Center(
        child: Text(
          'Error al cargar las mediciones',
          style: GoogleFonts.inter(fontSize: 14, color: clientsMutedTextColor),
        ),
      ),
      data: (measurements) => _MeasurementsContent(
        measurements: measurements,
        clientId: clientId,
        clientHeight: clientHeight,
        repository: ref.read(measurementRepositoryProvider),
      ),
    );
  }
}

// ── Content (rendered when stream has data) ───────────────────────────────────

class _MeasurementsContent extends StatelessWidget {
  final List<Measurement> measurements;
  final int clientId;
  final int? clientHeight;
  final MeasurementRepository repository;

  const _MeasurementsContent({
    required this.measurements,
    required this.clientId,
    required this.clientHeight,
    required this.repository,
  });

  void _openNewMeasurementDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => MeasurementFormDialog(
        clientId: clientId,
        repository: repository,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final latest = measurements.isNotEmpty ? measurements.first : null;
    final previous = measurements.length > 1 ? measurements[1] : null;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Metric cards ────────────────────────────────────────────
          _MetricCardsRow(
            latest: latest,
            clientHeight: clientHeight,
          ),
          const SizedBox(height: 20),

          // ── History header + button ──────────────────────────────────
          Row(
            children: [
              Text(
                'Historial de mediciones',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: clientsHeadingColor,
                ),
              ),
              const Spacer(),
              SizedBox(
                height: clientsButtonHeight,
                child: ElevatedButton.icon(
                  onPressed: () => _openNewMeasurementDialog(context),
                  icon: const Icon(Icons.add, size: 16),
                  label: Text(
                    'Nueva medición',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: clientsBrandColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: clientsBorderRadius,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ── History list ─────────────────────────────────────────────
          measurements.isEmpty
              ? _EmptyState(onAdd: () => _openNewMeasurementDialog(context))
              : _MeasurementsList(
                  measurements: measurements,
                  previousMeasurement: previous,
                ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── Metric cards row ──────────────────────────────────────────────────────────

class _MetricCardsRow extends StatelessWidget {
  final Measurement? latest;
  final int? clientHeight;

  const _MetricCardsRow({required this.latest, required this.clientHeight});

  @override
  Widget build(BuildContext context) {
    final weight = latest?.weight;
    final bodyFat = latest?.bodyFat;
    final muscleMass = latest?.muscleMass;
    final bmi = calculateBmi(heightCm: clientHeight, weightKg: weight);

    return Row(
      children: [
        _MetricCard(
          icon: Icons.monitor_weight_outlined,
          label: 'Peso actual',
          value: weight != null ? '${weight.toStringAsFixed(1)} kg' : '—',
        ),
        const SizedBox(width: 12),
        _MetricCard(
          icon: Icons.water_drop_outlined,
          label: 'Grasa corporal',
          value: bodyFat != null ? '${bodyFat.toStringAsFixed(1)} %' : '—',
        ),
        const SizedBox(width: 12),
        _MetricCard(
          icon: Icons.fitness_center_outlined,
          label: 'Masa muscular',
          value:
              muscleMass != null ? '${muscleMass.toStringAsFixed(1)} kg' : '—',
        ),
        const SizedBox(width: 12),
        _MetricCard(
          icon: Icons.calculate_outlined,
          label: 'IMC',
          value: bmi != null ? bmi.toStringAsFixed(1) : '—',
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
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
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: clientsHeadingColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Measurements list ─────────────────────────────────────────────────────────

class _MeasurementsList extends StatelessWidget {
  final List<Measurement> measurements;
  final Measurement? previousMeasurement;

  const _MeasurementsList({
    required this.measurements,
    required this.previousMeasurement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: clientsBorderRadius,
        border: Border.all(color: clientsBorderColor),
      ),
      child: Column(
        children: [
          // Header row
          _TableHeader(),
          const Divider(height: 1, color: clientsBorderColor),
          // Rows
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: measurements.length,
            separatorBuilder: (_, __) =>
                const Divider(height: 1, color: clientsBorderColor),
            itemBuilder: (_, index) {
              final m = measurements[index];
              // Δ weight: only for the latest vs its immediate predecessor
              final weightDelta = (index == 0 && previousMeasurement != null)
                  ? _weightDelta(m.weight, previousMeasurement!.weight)
                  : null;
              return _MeasurementRow(
                measurement: m,
                weightDelta: weightDelta,
              );
            },
          ),
        ],
      ),
    );
  }

  String? _weightDelta(double? current, double? previous) {
    if (current == null || previous == null) return null;
    final delta = current - previous;
    final sign = delta >= 0 ? '+' : '';
    return '$sign${delta.toStringAsFixed(1)} kg';
  }
}

class _TableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text('Fecha', style: _headerStyle()),
          ),
          Expanded(
            child: Text('Peso', style: _headerStyle()),
          ),
          Expanded(
            child: Text('Grasa', style: _headerStyle()),
          ),
          Expanded(
            child: Text('Músculo', style: _headerStyle()),
          ),
          Expanded(
            child: Text('Variación', style: _headerStyle()),
          ),
        ],
      ),
    );
  }

  TextStyle _headerStyle() => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: clientsMutedTextColor,
      );
}

class _MeasurementRow extends StatelessWidget {
  final Measurement measurement;
  final String? weightDelta;

  const _MeasurementRow({required this.measurement, this.weightDelta});

  @override
  Widget build(BuildContext context) {
    final d = measurement.date;
    final dateStr =
        '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

    Color? deltaColor;
    if (weightDelta != null) {
      deltaColor = weightDelta!.startsWith('+')
          ? const Color(0xFFD94A4A)
          : const Color(0xFF0FA37F);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(dateStr, style: _cellStyle()),
          ),
          Expanded(
            child: Text(
              measurement.weight != null
                  ? '${measurement.weight!.toStringAsFixed(1)} kg'
                  : '—',
              style: _cellStyle(),
            ),
          ),
          Expanded(
            child: Text(
              measurement.bodyFat != null
                  ? '${measurement.bodyFat!.toStringAsFixed(1)} %'
                  : '—',
              style: _cellStyle(),
            ),
          ),
          Expanded(
            child: Text(
              measurement.muscleMass != null
                  ? '${measurement.muscleMass!.toStringAsFixed(1)} kg'
                  : '—',
              style: _cellStyle(),
            ),
          ),
          Expanded(
            child: weightDelta != null
                ? Text(
                    weightDelta!,
                    style: _cellStyle().copyWith(
                      color: deltaColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Text('—', style: _cellStyle()),
          ),
        ],
      ),
    );
  }

  TextStyle _cellStyle() => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: clientsBodyTextColor,
      );
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final VoidCallback onAdd;

  const _EmptyState({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: clientsBorderRadius,
        border: Border.all(color: clientsBorderColor),
      ),
      child: Column(
        children: [
          Icon(Icons.monitor_weight_outlined,
              size: 36, color: clientsMutedTextColor.withValues(alpha: 0.4)),
          const SizedBox(height: 12),
          Text(
            'Sin mediciones registradas',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: clientsMutedTextColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Añade la primera medición para empezar a hacer seguimiento.',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: clientsMutedTextColor.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: onAdd,
            child: Text(
              'Añadir primera medición',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: clientsBrandColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
