import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/data/repositories/measurement_repository.dart';
import 'package:nutritrack/presentation/layout/responsive_utils.dart';
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

  // Composición corporal
  final _weightController     = TextEditingController();
  final _bodyFatController    = TextEditingController();
  final _muscleMassController = TextEditingController();

  // Medidas corporales
  final _waistController = TextEditingController();
  final _chestController = TextEditingController();
  final _armController   = TextEditingController();
  final _thighController = TextEditingController();
  final _calfController  = TextEditingController();

  DateTime _date = DateTime.now();
  bool _submitting = false;

  @override
  void dispose() {
    _weightController.dispose();
    _bodyFatController.dispose();
    _muscleMassController.dispose();
    _waistController.dispose();
    _chestController.dispose();
    _armController.dispose();
    _thighController.dispose();
    _calfController.dispose();
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

  double? _parse(TextEditingController c) {
    final t = c.text.trim();
    return t.isEmpty ? null : double.tryParse(t);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);

    try {
      await widget.repository.insertMeasurement(
        clientId:   widget.clientId,
        date:       _date,
        weight:     double.tryParse(_weightController.text.trim()),
        bodyFat:    _parse(_bodyFatController),
        muscleMass: _parse(_muscleMassController),
        waist:      _parse(_waistController),
        chest:      _parse(_chestController),
        arm:        _parse(_armController),
        thigh:      _parse(_thighController),
        calf:       _parse(_calfController),
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
    final compact = context.isCompact;
    final maxScrollHeight = MediaQuery.of(context).size.height * 0.6;
    final keyboardBottom = MediaQuery.of(context).viewInsets.bottom;

    final bodyFatField = _Field(
      label: 'Grasa corporal (%)',
      child: TextFormField(
        controller: _bodyFatController,
        enabled: !_submitting,
        decoration: _dec('ej. 18.0', cs),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
        ],
        validator: (v) {
          if (v == null || v.trim().isEmpty) return null;
          final val = double.tryParse(v.trim());
          if (val == null || val < 0 || val > 100) return 'Valor entre 0 y 100';
          return null;
        },
      ),
    );
    final muscleMassField = _Field(
      label: 'Masa muscular (kg)',
      child: TextFormField(
        controller: _muscleMassController,
        enabled: !_submitting,
        decoration: _dec('ej. 35.0', cs),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
        ],
        validator: _positiveOptional,
      ),
    );

    return Dialog(
      backgroundColor: cs.surface,
      shape: const RoundedRectangleBorder(borderRadius: clientsBorderRadius),
      insetPadding: EdgeInsets.symmetric(
        horizontal: compact ? 16.0 : 40.0,
        vertical: 24,
      ),
      child: SizedBox(
        width: compact ? double.infinity : 420,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ───────────────────────────────────────────────
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

              // ── Scrollable form body ──────────────────────────────────
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxScrollHeight),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Fecha
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

                        // Peso
                        _Field(
                          label: 'Peso (kg) *',
                          child: TextFormField(
                            controller: _weightController,
                            enabled: !_submitting,
                            decoration: _dec('ej. 72.5', cs),
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*'),
                              ),
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

                        // Grasa / Músculo
                        if (compact)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bodyFatField,
                              const SizedBox(height: 12),
                              muscleMassField,
                            ],
                          )
                        else
                          Row(
                            children: [
                              Expanded(child: bodyFatField),
                              const SizedBox(width: 12),
                              Expanded(child: muscleMassField),
                            ],
                          ),
                        const SizedBox(height: 20),

                        // ── Medidas corporales ──────────────────────────
                        Text(
                          'Medidas corporales (cm)',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Cintura / Pecho
                        if (compact)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _Field(label: 'Cintura', child: _cmField(_waistController, 'ej. 80.0', cs)),
                              const SizedBox(height: 12),
                              _Field(label: 'Pecho', child: _cmField(_chestController, 'ej. 95.0', cs)),
                            ],
                          )
                        else
                          Row(
                            children: [
                              Expanded(child: _Field(label: 'Cintura', child: _cmField(_waistController, 'ej. 80.0', cs))),
                              const SizedBox(width: 12),
                              Expanded(child: _Field(label: 'Pecho', child: _cmField(_chestController, 'ej. 95.0', cs))),
                            ],
                          ),
                        const SizedBox(height: 12),

                        // Brazo / Muslo
                        if (compact)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _Field(label: 'Brazo', child: _cmField(_armController, 'ej. 32.0', cs)),
                              const SizedBox(height: 12),
                              _Field(label: 'Muslo', child: _cmField(_thighController, 'ej. 55.0', cs)),
                            ],
                          )
                        else
                          Row(
                            children: [
                              Expanded(child: _Field(label: 'Brazo', child: _cmField(_armController, 'ej. 32.0', cs))),
                              const SizedBox(width: 12),
                              Expanded(child: _Field(label: 'Muslo', child: _cmField(_thighController, 'ej. 55.0', cs))),
                            ],
                          ),
                        const SizedBox(height: 12),

                        // Pantorrilla
                        _Field(
                          label: 'Pantorrilla',
                          child: _cmField(_calfController, 'ej. 36.0', cs),
                        ),
                        SizedBox(height: keyboardBottom > 0 ? keyboardBottom : 4),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ── Buttons ───────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _submitting
                        ? null
                        : () => Navigator.of(context).pop(),
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
    );
  }

  Widget _cmField(
    TextEditingController controller,
    String hint,
    ColorScheme cs,
  ) {
    return TextFormField(
      controller: controller,
      enabled: !_submitting,
      decoration: _dec(hint, cs),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      validator: _positiveOptional,
    );
  }
}

String? _positiveOptional(String? v) {
  if (v == null || v.trim().isEmpty) return null;
  final val = double.tryParse(v.trim());
  if (val == null || val <= 0) return 'Valor inválido';
  return null;
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
