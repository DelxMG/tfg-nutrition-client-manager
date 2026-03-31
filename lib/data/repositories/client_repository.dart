import '../daos/client_dao.dart';
import '../db/tables/clients.dart';
import '../db/app_database.dart';

class ClientRepository {
  final ClientDao clientDao;

  ClientRepository(AppDatabase db) : clientDao = ClientDao(db);

  Future<int> insertClient({
    required String name,
    String? email,
    String? phone,
    int? height,
    Sex? sex,
    DateTime? birthDate,
    ClientStatus status = ClientStatus.active,
  }) {
    return clientDao.insertClient(
      name: name,
      email: email,
      phone: phone,
      height: height,
      sex: sex,
      birthDate: birthDate,
      status: status,
    );
  }

  Future<bool> updateClient(Client client) {
    return clientDao.updateClient(client);
  }

  Future<int> updateClientStatus(int clientId, ClientStatus status) {
    return clientDao.updateClientStatus(clientId, status);
  }

  Future<Client?> getClientById(int clientId) {
    return clientDao.getClientById(clientId);
  }

  Stream<List<Client>> watchAllClients() {
    return clientDao.watchAllClients();
  }

  Stream<List<Client>> watchClients({
    String search = '',
    ClientStatus? status,
  }) {
    return clientDao.watchClients(search: search, status: status);
  }

  Future<int> deleteClient(int clientId) {
    return clientDao.deleteClient(clientId);
  }
}