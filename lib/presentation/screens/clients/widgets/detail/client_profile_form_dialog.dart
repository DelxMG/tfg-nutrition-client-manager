import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/data/repositories/anamnesis_repository.dart';
import 'package:nutritrack/data/repositories/client_repository.dart';
import 'package:nutritrack/data/repositories/measurement_repository.dart';
import 'package:nutritrack/domain/enums.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:nutritrack/presentation/screens/clients/helpers/clients_formatters.dart';

class ClientProfileFormDialog extends StatefulWidget {
  final Client client;
  final AnamnesisTableData? anamnesis;
  final bool hasExistingMeasurements;
  final ClientRepository clientRepository;
  final AnamnesisRepository anamnesisRepository;
  final MeasurementRepository measurementRepository;

  const ClientProfileFormDialog({
    super.key,
    required this.client,
    required this.anamnesis,
    required this.hasExistingMeasurements,
    required this.clientRepository,
    required this.anamnesisRepository,
    required this.measurementRepository,
  });

  @override
  State<ClientProfileFormDialog> createState() =>
      _ClientProfileFormDialogState();
}

class _ClientProfileFormDialogState extends State<ClientProfileFormDialog> {
  final _formKey = GlobalKey<FormState>();

  // ── Client controllers ────────────────────────────────────────────────────
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _heightController;

  // ── Anamnesis controllers ──────────────────────────────────────────────────
  late final TextEditingController _objectiveController;
  late final TextEditingController _occupationController;
  late final TextEditingController _allergiesController;
  late final TextEditingController _pathologiesController;
  late final TextEditingController _observationsController;
  late final TextEditingController _supplementsController;

  // ── Initial measurement controllers ───────────────────────────────────────
  late final TextEditingController _initialWeightController;
  late final TextEditingController _initialBodyFatController;
  late final TextEditingController _initialMuscleMassController;

  // ── Stateful values ───────────────────────────────────────────────────────
  Sex? _sex;
  ClientStatus _status = ClientStatus.active;
  DateTime? _birthDate;
  late DateTime _createdAt;
  PhysicalActivity? _physicalActivity;
  late DateTime _anamnesisDate;
  DateTime _initialDate = DateTime.now();

  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    final c = widget.client;
    final a = widget.anamnesis;

    _nameController = TextEditingController(text: c.name);
    _emailController = TextEditingController(text: c.email ?? '');
    _phoneController = TextEditingController(text: c.phone ?? '');
    _heightController =
        TextEditingController(text: c.height?.toString() ?? '');

    _sex = c.sex;
    _status = c.status;
    _birthDate = c.birthDate;
    _createdAt = c.createdAt;

    _objectiveController = TextEditingController(text: a?.objective ?? '');
    _occupationController = TextEditingController(text: a?.occupation ?? '');
    _allergiesController = TextEditingController(text: a?.allergies ?? '');
    _pathologiesController = TextEditingController(text: a?.pathologies ?? '');
    _observationsController =
        TextEditingController(text: a?.observations ?? '');
    _supplementsController = TextEditingController(text: a?.supplements ?? '');
    _physicalActivity = a?.physicalActivity;
    _anamnesisDate = a?.date ?? DateTime.now();

    _initialWeightController = TextEditingController();
    _initialBodyFatController = TextEditingController();
    _initialMuscleMassController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _heightController.dispose();
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

  // ── Helpers ───────────────────────────────────────────────────────────────

  String? _val(TextEditingController c) {
    final v = c.text.trim();
    return v.isEmpty ? null : v;
  }

  int? _parseInt(TextEditingController c) {
    final v = c.text.trim();
    return v.isEmpty ? null : int.tryParse(v);
  }

  double? _parseDouble(TextEditingController c) {
    final v = c.text.trim();
    return v.isEmpty ? null : double.tryParse(v);
  }

  Future<void> _pickDate({
    required DateTime current,
    required void Function(DateTime) onPicked,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
    );
    if (picked != null) onPicked(picked);
  }

