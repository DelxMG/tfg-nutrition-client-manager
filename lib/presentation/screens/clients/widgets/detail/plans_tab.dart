import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/application/providers/database_provider.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/data/repositories/nutrition_plan_repository.dart';
import 'package:nutritrack/domain/enums.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;

// ── Status helpers ─────────────────────────────────────────────────────────────

extension _PlanStatusX on PlanStatus {
  String get label => switch (this) {
        PlanStatus.draft     => 'Borrador',
        PlanStatus.active    => 'Activo',
        PlanStatus.archived  => 'Archivado',
      };

  Color get color => switch (this) {
        PlanStatus.draft    => const Color(0xFFB6B6AF),
        PlanStatus.active   => const Color(0xFF22C55E),
        PlanStatus.archived => const Color(0xFF6366F1),
      };
}

// ── GoalType helpers ───────────────────────────────────────────────────────────

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

// ── Date helper ────────────────────────────────────────────────────────────────

String _fmtDate(DateTime d) {
  const months = [
    'ene', 'feb', 'mar', 'abr', 'may', 'jun',
    'jul', 'ago', 'sep', 'oct', 'nov', 'dic',
  ];
  return '${d.day} ${months[d.month - 1]} ${d.year}';
}

// ── PlansTab ───────────────────────────────────────────────────────────────────

class PlansTab extends ConsumerWidget {
  final int clientId;

  const PlansTab({super.key, required this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final plansAsync = ref.watch(clientNutritionPlansProvider(clientId));

    return plansAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Text(
          'Error al cargar los planes',
          style: GoogleFonts.inter(fontSize: 14, color: cs.onSurfaceVariant),
        ),
      ),
      data: (plans) => _PlansContent(
        plans: plans,
        clientId: clientId,
        repository: ref.read(nutritionPlanRepositoryProvider),
      ),
    );
  }
}

// ── Content ────────────────────────────────────────────────────────────────────

class _PlansContent extends StatefulWidget {
  final List<NutritionPlan> plans;
  final int clientId;
  final NutritionPlanRepository repository;

  const _PlansContent({
    required this.plans,
    required this.clientId,
    required this.repository,
  });

  @override
  State<_PlansContent> createState() => _PlansContentState();
}

class _PlansContentState extends State<_PlansContent> {
  Future<void> _openForm({
    int? preselectedCalculationId,
    NutritionPlan? existing,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (_) => PlanFormDialog(
        clientId: widget.clientId,
        preselectedCalculationId: preselectedCalculationId,
        existingPlan: existing,
      ),
    );
  }

  Future<void> _archivePlan(NutritionPlan plan) async {
    await widget.repository.updatePlan(plan.planId, status: PlanStatus.archived);
  }

  Future<void> _confirmDelete(NutritionPlan plan) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar plan'),
        content: Text(
          '¿Eliminar "${plan.name}"? Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await widget.repository.deletePlan(plan.planId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ──────────────────────────────────────────────────────
        Row(
          children: [
            Text(
              'Planes',
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
              ),
            ),
            const Spacer(),
            FilledButton.tonal(
              onPressed: () => _openForm(),
              child: const Text('Nuevo plan'),
            ),
          ],
        ),
        const SizedBox(height: 16),

        if (widget.plans.isEmpty)
          Expanded(child: _EmptyPlansState(onCreate: () => _openForm()))
        else
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (final plan in widget.plans) ...[
                    _PlanCard(
                      plan: plan,
                      onEdit: () => _openForm(existing: plan),
                      onArchive: () => _archivePlan(plan),
                      onDelete: () => _confirmDelete(plan),
                    ),
                    const SizedBox(height: 12),
                  ],
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

// ── Plan card ──────────────────────────────────────────────────────────────────

class _PlanCard extends StatelessWidget {
  final NutritionPlan plan;
  final VoidCallback onEdit;
  final VoidCallback onArchive;
  final VoidCallback onDelete;

  const _PlanCard({
    required this.plan,
    required this.onEdit,
    required this.onArchive,
    required this.onDelete,
  });

