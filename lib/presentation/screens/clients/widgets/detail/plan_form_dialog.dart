import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/application/providers/database_provider.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/domain/enums.dart';
import 'package:nutritrack/presentation/layout/responsive_utils.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:path/path.dart' as p;

// ── Helpers ───────────────────────────────────────────────────────────────────

extension _PlanStatusX on PlanStatus {
  String get label => switch (this) {
        PlanStatus.draft    => 'Borrador',
        PlanStatus.active   => 'Activo',
        PlanStatus.archived => 'Archivado',
      };

  Color get color => switch (this) {
        PlanStatus.draft    => const Color(0xFFE3A12A),
        PlanStatus.active   => const Color(0xFF22C55E),
        PlanStatus.archived => const Color(0xFF9E9E9E),
      };
}

extension _GoalTypeX on GoalType {
  String get label => switch (this) {
        GoalType.deficit     => 'Déficit',
        GoalType.maintenance => 'Mantenimiento',
        GoalType.surplus     => 'Superávit',
      };

  Color get color => switch (this) {
        GoalType.deficit     => const Color(0xFF3B82F6),
        GoalType.maintenance => const Color(0xFF22C55E),
        GoalType.surplus     => const Color(0xFFE3A12A),
      };
}

String _fmtDate(DateTime d) {
  const months = [
    'ene', 'feb', 'mar', 'abr', 'may', 'jun',
    'jul', 'ago', 'sep', 'oct', 'nov', 'dic',
  ];
  return '${d.day} ${months[d.month - 1]} ${d.year}';
}

// ── PlanFormDialog ────────────────────────────────────────────────────────────

class PlanFormDialog extends ConsumerStatefulWidget {
  final int clientId;
  final int? preselectedCalculationId;
  final NutritionPlan? existingPlan;

  const PlanFormDialog({
    super.key,
    required this.clientId,
    this.preselectedCalculationId,
    this.existingPlan,
  });

  @override
  ConsumerState<PlanFormDialog> createState() => _PlanFormDialogState();
}

class _PlanFormDialogState extends ConsumerState<PlanFormDialog> {
  final _formKey   = GlobalKey<FormState>();
  final _nameCtrl  = TextEditingController();
  final _descCtrl  = TextEditingController();
  final _mealsCtrl = TextEditingController();
  final _kcalCtrl  = TextEditingController();

  int?       _selectedCalculationId;
  PlanStatus _status         = PlanStatus.draft;
  GoalType?  _goalType;
  bool       _goalTypeError  = false;
  String?    _pdfPath;
  bool       _saving         = false;

