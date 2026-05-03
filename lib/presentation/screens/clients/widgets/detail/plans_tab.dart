import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/application/providers/database_provider.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/data/repositories/nutrition_plan_repository.dart';
import 'package:nutritrack/domain/enums.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:nutritrack/presentation/screens/clients/widgets/detail/plan_form_dialog.dart';
import 'package:open_filex/open_filex.dart';

// ── Status helpers ─────────────────────────────────────────────────────────────

extension _PlanStatusX on PlanStatus {
  String get label => switch (this) {
    PlanStatus.draft => 'Borrador',
    PlanStatus.active => 'Activo',
    PlanStatus.archived => 'Archivado',
  };

  Color get color => switch (this) {
    PlanStatus.draft => const Color(0xFFE3A12A),
    PlanStatus.active => const Color(0xFF22C55E),
    PlanStatus.archived => const Color(0xFF9E9E9E),
  };
}

// ── GoalType helpers ───────────────────────────────────────────────────────────

extension _GoalTypeX on GoalType {
  String get label => switch (this) {
    GoalType.deficit => 'Déficit',
    GoalType.maintenance => 'Mantenimiento',
    GoalType.surplus => 'Superávit',
  };

  Color get color => switch (this) {
    GoalType.deficit => const Color(0xFF3B82F6),
    GoalType.maintenance => const Color(0xFF22C55E),
    GoalType.surplus => const Color(0xFFE3A12A),
  };
}

// ── Date helper ────────────────────────────────────────────────────────────────

String _fmtDate(DateTime d) {
  const months = [
    'ene',
    'feb',
    'mar',
    'abr',
    'may',
    'jun',
    'jul',
    'ago',
    'sep',
    'oct',
    'nov',
    'dic',
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Planes de nutrición',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface,
                  ),
                ),
                Text(
                  widget.plans.length == 1
                      ? '1 plan'
                      : '${widget.plans.length} planes',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: clientsButtonHeight,
              child: ElevatedButton.icon(
                onPressed: () => _openForm(),
                icon: const Icon(Icons.add, size: 16),
                label: Text(
                  'Nuevo plan',
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
  final VoidCallback onDelete;

  const _PlanCard({
    required this.plan,
    required this.onEdit,
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
    final cs = Theme.of(context).colorScheme;
    final goalType = plan.goalType;

    final isActive = plan.status == PlanStatus.active;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: clientsBorderRadius,
        border: Border.all(
          color: isActive
              ? cs.primary.withValues(alpha: 0.35)
              : cs.outlineVariant,
          width: isActive ? 1.5 : 1.0,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Name + inline status · GoalType badge ────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.assignment_outlined,
                size: 16,
                color: isActive ? cs.primary : cs.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        plan.name,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: cs.onSurface,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: plan.status.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      plan.status.label,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: plan.status.color,
                      ),
                    ),
                  ],
                ),
              ),
              if (goalType != null) ...[
                const SizedBox(width: 8),
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

          // ── kcal + meals ─────────────────────────────────────────────
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
              _ViewButton(
                onPressed: () {
                  if (plan.pdfFile != null) {
                    _openPdf(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Este plan no tiene PDF adjunto'),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(width: 4),
              _EditButton(onPressed: onEdit),
              const SizedBox(width: 4),
              _DeleteButton(onPressed: onDelete),
            ],
          ),
        ],
      ),
    );
  }
}

// ── View button (eye toggle on hover) ─────────────────────────────────────────

class _ViewButton extends StatefulWidget {
  final VoidCallback? onPressed;

  const _ViewButton({this.onPressed});

  @override
  State<_ViewButton> createState() => _ViewButtonState();
}

class _ViewButtonState extends State<_ViewButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final enabled = widget.onPressed != null;

    return Tooltip(
      message: 'Ver PDF',
      child: MouseRegion(
        cursor: enabled ? SystemMouseCursors.click : MouseCursor.defer,
        onEnter: enabled ? (_) => setState(() => _hovered = true) : null,
        onExit: enabled ? (_) => setState(() => _hovered = false) : null,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: Icon(
                _hovered
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                key: ValueKey(_hovered),
                size: 16,
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Edit button (primary tint on hover) ────────────────────────────────────────

class _EditButton extends StatefulWidget {
  final VoidCallback? onPressed;

  const _EditButton({this.onPressed});

  @override
  State<_EditButton> createState() => _EditButtonState();
}

class _EditButtonState extends State<_EditButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final enabled = widget.onPressed != null;

    return Tooltip(
      message: 'Editar plan',
      child: MouseRegion(
        cursor: enabled ? SystemMouseCursors.click : MouseCursor.defer,
        onEnter: enabled ? (_) => setState(() => _hovered = true) : null,
        onExit: enabled ? (_) => setState(() => _hovered = false) : null,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: _hovered
                  ? cs.primary.withValues(alpha: 0.08)
                  : Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            child: Icon(
              Icons.edit_outlined,
              size: 16,
              color: _hovered ? cs.primary : cs.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Delete button (scale + red on hover) ──────────────────────────────────────

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
      message: 'Eliminar plan',
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
                borderRadius: const BorderRadius.all(Radius.circular(6)),
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

// ── Empty state ────────────────────────────────────────────────────────────────

class _EmptyPlansState extends StatelessWidget {
  final VoidCallback onCreate;

  const _EmptyPlansState({required this.onCreate});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
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
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Crea un plan manualmente o desde un cálculo guardado.',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: cs.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: clientsButtonHeight,
              child: ElevatedButton.icon(
                onPressed: onCreate,
                icon: const Icon(Icons.add, size: 16),
                label: Text(
                  'Crear primer plan',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: cs.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: clientsBorderRadius,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
