import '../db/app_database.dart';
import '../models/client_summary.dart';
import 'anamnesis_repository.dart';
import 'client_repository.dart';
import 'measurement_repository.dart';

class ClientSummaryRepository {
  final ClientRepository _clientRepository;
  final AnamnesisRepository _anamnesisRepository;
  final MeasurementRepository _measurementRepository;

  ClientSummaryRepository(AppDatabase db)
      : _clientRepository = ClientRepository(db),
        _anamnesisRepository = AnamnesisRepository(db),
        _measurementRepository = MeasurementRepository(db);

  /// Fetches client, anamnesis and latest measurement in parallel.
  /// Returns null if the client does not exist.
  Future<ClientSummary?> getClientSummary(int clientId) async {
    final clientFuture = _clientRepository.getClientById(clientId);
    final anamnesisFuture = _anamnesisRepository.getAnamnesisByClientId(clientId);
    final measurementFuture =
        _measurementRepository.getLatestMeasurementByClientId(clientId);

    final client = await clientFuture;
    if (client == null) return null;

    return ClientSummary(
      client: client,
      anamnesis: await anamnesisFuture,
      latestMeasurement: await measurementFuture,
    );
  }
}