  // ── Save ──────────────────────────────────────────────────────────────────

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);

    try {
      // 1. Update client
      await widget.clientRepository.updateClient(
        widget.client.copyWith(
          name: _nameController.text.trim(),
          email: Value(_val(_emailController)),
          phone: Value(_val(_phoneController)),
          height: Value(_parseInt(_heightController)),
          sex: Value(_sex),
          birthDate: Value(_birthDate),
          status: _status,
          createdAt: _createdAt,
        ),
      );

      // 2. Upsert anamnesis
      await widget.anamnesisRepository.upsertAnamnesisByClientId(
        clientId: widget.client.clientId,
        date: _anamnesisDate,
        objective: _val(_objectiveController),
        physicalActivity: _physicalActivity,
        occupation: _val(_occupationController),
        allergies: _val(_allergiesController),
        pathologies: _val(_pathologiesController),
        observations: _val(_observationsController),
        supplements: _val(_supplementsController),
      );

      // 3. Insert initial measurement if applicable
      if (!widget.hasExistingMeasurements) {
        final w = _parseDouble(_initialWeightController);
        final f = _parseDouble(_initialBodyFatController);
        final m = _parseDouble(_initialMuscleMassController);
        if (w != null || f != null || m != null) {
          await widget.measurementRepository.insertMeasurement(
            clientId: widget.client.clientId,
            date: _initialDate,
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
          content: Text('Error al guardar los cambios. Inténtalo de nuevo.'),
        ),
      );
    }
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: clientsBorderRadius),
      child: SizedBox(
        width: 600,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 720),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ───────────────────────────────────────────────
                _Header(
                  onClose: _submitting ? null : () => Navigator.of(context).pop(),
                ),

                // ── Scrollable body ──────────────────────────────────────
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(28, 20, 28, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPersonalSection(),
                        const SizedBox(height: 24),
                        _buildAnamnesisSection(),
                        if (!widget.hasExistingMeasurements) ...[
                          const SizedBox(height: 24),
                          _buildInitialMeasurementSection(),
                        ],
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                // ── Footer buttons ───────────────────────────────────────
                _Footer(
                  submitting: _submitting,
                  onCancel: () => Navigator.of(context).pop(),
                  onSave: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Section builders ──────────────────────────────────────────────────────

  Widget _buildPersonalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle('Datos personales'),
        const SizedBox(height: 14),

        // Name
        _Field(
          label: 'Nombre *',
          child: TextFormField(
            controller: _nameController,
            enabled: !_submitting,
            decoration: _inputDecoration('Nombre completo'),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'El nombre es obligatorio' : null,
          ),
        ),
        const SizedBox(height: 12),

        // Email
        _Field(
          label: 'Email',
          child: TextFormField(
            controller: _emailController,
            enabled: !_submitting,
            decoration: _inputDecoration('correo@ejemplo.com'),
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return null;
              if (!v.contains('@')) return 'Email no válido';
              return null;
            },
          ),
        ),
        const SizedBox(height: 12),

        // Phone + Height
        Row(
          children: [
            Expanded(
              child: _Field(
                label: 'Teléfono',
                child: TextFormField(
                  controller: _phoneController,
                  enabled: !_submitting,
                  decoration: _inputDecoration('Ej. 612 345 678'),
                  keyboardType: TextInputType.phone,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _Field(
                label: 'Altura (cm)',
                child: TextFormField(
                  controller: _heightController,
                  enabled: !_submitting,
                  decoration: _inputDecoration('Ej. 170'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return null;
                    final h = int.tryParse(v.trim());
                    if (h == null || h <= 0) return 'Altura no válida';
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Sex + Status
        Row(
          children: [
            Expanded(
              child: _Field(
                label: 'Sexo',
                child: DropdownButtonFormField<Sex?>(
                  value: _sex,
                  decoration: _inputDecoration(null),
                  hint: _hintText('Sin especificar'),
                  items: [
                    _dropdownItem<Sex?>(null, 'Sin especificar'),
                    ...Sex.values.map((s) => _dropdownItem(s, s.label)),
                  ],
                  onChanged:
                      _submitting ? null : (v) => setState(() => _sex = v),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _Field(
                label: 'Estado',
                child: DropdownButtonFormField<ClientStatus>(
                  value: _status,
                  decoration: _inputDecoration(null),
                  items: ClientStatus.values
                      .map((s) => _dropdownItem(s, s.label))
                      .toList(),
                  onChanged: _submitting
                      ? null
                      : (v) => setState(() => _status = v ?? _status),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // BirthDate + CreatedAt
        Row(
          children: [
            Expanded(
              child: _Field(
                label: 'Fecha de nacimiento',
                child: _DateButton(
                  date: _birthDate,
                  placeholder: 'Sin especificar',
                  disabled: _submitting,
                  onTap: () => _pickDate(
                    current: _birthDate ?? DateTime(1990),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    onPicked: (d) => setState(() => _birthDate = d),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _Field(
                label: 'Fecha de inicio',
                child: _DateButton(
                  date: _createdAt,
                  disabled: _submitting,
                  onTap: () => _pickDate(
                    current: _createdAt,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                    onPicked: (d) => setState(() => _createdAt = d),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnamnesisSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionDivider(),
        const SizedBox(height: 16),
        const _SectionTitle('Anamnesis'),
        const SizedBox(height: 14),

        // Objective
        _Field(
          label: 'Objetivo',
          child: TextFormField(
            controller: _objectiveController,
            enabled: !_submitting,
            decoration: _inputDecoration('Ej. perder peso, ganar músculo...'),
          ),
        ),
        const SizedBox(height: 12),

        // PhysicalActivity + Occupation
        Row(
          children: [
            Expanded(
              child: _Field(
                label: 'Actividad física',
                child: DropdownButtonFormField<PhysicalActivity?>(
                  value: _physicalActivity,
                  decoration: _inputDecoration(null),
                  hint: _hintText('Sin especificar'),
                  items: [
                    _dropdownItem<PhysicalActivity?>(null, 'Sin especificar'),
                    ...PhysicalActivity.values
                        .map((a) => _dropdownItem(a, a.label)),
                  ],
                  onChanged: _submitting
                      ? null
                      : (v) => setState(() => _physicalActivity = v),
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
                  decoration: _inputDecoration('Ej. administrativo...'),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Allergies
        _Field(
          label: 'Alergias e intolerancias',
          child: TextFormField(
            controller: _allergiesController,
            enabled: !_submitting,
            decoration: _inputDecoration('Ej. gluten, lactosa...'),
            keyboardType: TextInputType.multiline,
            minLines: 2,
            maxLines: 3,
          ),
        ),
        const SizedBox(height: 12),

        // Pathologies
        _Field(
          label: 'Condiciones médicas',
          child: TextFormField(
            controller: _pathologiesController,
            enabled: !_submitting,
            decoration: _inputDecoration('Ej. diabetes, hipertensión...'),
            keyboardType: TextInputType.multiline,
            minLines: 2,
            maxLines: 3,
          ),
        ),
        const SizedBox(height: 12),

        // Observations
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
        const SizedBox(height: 12),

        // Supplements
        _Field(
          label: 'Suplementos',
          child: TextFormField(
            controller: _supplementsController,
            enabled: !_submitting,
            decoration: _inputDecoration('Ej. proteína, creatina...'),
            keyboardType: TextInputType.multiline,
            minLines: 2,
            maxLines: 3,
          ),
        ),
        const SizedBox(height: 12),

        // Anamnesis date
        SizedBox(
          width: (600 - 56 - 12) / 2, // half width minus dialog padding
          child: _Field(
            label: 'Fecha de anamnesis',
            child: _DateButton(
              date: _anamnesisDate,
              disabled: _submitting,
              onTap: () => _pickDate(
                current: _anamnesisDate,
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
                onPicked: (d) => setState(() => _anamnesisDate = d),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInitialMeasurementSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionDivider(),
        const SizedBox(height: 16),
        const _SectionTitle('Medición inicial'),
        const SizedBox(height: 2),
        Text(
          'Opcional. Registra los datos de partida del cliente.',
          style: GoogleFonts.inter(fontSize: 12, color: clientsMutedTextColor),
        ),
        const SizedBox(height: 14),

        // Date
        SizedBox(
          width: (600 - 56 - 12) / 2,
          child: _Field(
            label: 'Fecha',
            child: _DateButton(
              date: _initialDate,
              disabled: _submitting,
              onTap: () => _pickDate(
                current: _initialDate,
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
                onPicked: (d) => setState(() => _initialDate = d),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Weight + BodyFat + MuscleMass
        Row(
          children: [
            Expanded(
              child: _Field(
                label: 'Peso (kg)',
                child: TextFormField(
                  controller: _initialWeightController,
                  enabled: !_submitting,
                  decoration: _inputDecoration('ej. 72.5'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return null;
                    final val = double.tryParse(v.trim());
                    if (val == null || val <= 0) return 'Peso no válido';
                    return null;
                  },
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
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
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
                  controller: _initialMuscleMassController,
                  enabled: !_submitting,
                  decoration: _inputDecoration('ej. 35.0'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return null;
                    final val = double.tryParse(v.trim());
                    if (val == null || val <= 0) return 'Valor no válido';
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  final VoidCallback? onClose;

  const _Header({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 0),
      child: Row(
        children: [
          Text(
            'Editar ficha',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: clientsHeadingColor,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close, size: 20),
            color: clientsMutedTextColor,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────

class _Footer extends StatelessWidget {
  final bool submitting;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const _Footer({
    required this.submitting,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 12, 28, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: submitting ? null : onCancel,
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
              onPressed: submitting ? null : onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: clientsBrandColor,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: const RoundedRectangleBorder(
                  borderRadius: clientsBorderRadius,
                ),
              ),
              child: submitting
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
    );
  }
}

// ── Section widgets ───────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: clientsHeadingColor,
        letterSpacing: 0.1,
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, color: Color(0xFFF0F0EC));
  }
}

// ── Field wrapper ─────────────────────────────────────────────────────────────

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

// ── Date picker button ────────────────────────────────────────────────────────

class _DateButton extends StatelessWidget {
  final DateTime? date;
  final String? placeholder;
  final bool disabled;
  final VoidCallback onTap;

  const _DateButton({
    required this.date,
    required this.onTap,
    this.placeholder,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? null : onTap,
      borderRadius: clientsChipBorderRadius,
      child: InputDecorator(
        decoration: _inputDecoration(null),
        child: Text(
          date != null ? formatDate(date) : (placeholder ?? '—'),
          style: GoogleFonts.inter(
            fontSize: 14,
            color: date != null ? clientsBodyTextColor : clientsMutedTextColor,
          ),
        ),
      ),
    );
  }
}

// ── Dropdown helpers ──────────────────────────────────────────────────────────

DropdownMenuItem<T> _dropdownItem<T>(T value, String label) {
  return DropdownMenuItem<T>(
    value: value,
    child: Text(label, style: GoogleFonts.inter(fontSize: 14)),
  );
}

Widget _hintText(String text) {
  return Text(
    text,
    style: GoogleFonts.inter(fontSize: 14, color: clientsMutedTextColor),
  );
}

// ── Input decoration ──────────────────────────────────────────────────────────

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
