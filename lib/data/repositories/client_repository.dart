import 'package:drift/drift.dart';
import '../db/tables/clients.dart';
import '../db/app_database.dart';

class ClientRepository {
  final AppDatabase db;

  ClientRepository(this.db);

  Future<int> insertClient({
    required String name,
    String? email,
    String? phone,
    int? height,
    Sex? sex,
    DateTime? birthDate,
    ClientStatus status = ClientStatus.active,
  }) {
    return db
        .into(db.clients)
        .insert(
          ClientsCompanion.insert(
            name: name,
            email: Value(email),
            phone: Value(phone),
            height: Value(height),
            sex: Value(sex),
            birthDate: Value(birthDate),
            status: Value(status),
          ),
        );
  }

  Stream<List<Client>> watchAllClients() {
    return (db.select(
      db.clients,
    )..orderBy([(tbl) => OrderingTerm.asc(tbl.name)])).watch();
  }
}
