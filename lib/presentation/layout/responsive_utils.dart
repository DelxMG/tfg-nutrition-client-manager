import 'package:flutter/material.dart';

// ── Breakpoints ───────────────────────────────────────────────────────────────

const double kCompactBreakpoint = 1024;

// ── Width helpers ─────────────────────────────────────────────────────────────

bool isCompactWidth(double width) => width < kCompactBreakpoint;
bool isDesktopWidth(double width) => width >= kCompactBreakpoint;

// ── BuildContext extension ────────────────────────────────────────────────────

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  bool get isCompact => isCompactWidth(screenWidth);
  bool get isDesktop => isDesktopWidth(screenWidth);
}
