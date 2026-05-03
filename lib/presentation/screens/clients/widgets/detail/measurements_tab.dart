import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/application/providers/database_provider.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/data/repositories/measurement_repository.dart';
import 'package:nutritrack/domain/services/bmi_calculator.dart';
import 'package:nutritrack/presentation/layout/responsive_utils.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/detail/measurement_form_dialog.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/detail/weight_evolution_chart.dart';

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
    final cs = Theme.of(context).colorScheme;
    final measurementsAsync = ref.watch(clientMeasurementsProvider(clientId));

    return measurementsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => Center(
        child: Text(
          'Error al cargar las mediciones',
          style: GoogleFonts.inter(fontSize: 14, color: cs.onSurfaceVariant),
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
      builder: (_) =>
          MeasurementFormDialog(clientId: clientId, repository: repository),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final compact = context.isCompact;
    final latest = measurements.isNotEmpty ? measurements.first : null;

    final newButton = SizedBox(
      height: clientsButtonHeight,
      child: ElevatedButton.icon(
        onPressed: () => _openNewMeasurementDialog(context),
        icon: const Icon(Icons.add, size: 16),
        label: Text(
          'Nueva medición',
          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: clientsBorderRadius,
          ),
        ),
      ),
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Metric cards ──────────────────────────────────────────────
          _MetricCardsRow(latest: latest),
          const SizedBox(height: 20),

          // ── Weight evolution chart ─────────────────────────────────────
          if (measurements.any((m) => m.weight != null)) ...[
            WeightEvolutionChart(measurements: measurements),
            const SizedBox(height: 20),
          ],

          // ── History header + button ────────────────────────────────────
          if (compact)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Historial de mediciones',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(width: double.infinity, child: newButton),
              ],
            )
          else
            Row(
              children: [
                Text(
                  'Historial de mediciones',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface,
                  ),
                ),
                const Spacer(),
                newButton,
              ],
            ),
          const SizedBox(height: 12),

          // ── History list ──────────────────────────────────────────────
          measurements.isEmpty
              ? _EmptyState(onAdd: () => _openNewMeasurementDialog(context))
              : _MeasurementsList(
                  measurements: measurements,
                  clientHeight: clientHeight,
                  repository: repository,
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

  const _MetricCardsRow({required this.latest});

  @override
  Widget build(BuildContext context) {
    final weight = latest?.weight;
    final bodyFat = latest?.bodyFat;
    final muscleMass = latest?.muscleMass;

    final cards = [
      _MetricCard(
        icon: Icons.monitor_weight_outlined,
        label: 'Peso actual',
        value: weight != null ? '${weight.toStringAsFixed(1)} kg' : '—',
      ),
      _MetricCard(
        icon: Icons.water_drop_outlined,
        label: 'Grasa corporal',
        value: bodyFat != null ? '${bodyFat.toStringAsFixed(1)} %' : '—',
      ),
      _MetricCard(
        icon: Icons.fitness_center_outlined,
        label: 'Masa muscular',
        value: muscleMass != null ? '${muscleMass.toStringAsFixed(1)} kg' : '—',
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
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Measurements list ─────────────────────────────────────────────────────────

class _MeasurementsList extends StatelessWidget {
  final List<Measurement> measurements;
  final int? clientHeight;
  final MeasurementRepository repository;

  const _MeasurementsList({
    required this.measurements,
    required this.clientHeight,
    required this.repository,
  });

  Future<void> _confirmDelete(BuildContext context, Measurement m) async {
    final d = m.date;
    final dateStr =
        '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar medición'),
        content: Text(
          '¿Seguro que quieres eliminar la medición del $dateStr? '
          'Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFD94A4A),
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await repository.deleteMeasurement(m.measurementId);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al eliminar la medición. Inténtalo de nuevo.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final compact = context.isCompact;

    if (compact) {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: measurements.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (ctx, index) {
          final m = measurements[index];
          return _MeasurementCard(
            measurement: m,
            bmi: calculateBmi(heightCm: clientHeight, weightKg: m.weight),
            onDelete: () => _confirmDelete(ctx, m),
          );
        },
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: clientsBorderRadius,
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        children: [
          const _TableHeader(),
          Divider(height: 1, color: cs.outlineVariant),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: measurements.length,
            separatorBuilder: (_, __) => Builder(
              builder: (ctx) => Divider(
                height: 1,
                color: Theme.of(ctx).colorScheme.outlineVariant,
              ),
            ),
            itemBuilder: (ctx, index) {
              final m = measurements[index];
              return _MeasurementRow(
                measurement: m,
                bmi: calculateBmi(heightCm: clientHeight, weightKg: m.weight),
                onDelete: () => _confirmDelete(ctx, m),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ── Desktop: table header ─────────────────────────────────────────────────────

class _TableHeader extends StatelessWidget {
  const _TableHeader();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text('Fecha',       style: _headerStyle(cs))),
          Expanded(child: _h('Peso',        cs)),
          Expanded(child: _h('Grasa',       cs)),
          Expanded(child: _h('Músculo',     cs)),
          Expanded(child: _h('Brazo',       cs)),
          Expanded(child: _h('Muslo',       cs)),
          Expanded(child: _h('Pecho',       cs)),
          Expanded(child: _h('Cintura',     cs)),
          Expanded(child: _h('Pantorrilla', cs)),
          Expanded(child: _h('IMC',         cs)),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _h(String label, ColorScheme cs) => Text(
    label,
    overflow: TextOverflow.ellipsis,
    style: _headerStyle(cs),
  );

  TextStyle _headerStyle(ColorScheme cs) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: cs.onSurfaceVariant,
  );
}

// ── Desktop: table row ────────────────────────────────────────────────────────

class _MeasurementRow extends StatelessWidget {
  final Measurement measurement;
  final double? bmi;
  final VoidCallback? onDelete;

  const _MeasurementRow({required this.measurement, this.bmi, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final d = measurement.date;
    final dateStr =
        '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(dateStr, style: _cellStyle(cs))),
          Expanded(
            child: Text(
              measurement.weight != null
                  ? '${measurement.weight!.toStringAsFixed(1)} kg'
                  : '—',
              style: _cellStyle(cs),
            ),
          ),
          Expanded(
            child: Text(
              measurement.bodyFat != null
                  ? '${measurement.bodyFat!.toStringAsFixed(1)} %'
                  : '—',
              style: _cellStyle(cs),
            ),
          ),
          Expanded(
            child: Text(
              measurement.muscleMass != null
                  ? '${measurement.muscleMass!.toStringAsFixed(1)} kg'
                  : '—',
              style: _cellStyle(cs),
            ),
          ),
          Expanded(
            child: Text(
              measurement.arm != null
                  ? '${measurement.arm!.toStringAsFixed(1)} cm'
                  : '—',
              style: _cellStyle(cs),
            ),
          ),
          Expanded(
            child: Text(
              measurement.thigh != null
                  ? '${measurement.thigh!.toStringAsFixed(1)} cm'
                  : '—',
              style: _cellStyle(cs),
            ),
          ),
          Expanded(
            child: Text(
              measurement.chest != null
                  ? '${measurement.chest!.toStringAsFixed(1)} cm'
                  : '—',
              style: _cellStyle(cs),
            ),
          ),
          Expanded(
            child: Text(
              measurement.waist != null
                  ? '${measurement.waist!.toStringAsFixed(1)} cm'
                  : '—',
              style: _cellStyle(cs),
            ),
          ),
          Expanded(
            child: Text(
              measurement.calf != null
                  ? '${measurement.calf!.toStringAsFixed(1)} cm'
                  : '—',
              style: _cellStyle(cs),
            ),
          ),
          Expanded(
            child: Text(
              bmi != null ? bmi!.toStringAsFixed(1) : '—',
              style: _cellStyle(cs),
            ),
          ),
          SizedBox(
            width: 40,
            child: Center(child: _DeleteButton(onPressed: onDelete)),
          ),
        ],
      ),
    );
  }

  TextStyle _cellStyle(ColorScheme cs) => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: cs.onSurface,
  );
}

// ── Compact: measurement card ─────────────────────────────────────────────────

class _MeasurementCard extends StatelessWidget {
  final Measurement measurement;
  final double? bmi;
  final VoidCallback? onDelete;

  const _MeasurementCard({required this.measurement, this.bmi, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final d = measurement.date;
    final dateStr =
        '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

    final items = <(String, String)>[
      if (measurement.weight != null)
        ('Peso', '${measurement.weight!.toStringAsFixed(1)} kg'),
      if (bmi != null) ('IMC', bmi!.toStringAsFixed(1)),
      if (measurement.bodyFat != null)
        ('Grasa', '${measurement.bodyFat!.toStringAsFixed(1)} %'),
      if (measurement.muscleMass != null)
        ('Músculo', '${measurement.muscleMass!.toStringAsFixed(1)} kg'),
      if (measurement.waist != null)
        ('Cintura', '${measurement.waist!.toStringAsFixed(1)} cm'),
      if (measurement.arm != null)
        ('Brazo', '${measurement.arm!.toStringAsFixed(1)} cm'),
      if (measurement.chest != null)
        ('Pecho', '${measurement.chest!.toStringAsFixed(1)} cm'),
      if (measurement.thigh != null)
        ('Muslo', '${measurement.thigh!.toStringAsFixed(1)} cm'),
      if (measurement.calf != null)
        ('Pantorrilla', '${measurement.calf!.toStringAsFixed(1)} cm'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: clientsBorderRadius,
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header: date + delete ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
            child: Row(
              children: [
                Text(
                  dateStr,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: cs.onSurfaceVariant,
                  ),
                  style: IconButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: const Size(36, 36),
                  ),
                ),
              ],
            ),
          ),
          if (items.isNotEmpty) ...[
            Divider(height: 1, thickness: 1, color: cs.outlineVariant),
            // ── Metrics: 2-column grid ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final colWidth = (constraints.maxWidth - 16) / 2;
                  return Wrap(
                    spacing: 16,
                    runSpacing: 12,
                    children: [
                      for (final (label, value) in items)
                        SizedBox(
                          width: colWidth,
                          child: _MetricItem(label: label, value: value),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final String label;
  final String value;

  const _MetricItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: cs.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
          ),
        ),
      ],
    );
  }
}

// ── Delete button with hover animation ───────────────────────────────────────

class _DeleteButton extends StatefulWidget {
  final VoidCallback? onPressed;

  const _DeleteButton({this.onPressed});

  @override
  State<_DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<_DeleteButton>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late final AnimationController _controller;
  late final Animation<double> _scale;

  static const _red = Color(0xFFD94A4A);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scale = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
        reverseCurve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final enabled = widget.onPressed != null;

    return Tooltip(
      message: 'Eliminar medición',
      child: MouseRegion(
        cursor: enabled ? SystemMouseCursors.click : MouseCursor.defer,
        onEnter: enabled
            ? (_) {
                setState(() => _hovered = true);
                _controller.forward();
              }
            : null,
        onExit: enabled
            ? (_) {
                setState(() => _hovered = false);
                _controller.reverse();
              }
            : null,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedBuilder(
            animation: _scale,
            builder: (context, child) =>
                Transform.scale(scale: _scale.value, child: child),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: _hovered
                    ? _red.withValues(alpha: 0.08)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: Icon(
                  _hovered ? Icons.delete : Icons.delete_outline,
                  key: ValueKey(_hovered),
                  size: 16,
                  color: _hovered ? _red : cs.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final VoidCallback onAdd;

  const _EmptyState({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: clientsBorderRadius,
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        children: [
          Icon(
            Icons.monitor_weight_outlined,
            size: 36,
            color: cs.onSurfaceVariant.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 12),
          Text(
            'Sin mediciones registradas',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Añade la primera medición para empezar a hacer seguimiento.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: cs.onSurfaceVariant.withValues(alpha: 0.7),
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
                color: cs.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
