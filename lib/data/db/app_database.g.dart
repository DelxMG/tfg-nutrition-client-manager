// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
    'client_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Sex?, int> sex =
      GeneratedColumn<int>(
        'sex',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<Sex?>($ClientsTable.$convertersexn);
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
    'birth_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ClientStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(ClientStatus.active.index),
      ).withConverter<ClientStatus>($ClientsTable.$converterstatus);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    clientId,
    name,
    email,
    phone,
    height,
    sex,
    birthDate,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Client> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clientId};
  @override
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Client(
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height'],
      ),
      sex: $ClientsTable.$convertersexn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sex'],
        ),
      ),
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birth_date'],
      ),
      status: $ClientsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Sex, int, int> $convertersex =
      const EnumIndexConverter<Sex>(Sex.values);
  static JsonTypeConverter2<Sex?, int?, int?> $convertersexn =
      JsonTypeConverter2.asNullable($convertersex);
  static JsonTypeConverter2<ClientStatus, int, int> $converterstatus =
      const EnumIndexConverter<ClientStatus>(ClientStatus.values);
}

class Client extends DataClass implements Insertable<Client> {
  final int clientId;
  final String name;
  final String? email;
  final String? phone;
  final int? height;
  final Sex? sex;
  final DateTime? birthDate;
  final ClientStatus status;
  final DateTime createdAt;
  const Client({
    required this.clientId,
    required this.name,
    this.email,
    this.phone,
    this.height,
    this.sex,
    this.birthDate,
    required this.status,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_id'] = Variable<int>(clientId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<int>(height);
    }
    if (!nullToAbsent || sex != null) {
      map['sex'] = Variable<int>($ClientsTable.$convertersexn.toSql(sex));
    }
    if (!nullToAbsent || birthDate != null) {
      map['birth_date'] = Variable<DateTime>(birthDate);
    }
    {
      map['status'] = Variable<int>(
        $ClientsTable.$converterstatus.toSql(status),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      clientId: Value(clientId),
      name: Value(name),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      sex: sex == null && nullToAbsent ? const Value.absent() : Value(sex),
      birthDate: birthDate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDate),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory Client.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      clientId: serializer.fromJson<int>(json['clientId']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      height: serializer.fromJson<int?>(json['height']),
      sex: $ClientsTable.$convertersexn.fromJson(
        serializer.fromJson<int?>(json['sex']),
      ),
      birthDate: serializer.fromJson<DateTime?>(json['birthDate']),
      status: $ClientsTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientId': serializer.toJson<int>(clientId),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'height': serializer.toJson<int?>(height),
      'sex': serializer.toJson<int?>($ClientsTable.$convertersexn.toJson(sex)),
      'birthDate': serializer.toJson<DateTime?>(birthDate),
      'status': serializer.toJson<int>(
        $ClientsTable.$converterstatus.toJson(status),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Client copyWith({
    int? clientId,
    String? name,
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<int?> height = const Value.absent(),
    Value<Sex?> sex = const Value.absent(),
    Value<DateTime?> birthDate = const Value.absent(),
    ClientStatus? status,
    DateTime? createdAt,
  }) => Client(
    clientId: clientId ?? this.clientId,
    name: name ?? this.name,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    height: height.present ? height.value : this.height,
    sex: sex.present ? sex.value : this.sex,
    birthDate: birthDate.present ? birthDate.value : this.birthDate,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
  Client copyWithCompanion(ClientsCompanion data) {
    return Client(
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      height: data.height.present ? data.height.value : this.height,
      sex: data.sex.present ? data.sex.value : this.sex,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('clientId: $clientId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('height: $height, ')
          ..write('sex: $sex, ')
          ..write('birthDate: $birthDate, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    clientId,
    name,
    email,
    phone,
    height,
    sex,
    birthDate,
    status,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.clientId == this.clientId &&
          other.name == this.name &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.height == this.height &&
          other.sex == this.sex &&
          other.birthDate == this.birthDate &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<int> clientId;
  final Value<String> name;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<int?> height;
  final Value<Sex?> sex;
  final Value<DateTime?> birthDate;
  final Value<ClientStatus> status;
  final Value<DateTime> createdAt;
  const ClientsCompanion({
    this.clientId = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.height = const Value.absent(),
    this.sex = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ClientsCompanion.insert({
    this.clientId = const Value.absent(),
    required String name,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.height = const Value.absent(),
    this.sex = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Client> custom({
    Expression<int>? clientId,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<int>? height,
    Expression<int>? sex,
    Expression<DateTime>? birthDate,
    Expression<int>? status,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (clientId != null) 'client_id': clientId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (height != null) 'height': height,
      if (sex != null) 'sex': sex,
      if (birthDate != null) 'birth_date': birthDate,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ClientsCompanion copyWith({
    Value<int>? clientId,
    Value<String>? name,
    Value<String?>? email,
    Value<String?>? phone,
    Value<int?>? height,
    Value<Sex?>? sex,
    Value<DateTime?>? birthDate,
    Value<ClientStatus>? status,
    Value<DateTime>? createdAt,
  }) {
    return ClientsCompanion(
      clientId: clientId ?? this.clientId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      height: height ?? this.height,
      sex: sex ?? this.sex,
      birthDate: birthDate ?? this.birthDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (sex.present) {
      map['sex'] = Variable<int>($ClientsTable.$convertersexn.toSql(sex.value));
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $ClientsTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('clientId: $clientId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('height: $height, ')
          ..write('sex: $sex, ')
          ..write('birthDate: $birthDate, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientsTable clients = $ClientsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [clients];
}

typedef $$ClientsTableCreateCompanionBuilder =
    ClientsCompanion Function({
      Value<int> clientId,
      required String name,
      Value<String?> email,
      Value<String?> phone,
      Value<int?> height,
      Value<Sex?> sex,
      Value<DateTime?> birthDate,
      Value<ClientStatus> status,
      Value<DateTime> createdAt,
    });
typedef $$ClientsTableUpdateCompanionBuilder =
    ClientsCompanion Function({
      Value<int> clientId,
      Value<String> name,
      Value<String?> email,
      Value<String?> phone,
      Value<int?> height,
      Value<Sex?> sex,
      Value<DateTime?> birthDate,
      Value<ClientStatus> status,
      Value<DateTime> createdAt,
    });

class $$ClientsTableFilterComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Sex?, Sex, int> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ClientStatus, ClientStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClientsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Sex?, int> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ClientStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ClientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientsTable,
          Client,
          $$ClientsTableFilterComposer,
          $$ClientsTableOrderingComposer,
          $$ClientsTableAnnotationComposer,
          $$ClientsTableCreateCompanionBuilder,
          $$ClientsTableUpdateCompanionBuilder,
          (Client, BaseReferences<_$AppDatabase, $ClientsTable, Client>),
          Client,
          PrefetchHooks Function()
        > {
  $$ClientsTableTableManager(_$AppDatabase db, $ClientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> clientId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<Sex?> sex = const Value.absent(),
                Value<DateTime?> birthDate = const Value.absent(),
                Value<ClientStatus> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ClientsCompanion(
                clientId: clientId,
                name: name,
                email: email,
                phone: phone,
                height: height,
                sex: sex,
                birthDate: birthDate,
                status: status,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> clientId = const Value.absent(),
                required String name,
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<Sex?> sex = const Value.absent(),
                Value<DateTime?> birthDate = const Value.absent(),
                Value<ClientStatus> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ClientsCompanion.insert(
                clientId: clientId,
                name: name,
                email: email,
                phone: phone,
                height: height,
                sex: sex,
                birthDate: birthDate,
                status: status,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientsTable,
      Client,
      $$ClientsTableFilterComposer,
      $$ClientsTableOrderingComposer,
      $$ClientsTableAnnotationComposer,
      $$ClientsTableCreateCompanionBuilder,
      $$ClientsTableUpdateCompanionBuilder,
      (Client, BaseReferences<_$AppDatabase, $ClientsTable, Client>),
      Client,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
}
