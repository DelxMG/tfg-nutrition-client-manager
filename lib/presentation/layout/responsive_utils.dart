import 'package:flutter/material.dart';

// ── Breakpoints ───────────────────────────────────────────────────────────────

const double kMobileBreakpoint = 600;
const double kTabletBreakpoint = 1024;

// ── Screen type enum ──────────────────────────────────────────────────────────

enum ScreenType { mobile, tablet, desktop }

// ── Width helpers ─────────────────────────────────────────────────────────────

bool isMobileWidth(double width) => width < kMobileBreakpoint;
bool isTabletWidth(double width) =>
    width >= kMobileBreakpoint && width < kTabletBreakpoint;
bool isDesktopWidth(double width) => width >= kTabletBreakpoint;

ScreenType screenTypeOf(double width) {
  if (isMobileWidth(width)) return ScreenType.mobile;
  if (isTabletWidth(width)) return ScreenType.tablet;
  return ScreenType.desktop;
}

// ── BuildContext extension ────────────────────────────────────────────────────

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  ScreenType get screenType => screenTypeOf(screenWidth);
  bool get isMobile => screenType == ScreenType.mobile;
  bool get isTablet => screenType == ScreenType.tablet;
  bool get isDesktop => screenType == ScreenType.desktop;
}
