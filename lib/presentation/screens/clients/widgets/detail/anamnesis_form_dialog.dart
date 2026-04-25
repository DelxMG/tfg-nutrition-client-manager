import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/data/repositories/anamnesis_repository.dart';
import 'package:nutritrack/data/repositories/measurement_repository.dart';
import 'package:nutritrack/domain/enums.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:nutritrack/presentation/screens/clients/helpers/clients_formatters.dart';

class AnamnesisFormDialog extends StatefulWidget {
  final int clientId;
  final AnamnesisTableData? anamnesis;
  final AnamnesisRepository repository;
  final bool hasExistingMeasurements;
  final MeasurementRepository? measurementRepository;

  const AnamnesisFormDialog({
    super.key,
    required this.clientId,
    required this.anamnesis,
    required this.repository,
    this.hasExistingMeasurements = true,
    this.measurementRepository,
  });

  @override
  State<AnamnesisFormDialog> createState() => _AnamnesisFormDialogState();
}

class _AnamnesisFormDialogState extends State<AnamnesisFormDialog> {
  late final TextEditingController _objectiveController;
  late final TextEditingController _occupationController;
  late final TextEditingController _allergiesController;
  late final TextEditingController _pathologiesController;
  late final TextEditingController _observationsController;
  late final TextEditingController _supplementsController;

  // Initial measurement fields (only used when !hasExistingMeasurements)
  late final TextEditingController _initialWeightController;
  late final TextEditingController _initialBodyFatController;
  late final TextEditingController _initialMuscleMassController;
  DateTime _initialMeasurementDate = DateTime.now();

  PhysicalActivity? _physicalActivity;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    final a = widget.anamnesis;
    _objectiveController = TextEditingController(text: a?.objective ?? '');
    _occupationController = TextEditingController(text: a?.occupation ?? '');
    _allergiesController = TextEditingController(text: a?.allergies ?? '');
    _pathologiesController = TextEditingController(text: a?.pathologies ?? '');
    _observationsController = TextEditingController(text: a?.observations ?? '');
    _supplementsController = TextEditingController(text: a?.supplements ?? '');
    _physicalActivity = a?.physicalActivity;

