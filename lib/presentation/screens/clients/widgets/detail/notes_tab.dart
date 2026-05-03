import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/application/providers/database_provider.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/data/repositories/note_repository.dart';
import 'package:nutritrack/domain/enums.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:nutritrack/presentation/screens/clients/helpers/clients_formatters.dart';

class NotesTab extends ConsumerWidget {
  final int clientId;

  const NotesTab({super.key, required this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final notesAsync = ref.watch(clientNotesProvider(clientId));

    return notesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Text(
          'Error al cargar las notas',
          style: GoogleFonts.inter(fontSize: 14, color: cs.onSurfaceVariant),
        ),
      ),
      data: (notes) => _NotesContent(
        notes: notes,
        clientId: clientId,
        repository: ref.read(noteRepositoryProvider),
      ),
    );
  }
}

// ── Content ────────────────────────────────────────────────────────────────────

class _NotesContent extends StatefulWidget {
  final List<Note> notes;
  final int clientId;
  final NoteRepository repository;

  const _NotesContent({
    required this.notes,
    required this.clientId,
    required this.repository,
  });

  @override
  State<_NotesContent> createState() => _NotesContentState();
}

class _NotesContentState extends State<_NotesContent> {
  final _controller = TextEditingController();
  NoteType _selectedType = NoteType.general;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() => setState(() {});

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  bool get _canSubmit => !_submitting && _controller.text.trim().isNotEmpty;

  Future<void> _submit() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() => _submitting = true);
    try {
      await widget.repository.insertNote(
        clientId: widget.clientId,
        content: text,
        type: _selectedType,
      );
      _controller.clear();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al guardar la nota. Inténtalo de nuevo.'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _confirmDelete(Note note) async {
    final d = note.date;
    final dateStr =
        '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar nota'),
        content: Text(
          '¿Seguro que quieres eliminar la nota del $dateStr? '
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
      await widget.repository.deleteNote(note.noteId);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al eliminar la nota. Inténtalo de nuevo.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Composer ──────────────────────────────────────────────────
          _NoteComposer(
            controller: _controller,
            selectedType: _selectedType,
            submitting: _submitting,
            canSubmit: _canSubmit,
            onTypeChanged: (t) => setState(() => _selectedType = t),
            onSubmit: _submit,
          ),
          const SizedBox(height: 20),

          // ── History header ────────────────────────────────────────────
          Text(
            'Historial de notas',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 12),

          // ── List / empty state ────────────────────────────────────────
          widget.notes.isEmpty
              ? const _EmptyState()
              : _NotesList(notes: widget.notes, onDelete: _confirmDelete),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── Composer ──────────────────────────────────────────────────────────────────

class _NoteComposer extends StatelessWidget {
  final TextEditingController controller;
  final NoteType selectedType;
  final bool submitting;
  final bool canSubmit;
  final ValueChanged<NoteType> onTypeChanged;
  final VoidCallback onSubmit;

  const _NoteComposer({
    required this.controller,
    required this.selectedType,
    required this.submitting,
    required this.canSubmit,
    required this.onTypeChanged,
    required this.onSubmit,
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
          // ── Type selector ───────────────────────────────────────────
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: NoteType.values.map((type) {
              final selected = type == selectedType;
              final badgeColor = _noteTypeBadgeColor(type);
              return InkWell(
                borderRadius: clientsChipBorderRadius,
                onTap: submitting ? null : () => onTypeChanged(type),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? badgeColor.withValues(alpha: 0.12)
                        : cs.surfaceContainerHighest,
                    borderRadius: clientsChipBorderRadius,
                    border: Border.all(
                      color: selected
                          ? badgeColor.withValues(alpha: 0.45)
                          : cs.outlineVariant,
                    ),
                  ),
                  child: Text(
                    _noteTypeLabel(type),
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                      color: selected ? badgeColor : cs.onSurfaceVariant,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),

          // ── Text field ──────────────────────────────────────────────
          TextField(
            controller: controller,
            enabled: !submitting,
            minLines: 3,
            maxLines: 6,
            style: GoogleFonts.inter(fontSize: 14, color: cs.onSurface),
            decoration: InputDecoration(
              hintText: 'Escribe una nota...',
              hintStyle: GoogleFonts.inter(
                fontSize: 14,
                color: cs.onSurfaceVariant,
              ),
              filled: true,
              fillColor: cs.surfaceContainerHighest,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
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
                borderSide: BorderSide(
                  color: cs.primary.withValues(alpha: 0.7),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ── Save button ─────────────────────────────────────────────
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: clientsButtonHeight,
              child: ElevatedButton.icon(
                onPressed: canSubmit ? onSubmit : null,
                icon: submitting
                    ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.send, size: 15),
                label: Text(
                  'Guardar nota',
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

// ── Notes list ────────────────────────────────────────────────────────────────

class _NotesList extends StatelessWidget {
  final List<Note> notes;
  final Future<void> Function(Note) onDelete;

  const _NotesList({required this.notes, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < notes.length; i++) ...[
          _NoteCard(note: notes[i], onDelete: () => onDelete(notes[i])),
          if (i < notes.length - 1) const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onDelete;

  const _NoteCard({required this.note, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final badgeColor = _noteTypeBadgeColor(note.type);

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
          // ── Header: badge + date + delete ──────────────────────────
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.12),
                  borderRadius: clientsChipBorderRadius,
                ),
                child: Text(
                  _noteTypeLabel(note.type),
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: badgeColor,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                formatDate(note.date),
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

          // ── Content ─────────────────────────────────────────────────
          Text(
            note.content,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: cs.onSurface,
              height: 1.5,
            ),
          ),
        ],
      ),
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
      message: 'Eliminar nota',
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
  const _EmptyState();

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
            Icons.note_alt_outlined,
            size: 36,
            color: cs.onSurfaceVariant.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 12),
          Text(
            'Sin notas registradas',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Usa el compositor de arriba para añadir la primera nota.',
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

// ── NoteType helpers ──────────────────────────────────────────────────────────

String _noteTypeLabel(NoteType type) {
  switch (type) {
    case NoteType.general:
      return 'General';
    case NoteType.session:
      return 'Sesión';
    case NoteType.followUp:
      return 'Seguimiento';
    case NoteType.important:
      return 'Importante';
  }
}

Color _noteTypeBadgeColor(NoteType type) {
  switch (type) {
    case NoteType.general:
      return const Color(0xFF7A7A73);
    case NoteType.session:
      return const Color(0xFF3B82F6);
    case NoteType.followUp:
      return const Color(0xFFE3A12A);
    case NoteType.important:
      return const Color(0xFFD94A4A);
  }
}
