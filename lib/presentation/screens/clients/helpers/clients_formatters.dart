import 'package:flutter/material.dart';
import 'package:nutritrack/data/db/tables/clients.dart';
import 'package:nutritrack/data/db/tables/enums.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';

String getClientInitials(String name) {
  final trimmed = name.trim();
  if (trimmed.isEmpty) return '?';

  final parts = trimmed.split(' ').where((part) => part.isNotEmpty).toList();

  if (parts.length >= 2) {
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  return parts.first.substring(0, 1).toUpperCase();
}

int? calculateClientAge(DateTime? birthDate) {
  if (birthDate == null) return null;

  final now = DateTime.now();
  int age = now.year - birthDate.year;

  if (now.month < birthDate.month ||
      (now.month == birthDate.month && now.day < birthDate.day)) {
    age--;
  }

  return age;
}

// ── Date formatting ───────────────────────────────────────────────────────────

String formatDate(DateTime? date) {
  if (date == null) return '—';
  final d = date.day.toString().padLeft(2, '0');
  final m = date.month.toString().padLeft(2, '0');
  return '$d/$m/${date.year}';
}

// ── Sex label ─────────────────────────────────────────────────────────────────

extension SexPresentation on Sex {
  String get label {
    switch (this) {
      case Sex.male:
        return 'Masculino';
      case Sex.female:
        return 'Femenino';
    }
  }
}

// ── PhysicalActivity label ────────────────────────────────────────────────────

extension PhysicalActivityPresentation on PhysicalActivity {
  String get label {
    switch (this) {
      case PhysicalActivity.sedentary:
        return 'Sedentario';
      case PhysicalActivity.light:
        return 'Ligero';
      case PhysicalActivity.moderate:
        return 'Moderado';
      case PhysicalActivity.active:
        return 'Activo';
      case PhysicalActivity.veryActive:
        return 'Muy activo';
    }
  }
}

// ── ClientStatus ──────────────────────────────────────────────────────────────

extension ClientStatusPresentation on ClientStatus {
  String get label {
    switch (this) {
      case ClientStatus.active:
        return 'Activo';
      case ClientStatus.inactive:
        return 'Inactivo';
      case ClientStatus.pending:
        return 'Pendiente';
    }
  }

  Color get color {
    switch (this) {
      case ClientStatus.active:
        return clientsBrandColor;
      case ClientStatus.inactive:
        return const Color(0xFFB6B6AF);
      case ClientStatus.pending:
        return const Color(0xFFE3A12A);
    }
  }
}