    _initialWeightController = TextEditingController();
    _initialBodyFatController = TextEditingController();
    _initialMuscleMassController = TextEditingController();
  }

  @override
  void dispose() {
    _objectiveController.dispose();
    _occupationController.dispose();
    _allergiesController.dispose();
    _pathologiesController.dispose();
    _observationsController.dispose();
    _supplementsController.dispose();
    _initialWeightController.dispose();
    _initialBodyFatController.dispose();
    _initialMuscleMassController.dispose();
    super.dispose();
  }

  String? _val(TextEditingController c) {
    final v = c.text.trim();
    return v.isEmpty ? null : v;
  }

  double? _parseDouble(TextEditingController c) {
    final v = c.text.trim();
    return v.isEmpty ? null : double.tryParse(v);
  }

  Future<void> _pickInitialDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _initialMeasurementDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _initialMeasurementDate = picked);
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);

    try {
      await widget.repository.upsertAnamnesisByClientId(
        clientId: widget.clientId,
        objective: _val(_objectiveController),
        physicalActivity: _physicalActivity,
        occupation: _val(_occupationController),
        allergies: _val(_allergiesController),
        pathologies: _val(_pathologiesController),
        observations: _val(_observationsController),
        supplements: _val(_supplementsController),
      );

      if (!widget.hasExistingMeasurements && widget.measurementRepository != null) {
        final w = _parseDouble(_initialWeightController);
        final f = _parseDouble(_initialBodyFatController);
        final m = _parseDouble(_initialMuscleMassController);
        if (w != null || f != null || m != null) {
          await widget.measurementRepository!.insertMeasurement(
            clientId: widget.clientId,
            date: _initialMeasurementDate,
            weight: w,
            bodyFat: f,
            muscleMass: m,
          );
        }
      }

      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      setState(() => _submitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al guardar la anamnesis. Inténtalo de nuevo.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNew = widget.anamnesis == null;

    return Dialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: clientsBorderRadius),
      child: SizedBox(
        width: 520,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 680),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header (fixed) ───────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 28, 28, 0),
                child: Row(
                  children: [
                    Text(
                      isNew ? 'Completar anamnesis' : 'Editar anamnesis',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: clientsHeadingColor,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, size: 20),
                      color: clientsMutedTextColor,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),

              // ── Scrollable fields ────────────────────────────────────────
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(28, 20, 28, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Field(
                        label: 'Objetivo',
                        child: TextFormField(
                          controller: _objectiveController,
                          enabled: !_submitting,
                          decoration:
                              _inputDecoration('Ej. perder peso, ganar músculo...'),
                        ),
                      ),
                      const SizedBox(height: 14),

                      Row(
                        children: [
                          Expanded(
                            child: _Field(
                              label: 'Actividad física',
                              child: DropdownButtonFormField<PhysicalActivity?>(
                                value: _physicalActivity,
                                decoration: _inputDecoration(null),
                                hint: Text(
                                  'Sin especificar',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: clientsMutedTextColor,
                                  ),
                                ),
                                items: [
                                  DropdownMenuItem<PhysicalActivity?>(
                                    value: null,
                                    child: Text(
                                      'Sin especificar',
                                      style: GoogleFonts.inter(fontSize: 14),
                                    ),
                                  ),
                                  ...PhysicalActivity.values.map(
                                    (a) => DropdownMenuItem(
                                      value: a,
                                      child: Text(
                                        a.label,
                                        style: GoogleFonts.inter(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                                onChanged: _submitting
                                    ? null
                                    : (v) =>
                                        setState(() => _physicalActivity = v),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _Field(
                              label: 'Ocupación',
                              child: TextFormField(
                                controller: _occupationController,
                                enabled: !_submitting,
                                decoration:
                                    _inputDecoration('Ej. administrativo...'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      _Field(
                        label: 'Alergias e intolerancias',
                        child: TextFormField(
                          controller: _allergiesController,
                          enabled: !_submitting,
                          decoration:
                              _inputDecoration('Ej. gluten, lactosa...'),
                          keyboardType: TextInputType.multiline,
                          minLines: 2,
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(height: 14),

                      _Field(
                        label: 'Condiciones médicas',
                        child: TextFormField(
                          controller: _pathologiesController,
                          enabled: !_submitting,
                          decoration: _inputDecoration(
                              'Ej. diabetes, hipertensión...'),
                          keyboardType: TextInputType.multiline,
                          minLines: 2,
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(height: 14),

                      _Field(
                        label: 'Observaciones',
                        child: TextFormField(
                          controller: _observationsController,
                          enabled: !_submitting,
                          decoration: _inputDecoration('Notas adicionales...'),
                          keyboardType: TextInputType.multiline,
                          minLines: 2,
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(height: 14),

                      _Field(
                        label: 'Suplementos',
                        child: TextFormField(
                          controller: _supplementsController,
                          enabled: !_submitting,
                          decoration:
                              _inputDecoration('Ej. proteína, creatina...'),
                          keyboardType: TextInputType.multiline,
                          minLines: 2,
                          maxLines: 3,
                        ),
                      ),

                      // ── Medición inicial (solo si no hay mediciones) ─────
                      if (!widget.hasExistingMeasurements) ...[
                        const SizedBox(height: 24),
                        const Divider(color: Color(0xFFF0F0EC)),
                        const SizedBox(height: 16),
                        Text(
                          'Medición inicial',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: clientsHeadingColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Opcional. Si ya tienes datos de partida puedes registrarlos aquí.',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: clientsMutedTextColor,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _Field(
                          label: 'Fecha',
                          child: InkWell(
                            onTap: _submitting ? null : _pickInitialDate,
                            borderRadius: clientsChipBorderRadius,
                            child: InputDecorator(
                              decoration: _inputDecoration(null),
                              child: Text(
                                formatDate(_initialMeasurementDate),
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: clientsBodyTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: _Field(
                                label: 'Peso (kg)',
                                child: TextFormField(
                                  controller: _initialWeightController,
                                  enabled: !_submitting,
                                  decoration: _inputDecoration('ej. 72.5'),
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _Field(
                                label: 'Grasa corporal (%)',
                                child: TextFormField(
                                  controller: _initialBodyFatController,
                                  enabled: !_submitting,
                                  decoration: _inputDecoration('ej. 18.0'),
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _Field(
                                label: 'Masa muscular (kg)',
                                child: TextFormField(
                                  controller: _initialMuscleMassController,
                                  enabled: !_submitting,
                                  decoration: _inputDecoration('ej. 35.0'),
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // ── Buttons (fixed) ──────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 0, 28, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed:
                          _submitting ? null : () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancelar',
                        style: GoogleFonts.inter(
                          color: clientsMutedTextColor,
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
                          backgroundColor: clientsBrandColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20),
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
              ),
            ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: clientsBodyTextColor,
          ),
        ),
        const SizedBox(height: 4),
        child,
      ],
    );
  }
}

InputDecoration _inputDecoration(String? hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: GoogleFonts.inter(fontSize: 14, color: clientsMutedTextColor),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    border: OutlineInputBorder(
      borderRadius: clientsChipBorderRadius,
      borderSide: const BorderSide(color: clientsInputBorderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: clientsChipBorderRadius,
      borderSide: const BorderSide(color: clientsInputBorderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: clientsChipBorderRadius,
      borderSide: BorderSide(color: clientsBrandColor.withAlpha(180)),
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
    fillColor: Colors.white,
  );
}
