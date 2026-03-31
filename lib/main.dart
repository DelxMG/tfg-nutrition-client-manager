import 'package:flutter/material.dart';
import 'package:nutritrack/presentation/screens/clients/clients_screen.dart';

void main() {
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
    );
  }
}
