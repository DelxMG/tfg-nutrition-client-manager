import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutritrack/data/db/app_database.dart';
import 'package:nutritrack/data/repositories/client_repository.dart';
import 'package:nutritrack/data/repositories/client_summary_repository.dart';
import 'package:nutritrack/data/repositories/measurement_repository.dart';

/// Single [AppDatabase] instance for the entire app lifetime.
/// The connection is closed automatically when the [ProviderScope] is disposed
/// (i.e. when the app shuts down).
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// [ClientRepository] built on top of the shared [AppDatabase].
final clientRepositoryProvider = Provider<ClientRepository>((ref) {
  return ClientRepository(ref.watch(appDatabaseProvider));
});

/// [ClientSummaryRepository] built on top of the shared [AppDatabase].
final clientSummaryRepositoryProvider = Provider<ClientSummaryRepository>((ref) {
  return ClientSummaryRepository(ref.watch(appDatabaseProvider));
});

/// [MeasurementRepository] built on top of the shared [AppDatabase].
final measurementRepositoryProvider = Provider<MeasurementRepository>((ref) {
  return MeasurementRepository(ref.watch(appDatabaseProvider));
});

/// Reactive list of all measurements for a given client, ordered by date desc.
final clientMeasurementsProvider =
    StreamProvider.family<List<Measurement>, int>((ref, clientId) {
  return ref
      .watch(measurementRepositoryProvider)
      .watchMeasurementsByClientId(clientId);
});
