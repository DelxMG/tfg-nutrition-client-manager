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
import 'package:nutritrack/presentation/screens/clients/widgets/detail/plan_form_dialog.dart';

// ── Macro colour tokens ───────────────────────────────────────────────────────

const _kProteinColor = Color(0xFF22C55E);
const _kCarbColor    = Color(0xFFE3A12A);
const _kFatColor     = Color(0xFF3B82F6);

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
  final _weightController       = TextEditingController();
  final _heightController       = TextEditingController();
  final _ageController          = TextEditingController();
  final _proteinPerKgController = TextEditingController(text: '2.0');
  final _fatPerKgController     = TextEditingController(text: '0.9');

  GoalType _goalType      = GoalType.maintenance;
  BmrFormula _formula     = BmrFormula.mifflinStJeor;
  PhysicalActivity? _activity;
  Sex? _sex;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _prefill();
    for (final c in _controllers) { c.addListener(_onChanged); }
  }

  List<TextEditingController> get _controllers => [
        _weightController,
        _heightController,
        _ageController,
        _proteinPerKgController,
        _fatPerKgController,
      ];

  void _prefill() {
    final w = widget.latestMeasurement?.weight;
    if (w != null) _weightController.text = w.toStringAsFixed(1);
    final h = widget.client.height;
    if (h != null) _heightController.text = h.toString();
    final age = calculateClientAge(widget.client.birthDate);
    if (age != null) _ageController.text = age.toString();
    _sex      = widget.client.sex;
    _activity = widget.anamnesis?.physicalActivity;
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    for (final c in _controllers) {
      c.removeListener(_onChanged);
      c.dispose();
    }
    super.dispose();
  }

  void _reset() {
    setState(() {
      _goalType = GoalType.maintenance;
      _formula  = BmrFormula.mifflinStJeor;
      _sex      = widget.client.sex;
      _activity = widget.anamnesis?.physicalActivity;

      final w = widget.latestMeasurement?.weight;
      _weightController.text = w != null ? w.toStringAsFixed(1) : '';
      final h = widget.client.height;
      _heightController.text = h != null ? h.toString() : '';
      final age = calculateClientAge(widget.client.birthDate);
      _ageController.text          = age != null ? age.toString() : '';
      _proteinPerKgController.text = '2.0';
      _fatPerKgController.text     = '0.9';
    });
  }

  NutritionResult? get _result {
    final weight       = double.tryParse(_weightController.text.trim());
    final height       = int.tryParse(_heightController.text.trim());
    final age          = int.tryParse(_ageController.text.trim());
    final proteinPerKg = double.tryParse(_proteinPerKgController.text.trim()) ?? 2.0;
    final fatPerKg     = double.tryParse(_fatPerKgController.text.trim()) ?? 0.9;

    final bmr = calculateBmr(
      weightKg: weight, heightCm: height, age: age,
      sex: _sex, formula: _formula,
    );
    final tdee = calculateTdee(bmr: bmr, activity: _activity);
    return calculateNutrition(
      bmr: bmr, tdee: tdee, goalType: _goalType,
      weightKg: weight, proteinPerKg: proteinPerKg, fatPerKg: fatPerKg,
    );
  }

  bool get _canSave => !_saving && (_result?.isValid == true);

  Future<void> _save() async {
    final result = _result;
    if (result == null || !result.isValid) return;

    final weight       = double.tryParse(_weightController.text.trim());
    final height       = int.tryParse(_heightController.text.trim());
    final age          = int.tryParse(_ageController.text.trim());
    final proteinPerKg = double.tryParse(_proteinPerKgController.text.trim());
    final fatPerKg     = double.tryParse(_fatPerKgController.text.trim());

    setState(() => _saving = true);
    try {
      await ref.read(nutritionCalculationRepositoryProvider).insertCalculation(
        clientId:       widget.clientId,
        goalType:       _goalType,
        bmrFormula:     _formula,
        bmr:            result.bmr,
        tdee:           result.tdee,
        kcalTarget:     result.kcalTarget,
        proteins:       result.proteins,
        carbohydrates:  result.carbohydrates,
        fats:           result.fats,
        weightUsed:     weight,
        heightUsed:     height,
        ageUsed:        age,
        activityFactor: _activity != null ? activityFactorFor(_activity!) : null,
        proteinPerKg:   proteinPerKg,
        fatPerKg:       fatPerKg,
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al guardar el cálculo. Inténtalo de nuevo.')),
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
          '¿Seguro que quieres eliminar el cálculo del ${_formatDateShort(calc.date)}? '
          'Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: const Color(0xFFD94A4A)),
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
          const SnackBar(content: Text('Error al eliminar el cálculo. Inténtalo de nuevo.')),
        );
      }
    }
  }

  void _openPlanForm(NutritionCalculation calc) {
    showDialog<void>(
      context: context,
      builder: (_) => PlanFormDialog(
        clientId: widget.clientId,
        preselectedCalculationId: calc.calculationId,
      ),
    );
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
          // ── 2-column dashboard ────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left column
              Expanded(
                child: Column(
                  children: [
                    _GoalCard(
                      goalType: _goalType,
                      saving: _saving,
                      onChanged: (g) => setState(() => _goalType = g),
                    ),
                    const SizedBox(height: 12),
                    _ParametersCard(
                      weightController:      _weightController,
                      heightController:      _heightController,
                      ageController:         _ageController,
                      proteinPerKgController: _proteinPerKgController,
                      fatPerKgController:    _fatPerKgController,
                      sex:      _sex,
                      activity: _activity,
                      formula:  _formula,
                      saving:   _saving,
                      onSexChanged:      (s) => setState(() => _sex = s),
                      onActivityChanged: (a) => setState(() => _activity = a),
                      onFormulaChanged:  (f) => setState(() => _formula = f),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Right column
              Expanded(
                child: Column(
                  children: [
                    _ResultCard(result: result),
                    const SizedBox(height: 12),
                    _MacrosCard(
                      result:   result,
                      saving:   _saving,
                      canSave:  _canSave,
                      onSave:   _save,
                      onReset:  _reset,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── History ───────────────────────────────────────────────────
          Text(
            'Cálculos guardados',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          calculationsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error:   (e, _) => Text(
              'Error al cargar el historial',
              style: GoogleFonts.inter(fontSize: 14, color: cs.onSurfaceVariant),
            ),
            data: (calcs) => calcs.isEmpty
                ? const _EmptyHistoryState()
                : _HistoryTable(
                    calculations: calcs,
                    onDelete: _confirmDelete,
                    onGeneratePlan: _openPlanForm,
                  ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── _GoalCard — 3 horizontal cards ───────────────────────────────────────────

class _GoalCard extends StatelessWidget {
  final GoalType goalType;
  final bool saving;
  final ValueChanged<GoalType> onChanged;

  const _GoalCard({
    required this.goalType,
    required this.saving,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: clientsBorderRadius,
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tipo de objetivo',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: GoalType.values.asMap().entries.map((e) {
              final isLast  = e.key == GoalType.values.length - 1;
              final g       = e.value;
              final selected = goalType == g;
              final color   = _goalTypeColor(g);

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: isLast ? 0 : 10),
                  child: InkWell(
                    borderRadius: clientsBorderRadius,
                    onTap: saving ? null : () => onChanged(g),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      height: 72,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected
                            ? color.withValues(alpha: 0.08)
                            : cs.surfaceContainerHighest,
                        borderRadius: clientsBorderRadius,
                        border: Border.all(
                          color: selected ? color : cs.outlineVariant,
                          width: selected ? 1.5 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _goalTypeLabel(g),
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: selected ? color : cs.onSurface,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            _goalTypeSubtitle(g),
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ── _ParametersCard ───────────────────────────────────────────────────────────

class _ParametersCard extends StatelessWidget {
  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController ageController;
  final TextEditingController proteinPerKgController;
  final TextEditingController fatPerKgController;
  final Sex? sex;
  final PhysicalActivity? activity;
  final BmrFormula formula;
  final bool saving;
  final ValueChanged<Sex?> onSexChanged;
  final ValueChanged<PhysicalActivity?> onActivityChanged;
  final ValueChanged<BmrFormula> onFormulaChanged;

  const _ParametersCard({
    required this.weightController,
    required this.heightController,
    required this.ageController,
    required this.proteinPerKgController,
    required this.fatPerKgController,
    required this.sex,
    required this.activity,
    required this.formula,
    required this.saving,
    required this.onSexChanged,
    required this.onActivityChanged,
    required this.onFormulaChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: clientsBorderRadius,
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header: title + formula chips ────────────────────────────
          Row(
            children: [
              Text(
                'Parámetros',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                ),
              ),
              const Spacer(),
              ...BmrFormula.values.map((f) => Padding(
                padding: const EdgeInsets.only(left: 6),
                child: _SelectChip(
                  label: _bmrFormulaLabel(f),
                  selected: formula == f,
                  onTap: saving ? null : () => onFormulaChanged(f),
                ),
              )),
            ],
          ),
          const SizedBox(height: 14),

          // ── Peso | Altura | Edad ─────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: _NumericField(
                  label: 'PESO (KG)',
                  controller: weightController,
                  enabled: !saving,
                  decimal: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _NumericField(
                  label: 'ALTURA (CM)',
                  controller: heightController,
                  enabled: !saving,
                  decimal: false,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _NumericField(
                  label: 'EDAD',
                  controller: ageController,
                  enabled: !saving,
                  decimal: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // ── Género | Actividad ───────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Género chips
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _FieldLabel('GÉNERO'),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: Sex.values.map((s) {
                      final isLast = s == Sex.values.last;
                      return Padding(
                        padding: EdgeInsets.only(right: isLast ? 0 : 6),
                        child: _SelectChip(
                          label: s.label,
                          selected: sex == s,
                          onTap: saving ? null : () => onSexChanged(sex == s ? null : s),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              // Actividad chips
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _FieldLabel('NIVEL DE ACTIVIDAD'),
                    const SizedBox(height: 6),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _SelectChip(
                            label: '—',
                            selected: activity == null,
                            onTap: saving ? null : () => onActivityChanged(null),
                          ),
                          ...PhysicalActivity.values.map((a) => Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: _SelectChip(
                              label: a.label,
                              selected: activity == a,
                              onTap: saving ? null : () => onActivityChanged(a),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // ── Proteína | Grasa g/kg ────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: _NumericField(
                  label: 'PROTEÍNA (G/KG)',
                  controller: proteinPerKgController,
                  enabled: !saving,
                  decimal: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _NumericField(
                  label: 'GRASA (G/KG)',
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

// ── _ResultCard ───────────────────────────────────────────────────────────────

class _ResultCard extends StatelessWidget {
  final NutritionResult? result;

  const _ResultCard({required this.result});

  @override
  Widget build(BuildContext context) {
    final cs        = Theme.of(context).colorScheme;
    final hasResult = result != null && result!.isValid;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: clientsBorderRadius,
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────────────
          Row(
            children: [
              Icon(Icons.local_fire_department_outlined,
                  size: 16, color: cs.primary),
              const SizedBox(width: 6),
              Text(
                'Resultado',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                ),
              ),
            ],
          ),
          if (!hasResult) ...[
            const SizedBox(height: 10),
            Text(
              'Completa los datos para calcular',
              style: GoogleFonts.inter(fontSize: 12, color: cs.onSurfaceVariant),
            ),
          ] else ...[
            const SizedBox(height: 14),
            // TMB
            Row(
              children: [
                Text('TMB',
                    style: GoogleFonts.inter(fontSize: 13, color: cs.onSurface)),
                const Spacer(),
                Text(
                  '${result!.bmr.toStringAsFixed(0)} kcal',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // TDEE
            Row(
              children: [
                Text('TDEE',
                    style: GoogleFonts.inter(fontSize: 13, color: cs.onSurface)),
                const Spacer(),
                Text(
                  '${result!.tdee.toStringAsFixed(0)} kcal',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Divider(height: 1, thickness: 1, color: cs.outlineVariant),
            const SizedBox(height: 12),
            // Objetivo calórico
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Objetivo calórico',
                  style: GoogleFonts.inter(fontSize: 13, color: cs.onSurface),
                ),
                const Spacer(),
                Text(
                  '${result!.kcalTarget.toStringAsFixed(0)} kcal',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: cs.primary,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ── _MacrosCard ───────────────────────────────────────────────────────────────

class _MacrosCard extends StatelessWidget {
  final NutritionResult? result;
  final bool saving;
  final bool canSave;
  final VoidCallback onSave;
  final VoidCallback onReset;

  const _MacrosCard({
    required this.result,
    required this.saving,
    required this.canSave,
    required this.onSave,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final cs        = Theme.of(context).colorScheme;
    final hasResult = result != null && result!.isValid;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: clientsBorderRadius,
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Distribución de macros',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 12),

          if (hasResult) ...[
            _MacroBar(result: result!),
            const SizedBox(height: 14),
            _MacroRow(
              label: 'Proteína',
              grams: result!.proteins,
              kcal: result!.proteinKcal,
              totalKcal: result!.kcalTarget,
              color: _kProteinColor,
            ),
            const SizedBox(height: 8),
            _MacroRow(
              label: 'Carbohidratos',
              grams: result!.carbohydrates,
              kcal: result!.carbKcal,
              totalKcal: result!.kcalTarget,
              color: _kCarbColor,
            ),
            const SizedBox(height: 8),
            _MacroRow(
              label: 'Grasas',
              grams: result!.fats,
              kcal: result!.fatKcal,
              totalKcal: result!.kcalTarget,
              color: _kFatColor,
            ),
            const SizedBox(height: 16),
          ] else ...[
            Container(
              height: 8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest,
                borderRadius: clientsChipBorderRadius,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Completa los datos para ver la distribución',
              style: GoogleFonts.inter(fontSize: 12, color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
          ],

          // ── Buttons ──────────────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: clientsButtonHeight,
                  child: ElevatedButton.icon(
                    onPressed: canSave ? onSave : null,
                    icon: saving
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.save_outlined, size: 15),
                    label: Text(
                      'Guardar cálculo',
                      style: GoogleFonts.inter(
                          fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cs.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: const RoundedRectangleBorder(
                          borderRadius: clientsBorderRadius),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: clientsButtonHeight,
                child: OutlinedButton.icon(
                  onPressed: saving ? null : onReset,
                  icon: const Icon(Icons.refresh_rounded, size: 15),
                  label: Text(
                    'Reset',
                    style: GoogleFonts.inter(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: cs.onSurfaceVariant,
                    side: BorderSide(color: cs.outlineVariant),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    shape: const RoundedRectangleBorder(
                        borderRadius: clientsBorderRadius),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── _MacroBar ─────────────────────────────────────────────────────────────────

class _MacroBar extends StatelessWidget {
  final NutritionResult result;

  const _MacroBar({required this.result});

  @override
  Widget build(BuildContext context) {
    final target = result.kcalTarget;
    if (target <= 0) return const SizedBox.shrink();

    final proteinRatio = (result.proteinKcal / target).clamp(0.01, 0.97);
    final carbRatio    = (result.carbKcal    / target).clamp(0.01, 0.97);
    final fatRatio     = (1.0 - proteinRatio - carbRatio).clamp(0.01, 0.97);

    return ClipRRect(
      borderRadius: clientsChipBorderRadius,
      child: SizedBox(
        height: 12,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  width: proteinRatio * w,
                  color: _kProteinColor,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  width: carbRatio * w,
                  color: _kCarbColor,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  width: fatRatio * w,
                  color: _kFatColor,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ── _MacroRow — dot | label | kcal | % | grams ───────────────────────────────

class _MacroRow extends StatelessWidget {
  final String label;
  final double grams;
  final double kcal;
  final double totalKcal;
  final Color color;

  const _MacroRow({
    required this.label,
    required this.grams,
    required this.kcal,
    required this.totalKcal,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cs  = Theme.of(context).colorScheme;
    final pct = totalKcal > 0 ? (kcal / totalKcal * 100).round() : 0;

    return Row(
      children: [
        // Dot
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        // Label
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(fontSize: 13, color: cs.onSurface),
          ),
        ),
        // kcal
        Text(
          '${kcal.toStringAsFixed(0)} kcal',
          style: GoogleFonts.inter(fontSize: 12, color: cs.onSurfaceVariant),
        ),
        const SizedBox(width: 10),
        // %
        SizedBox(
          width: 32,
          child: Text(
            '$pct%',
            style: GoogleFonts.inter(
                fontSize: 12, color: cs.onSurfaceVariant),
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(width: 12),
        // Grams — bold, slightly larger, right-aligned
        SizedBox(
          width: 44,
          child: Text(
            '${grams.toStringAsFixed(0)}g',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

// ── History table ─────────────────────────────────────────────────────────────

class _HistoryTable extends StatelessWidget {
  final List<NutritionCalculation> calculations;
  final Future<void> Function(NutritionCalculation) onDelete;
  final void Function(NutritionCalculation) onGeneratePlan;

  const _HistoryTable({
    required this.calculations,
    required this.onDelete,
    required this.onGeneratePlan,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: clientsBorderRadius,
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        children: [
          // ── Header ───────────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: const [
                Expanded(flex: 2, child: _HeaderCell('FECHA')),
                Expanded(flex: 2, child: _HeaderCell('OBJETIVO')),
                Expanded(flex: 1, child: _HeaderCell('TMB')),
                Expanded(flex: 1, child: _HeaderCell('TDEE')),
                Expanded(flex: 2, child: _HeaderCell('KCAL OBJETIVO')),
                Expanded(flex: 1, child: _HeaderCell('PROTEÍNA')),
                Expanded(flex: 1, child: _HeaderCell('CARBOS')),
                Expanded(flex: 1, child: _HeaderCell('GRASA')),
                SizedBox(width: 60),
              ],
            ),
          ),
          // ── Data rows ────────────────────────────────────────────────
          for (int i = 0; i < calculations.length; i++) ...[
            Divider(height: 1, thickness: 1, color: cs.outlineVariant),
            _HistoryRow(
              calc: calculations[i],
              onDelete: () => onDelete(calculations[i]),
              onGeneratePlan: () => onGeneratePlan(calculations[i]),
            ),
          ],
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;

  const _HeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: cs.onSurfaceVariant,
        letterSpacing: 0.3,
      ),
    );
  }
}

class _HistoryRow extends StatelessWidget {
  final NutritionCalculation calc;
  final VoidCallback onDelete;
  final VoidCallback onGeneratePlan;

  const _HistoryRow({
    required this.calc,
    required this.onDelete,
    required this.onGeneratePlan,
  });

  @override
  Widget build(BuildContext context) {
    final cs        = Theme.of(context).colorScheme;
    final goalColor = _goalTypeColor(calc.goalType);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          // FECHA — teal
          Expanded(
            flex: 2,
            child: Text(
              _formatDateShort(calc.date),
              style: GoogleFonts.inter(
                fontSize: 13,
                color: cs.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // OBJETIVO badge
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: goalColor.withValues(alpha: 0.10),
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
            ),
          ),
          // TMB
          Expanded(
            flex: 1,
            child: Text(
              calc.bmr.toStringAsFixed(0),
              style: GoogleFonts.inter(fontSize: 13, color: cs.onSurface),
            ),
          ),
          // TDEE
          Expanded(
            flex: 1,
            child: Text(
              calc.tdee.toStringAsFixed(0),
              style: GoogleFonts.inter(fontSize: 13, color: cs.onSurface),
            ),
          ),
          // KCAL OBJETIVO — teal
          Expanded(
            flex: 2,
            child: Text(
              calc.kcalTarget.toStringAsFixed(0),
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: cs.primary,
              ),
            ),
          ),
          // PROTEÍNA
          Expanded(
            flex: 1,
            child: Text(
              '${calc.proteins.toStringAsFixed(0)}g',
              style: GoogleFonts.inter(fontSize: 13, color: cs.onSurface),
            ),
          ),
          // CARBOS
          Expanded(
            flex: 1,
            child: Text(
              '${calc.carbohydrates.toStringAsFixed(0)}g',
              style: GoogleFonts.inter(fontSize: 13, color: cs.onSurface),
            ),
          ),
          // GRASA
          Expanded(
            flex: 1,
            child: Text(
              '${calc.fats.toStringAsFixed(0)}g',
              style: GoogleFonts.inter(fontSize: 13, color: cs.onSurface),
            ),
          ),
          // Generar plan
          IconButton(
            icon: const Icon(Icons.assignment_outlined),
            iconSize: 18,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
            tooltip: 'Generar plan',
            onPressed: onGeneratePlan,
          ),
          const SizedBox(width: 4),
          // Delete
          _DeleteButton(onPressed: onDelete),
        ],
      ),
    );
  }
}

// ── Delete button ─────────────────────────────────────────────────────────────

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
        vsync: this, duration: const Duration(milliseconds: 200));
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
    final cs      = Theme.of(context).colorScheme;
    final enabled = widget.onPressed != null;

    return Tooltip(
      message: 'Eliminar cálculo',
      child: MouseRegion(
        cursor: enabled ? SystemMouseCursors.click : MouseCursor.defer,
        onEnter: enabled
            ? (_) { setState(() => _hovered = true);  _controller.forward(); }
            : null,
        onExit: enabled
            ? (_) { setState(() => _hovered = false); _controller.reverse(); }
            : null,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedBuilder(
            animation: _scale,
            builder: (context, child) =>
                Transform.scale(scale: _scale.value, child: child),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 28, height: 28,
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
          Icon(Icons.calculate_outlined,
              size: 36,
              color: cs.onSurfaceVariant.withValues(alpha: 0.4)),
          const SizedBox(height: 12),
          Text(
            'Sin cálculos guardados',
            style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 4),
          Text(
            'Completa el formulario y guarda para registrar un cálculo.',
            style: GoogleFonts.inter(
                fontSize: 13,
                color: cs.onSurfaceVariant.withValues(alpha: 0.7)),
          ),
        ],
      ),
    );
  }
}

// ── Shared input widgets ──────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String label;

  const _FieldLabel(this.label);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(
      label,
      style: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: cs.onSurfaceVariant,
        letterSpacing: 0.4,
      ),
    );
  }
}

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
        _FieldLabel(label),
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

class _SelectChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const _SelectChip({
    required this.label,
    required this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs    = Theme.of(context).colorScheme;
    final color = cs.primary;

    return InkWell(
      borderRadius: clientsChipBorderRadius,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: selected
              ? color.withValues(alpha: 0.10)
              : Colors.transparent,
          borderRadius: clientsChipBorderRadius,
          border: Border.all(
            color: selected ? color : cs.outlineVariant,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected ? color : cs.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

// ── Shared decoration helper ──────────────────────────────────────────────────

InputDecoration _fieldDecoration(ColorScheme cs) => InputDecoration(
      isDense: true,
      filled: true,
      fillColor: cs.surfaceContainerHighest,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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

// ── Date / label helpers ──────────────────────────────────────────────────────

String _formatDateShort(DateTime d) {
  const months = [
    'ene', 'feb', 'mar', 'abr', 'may', 'jun',
    'jul', 'ago', 'sep', 'oct', 'nov', 'dic',
  ];
  return '${d.day} ${months[d.month - 1]} ${d.year}';
}

String _goalTypeLabel(GoalType type) => switch (type) {
      GoalType.deficit     => 'Déficit',
      GoalType.maintenance => 'Mantenimiento',
      GoalType.surplus     => 'Superávit',
    };

String _goalTypeSubtitle(GoalType type) => switch (type) {
      GoalType.deficit     => '-10% TDEE',
      GoalType.maintenance => '= TDEE',
      GoalType.surplus     => '+10% TDEE',
    };

Color _goalTypeColor(GoalType type) => switch (type) {
      GoalType.deficit     => const Color(0xFF3B82F6),
      GoalType.maintenance => const Color(0xFF22C55E),
      GoalType.surplus     => const Color(0xFFE3A12A),
    };

String _bmrFormulaLabel(BmrFormula formula) => switch (formula) {
      BmrFormula.mifflinStJeor  => 'Mifflin-St Jeor',
      BmrFormula.harrisBenedict => 'Harris-Benedict',
    };