  @override
  void initState() {
    super.initState();
    _selectedCalculationId =
        widget.preselectedCalculationId ?? widget.existingPlan?.calculationId;

    final ex = widget.existingPlan;
    if (ex != null) {
      _nameCtrl.text  = ex.name;
      _descCtrl.text  = ex.description ?? '';
      _mealsCtrl.text = ex.mealsCount?.toString() ?? '';
      _status         = ex.status;
      _goalType       = ex.goalType;
      _pdfPath        = ex.pdfFile;
      if (ex.calculationId == null && ex.kcalSnapshot != null) {
        _kcalCtrl.text = ex.kcalSnapshot!.toStringAsFixed(0);
      }
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _mealsCtrl.dispose();
    _kcalCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() => _pdfPath = result.files.single.path);
    }
  }

  Future<void> _save(List<NutritionCalculation> calculations) async {
    final isManual         = _selectedCalculationId == null;
    final hasGoalTypeError = isManual && _goalType == null;

    if (hasGoalTypeError) setState(() => _goalTypeError = true);
    if (!_formKey.currentState!.validate() || hasGoalTypeError) return;

    setState(() => _saving = true);

    final name       = _nameCtrl.text.trim();
    final mealsCount = int.tryParse(_mealsCtrl.text.trim());
    final desc       = _descCtrl.text.trim().isEmpty
        ? null
        : _descCtrl.text.trim();

    NutritionCalculation? selectedCalc;
    if (_selectedCalculationId != null) {
      final idx = calculations.indexWhere(
        (c) => c.calculationId == _selectedCalculationId,
      );
      if (idx >= 0) selectedCalc = calculations[idx];
    }

    final kcalSnapshot = selectedCalc?.kcalTarget
        ?? double.tryParse(_kcalCtrl.text.trim());
    final goalType = selectedCalc?.goalType ?? _goalType;

    final repo = ref.read(nutritionPlanRepositoryProvider);

    try {
      if (widget.existingPlan == null) {
        await repo.insertPlan(
          clientId: widget.clientId,
          calculationId: _selectedCalculationId,
          name: name,
          status: _status,
          description: desc,
          mealsCount: mealsCount,
          kcalSnapshot: kcalSnapshot,
          goalType: goalType,
          pdfFile: _pdfPath,
        );
      } else {
        await repo.updatePlan(
          widget.existingPlan!.planId,
          name: name,
          status: _status,
          description: desc,
          mealsCount: mealsCount,
          kcalSnapshot: kcalSnapshot,
          goalType: _goalType,
          pdfFile: _pdfPath,
        );
      }
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs     = Theme.of(context).colorScheme;
    final isEdit = widget.existingPlan != null;

    final calculations = ref
        .watch(clientNutritionCalculationsProvider(widget.clientId))
        .maybeWhen(data: (c) => c, orElse: () => <NutritionCalculation>[]);

    NutritionCalculation? selectedCalc;
    if (_selectedCalculationId != null) {
      final idx = calculations.indexWhere(
        (c) => c.calculationId == _selectedCalculationId,
      );
      if (idx >= 0) selectedCalc = calculations[idx];
    }

    final compact = context.isCompact;
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardBottom = MediaQuery.of(context).viewInsets.bottom;

    return Dialog(
      backgroundColor: cs.surface,
      shape: const RoundedRectangleBorder(borderRadius: clientsBorderRadius),
      insetPadding: EdgeInsets.symmetric(
        horizontal: compact ? 16.0 : 40.0,
        vertical: 24,
      ),
      child: SizedBox(
        width: compact ? double.infinity : 580,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: compact ? screenHeight - 48 : 680,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ───────────────────────────────────────────────
                _DialogHeader(
                  title: isEdit ? 'Editar plan' : 'Nuevo plan',
                  onClose: _saving ? null : () => Navigator.of(context).pop(),
                ),

                // ── Body ─────────────────────────────────────────────────
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(28, 20, 28, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nombre
                        _Field(
                          label: 'Nombre *',
                          child: TextFormField(
                            controller: _nameCtrl,
                            enabled: !_saving,
                            decoration: _dec('Ej. Plan verano 2026', cs),
                            autofocus: true,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'El nombre es obligatorio'
                                : null,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Descripción
                        _Field(
                          label: 'Descripción',
                          child: TextFormField(
                            controller: _descCtrl,
                            enabled: !_saving,
                            decoration:
                                _dec('Descripción breve (opcional)', cs),
                            minLines: 2,
                            maxLines: 3,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Estado
                        _Field(
                          label: 'Estado',
                          child: Row(
                            children: [
                              for (final s in PlanStatus.values)
                                Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: _SelectChip(
                                    label: s.label,
                                    selected: _status == s,
                                    color: s.color,
                                    onTap: _saving
                                        ? null
                                        : () => setState(() => _status = s),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Comidas/día + Cálculo base
                        if (compact)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _Field(
                                label: 'Comidas/día',
                                child: TextFormField(
                                  controller: _mealsCtrl,
                                  enabled: !_saving,
                                  decoration: _dec('Ej. 5', cs),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              _Field(
                                label: 'Cálculo base',
                                child: InputDecorator(
                                  decoration: _dec(null, cs).copyWith(
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(12, 4, 4, 4),
                                    enabled: !isEdit,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<int?>(
                                      value: _selectedCalculationId,
                                      isDense: true,
                                      isExpanded: true,
                                      onChanged: isEdit || _saving
                                          ? null
                                          : (v) => setState(() {
                                                _selectedCalculationId = v;
                                                if (v != null) {
                                                  _kcalCtrl.clear();
                                                  _goalType      = null;
                                                  _goalTypeError = false;
                                                }
                                              }),
                                      items: [
                                        DropdownMenuItem<int?>(
                                          value: null,
                                          child: Text(
                                            'Manual (sin cálculo)',
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              color: cs.onSurface,
                                            ),
                                          ),
                                        ),
                                        for (final c in calculations)
                                          DropdownMenuItem<int?>(
                                            value: c.calculationId,
                                            child: Text(
                                              '${_fmtDate(c.date)} · ${c.kcalTarget.toStringAsFixed(0)} kcal',
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                color: cs.onSurface,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        else
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 130,
                              child: _Field(
                                label: 'Comidas/día',
                                child: TextFormField(
                                  controller: _mealsCtrl,
                                  enabled: !_saving,
                                  decoration: _dec('Ej. 5', cs),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _Field(
                                label: 'Cálculo base',
                                child: InputDecorator(
                                  decoration: _dec(null, cs).copyWith(
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(12, 4, 4, 4),
                                    enabled: !isEdit,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<int?>(
                                      value: _selectedCalculationId,
                                      isDense: true,
                                      isExpanded: true,
                                      onChanged: isEdit || _saving
                                          ? null
                                          : (v) => setState(() {
                                                _selectedCalculationId = v;
                                                if (v != null) {
                                                  _kcalCtrl.clear();
                                                  _goalType      = null;
                                                  _goalTypeError = false;
                                                }
                                              }),
                                      items: [
                                        DropdownMenuItem<int?>(
                                          value: null,
                                          child: Text(
                                            'Manual (sin cálculo)',
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              color: cs.onSurface,
                                            ),
                                          ),
                                        ),
                                        for (final c in calculations)
                                          DropdownMenuItem<int?>(
                                            value: c.calculationId,
                                            child: Text(
                                              '${_fmtDate(c.date)} · ${c.kcalTarget.toStringAsFixed(0)} kcal',
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                color: cs.onSurface,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Kcal + GoalType
                        if (selectedCalc != null)
                          _KcalInfoRow(calculation: selectedCalc, cs: cs)
                        else ...[
                          _Field(
                            label: 'Kcal objetivo / día *',
                            child: TextFormField(
                              controller: _kcalCtrl,
                              enabled: !_saving,
                              decoration: _dec('Ej. 2.000', cs).copyWith(
                                suffixText: 'kcal',
                                suffixStyle: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: cs.onSurfaceVariant,
                                ),
                              ),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.]'),
                                ),
                              ],
                              validator: (v) =>
                                  (v == null || v.trim().isEmpty)
                                      ? 'Campo obligatorio'
                                      : null,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _Field(
                            label: 'Objetivo *',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    for (final g in GoalType.values) ...[
                                      _SelectChip(
                                        label: g.label,
                                        selected: _goalType == g,
                                        color: g.color,
                                        onTap: _saving
                                            ? null
                                            : () => setState(() {
                                                  _goalType      = g;
                                                  _goalTypeError = false;
                                                }),
                                      ),
                                      if (g != GoalType.values.last)
                                        const SizedBox(width: 6),
                                    ],
                                  ],
                                ),
                                if (_goalTypeError) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    'Selecciona un objetivo',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: const Color(0xFFE57373),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 16),

                        // PDF
                        _Field(
                          label: 'PDF adjunto',
                          child: _pdfPath == null
                              ? SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child: OutlinedButton.icon(
                                    icon: const Icon(
                                      Icons.upload_file_outlined,
                                      size: 16,
                                    ),
                                    label: Text(
                                      'Subir PDF',
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    onPressed: _saving ? null : _pickPdf,
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: cs.outlineVariant,
                                      ),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: clientsChipBorderRadius,
                                      ),
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 40,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: cs.surfaceContainerHighest,
                                          border: Border.all(
                                            color: cs.outlineVariant,
                                          ),
                                          borderRadius: clientsChipBorderRadius,
                                        ),
                                        child: Text(
                                          p.basename(_pdfPath!),
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            color: cs.onSurface,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    SizedBox(
                                      height: 40,
                                      child: OutlinedButton.icon(
                                        icon: Icon(
                                          Icons.delete_outline,
                                          size: 16,
                                          color: cs.error,
                                        ),
                                        label: Text(
                                          'Eliminar PDF',
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: cs.error,
                                          ),
                                        ),
                                        onPressed: _saving
                                            ? null
                                            : () => setState(
                                                  () => _pdfPath = null,
                                                ),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: cs.error,
                                          side: BorderSide(
                                            color: cs.error.withValues(
                                              alpha: 0.4,
                                            ),
                                          ),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: clientsChipBorderRadius,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        SizedBox(height: keyboardBottom > 0 ? keyboardBottom : 24),
                      ],
                    ),
                  ),
                ),

                // ── Footer ───────────────────────────────────────────────
                _DialogFooter(
                  saving: _saving,
                  saveLabel: isEdit ? 'Guardar cambios' : 'Crear plan',
                  onCancel: _saving ? null : () => Navigator.of(context).pop(),
                  onSave: () => _save(calculations),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Kcal info row ─────────────────────────────────────────────────────────────

class _KcalInfoRow extends StatelessWidget {
  final NutritionCalculation calculation;
  final ColorScheme cs;

  const _KcalInfoRow({required this.calculation, required this.cs});

  @override
  Widget build(BuildContext context) {
    final goalType = calculation.goalType;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kcal objetivo / día',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: clientsChipBorderRadius,
          ),
          child: Row(
            children: [
              Icon(
                Icons.local_fire_department_outlined,
                size: 15,
                color: cs.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Text(
                '${calculation.kcalTarget.toStringAsFixed(0)} kcal/día',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: goalType.color.withValues(alpha: 0.10),
                  borderRadius: clientsChipBorderRadius,
                ),
                child: Text(
                  goalType.label,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: goalType.color,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'Del cálculo del ${_fmtDate(calculation.date)}',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Select chip (status / goal type) ─────────────────────────────────────────

class _SelectChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback? onTap;

  const _SelectChip({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: clientsChipBorderRadius,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color:
              selected ? color.withValues(alpha: 0.10) : Colors.transparent,
          borderRadius: clientsChipBorderRadius,
          border: Border.all(
            color: selected ? color : cs.outlineVariant,
            width: selected ? 1.5 : 1.0,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected ? color : cs.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

// ── Dialog header ─────────────────────────────────────────────────────────────

class _DialogHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onClose;

  const _DialogHeader({required this.title, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 0),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close, size: 20),
            color: cs.onSurfaceVariant,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

// ── Dialog footer ─────────────────────────────────────────────────────────────

class _DialogFooter extends StatelessWidget {
  final bool saving;
  final String saveLabel;
  final VoidCallback? onCancel;
  final VoidCallback? onSave;

  const _DialogFooter({
    required this.saving,
    required this.saveLabel,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 12, 28, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: onCancel,
            child: Text(
              'Cancelar',
              style: GoogleFonts.inter(
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: clientsButtonHeight,
            child: ElevatedButton(
              onPressed: saving ? null : onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor: cs.primary.withValues(alpha: 0.4),
                disabledForegroundColor: Colors.white70,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: const RoundedRectangleBorder(
                  borderRadius: clientsBorderRadius,
                ),
              ),
              child: saving
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      saveLabel,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Field wrapper ─────────────────────────────────────────────────────────────

class _Field extends StatelessWidget {
  final String label;
  final Widget child;

  const _Field({required this.label, required this.child});

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
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        child,
      ],
    );
  }
}

// ── Input decoration ──────────────────────────────────────────────────────────

InputDecoration _dec(String? hint, ColorScheme cs) {
  return InputDecoration(
    hintText: hint,
    hintStyle: GoogleFonts.inter(fontSize: 14, color: cs.onSurfaceVariant),
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
    errorBorder: OutlineInputBorder(
      borderRadius: clientsChipBorderRadius,
      borderSide: const BorderSide(color: Color(0xFFE57373)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: clientsChipBorderRadius,
      borderSide: const BorderSide(color: Color(0xFFE57373)),
    ),
  );
}
