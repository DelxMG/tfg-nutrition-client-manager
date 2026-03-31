import 'package:flutter/material.dart';

import 'data/db/app_database.dart';
import 'data/repositories/client_repository.dart';
import 'data/db/tables/clients.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase();
  final clientRepository = ClientRepository(db);

  final clientsBefore = await clientRepository.watchAllClients().first;
  debugPrint('Clientes antes del insert: $clientsBefore');

  await clientRepository.insertClient(
    name: 'Cliente prueba',
    email: 'prueba@test.com',
    phone: '600000000',
    height: 175,
    sex: Sex.male,
    status: ClientStatus.active,
  );

  final clientsAfter = await clientRepository.watchAllClients().first;
  debugPrint('Clientes después del insert: $clientsAfter');

  runApp(const NutriTrackApp());
}

class NutriTrackApp extends StatelessWidget {
  const NutriTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriTrack',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: Text('Prueba Drift OK'),
        ),
      ),
    );
  }
}