  Future<void> _openPdf(BuildContext context) async {
    final result = await OpenFilex.open(plan.pdfFile!);
    if (result.type != ResultType.done && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No se pudo abrir el archivo: ${result.message}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs       = Theme.of(context).colorScheme;
    final goalType = plan.goalType;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: clientsBorderRadius,
        border: Border.all(color: cs.outlineVariant),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Name + status ────────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: Text(
                  plan.name,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _StatusBadge(plan.status),
            ],
          ),

          // ── Description ──────────────────────────────────────────────
          if (plan.description != null && plan.description!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              plan.description!,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: cs.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],

          const SizedBox(height: 12),

          // ── kcal + meals + goal ──────────────────────────────────────
          Row(
            children: [
              if (plan.kcalSnapshot != null) ...[
                Icon(
                  Icons.local_fire_department_outlined,
                  size: 15,
                  color: cs.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  '${plan.kcalSnapshot!.toStringAsFixed(0)} kcal/día',
                  style: GoogleFonts.inter(fontSize: 13, color: cs.onSurface),
                ),
                const SizedBox(width: 16),
              ],
              if (plan.mealsCount != null) ...[
                Icon(
                  Icons.restaurant_outlined,
                  size: 15,
                  color: cs.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  '${plan.mealsCount} comidas',
                  style: GoogleFonts.inter(fontSize: 13, color: cs.onSurface),
                ),
              ],
              const Spacer(),
              if (goalType != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
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
            ],
          ),

          const SizedBox(height: 10),

          // ── Origin ───────────────────────────────────────────────────
          Row(
            children: [
              Icon(
                plan.calculationId != null
                    ? Icons.calculate_outlined
                    : Icons.edit_outlined,
                size: 13,
                color: cs.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                plan.calculationId != null ? 'Desde cálculo' : 'Manual',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
          ),

          Divider(height: 20, color: cs.outlineVariant),

          // ── Dates + actions ──────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Creado ${_fmtDate(plan.createdAt)}',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  if (plan.updatedAt != null)
                    Text(
                      'Actualizado ${_fmtDate(plan.updatedAt!)}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
              const Spacer(),
              TextButton(
                onPressed: plan.pdfFile != null
                    ? () => _openPdf(context)
                    : null,
                child: const Text('Ver'),
              ),
              TextButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Funcionalidad pendiente')),
                ),
                child: const Text('Exportar'),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (val) {
                  if (val == 'edit') {
                    onEdit();
                  } else if (val == 'archive') {
                    onArchive();
                  } else if (val == 'delete') {
                    onDelete();
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'edit', child: Text('Editar')),
                  PopupMenuItem(value: 'archive', child: Text('Archivar')),
                  PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Status badge ───────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final PlanStatus status;

  const _StatusBadge(this.status);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.12),
        borderRadius: clientsChipBorderRadius,
      ),
      child: Text(
        status.label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: status.color,
        ),
      ),
    );
  }
}

// ── Empty state ────────────────────────────────────────────────────────────────

class _EmptyPlansState extends StatelessWidget {
  final VoidCallback onCreate;

  const _EmptyPlansState({required this.onCreate});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 48,
            color: cs.onSurfaceVariant.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16),
          Text(
            'Sin planes todavía',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Crea un plan manualmente o desde un cálculo guardado.',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: cs.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          FilledButton.tonal(
            onPressed: onCreate,
            child: const Text('Crear primer plan'),
          ),
        ],
      ),
    );
  }
}

// ── Plan form dialog ───────────────────────────────────────────────────────────

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
  int?    _selectedCalculationId;
  String? _pdfPath;
  bool    _saving = false;

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
      _pdfPath = existing.pdfFile;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _mealsController.dispose();
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

    NutritionCalculation? selectedCalc;
    if (_selectedCalculationId != null) {
      final idx = calculations.indexWhere(
        (c) => c.calculationId == _selectedCalculationId,
      );
      if (idx >= 0) selectedCalc = calculations[idx];
    }

    final repo = ref.read(nutritionPlanRepositoryProvider);

    try {
      if (widget.existingPlan == null) {
        await repo.insertPlan(
          clientId: widget.clientId,
          calculationId: _selectedCalculationId,
          name: name,
          description: desc,
          mealsCount: mealsCount,
          kcalSnapshot: selectedCalc?.kcalTarget,
          goalType: selectedCalc?.goalType,
          pdfFile: _pdfPath,
        );
      } else {
        await repo.updatePlan(
          widget.existingPlan!.planId,
          name: name,
          description: desc,
          mealsCount: mealsCount,
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

    return AlertDialog(
      title: Text(isEdit ? 'Editar plan' : 'Nuevo plan'),
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre *'),
                autofocus: true,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),
              // Description
              TextField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                maxLines: 2,
                minLines: 1,
              ),
              const SizedBox(height: 12),
              // Meals count
              TextField(
                controller: _mealsController,
                decoration: const InputDecoration(labelText: 'Comidas por día'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 16),
              // Calculation selector
              Text(
                'Cálculo base',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: cs.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              DropdownButtonHideUnderline(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: cs.outline),
                    borderRadius: clientsChipBorderRadius,
                  ),
                  child: DropdownButton<int?>(
                    value: _selectedCalculationId,
                    isExpanded: true,
                    // Calculation selector locked in edit mode
                    onChanged: isEdit
                        ? null
                        : (v) => setState(() => _selectedCalculationId = v),
                    items: [
                      const DropdownMenuItem<int?>(
                        value: null,
                        child: Text('Sin cálculo (manual)'),
                      ),
                      for (final c in calculations)
                        DropdownMenuItem<int?>(
                          value: c.calculationId,
                          child: Text(
                            '${_fmtDate(c.date)} – ${c.kcalTarget.toStringAsFixed(0)} kcal',
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // PDF picker
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _pdfPath != null
                          ? p.basename(_pdfPath!)
                          : 'Sin PDF adjunto',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: cs.onSurfaceVariant,
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
