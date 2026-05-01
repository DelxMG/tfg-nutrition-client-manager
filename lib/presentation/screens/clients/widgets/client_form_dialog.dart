import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/data/repositories/client_repository.dart';
import 'package:nutritrack/domain/enums.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';

class ClientFormDialog extends StatefulWidget {
  final ClientRepository repository;

  const ClientFormDialog({super.key, required this.repository});

  @override
  State<ClientFormDialog> createState() => _ClientFormDialogState();
}

class _ClientFormDialogState extends State<ClientFormDialog> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _heightController = TextEditingController();

  Sex? _sex;
  ClientStatus _status = ClientStatus.active;
  DateTime? _birthDate;
  bool _submitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _birthDate = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);

    try {
      await widget.repository.insertClient(
        name: _nameController.text.trim(),
        email: _emailController.text.trim().isEmpty
            ? null
            : _emailController.text.trim(),
        phone: _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
        height: int.tryParse(_heightController.text.trim()),
        sex: _sex,
        birthDate: _birthDate,
        status: _status,
      );

      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      setState(() => _submitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al guardar el cliente. Inténtalo de nuevo.'),
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
        width: 480,
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
                      'Nuevo cliente',
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

                // ── Nombre ───────────────────────────────────────────────
                _Field(
                  label: 'Nombre *',
                  child: TextFormField(
                    controller: _nameController,
                    enabled: !_submitting,
                    decoration: _dec('Nombre completo', cs),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'El nombre es obligatorio';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 14),

                // ── Email / Teléfono ──────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: _Field(
                        label: 'Email',
                        child: TextFormField(
                          controller: _emailController,
                          enabled: !_submitting,
                          decoration: _dec('correo@ejemplo.com', cs),
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return null;

                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                            if (!emailRegex.hasMatch(v.trim())) {
                              return 'Email inválido';
                            }

                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _Field(
                        label: 'Teléfono',
                        child: TextFormField(
                          controller: _phoneController,
                          enabled: !_submitting,
                          decoration: _dec('+34 600 000 000', cs),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // ── Altura / Sexo ─────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: _Field(
                        label: 'Altura (cm)',
                        child: TextFormField(
                          controller: _heightController,
                          enabled: !_submitting,
                          decoration: _dec('170', cs),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (v) {
                            if (v == null || v.isEmpty) return null;

                            final height = int.tryParse(v);
                            if (height == null || height <= 0) {
                              return 'Altura inválida';
                            }

                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _Field(
                        label: 'Sexo',
                        child: DropdownButtonFormField<Sex>(
                          value: _sex,
                          decoration: _dec(null, cs),
                          hint: Text(
                            'Seleccionar',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                                value: Sex.male, child: Text('Hombre')),
                            DropdownMenuItem(
                                value: Sex.female, child: Text('Mujer')),
                          ],
                          onChanged:
                              _submitting ? null : (v) => setState(() => _sex = v),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // ── Fecha nacimiento / Estado ─────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: _Field(
                        label: 'Fecha de nacimiento',
                        child: InkWell(
                          onTap: _submitting ? null : _pickDate,
                          borderRadius: clientsChipBorderRadius,
                          child: InputDecorator(
                            decoration: _dec(null, cs),
                            child: Text(
                              _birthDate == null
                                  ? 'Seleccionar fecha'
                                  : '${_birthDate!.day.toString().padLeft(2, '0')}/'
                                      '${_birthDate!.month.toString().padLeft(2, '0')}/'
                                      '${_birthDate!.year}',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: _birthDate == null
                                    ? cs.onSurfaceVariant
                                    : cs.onSurface,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _Field(
                        label: 'Estado',
                        child: DropdownButtonFormField<ClientStatus>(
                          value: _status,
                          decoration: _dec(null, cs),
                          items: const [
                            DropdownMenuItem(
                                value: ClientStatus.active,
                                child: Text('Activo')),
                            DropdownMenuItem(
                                value: ClientStatus.inactive,
                                child: Text('Inactivo')),
                            DropdownMenuItem(
                                value: ClientStatus.pending,
                                child: Text('Pendiente')),
                          ],
                          onChanged: _submitting
                              ? null
                              : (v) => setState(() => _status = v!),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // ── Botones ───────────────────────────────────────────────
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
    hintStyle: GoogleFonts.inter(
      fontSize: 14,
      color: cs.onSurfaceVariant,
    ),
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
