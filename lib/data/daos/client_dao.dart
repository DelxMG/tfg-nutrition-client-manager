import 'package:drift/drift.dart';
import '../db/app_database.dart';
import '../db/tables/clients.dart';

part 'client_dao.g.dart';

@DriftAccessor(tables: [Clients])
class ClientDao extends DatabaseAccessor<AppDatabase> with _$ClientDaoMixin {
  ClientDao(super.db);

  Future<int> insertClient({
    required String name,
    String? email,
    String? phone,
    int? height,
    Sex? sex,
    DateTime? birthDate,
    ClientStatus status = ClientStatus.active,
  }) {
    return into(clients).insert(
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

  Future<bool> updateClient(Client client) {
    return update(clients).replace(client);
  }

  Future<int> updateClientStatus(int clientId, ClientStatus status) {
    return (update(clients)..where((tbl) => tbl.clientId.equals(clientId))).write(
      ClientsCompanion(
        status: Value(status),
      ),
    );
  }

  Future<Client?> getClientById(int clientId) {
    return (select(clients)..where((tbl) => tbl.clientId.equals(clientId)))
        .getSingleOrNull();
  }

  Stream<Client?> watchClientById(int clientId) {
    return (select(clients)..where((tbl) => tbl.clientId.equals(clientId)))
        .watchSingleOrNull();
  }

  Stream<List<Client>> watchAllClients() {
    return (select(clients)
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.name)]))
        .watch();
  }

  Stream<List<Client>> watchClients({
    String search = '',
    ClientStatus? status,
  }) {
    final query = select(clients)
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.name)]);

    final normalizedSearch = search.trim();

    if (normalizedSearch.isNotEmpty) {
      query.where((tbl) => tbl.name.like('%$normalizedSearch%'));
    }

    if (status != null) {
      query.where((tbl) => tbl.status.equals(status.index));
    }

    return query.watch();
  }

  Future<int> deleteClient(int clientId) {
    return (delete(clients)..where((tbl) => tbl.clientId.equals(clientId))).go();
  }
}