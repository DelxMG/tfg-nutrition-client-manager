import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/application/providers/database_provider.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/domain/enums.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:path/path.dart' as p;

// ── Local helpers ─────────────────────────────────────────────────────────────

extension _PlanStatusX on PlanStatus {
  String get label => switch (this) {
        PlanStatus.draft    => 'Borrador',
        PlanStatus.active   => 'Activo',
        PlanStatus.archived => 'Archivado',
      };

  Color get color => switch (this) {
        PlanStatus.draft    => const Color(0xFFB6B6AF),
        PlanStatus.active   => const Color(0xFF22C55E),
        PlanStatus.archived => const Color(0xFF6366F1),
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
  final _nameController  = TextEditingController();
  final _descController  = TextEditingController();
  final _mealsController = TextEditingController();
  final _kcalController  = TextEditingController();

  int?        _selectedCalculationId;
  PlanStatus  _status = PlanStatus.draft;
  String?     _pdfPath;
  bool        _saving = false;

  @override
  void initState() {
    super.initState();
    _selectedCalculationId =
        widget.preselectedCalculationId ?? widget.existingPlan?.calculationId;

    final existing = widget.existingPlan;
    if (existing != null) {
      _nameController.text  = existing.name;
      _descController.text  = existing.description ?? '';
      _mealsController.text = existing.mealsCount?.toString() ?? '';
      _status  = existing.status;
      _pdfPath = existing.pdfFile;
      // Manual kcal editable only when plan has no linked calculation
      if (existing.calculationId == null && existing.kcalSnapshot != null) {
        _kcalController.text = existing.kcalSnapshot!.toStringAsFixed(0);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _mealsController.dispose();
    _kcalController.dispose();
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
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    setState(() => _saving = true);

    final mealsCount = int.tryParse(_mealsController.text.trim());
    final desc = _descController.text.trim().isEmpty
        ? null
        : _descController.text.trim();

    // Find selected calculation (if any)
    NutritionCalculation? selectedCalc;
    if (_selectedCalculationId != null) {
      final idx = calculations.indexWhere(
        (c) => c.calculationId == _selectedCalculationId,
      );
      if (idx >= 0) selectedCalc = calculations[idx];
    }

    // kcalSnapshot: auto from calculation or from manual field
    final kcalSnapshot = selectedCalc?.kcalTarget
        ?? double.tryParse(_kcalController.text.trim());

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
          goalType: selectedCalc?.goalType,
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
    final canSave = !_saving && _nameController.text.trim().isNotEmpty;

    final calculations = ref
        .watch(clientNutritionCalculationsProvider(widget.clientId))
        .maybeWhen(data: (c) => c, orElse: () => <NutritionCalculation>[]);

    // Resolve currently selected calculation for the kcal info row
    NutritionCalculation? selectedCalc;
    if (_selectedCalculationId != null) {
      final idx = calculations.indexWhere(
        (c) => c.calculationId == _selectedCalculationId,
      );
      if (idx >= 0) selectedCalc = calculations[idx];
    }

    return AlertDialog(
      title: Text(
        isEdit ? 'Editar plan' : 'Nuevo plan',
        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
      ),
      content: SizedBox(
        width: 460,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Name ──────────────────────────────────────────────────
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre *',
                  hintText: 'Ej. Plan verano 2026',
                ),
                autofocus: true,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),

              // ── Description ───────────────────────────────────────────
              TextField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  hintText: 'Descripción breve (opcional)',
                ),
                maxLines: 2,
                minLines: 1,
              ),
              const SizedBox(height: 16),

              // ── Status chips ──────────────────────────────────────────
              _FieldLabel('Estado'),
              const SizedBox(height: 6),
              Row(
                children: [
                  for (final s in PlanStatus.values)
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: _StatusChip(
                        label: s.label,
                        selected: _status == s,
                        color: s.color,
                        onTap: () => setState(() => _status = s),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),

              // ── Comidas/día ───────────────────────────────────────────
              TextField(
                controller: _mealsController,
                decoration: const InputDecoration(labelText: 'Comidas por día'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 16),

              // ── Cálculo base ──────────────────────────────────────────
              _FieldLabel('Cálculo base'),
              const SizedBox(height: 6),
              DropdownButtonHideUnderline(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isEdit ? cs.outlineVariant : cs.outline,
                    ),
                    borderRadius: clientsChipBorderRadius,
                  ),
                  child: DropdownButton<int?>(
                    value: _selectedCalculationId,
                    isExpanded: true,
                    onChanged: isEdit
                        ? null
                        : (v) => setState(() {
                              _selectedCalculationId = v;
                              if (v != null) _kcalController.clear();
                            }),
                    items: [
                      DropdownMenuItem<int?>(
                        value: null,
                        child: Text(
                          'Sin cálculo (manual)',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: cs.onSurface,
                          ),
                        ),
                      ),
                      for (final c in calculations)
                        DropdownMenuItem<int?>(
                          value: c.calculationId,
                          child: Text(
                            '${_fmtDate(c.date)} – ${c.kcalTarget.toStringAsFixed(0)} kcal',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: cs.onSurface,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // ── Kcal: info row when calc selected, input when manual ──
              if (selectedCalc != null)
                _KcalInfoRow(calculation: selectedCalc)
              else
                TextField(
                  controller: _kcalController,
                  decoration: const InputDecoration(
                    labelText: 'Kcal objetivo / día (opcional)',
                    suffixText: 'kcal',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                ),
              const SizedBox(height: 16),

              // ── PDF ───────────────────────────────────────────────────
              _FieldLabel('PDF adjunto'),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _pdfPath != null
                          ? p.basename(_pdfPath!)
                          : 'Sin PDF adjunto',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: _pdfPath != null
                            ? cs.onSurface
                            : cs.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.upload_file_outlined, size: 16),
                    label: const Text('Subir PDF'),
                    onPressed: _pickPdf,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: canSave ? () => _save(calculations) : null,
          child: _saving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(isEdit ? 'Guardar cambios' : 'Crear plan'),
        ),
      ],
    );
  }
}

// ── Helper widgets ────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 12,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _StatusChip({
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: clientsChipBorderRadius,
          border: Border.all(
            color: selected ? color : cs.outlineVariant,
            width: selected ? 1.5 : 1.0,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? color : cs.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _KcalInfoRow extends StatelessWidget {
  final NutritionCalculation calculation;

  const _KcalInfoRow({required this.calculation});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
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
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: cs.onSurface,
            ),
          ),
          const Spacer(),
          Text(
            'Del cálculo del ${_fmtDate(calculation.date)}',
            style: GoogleFonts.inter(fontSize: 12, color: cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
