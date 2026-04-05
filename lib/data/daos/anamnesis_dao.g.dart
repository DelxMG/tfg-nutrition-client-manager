// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anamnesis_dao.dart';

// ignore_for_file: type=lint
mixin _$AnamnesisDaoMixin on DatabaseAccessor<AppDatabase> {
  $ClientsTable get clients => attachedDatabase.clients;
  $AnamnesisTableTable get anamnesisTable => attachedDatabase.anamnesisTable;
  AnamnesisDaoManager get managers => AnamnesisDaoManager(this);
}

class AnamnesisDaoManager {
  final _$AnamnesisDaoMixin _db;
  AnamnesisDaoManager(this._db);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db.attachedDatabase, _db.clients);
  $$AnamnesisTableTableTableManager get anamnesisTable =>
      $$AnamnesisTableTableTableManager(
        _db.attachedDatabase,
        _db.anamnesisTable,
      );
}
