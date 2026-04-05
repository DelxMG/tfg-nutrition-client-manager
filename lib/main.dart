import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/presentation/screens/clients/clients_constants.dart';
import 'package:nutritrack/presentation/screens/clients/clients_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NutriTrackApp());
}

class NutriTrackApp extends StatelessWidget {
  const NutriTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriTrack',
      debugShowCheckedModeBanner: false,
      home: const ClientsScreen(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: clientsBrandColor,
          surface: Colors.white,
          onSurface: clientsBodyTextColor,
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
    );
  }
}