import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/data/repositories/measurement_repository.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';

class MeasurementFormDialog extends StatefulWidget {
  final int clientId;
  final MeasurementRepository repository;

  const MeasurementFormDialog({
    super.key,
    required this.clientId,
    required this.repository,
  });

  @override
  State<MeasurementFormDialog> createState() => _MeasurementFormDialogState();
}

class _MeasurementFormDialogState extends State<MeasurementFormDialog> {
  final _formKey = GlobalKey<FormState>();

  final _weightController = TextEditingController();
  final _bodyFatController = TextEditingController();
  final _muscleMassController = TextEditingController();

  DateTime _date = DateTime.now();
  bool _submitting = false;

  @override
  void dispose() {
    _weightController.dispose();
    _bodyFatController.dispose();
    _muscleMassController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);

    try {
      await widget.repository.insertMeasurement(
        clientId: widget.clientId,
        date: _date,
        weight: double.tryParse(_weightController.text.trim()),
        bodyFat: _bodyFatController.text.trim().isEmpty
            ? null
            : double.tryParse(_bodyFatController.text.trim()),
        muscleMass: _muscleMassController.text.trim().isEmpty
            ? null
            : double.tryParse(_muscleMassController.text.trim()),
      );

      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      setState(() => _submitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al guardar la medición. Inténtalo de nuevo.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Dialog(
      backgroundColor: cs.surface,
      shape: const RoundedRectangleBorder(borderRadius: clientsBorderRadius),
      child: SizedBox(
        width: 420,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──────────────────────────────────────────────
                Row(
                  children: [
                    Text(
                      'Nueva medición',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, size: 20),
                      color: cs.onSurfaceVariant,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // ── Fecha ───────────────────────────────────────────────
                _Field(
                  label: 'Fecha',
                  child: InkWell(
                    onTap: _submitting ? null : _pickDate,
                    borderRadius: clientsChipBorderRadius,
                    child: InputDecorator(
                      decoration: _dec(null, cs),
                      child: Text(
                        '${_date.day.toString().padLeft(2, '0')}/'
                        '${_date.month.toString().padLeft(2, '0')}/'
                        '${_date.year}',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: cs.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // ── Peso ────────────────────────────────────────────────
                _Field(
                  label: 'Peso (kg) *',
                  child: TextFormField(
                    controller: _weightController,
                    enabled: !_submitting,
                    decoration: _dec('ej. 72.5', cs),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'El peso es obligatorio';
                      }
                      final val = double.tryParse(v.trim());
                      if (val == null || val <= 0) {
                        return 'Introduce un peso válido';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 14),

                // ── Grasa / Músculo ─────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: _Field(
                        label: 'Grasa corporal (%)',
                        child: TextFormField(
                          controller: _bodyFatController,
                          enabled: !_submitting,
                          decoration: _dec('ej. 18.0', cs),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*')),
                          ],
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return null;
                            final val = double.tryParse(v.trim());
                            if (val == null || val < 0 || val > 100) {
                              return 'Valor entre 0 y 100';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _Field(
                        label: 'Masa muscular (kg)',
                        child: TextFormField(
                          controller: _muscleMassController,
                          enabled: !_submitting,
                          decoration: _dec('ej. 35.0', cs),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*')),
                          ],
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return null;
                            final val = double.tryParse(v.trim());
                            if (val == null || val <= 0) {
                              return 'Introduce un valor válido';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // ── Botones ─────────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed:
                          _submitting ? null : () => Navigator.of(context).pop(),
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
                        onPressed: _submitting ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cs.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          shape: const RoundedRectangleBorder(
                            borderRadius: clientsBorderRadius,
                          ),
                        ),
                        child: _submitting
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Guardar',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Helpers ────────────────────────────────────────────────────────────────────

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
    filled: true,
    fillColor: cs.surfaceContainerHighest,
  );
}
