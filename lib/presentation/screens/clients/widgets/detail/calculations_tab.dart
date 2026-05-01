import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/application/providers/database_provider.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/domain/enums.dart';
import 'package:nutritrack/domain/models/nutrition_result.dart';
import 'package:nutritrack/domain/services/bmr_calculator.dart';
import 'package:nutritrack/domain/services/nutrition_calculator.dart';
import 'package:nutritrack/domain/services/tdee_calculator.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:nutritrack/presentation/screens/clients/helpers/clients_formatters.dart';

// ── Main tab widget ───────────────────────────────────────────────────────────

class CalculationsTab extends ConsumerStatefulWidget {
  final int clientId;
  final Client client;
  final Measurement? latestMeasurement;
  final AnamnesisTableData? anamnesis;

  const CalculationsTab({
    super.key,
    required this.clientId,
    required this.client,
    required this.latestMeasurement,
    required this.anamnesis,
  });

  @override
  ConsumerState<CalculationsTab> createState() => _CalculationsTabState();
}

class _CalculationsTabState extends ConsumerState<CalculationsTab> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _proteinPerKgController = TextEditingController(text: '2.0');
  final _fatPerKgController = TextEditingController(text: '0.9');

  GoalType _goalType = GoalType.maintenance;
  BmrFormula _formula = BmrFormula.mifflinStJeor;
  PhysicalActivity? _activity;
  bool _saving = false;

  int? _age;
  Sex? _sex;

  @override
  void initState() {
    super.initState();
    final w = widget.latestMeasurement?.weight;
    if (w != null) _weightController.text = w.toStringAsFixed(1);
    final h = widget.client.height;
    if (h != null) _heightController.text = h.toString();
    _age = calculateClientAge(widget.client.birthDate);
    _sex = widget.client.sex;
    _activity = widget.anamnesis?.physicalActivity;

    _weightController.addListener(_onChanged);
    _heightController.addListener(_onChanged);
    _proteinPerKgController.addListener(_onChanged);
    _fatPerKgController.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    _weightController.removeListener(_onChanged);
    _heightController.removeListener(_onChanged);
    _proteinPerKgController.removeListener(_onChanged);
    _fatPerKgController.removeListener(_onChanged);
    _weightController.dispose();
    _heightController.dispose();
    _proteinPerKgController.dispose();
    _fatPerKgController.dispose();
    super.dispose();
  }

  NutritionResult? get _result {
    final weight = double.tryParse(_weightController.text.trim());
    final height = int.tryParse(_heightController.text.trim());
    final proteinPerKg =
        double.tryParse(_proteinPerKgController.text.trim()) ?? 2.0;
    final fatPerKg =
        double.tryParse(_fatPerKgController.text.trim()) ?? 0.9;

    final bmr = calculateBmr(
      weightKg: weight,
      heightCm: height,
      age: _age,
      sex: _sex,
      formula: _formula,
    );
    final tdee = calculateTdee(bmr: bmr, activity: _activity);
    return calculateNutrition(
      bmr: bmr,
      tdee: tdee,
      goalType: _goalType,
      weightKg: weight,
      proteinPerKg: proteinPerKg,
      fatPerKg: fatPerKg,
    );
  }

  bool get _canSave => !_saving && (_result?.isValid == true);

  Future<void> _save() async {
    final result = _result;
    if (result == null || !result.isValid) return;

    final weight = double.tryParse(_weightController.text.trim());
    final height = int.tryParse(_heightController.text.trim());
    final proteinPerKg = double.tryParse(_proteinPerKgController.text.trim());
    final fatPerKg = double.tryParse(_fatPerKgController.text.trim());

    setState(() => _saving = true);
    try {
      await ref.read(nutritionCalculationRepositoryProvider).insertCalculation(
            clientId: widget.clientId,
            goalType: _goalType,
            bmrFormula: _formula,
            bmr: result.bmr,
            tdee: result.tdee,
            kcalTarget: result.kcalTarget,
            proteins: result.proteins,
            carbohydrates: result.carbohydrates,
            fats: result.fats,
            weightUsed: weight,
            heightUsed: height,
            ageUsed: _age,
            activityFactor:
                _activity != null ? activityFactorFor(_activity!) : null,
            proteinPerKg: proteinPerKg,
            fatPerKg: fatPerKg,
          );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al guardar el cálculo. Inténtalo de nuevo.'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _confirmDelete(NutritionCalculation calc) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar cálculo'),
        content: Text(
          '¿Seguro que quieres eliminar el cálculo del ${formatDate(calc.date)}? '
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
      await ref
          .read(nutritionCalculationRepositoryProvider)
          .deleteCalculation(calc.calculationId);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al eliminar el cálculo. Inténtalo de nuevo.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final calculationsAsync =
        ref.watch(clientNutritionCalculationsProvider(widget.clientId));
    final result = _result;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Form ──────────────────────────────────────────────────────────
          _FormCard(
            goalType: _goalType,
            formula: _formula,
            activity: _activity,
            weightController: _weightController,
            heightController: _heightController,
            proteinPerKgController: _proteinPerKgController,
            fatPerKgController: _fatPerKgController,
            saving: _saving,
            onGoalTypeChanged: (g) => setState(() => _goalType = g),
            onFormulaChanged: (f) => setState(() => _formula = f),
            onActivityChanged: (a) => setState(() => _activity = a),
          ),
          const SizedBox(height: 16),

          // ── Results ───────────────────────────────────────────────────────
          _ResultsCard(
            result: result,
            saving: _saving,
            canSave: _canSave,
            onSave: _save,
          ),
          const SizedBox(height: 20),

          // ── History header ────────────────────────────────────────────────
          Text(
            'Historial de cálculos',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 12),

          // ── History list ──────────────────────────────────────────────────
          calculationsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text(
              'Error al cargar el historial',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: cs.onSurfaceVariant,
              ),
            ),
            data: (calculations) => calculations.isEmpty
                ? const _EmptyHistoryState()
                : Column(
                    children: [
                      for (int i = 0; i < calculations.length; i++) ...[
                        _CalcHistoryCard(
                          calc: calculations[i],
                          onDelete: () => _confirmDelete(calculations[i]),
                        ),
                        if (i < calculations.length - 1)
                          const SizedBox(height: 8),
                      ],
                    ],
                  ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── Form card ──────────────────────────────────────────────────────────────────

class _FormCard extends StatelessWidget {
  final GoalType goalType;
  final BmrFormula formula;
  final PhysicalActivity? activity;
  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController proteinPerKgController;
  final TextEditingController fatPerKgController;
  final bool saving;
  final ValueChanged<GoalType> onGoalTypeChanged;
  final ValueChanged<BmrFormula> onFormulaChanged;
  final ValueChanged<PhysicalActivity?> onActivityChanged;

  const _FormCard({
    required this.goalType,
    required this.formula,
    required this.activity,
    required this.weightController,
    required this.heightController,
    required this.proteinPerKgController,
    required this.fatPerKgController,
    required this.saving,
    required this.onGoalTypeChanged,
    required this.onFormulaChanged,
    required this.onActivityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final dec = _fieldDecoration(cs);

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
          // ── GoalType chips ───────────────────────────────────────────
          Text(
            'Objetivo',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: GoalType.values.map((g) {
                final selected = g == goalType;
                final color = _goalTypeColor(g);
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: InkWell(
                    borderRadius: clientsChipBorderRadius,
                    onTap: saving ? null : () => onGoalTypeChanged(g),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: selected
                            ? color.withValues(alpha: 0.12)
                            : cs.surfaceContainerHighest,
                        borderRadius: clientsChipBorderRadius,
                        border: Border.all(
                          color: selected
                              ? color.withValues(alpha: 0.45)
                              : cs.outlineVariant,
                        ),
                      ),
                      child: Text(
                        _goalTypeLabel(g),
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight:
                              selected ? FontWeight.w600 : FontWeight.w500,
                          color: selected ? color : cs.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 14),

          // ── Weight + Height ──────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: _NumericField(
                  label: 'Peso (kg)',
                  controller: weightController,
                  enabled: !saving,
                  decimal: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _NumericField(
                  label: 'Altura (cm)',
                  controller: heightController,
                  enabled: !saving,
                  decimal: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ── Activity + Formula ───────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Actividad física',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<PhysicalActivity?>(
                      initialValue: activity,
                      decoration: dec,
                      style: GoogleFonts.inter(
                          fontSize: 14, color: cs.onSurface),
                      onChanged: saving ? null : onActivityChanged,
                      items: [
                        DropdownMenuItem<PhysicalActivity?>(
                          value: null,
                          child: Text(
                            '—',
                            style: GoogleFonts.inter(
                                fontSize: 14, color: cs.onSurface),
                          ),
                        ),
                        ...PhysicalActivity.values.map(
                          (a) => DropdownMenuItem<PhysicalActivity?>(
                            value: a,
                            child: Text(
                              a.label,
                              style: GoogleFonts.inter(
                                  fontSize: 14, color: cs.onSurface),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fórmula TMB',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<BmrFormula>(
                      initialValue: formula,
                      decoration: dec,
                      style: GoogleFonts.inter(
                          fontSize: 14, color: cs.onSurface),
                      onChanged: saving
                          ? null
                          : (v) {
                              if (v != null) onFormulaChanged(v);
                            },
                      items: BmrFormula.values
                          .map(
                            (f) => DropdownMenuItem<BmrFormula>(
                              value: f,
                              child: Text(
                                _bmrFormulaLabel(f),
                                style: GoogleFonts.inter(
                                    fontSize: 14, color: cs.onSurface),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ── Protein + Fat per kg ─────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: _NumericField(
                  label: 'Proteína (g/kg)',
                  controller: proteinPerKgController,
                  enabled: !saving,
                  decimal: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _NumericField(
                  label: 'Grasa (g/kg)',
                  controller: fatPerKgController,
                  enabled: !saving,
                  decimal: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Results card ──────────────────────────────────────────────────────────────

class _ResultsCard extends StatelessWidget {
  final NutritionResult? result;
  final bool saving;
  final bool canSave;
  final VoidCallback onSave;

  const _ResultsCard({
    required this.result,
    required this.saving,
    required this.canSave,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final hasResult = result != null && result!.isValid;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: hasResult
            ? cs.primaryContainer.withValues(alpha: 0.35)
            : cs.surface,
        borderRadius: clientsBorderRadius,
        border: Border.all(
          color: hasResult
              ? cs.primary.withValues(alpha: 0.25)
              : cs.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Resultados',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                ),
              ),
              const Spacer(),
              if (!hasResult)
                Text(
                  'Completa los datos para calcular',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: cs.onSurfaceVariant,
                  ),
                ),
            ],
          ),
          if (hasResult) ...[
            const SizedBox(height: 14),
            // ── Energy row ───────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _ResultItem(
                    label: 'TMB',
                    value: '${result!.bmr.toStringAsFixed(0)} kcal',
                  ),
                ),
                Expanded(
                  child: _ResultItem(
                    label: 'TDEE',
                    value: '${result!.tdee.toStringAsFixed(0)} kcal',
                  ),
                ),
                Expanded(
                  child: _ResultItem(
                    label: 'Objetivo',
                    value: '${result!.kcalTarget.toStringAsFixed(0)} kcal',
                    highlighted: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // ── Macros row ───────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _ResultItem(
                    label: 'Proteínas',
                    value: '${result!.proteins.toStringAsFixed(1)} g',
                    sub: '${result!.proteinKcal.toStringAsFixed(0)} kcal',
                  ),
                ),
                Expanded(
                  child: _ResultItem(
                    label: 'Grasas',
                    value: '${result!.fats.toStringAsFixed(1)} g',
                    sub: '${result!.fatKcal.toStringAsFixed(0)} kcal',
                  ),
                ),
                Expanded(
                  child: _ResultItem(
                    label: 'Carbohidratos',
                    value: '${result!.carbohydrates.toStringAsFixed(1)} g',
                    sub: '${result!.carbKcal.toStringAsFixed(0)} kcal',
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: clientsButtonHeight,
              child: ElevatedButton.icon(
                onPressed: canSave ? onSave : null,
                icon: saving
                    ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.save_outlined, size: 15),
                label: Text(
                  'Guardar cálculo',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
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
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultItem extends StatelessWidget {
  final String label;
  final String value;
  final String? sub;
  final bool highlighted;

  const _ResultItem({
    required this.label,
    required this.value,
    this.sub,
    this.highlighted = false,
  });

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
            fontSize: highlighted ? 16 : 14,
            fontWeight: FontWeight.w700,
            color: highlighted ? cs.primary : cs.onSurface,
          ),
        ),
        if (sub != null)
          Text(
            sub!,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: cs.onSurfaceVariant,
            ),
          ),
      ],
    );
  }
}

// ── History card ──────────────────────────────────────────────────────────────

class _CalcHistoryCard extends StatelessWidget {
  final NutritionCalculation calc;
  final VoidCallback onDelete;

  const _CalcHistoryCard({required this.calc, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final goalColor = _goalTypeColor(calc.goalType);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: clientsBorderRadius,
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header: badge + formula + date + delete ─────────────────
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: goalColor.withValues(alpha: 0.12),
                  borderRadius: clientsChipBorderRadius,
                ),
                child: Text(
                  _goalTypeLabel(calc.goalType),
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: goalColor,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _bmrFormulaLabel(calc.bmrFormula),
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: cs.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Text(
                formatDate(calc.date),
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: cs.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 8),
              _DeleteButton(onPressed: onDelete),
            ],
          ),
          const SizedBox(height: 10),

          // ── Values: kcal + macros ────────────────────────────────────
          Row(
            children: [
              _HistoryValue(
                label: 'Objetivo',
                value: '${calc.kcalTarget.toStringAsFixed(0)} kcal',
                bold: true,
              ),
              const SizedBox(width: 20),
              _HistoryValue(
                label: 'P',
                value: '${calc.proteins.toStringAsFixed(1)} g',
              ),
              const SizedBox(width: 12),
              _HistoryValue(
                label: 'G',
                value: '${calc.fats.toStringAsFixed(1)} g',
              ),
              const SizedBox(width: 12),
              _HistoryValue(
                label: 'C',
                value: '${calc.carbohydrates.toStringAsFixed(1)} g',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HistoryValue extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _HistoryValue({
    required this.label,
    required this.value,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label ',
          style: GoogleFonts.inter(fontSize: 12, color: cs.onSurfaceVariant),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
            color: bold ? cs.primary : cs.onSurface,
          ),
        ),
      ],
    );
  }
}

// ── Shared input widgets ───────────────────────────────────────────────────────

class _NumericField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool enabled;
  final bool decimal;

  const _NumericField({
    required this.label,
    required this.controller,
    required this.enabled,
    required this.decimal,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: cs.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          enabled: enabled,
          keyboardType:
              TextInputType.numberWithOptions(decimal: decimal, signed: false),
          style: GoogleFonts.inter(fontSize: 14, color: cs.onSurface),
          decoration: _fieldDecoration(cs),
        ),
      ],
    );
  }
}

// ── Delete button (identical pattern to notes_tab) ────────────────────────────

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
      message: 'Eliminar cálculo',
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

// ── Empty history state ───────────────────────────────────────────────────────

class _EmptyHistoryState extends StatelessWidget {
  const _EmptyHistoryState();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: clientsBorderRadius,
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        children: [
          Icon(
            Icons.calculate_outlined,
            size: 36,
            color: cs.onSurfaceVariant.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 12),
          Text(
            'Sin cálculos guardados',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Completa el formulario y guarda para registrar un cálculo.',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: cs.onSurfaceVariant.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Shared decoration helper ──────────────────────────────────────────────────

InputDecoration _fieldDecoration(ColorScheme cs) => InputDecoration(
      isDense: true,
      filled: true,
      fillColor: cs.surfaceContainerHighest,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: clientsChipBorderRadius,
        borderSide: BorderSide(color: cs.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: clientsChipBorderRadius,
        borderSide: BorderSide(color: cs.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: clientsChipBorderRadius,
        borderSide: BorderSide(color: cs.primary.withValues(alpha: 0.7)),
      ),
    );

// ── Label / color helpers ─────────────────────────────────────────────────────

String _goalTypeLabel(GoalType type) => switch (type) {
      GoalType.deficit      => 'Déficit',
      GoalType.maintenance  => 'Mantenimiento',
      GoalType.surplus      => 'Superávit',
    };

Color _goalTypeColor(GoalType type) => switch (type) {
      GoalType.deficit      => const Color(0xFF3B82F6),
      GoalType.maintenance  => const Color(0xFF22C55E),
      GoalType.surplus      => const Color(0xFFE3A12A),
    };

String _bmrFormulaLabel(BmrFormula formula) => switch (formula) {
      BmrFormula.mifflinStJeor    => 'Mifflin-St Jeor',
      BmrFormula.harrisBenedict   => 'Harris-Benedict',
    };
