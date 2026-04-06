import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/presentation/layout/app_sidebar.dart';
import 'package:nutritrack/presentation/layout/app_top_bar.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';

/// Top-level layout: sidebar + topbar + a content slot.
/// Owns [isSidebarCollapsed] state so it never leaks into content screens.
class AppShell extends StatefulWidget {
  /// The main content area. Receives no layout concerns — only content.
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  bool _isSidebarCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.interTextTheme(Theme.of(context).textTheme);

    return Theme(
      data: Theme.of(context).copyWith(textTheme: textTheme),
      child: Scaffold(
        backgroundColor: clientsBgColor,
        body: Row(
          children: [
            AppSidebar(
              isCollapsed: _isSidebarCollapsed,
              onCollapse: () => setState(() => _isSidebarCollapsed = true),
              onExpand: () => setState(() => _isSidebarCollapsed = false),
            ),
            Expanded(
              child: Column(
                children: [
                  const AppTopBar(),
                  Expanded(child: widget.child),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
