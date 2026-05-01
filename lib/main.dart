import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/application/providers/theme_provider.dart';
import 'package:nutritrack/presentation/layout/app_shell.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:nutritrack/presentation/screens/clients/clients_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: NutriTrackApp()));
}

class NutriTrackApp extends ConsumerWidget {
  const NutriTrackApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'NutriTrack',
      debugShowCheckedModeBanner: false,
      home: const AppShell(child: ClientsScreen()),
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: clientsBrandColor,
          surface: Colors.white,
          onSurface: const Color(0xFF20201D),
          onSurfaceVariant: const Color(0xFF7A7A73),
          outlineVariant: const Color(0xFFE2E2DD),
          surfaceContainer: const Color(0xFFF4F4F2),
          surfaceContainerHighest: const Color(0xFFF1F1ED),
          primaryContainer: const Color(0xFFDCEFE9),
        ),
        datePickerTheme: DatePickerThemeData(
          backgroundColor: Colors.white,
          headerBackgroundColor: clientsBrandColor,
          headerForegroundColor: Colors.white,
          dayForegroundColor: WidgetStatePropertyAll(clientsBodyTextColor),
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          textStyle: GoogleFonts.inter(),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF0C8A6B),
          surface: const Color(0xFF1C1C1C),
          onSurface: const Color(0xFFE2E2DD),
          surfaceContainer: const Color(0xFF272727),
          surfaceContainerHighest: const Color(0xFF333333),
          outlineVariant: const Color(0xFF3A3A3A),
          onSurfaceVariant: const Color(0xFF9A9A93),
          primaryContainer: const Color(0xFF0D2B24),
        ),
        datePickerTheme: DatePickerThemeData(
          headerBackgroundColor: clientsBrandColor,
          headerForegroundColor: Colors.white,
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          textStyle: GoogleFonts.inter(),
        ),
      ),
    );
  }
}