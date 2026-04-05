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

class $AnamnesisTableTable extends AnamnesisTable
    with TableInfo<$AnamnesisTableTable, AnamnesisTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnamnesisTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _anamnesisIdMeta = const VerificationMeta(
    'anamnesisId',
  );
  @override
  late final GeneratedColumn<int> anamnesisId = GeneratedColumn<int>(
    'anamnesis_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (client_id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _objectiveMeta = const VerificationMeta(
    'objective',
  );
  @override
  late final GeneratedColumn<String> objective = GeneratedColumn<String>(
    'objective',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _initialWeightMeta = const VerificationMeta(
    'initialWeight',
  );
  @override
  late final GeneratedColumn<double> initialWeight = GeneratedColumn<double>(
    'initial_weight',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _observationsMeta = const VerificationMeta(
    'observations',
  );
  @override
  late final GeneratedColumn<String> observations = GeneratedColumn<String>(
    'observations',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _supplementsMeta = const VerificationMeta(
    'supplements',
  );
  @override
  late final GeneratedColumn<String> supplements = GeneratedColumn<String>(
    'supplements',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _allergiesMeta = const VerificationMeta(
    'allergies',
  );
  @override
  late final GeneratedColumn<String> allergies = GeneratedColumn<String>(
    'allergies',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PhysicalActivity?, int>
  physicalActivity =
      GeneratedColumn<int>(
        'physical_activity',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<PhysicalActivity?>(
        $AnamnesisTableTable.$converterphysicalActivityn,
      );
  static const VerificationMeta _pathologiesMeta = const VerificationMeta(
    'pathologies',
  );
  @override
  late final GeneratedColumn<String> pathologies = GeneratedColumn<String>(
    'pathologies',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occupationMeta = const VerificationMeta(
    'occupation',
  );
  @override
  late final GeneratedColumn<String> occupation = GeneratedColumn<String>(
    'occupation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    anamnesisId,
    clientId,
    date,
    objective,
    initialWeight,
    observations,
    supplements,
    allergies,
    physicalActivity,
    pathologies,
    occupation,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'anamnesis';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnamnesisTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('anamnesis_id')) {
      context.handle(
        _anamnesisIdMeta,
        anamnesisId.isAcceptableOrUnknown(
          data['anamnesis_id']!,
          _anamnesisIdMeta,
        ),
      );
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('objective')) {
      context.handle(
        _objectiveMeta,
        objective.isAcceptableOrUnknown(data['objective']!, _objectiveMeta),
      );
    }
    if (data.containsKey('initial_weight')) {
      context.handle(
        _initialWeightMeta,
        initialWeight.isAcceptableOrUnknown(
          data['initial_weight']!,
          _initialWeightMeta,
        ),
      );
    }
    if (data.containsKey('observations')) {
      context.handle(
        _observationsMeta,
        observations.isAcceptableOrUnknown(
          data['observations']!,
          _observationsMeta,
        ),
      );
    }
    if (data.containsKey('supplements')) {
      context.handle(
        _supplementsMeta,
        supplements.isAcceptableOrUnknown(
          data['supplements']!,
          _supplementsMeta,
        ),
      );
    }
    if (data.containsKey('allergies')) {
      context.handle(
        _allergiesMeta,
        allergies.isAcceptableOrUnknown(data['allergies']!, _allergiesMeta),
      );
    }
    if (data.containsKey('pathologies')) {
      context.handle(
        _pathologiesMeta,
        pathologies.isAcceptableOrUnknown(
          data['pathologies']!,
          _pathologiesMeta,
        ),
      );
    }
    if (data.containsKey('occupation')) {
      context.handle(
        _occupationMeta,
        occupation.isAcceptableOrUnknown(data['occupation']!, _occupationMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {anamnesisId};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {clientId},
  ];
  @override
  AnamnesisTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnamnesisTableData(
      anamnesisId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}anamnesis_id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      objective: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}objective'],
      ),
      initialWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}initial_weight'],
      ),
      observations: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observations'],
      ),
      supplements: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplements'],
      ),
      allergies: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}allergies'],
      ),
      physicalActivity: $AnamnesisTableTable.$converterphysicalActivityn
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}physical_activity'],
            ),
          ),
      pathologies: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pathologies'],
      ),
      occupation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}occupation'],
      ),
    );
  }

  @override
  $AnamnesisTableTable createAlias(String alias) {
    return $AnamnesisTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PhysicalActivity, int, int>
  $converterphysicalActivity = const EnumIndexConverter<PhysicalActivity>(
    PhysicalActivity.values,
  );
  static JsonTypeConverter2<PhysicalActivity?, int?, int?>
  $converterphysicalActivityn = JsonTypeConverter2.asNullable(
    $converterphysicalActivity,
  );
}

class AnamnesisTableData extends DataClass
    implements Insertable<AnamnesisTableData> {
  final int anamnesisId;
  final int clientId;
  final DateTime date;
  final String? objective;
  final double? initialWeight;
  final String? observations;
  final String? supplements;
  final String? allergies;
  final PhysicalActivity? physicalActivity;
  final String? pathologies;
  final String? occupation;
  const AnamnesisTableData({
    required this.anamnesisId,
    required this.clientId,
    required this.date,
    this.objective,
    this.initialWeight,
    this.observations,
    this.supplements,
    this.allergies,
    this.physicalActivity,
    this.pathologies,
    this.occupation,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['anamnesis_id'] = Variable<int>(anamnesisId);
    map['client_id'] = Variable<int>(clientId);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || objective != null) {
      map['objective'] = Variable<String>(objective);
    }
    if (!nullToAbsent || initialWeight != null) {
      map['initial_weight'] = Variable<double>(initialWeight);
    }
    if (!nullToAbsent || observations != null) {
      map['observations'] = Variable<String>(observations);
    }
    if (!nullToAbsent || supplements != null) {
      map['supplements'] = Variable<String>(supplements);
    }
    if (!nullToAbsent || allergies != null) {
      map['allergies'] = Variable<String>(allergies);
    }
    if (!nullToAbsent || physicalActivity != null) {
      map['physical_activity'] = Variable<int>(
        $AnamnesisTableTable.$converterphysicalActivityn.toSql(
          physicalActivity,
        ),
      );
    }
    if (!nullToAbsent || pathologies != null) {
      map['pathologies'] = Variable<String>(pathologies);
    }
    if (!nullToAbsent || occupation != null) {
      map['occupation'] = Variable<String>(occupation);
    }
    return map;
  }

  AnamnesisTableCompanion toCompanion(bool nullToAbsent) {
    return AnamnesisTableCompanion(
      anamnesisId: Value(anamnesisId),
      clientId: Value(clientId),
      date: Value(date),
      objective: objective == null && nullToAbsent
          ? const Value.absent()
          : Value(objective),
      initialWeight: initialWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(initialWeight),
      observations: observations == null && nullToAbsent
          ? const Value.absent()
          : Value(observations),
      supplements: supplements == null && nullToAbsent
          ? const Value.absent()
          : Value(supplements),
      allergies: allergies == null && nullToAbsent
          ? const Value.absent()
          : Value(allergies),
      physicalActivity: physicalActivity == null && nullToAbsent
          ? const Value.absent()
          : Value(physicalActivity),
      pathologies: pathologies == null && nullToAbsent
          ? const Value.absent()
          : Value(pathologies),
      occupation: occupation == null && nullToAbsent
          ? const Value.absent()
          : Value(occupation),
    );
  }

  factory AnamnesisTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnamnesisTableData(
      anamnesisId: serializer.fromJson<int>(json['anamnesisId']),
      clientId: serializer.fromJson<int>(json['clientId']),
      date: serializer.fromJson<DateTime>(json['date']),
      objective: serializer.fromJson<String?>(json['objective']),
      initialWeight: serializer.fromJson<double?>(json['initialWeight']),
      observations: serializer.fromJson<String?>(json['observations']),
      supplements: serializer.fromJson<String?>(json['supplements']),
      allergies: serializer.fromJson<String?>(json['allergies']),
      physicalActivity: $AnamnesisTableTable.$converterphysicalActivityn
          .fromJson(serializer.fromJson<int?>(json['physicalActivity'])),
      pathologies: serializer.fromJson<String?>(json['pathologies']),
      occupation: serializer.fromJson<String?>(json['occupation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'anamnesisId': serializer.toJson<int>(anamnesisId),
      'clientId': serializer.toJson<int>(clientId),
      'date': serializer.toJson<DateTime>(date),
      'objective': serializer.toJson<String?>(objective),
      'initialWeight': serializer.toJson<double?>(initialWeight),
      'observations': serializer.toJson<String?>(observations),
      'supplements': serializer.toJson<String?>(supplements),
      'allergies': serializer.toJson<String?>(allergies),
      'physicalActivity': serializer.toJson<int?>(
        $AnamnesisTableTable.$converterphysicalActivityn.toJson(
          physicalActivity,
        ),
      ),
      'pathologies': serializer.toJson<String?>(pathologies),
      'occupation': serializer.toJson<String?>(occupation),
    };
  }

  AnamnesisTableData copyWith({
    int? anamnesisId,
    int? clientId,
    DateTime? date,
    Value<String?> objective = const Value.absent(),
    Value<double?> initialWeight = const Value.absent(),
    Value<String?> observations = const Value.absent(),
    Value<String?> supplements = const Value.absent(),
    Value<String?> allergies = const Value.absent(),
    Value<PhysicalActivity?> physicalActivity = const Value.absent(),
    Value<String?> pathologies = const Value.absent(),
    Value<String?> occupation = const Value.absent(),
  }) => AnamnesisTableData(
    anamnesisId: anamnesisId ?? this.anamnesisId,
    clientId: clientId ?? this.clientId,
    date: date ?? this.date,
    objective: objective.present ? objective.value : this.objective,
    initialWeight: initialWeight.present
        ? initialWeight.value
        : this.initialWeight,
    observations: observations.present ? observations.value : this.observations,
    supplements: supplements.present ? supplements.value : this.supplements,
    allergies: allergies.present ? allergies.value : this.allergies,
    physicalActivity: physicalActivity.present
        ? physicalActivity.value
        : this.physicalActivity,
    pathologies: pathologies.present ? pathologies.value : this.pathologies,
    occupation: occupation.present ? occupation.value : this.occupation,
  );
  AnamnesisTableData copyWithCompanion(AnamnesisTableCompanion data) {
    return AnamnesisTableData(
      anamnesisId: data.anamnesisId.present
          ? data.anamnesisId.value
          : this.anamnesisId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      date: data.date.present ? data.date.value : this.date,
      objective: data.objective.present ? data.objective.value : this.objective,
      initialWeight: data.initialWeight.present
          ? data.initialWeight.value
          : this.initialWeight,
      observations: data.observations.present
          ? data.observations.value
          : this.observations,
      supplements: data.supplements.present
          ? data.supplements.value
          : this.supplements,
      allergies: data.allergies.present ? data.allergies.value : this.allergies,
      physicalActivity: data.physicalActivity.present
          ? data.physicalActivity.value
          : this.physicalActivity,
      pathologies: data.pathologies.present
          ? data.pathologies.value
          : this.pathologies,
      occupation: data.occupation.present
          ? data.occupation.value
          : this.occupation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnamnesisTableData(')
          ..write('anamnesisId: $anamnesisId, ')
          ..write('clientId: $clientId, ')
          ..write('date: $date, ')
          ..write('objective: $objective, ')
          ..write('initialWeight: $initialWeight, ')
          ..write('observations: $observations, ')
          ..write('supplements: $supplements, ')
          ..write('allergies: $allergies, ')
          ..write('physicalActivity: $physicalActivity, ')
          ..write('pathologies: $pathologies, ')
          ..write('occupation: $occupation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    anamnesisId,
    clientId,
    date,
    objective,
    initialWeight,
    observations,
    supplements,
    allergies,
    physicalActivity,
    pathologies,
    occupation,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnamnesisTableData &&
          other.anamnesisId == this.anamnesisId &&
          other.clientId == this.clientId &&
          other.date == this.date &&
          other.objective == this.objective &&
          other.initialWeight == this.initialWeight &&
          other.observations == this.observations &&
          other.supplements == this.supplements &&
          other.allergies == this.allergies &&
          other.physicalActivity == this.physicalActivity &&
          other.pathologies == this.pathologies &&
          other.occupation == this.occupation);
}

class AnamnesisTableCompanion extends UpdateCompanion<AnamnesisTableData> {
  final Value<int> anamnesisId;
  final Value<int> clientId;
  final Value<DateTime> date;
  final Value<String?> objective;
  final Value<double?> initialWeight;
  final Value<String?> observations;
  final Value<String?> supplements;
  final Value<String?> allergies;
  final Value<PhysicalActivity?> physicalActivity;
  final Value<String?> pathologies;
  final Value<String?> occupation;
  const AnamnesisTableCompanion({
    this.anamnesisId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.date = const Value.absent(),
    this.objective = const Value.absent(),
    this.initialWeight = const Value.absent(),
    this.observations = const Value.absent(),
    this.supplements = const Value.absent(),
    this.allergies = const Value.absent(),
    this.physicalActivity = const Value.absent(),
    this.pathologies = const Value.absent(),
    this.occupation = const Value.absent(),
  });
  AnamnesisTableCompanion.insert({
    this.anamnesisId = const Value.absent(),
    required int clientId,
    this.date = const Value.absent(),
    this.objective = const Value.absent(),
    this.initialWeight = const Value.absent(),
    this.observations = const Value.absent(),
    this.supplements = const Value.absent(),
    this.allergies = const Value.absent(),
    this.physicalActivity = const Value.absent(),
    this.pathologies = const Value.absent(),
    this.occupation = const Value.absent(),
  }) : clientId = Value(clientId);
  static Insertable<AnamnesisTableData> custom({
    Expression<int>? anamnesisId,
    Expression<int>? clientId,
    Expression<DateTime>? date,
    Expression<String>? objective,
    Expression<double>? initialWeight,
    Expression<String>? observations,
    Expression<String>? supplements,
    Expression<String>? allergies,
    Expression<int>? physicalActivity,
    Expression<String>? pathologies,
    Expression<String>? occupation,
  }) {
    return RawValuesInsertable({
      if (anamnesisId != null) 'anamnesis_id': anamnesisId,
      if (clientId != null) 'client_id': clientId,
      if (date != null) 'date': date,
      if (objective != null) 'objective': objective,
      if (initialWeight != null) 'initial_weight': initialWeight,
      if (observations != null) 'observations': observations,
      if (supplements != null) 'supplements': supplements,
      if (allergies != null) 'allergies': allergies,
      if (physicalActivity != null) 'physical_activity': physicalActivity,
      if (pathologies != null) 'pathologies': pathologies,
      if (occupation != null) 'occupation': occupation,
    });
  }

  AnamnesisTableCompanion copyWith({
    Value<int>? anamnesisId,
    Value<int>? clientId,
    Value<DateTime>? date,
    Value<String?>? objective,
    Value<double?>? initialWeight,
    Value<String?>? observations,
    Value<String?>? supplements,
    Value<String?>? allergies,
    Value<PhysicalActivity?>? physicalActivity,
    Value<String?>? pathologies,
    Value<String?>? occupation,
  }) {
    return AnamnesisTableCompanion(
      anamnesisId: anamnesisId ?? this.anamnesisId,
      clientId: clientId ?? this.clientId,
      date: date ?? this.date,
      objective: objective ?? this.objective,
      initialWeight: initialWeight ?? this.initialWeight,
      observations: observations ?? this.observations,
      supplements: supplements ?? this.supplements,
      allergies: allergies ?? this.allergies,
      physicalActivity: physicalActivity ?? this.physicalActivity,
      pathologies: pathologies ?? this.pathologies,
      occupation: occupation ?? this.occupation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (anamnesisId.present) {
      map['anamnesis_id'] = Variable<int>(anamnesisId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (objective.present) {
      map['objective'] = Variable<String>(objective.value);
    }
    if (initialWeight.present) {
      map['initial_weight'] = Variable<double>(initialWeight.value);
    }
    if (observations.present) {
      map['observations'] = Variable<String>(observations.value);
    }
    if (supplements.present) {
      map['supplements'] = Variable<String>(supplements.value);
    }
    if (allergies.present) {
      map['allergies'] = Variable<String>(allergies.value);
    }
    if (physicalActivity.present) {
      map['physical_activity'] = Variable<int>(
        $AnamnesisTableTable.$converterphysicalActivityn.toSql(
          physicalActivity.value,
        ),
      );
    }
    if (pathologies.present) {
      map['pathologies'] = Variable<String>(pathologies.value);
    }
    if (occupation.present) {
      map['occupation'] = Variable<String>(occupation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnamnesisTableCompanion(')
          ..write('anamnesisId: $anamnesisId, ')
          ..write('clientId: $clientId, ')
          ..write('date: $date, ')
          ..write('objective: $objective, ')
          ..write('initialWeight: $initialWeight, ')
          ..write('observations: $observations, ')
          ..write('supplements: $supplements, ')
          ..write('allergies: $allergies, ')
          ..write('physicalActivity: $physicalActivity, ')
          ..write('pathologies: $pathologies, ')
          ..write('occupation: $occupation')
          ..write(')'))
        .toString();
  }
}

class $MeasurementsTable extends Measurements
    with TableInfo<$MeasurementsTable, Measurement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeasurementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _measurementIdMeta = const VerificationMeta(
    'measurementId',
  );
  @override
  late final GeneratedColumn<int> measurementId = GeneratedColumn<int>(
    'measurement_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (client_id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyFatMeta = const VerificationMeta(
    'bodyFat',
  );
  @override
  late final GeneratedColumn<double> bodyFat = GeneratedColumn<double>(
    'body_fat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _muscleMassMeta = const VerificationMeta(
    'muscleMass',
  );
  @override
  late final GeneratedColumn<double> muscleMass = GeneratedColumn<double>(
    'muscle_mass',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _armMeta = const VerificationMeta('arm');
  @override
  late final GeneratedColumn<double> arm = GeneratedColumn<double>(
    'arm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _thighMeta = const VerificationMeta('thigh');
  @override
  late final GeneratedColumn<double> thigh = GeneratedColumn<double>(
    'thigh',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chestMeta = const VerificationMeta('chest');
  @override
  late final GeneratedColumn<double> chest = GeneratedColumn<double>(
    'chest',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _waistMeta = const VerificationMeta('waist');
  @override
  late final GeneratedColumn<double> waist = GeneratedColumn<double>(
    'waist',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _calfMeta = const VerificationMeta('calf');
  @override
  late final GeneratedColumn<double> calf = GeneratedColumn<double>(
    'calf',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    measurementId,
    clientId,
    date,
    weight,
    bodyFat,
    muscleMass,
    arm,
    thigh,
    chest,
    waist,
    calf,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'measurements';
  @override
  VerificationContext validateIntegrity(
    Insertable<Measurement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('measurement_id')) {
      context.handle(
        _measurementIdMeta,
        measurementId.isAcceptableOrUnknown(
          data['measurement_id']!,
          _measurementIdMeta,
        ),
      );
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('body_fat')) {
      context.handle(
        _bodyFatMeta,
        bodyFat.isAcceptableOrUnknown(data['body_fat']!, _bodyFatMeta),
      );
    }
    if (data.containsKey('muscle_mass')) {
      context.handle(
        _muscleMassMeta,
        muscleMass.isAcceptableOrUnknown(data['muscle_mass']!, _muscleMassMeta),
      );
    }
    if (data.containsKey('arm')) {
      context.handle(
        _armMeta,
        arm.isAcceptableOrUnknown(data['arm']!, _armMeta),
      );
    }
    if (data.containsKey('thigh')) {
      context.handle(
        _thighMeta,
        thigh.isAcceptableOrUnknown(data['thigh']!, _thighMeta),
      );
    }
    if (data.containsKey('chest')) {
      context.handle(
        _chestMeta,
        chest.isAcceptableOrUnknown(data['chest']!, _chestMeta),
      );
    }
    if (data.containsKey('waist')) {
      context.handle(
        _waistMeta,
        waist.isAcceptableOrUnknown(data['waist']!, _waistMeta),
      );
    }
    if (data.containsKey('calf')) {
      context.handle(
        _calfMeta,
        calf.isAcceptableOrUnknown(data['calf']!, _calfMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {measurementId};
  @override
  Measurement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Measurement(
      measurementId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}measurement_id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      ),
      bodyFat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}body_fat'],
      ),
      muscleMass: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}muscle_mass'],
      ),
      arm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}arm'],
      ),
      thigh: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}thigh'],
      ),
      chest: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}chest'],
      ),
      waist: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}waist'],
      ),
      calf: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calf'],
      ),
    );
  }

  @override
  $MeasurementsTable createAlias(String alias) {
    return $MeasurementsTable(attachedDatabase, alias);
  }
}

class Measurement extends DataClass implements Insertable<Measurement> {
  final int measurementId;
  final int clientId;
  final DateTime date;
  final double? weight;
  final double? bodyFat;
  final double? muscleMass;
  final double? arm;
  final double? thigh;
  final double? chest;
  final double? waist;
  final double? calf;
  const Measurement({
    required this.measurementId,
    required this.clientId,
    required this.date,
    this.weight,
    this.bodyFat,
    this.muscleMass,
    this.arm,
    this.thigh,
    this.chest,
    this.waist,
    this.calf,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['measurement_id'] = Variable<int>(measurementId);
    map['client_id'] = Variable<int>(clientId);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || bodyFat != null) {
      map['body_fat'] = Variable<double>(bodyFat);
    }
    if (!nullToAbsent || muscleMass != null) {
      map['muscle_mass'] = Variable<double>(muscleMass);
    }
    if (!nullToAbsent || arm != null) {
      map['arm'] = Variable<double>(arm);
    }
    if (!nullToAbsent || thigh != null) {
      map['thigh'] = Variable<double>(thigh);
    }
    if (!nullToAbsent || chest != null) {
      map['chest'] = Variable<double>(chest);
    }
    if (!nullToAbsent || waist != null) {
      map['waist'] = Variable<double>(waist);
    }
    if (!nullToAbsent || calf != null) {
      map['calf'] = Variable<double>(calf);
    }
    return map;
  }

  MeasurementsCompanion toCompanion(bool nullToAbsent) {
    return MeasurementsCompanion(
      measurementId: Value(measurementId),
      clientId: Value(clientId),
      date: Value(date),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      bodyFat: bodyFat == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyFat),
      muscleMass: muscleMass == null && nullToAbsent
          ? const Value.absent()
          : Value(muscleMass),
      arm: arm == null && nullToAbsent ? const Value.absent() : Value(arm),
      thigh: thigh == null && nullToAbsent
          ? const Value.absent()
          : Value(thigh),
      chest: chest == null && nullToAbsent
          ? const Value.absent()
          : Value(chest),
      waist: waist == null && nullToAbsent
          ? const Value.absent()
          : Value(waist),
      calf: calf == null && nullToAbsent ? const Value.absent() : Value(calf),
    );
  }

  factory Measurement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Measurement(
      measurementId: serializer.fromJson<int>(json['measurementId']),
      clientId: serializer.fromJson<int>(json['clientId']),
      date: serializer.fromJson<DateTime>(json['date']),
      weight: serializer.fromJson<double?>(json['weight']),
      bodyFat: serializer.fromJson<double?>(json['bodyFat']),
      muscleMass: serializer.fromJson<double?>(json['muscleMass']),
      arm: serializer.fromJson<double?>(json['arm']),
      thigh: serializer.fromJson<double?>(json['thigh']),
      chest: serializer.fromJson<double?>(json['chest']),
      waist: serializer.fromJson<double?>(json['waist']),
      calf: serializer.fromJson<double?>(json['calf']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'measurementId': serializer.toJson<int>(measurementId),
      'clientId': serializer.toJson<int>(clientId),
      'date': serializer.toJson<DateTime>(date),
      'weight': serializer.toJson<double?>(weight),
      'bodyFat': serializer.toJson<double?>(bodyFat),
      'muscleMass': serializer.toJson<double?>(muscleMass),
      'arm': serializer.toJson<double?>(arm),
      'thigh': serializer.toJson<double?>(thigh),
      'chest': serializer.toJson<double?>(chest),
      'waist': serializer.toJson<double?>(waist),
      'calf': serializer.toJson<double?>(calf),
    };
  }

  Measurement copyWith({
    int? measurementId,
    int? clientId,
    DateTime? date,
    Value<double?> weight = const Value.absent(),
    Value<double?> bodyFat = const Value.absent(),
    Value<double?> muscleMass = const Value.absent(),
    Value<double?> arm = const Value.absent(),
    Value<double?> thigh = const Value.absent(),
    Value<double?> chest = const Value.absent(),
    Value<double?> waist = const Value.absent(),
    Value<double?> calf = const Value.absent(),
  }) => Measurement(
    measurementId: measurementId ?? this.measurementId,
    clientId: clientId ?? this.clientId,
    date: date ?? this.date,
    weight: weight.present ? weight.value : this.weight,
    bodyFat: bodyFat.present ? bodyFat.value : this.bodyFat,
    muscleMass: muscleMass.present ? muscleMass.value : this.muscleMass,
    arm: arm.present ? arm.value : this.arm,
    thigh: thigh.present ? thigh.value : this.thigh,
    chest: chest.present ? chest.value : this.chest,
    waist: waist.present ? waist.value : this.waist,
    calf: calf.present ? calf.value : this.calf,
  );
  Measurement copyWithCompanion(MeasurementsCompanion data) {
    return Measurement(
      measurementId: data.measurementId.present
          ? data.measurementId.value
          : this.measurementId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      date: data.date.present ? data.date.value : this.date,
      weight: data.weight.present ? data.weight.value : this.weight,
      bodyFat: data.bodyFat.present ? data.bodyFat.value : this.bodyFat,
      muscleMass: data.muscleMass.present
          ? data.muscleMass.value
          : this.muscleMass,
      arm: data.arm.present ? data.arm.value : this.arm,
      thigh: data.thigh.present ? data.thigh.value : this.thigh,
      chest: data.chest.present ? data.chest.value : this.chest,
      waist: data.waist.present ? data.waist.value : this.waist,
      calf: data.calf.present ? data.calf.value : this.calf,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Measurement(')
          ..write('measurementId: $measurementId, ')
          ..write('clientId: $clientId, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('bodyFat: $bodyFat, ')
          ..write('muscleMass: $muscleMass, ')
          ..write('arm: $arm, ')
          ..write('thigh: $thigh, ')
          ..write('chest: $chest, ')
          ..write('waist: $waist, ')
          ..write('calf: $calf')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    measurementId,
    clientId,
    date,
    weight,
    bodyFat,
    muscleMass,
    arm,
    thigh,
    chest,
    waist,
    calf,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Measurement &&
          other.measurementId == this.measurementId &&
          other.clientId == this.clientId &&
          other.date == this.date &&
          other.weight == this.weight &&
          other.bodyFat == this.bodyFat &&
          other.muscleMass == this.muscleMass &&
          other.arm == this.arm &&
          other.thigh == this.thigh &&
          other.chest == this.chest &&
          other.waist == this.waist &&
          other.calf == this.calf);
}

class MeasurementsCompanion extends UpdateCompanion<Measurement> {
  final Value<int> measurementId;
  final Value<int> clientId;
  final Value<DateTime> date;
  final Value<double?> weight;
  final Value<double?> bodyFat;
  final Value<double?> muscleMass;
  final Value<double?> arm;
  final Value<double?> thigh;
  final Value<double?> chest;
  final Value<double?> waist;
  final Value<double?> calf;
  const MeasurementsCompanion({
    this.measurementId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.date = const Value.absent(),
    this.weight = const Value.absent(),
    this.bodyFat = const Value.absent(),
    this.muscleMass = const Value.absent(),
    this.arm = const Value.absent(),
    this.thigh = const Value.absent(),
    this.chest = const Value.absent(),
    this.waist = const Value.absent(),
    this.calf = const Value.absent(),
  });
  MeasurementsCompanion.insert({
    this.measurementId = const Value.absent(),
    required int clientId,
    this.date = const Value.absent(),
    this.weight = const Value.absent(),
    this.bodyFat = const Value.absent(),
    this.muscleMass = const Value.absent(),
    this.arm = const Value.absent(),
    this.thigh = const Value.absent(),
    this.chest = const Value.absent(),
    this.waist = const Value.absent(),
    this.calf = const Value.absent(),
  }) : clientId = Value(clientId);
  static Insertable<Measurement> custom({
    Expression<int>? measurementId,
    Expression<int>? clientId,
    Expression<DateTime>? date,
    Expression<double>? weight,
    Expression<double>? bodyFat,
    Expression<double>? muscleMass,
    Expression<double>? arm,
    Expression<double>? thigh,
    Expression<double>? chest,
    Expression<double>? waist,
    Expression<double>? calf,
  }) {
    return RawValuesInsertable({
      if (measurementId != null) 'measurement_id': measurementId,
      if (clientId != null) 'client_id': clientId,
      if (date != null) 'date': date,
      if (weight != null) 'weight': weight,
      if (bodyFat != null) 'body_fat': bodyFat,
      if (muscleMass != null) 'muscle_mass': muscleMass,
      if (arm != null) 'arm': arm,
      if (thigh != null) 'thigh': thigh,
      if (chest != null) 'chest': chest,
      if (waist != null) 'waist': waist,
      if (calf != null) 'calf': calf,
    });
  }

  MeasurementsCompanion copyWith({
    Value<int>? measurementId,
    Value<int>? clientId,
    Value<DateTime>? date,
    Value<double?>? weight,
    Value<double?>? bodyFat,
    Value<double?>? muscleMass,
    Value<double?>? arm,
    Value<double?>? thigh,
    Value<double?>? chest,
    Value<double?>? waist,
    Value<double?>? calf,
  }) {
    return MeasurementsCompanion(
      measurementId: measurementId ?? this.measurementId,
      clientId: clientId ?? this.clientId,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      bodyFat: bodyFat ?? this.bodyFat,
      muscleMass: muscleMass ?? this.muscleMass,
      arm: arm ?? this.arm,
      thigh: thigh ?? this.thigh,
      chest: chest ?? this.chest,
      waist: waist ?? this.waist,
      calf: calf ?? this.calf,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (measurementId.present) {
      map['measurement_id'] = Variable<int>(measurementId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (bodyFat.present) {
      map['body_fat'] = Variable<double>(bodyFat.value);
    }
    if (muscleMass.present) {
      map['muscle_mass'] = Variable<double>(muscleMass.value);
    }
    if (arm.present) {
      map['arm'] = Variable<double>(arm.value);
    }
    if (thigh.present) {
      map['thigh'] = Variable<double>(thigh.value);
    }
    if (chest.present) {
      map['chest'] = Variable<double>(chest.value);
    }
    if (waist.present) {
      map['waist'] = Variable<double>(waist.value);
    }
    if (calf.present) {
      map['calf'] = Variable<double>(calf.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeasurementsCompanion(')
          ..write('measurementId: $measurementId, ')
          ..write('clientId: $clientId, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('bodyFat: $bodyFat, ')
          ..write('muscleMass: $muscleMass, ')
          ..write('arm: $arm, ')
          ..write('thigh: $thigh, ')
          ..write('chest: $chest, ')
          ..write('waist: $waist, ')
          ..write('calf: $calf')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientsTable clients = $ClientsTable(this);
  late final $AnamnesisTableTable anamnesisTable = $AnamnesisTableTable(this);
  late final $MeasurementsTable measurements = $MeasurementsTable(this);
  late final ClientDao clientDao = ClientDao(this as AppDatabase);
  late final AnamnesisDao anamnesisDao = AnamnesisDao(this as AppDatabase);
  late final MeasurementDao measurementDao = MeasurementDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    clients,
    anamnesisTable,
    measurements,
  ];
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

final class $$ClientsTableReferences
    extends BaseReferences<_$AppDatabase, $ClientsTable, Client> {
  $$ClientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AnamnesisTableTable, List<AnamnesisTableData>>
  _anamnesisTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.anamnesisTable,
    aliasName: $_aliasNameGenerator(
      db.clients.clientId,
      db.anamnesisTable.clientId,
    ),
  );

  $$AnamnesisTableTableProcessedTableManager get anamnesisTableRefs {
    final manager = $$AnamnesisTableTableTableManager($_db, $_db.anamnesisTable)
        .filter(
          (f) => f.clientId.clientId.sqlEquals($_itemColumn<int>('client_id')!),
        );

    final cache = $_typedResult.readTableOrNull(_anamnesisTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MeasurementsTable, List<Measurement>>
  _measurementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.measurements,
    aliasName: $_aliasNameGenerator(
      db.clients.clientId,
      db.measurements.clientId,
    ),
  );

  $$MeasurementsTableProcessedTableManager get measurementsRefs {
    final manager = $$MeasurementsTableTableManager($_db, $_db.measurements)
        .filter(
          (f) => f.clientId.clientId.sqlEquals($_itemColumn<int>('client_id')!),
        );

    final cache = $_typedResult.readTableOrNull(_measurementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  Expression<bool> anamnesisTableRefs(
    Expression<bool> Function($$AnamnesisTableTableFilterComposer f) f,
  ) {
    final $$AnamnesisTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.anamnesisTable,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnamnesisTableTableFilterComposer(
            $db: $db,
            $table: $db.anamnesisTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> measurementsRefs(
    Expression<bool> Function($$MeasurementsTableFilterComposer f) f,
  ) {
    final $$MeasurementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.measurements,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeasurementsTableFilterComposer(
            $db: $db,
            $table: $db.measurements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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

  Expression<T> anamnesisTableRefs<T extends Object>(
    Expression<T> Function($$AnamnesisTableTableAnnotationComposer a) f,
  ) {
    final $$AnamnesisTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.anamnesisTable,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnamnesisTableTableAnnotationComposer(
            $db: $db,
            $table: $db.anamnesisTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> measurementsRefs<T extends Object>(
    Expression<T> Function($$MeasurementsTableAnnotationComposer a) f,
  ) {
    final $$MeasurementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.measurements,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeasurementsTableAnnotationComposer(
            $db: $db,
            $table: $db.measurements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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
          (Client, $$ClientsTableReferences),
          Client,
          PrefetchHooks Function({
            bool anamnesisTableRefs,
            bool measurementsRefs,
          })
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
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({anamnesisTableRefs = false, measurementsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (anamnesisTableRefs) db.anamnesisTable,
                    if (measurementsRefs) db.measurements,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (anamnesisTableRefs)
                        await $_getPrefetchedData<
                          Client,
                          $ClientsTable,
                          AnamnesisTableData
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._anamnesisTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).anamnesisTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.clientId,
                              ),
                          typedResults: items,
                        ),
                      if (measurementsRefs)
                        await $_getPrefetchedData<
                          Client,
                          $ClientsTable,
                          Measurement
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._measurementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).measurementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.clientId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
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
      (Client, $$ClientsTableReferences),
      Client,
      PrefetchHooks Function({bool anamnesisTableRefs, bool measurementsRefs})
    >;
typedef $$AnamnesisTableTableCreateCompanionBuilder =
    AnamnesisTableCompanion Function({
      Value<int> anamnesisId,
      required int clientId,
      Value<DateTime> date,
      Value<String?> objective,
      Value<double?> initialWeight,
      Value<String?> observations,
      Value<String?> supplements,
      Value<String?> allergies,
      Value<PhysicalActivity?> physicalActivity,
      Value<String?> pathologies,
      Value<String?> occupation,
    });
typedef $$AnamnesisTableTableUpdateCompanionBuilder =
    AnamnesisTableCompanion Function({
      Value<int> anamnesisId,
      Value<int> clientId,
      Value<DateTime> date,
      Value<String?> objective,
      Value<double?> initialWeight,
      Value<String?> observations,
      Value<String?> supplements,
      Value<String?> allergies,
      Value<PhysicalActivity?> physicalActivity,
      Value<String?> pathologies,
      Value<String?> occupation,
    });

final class $$AnamnesisTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $AnamnesisTableTable,
          AnamnesisTableData
        > {
  $$AnamnesisTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias(
        $_aliasNameGenerator(db.anamnesisTable.clientId, db.clients.clientId),
      );

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<int>('client_id')!;

    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.clientId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AnamnesisTableTableFilterComposer
    extends Composer<_$AppDatabase, $AnamnesisTableTable> {
  $$AnamnesisTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get anamnesisId => $composableBuilder(
    column: $table.anamnesisId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get objective => $composableBuilder(
    column: $table.objective,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get initialWeight => $composableBuilder(
    column: $table.initialWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observations => $composableBuilder(
    column: $table.observations,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplements => $composableBuilder(
    column: $table.supplements,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get allergies => $composableBuilder(
    column: $table.allergies,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PhysicalActivity?, PhysicalActivity, int>
  get physicalActivity => $composableBuilder(
    column: $table.physicalActivity,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get pathologies => $composableBuilder(
    column: $table.pathologies,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get occupation => $composableBuilder(
    column: $table.occupation,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnamnesisTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AnamnesisTableTable> {
  $$AnamnesisTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get anamnesisId => $composableBuilder(
    column: $table.anamnesisId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get objective => $composableBuilder(
    column: $table.objective,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get initialWeight => $composableBuilder(
    column: $table.initialWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observations => $composableBuilder(
    column: $table.observations,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplements => $composableBuilder(
    column: $table.supplements,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allergies => $composableBuilder(
    column: $table.allergies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get physicalActivity => $composableBuilder(
    column: $table.physicalActivity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pathologies => $composableBuilder(
    column: $table.pathologies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get occupation => $composableBuilder(
    column: $table.occupation,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnamnesisTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnamnesisTableTable> {
  $$AnamnesisTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get anamnesisId => $composableBuilder(
    column: $table.anamnesisId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get objective =>
      $composableBuilder(column: $table.objective, builder: (column) => column);

  GeneratedColumn<double> get initialWeight => $composableBuilder(
    column: $table.initialWeight,
    builder: (column) => column,
  );

  GeneratedColumn<String> get observations => $composableBuilder(
    column: $table.observations,
    builder: (column) => column,
  );

  GeneratedColumn<String> get supplements => $composableBuilder(
    column: $table.supplements,
    builder: (column) => column,
  );

  GeneratedColumn<String> get allergies =>
      $composableBuilder(column: $table.allergies, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PhysicalActivity?, int>
  get physicalActivity => $composableBuilder(
    column: $table.physicalActivity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pathologies => $composableBuilder(
    column: $table.pathologies,
    builder: (column) => column,
  );

  GeneratedColumn<String> get occupation => $composableBuilder(
    column: $table.occupation,
    builder: (column) => column,
  );

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnamnesisTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnamnesisTableTable,
          AnamnesisTableData,
          $$AnamnesisTableTableFilterComposer,
          $$AnamnesisTableTableOrderingComposer,
          $$AnamnesisTableTableAnnotationComposer,
          $$AnamnesisTableTableCreateCompanionBuilder,
          $$AnamnesisTableTableUpdateCompanionBuilder,
          (AnamnesisTableData, $$AnamnesisTableTableReferences),
          AnamnesisTableData,
          PrefetchHooks Function({bool clientId})
        > {
  $$AnamnesisTableTableTableManager(
    _$AppDatabase db,
    $AnamnesisTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnamnesisTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnamnesisTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnamnesisTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> anamnesisId = const Value.absent(),
                Value<int> clientId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> objective = const Value.absent(),
                Value<double?> initialWeight = const Value.absent(),
                Value<String?> observations = const Value.absent(),
                Value<String?> supplements = const Value.absent(),
                Value<String?> allergies = const Value.absent(),
                Value<PhysicalActivity?> physicalActivity =
                    const Value.absent(),
                Value<String?> pathologies = const Value.absent(),
                Value<String?> occupation = const Value.absent(),
              }) => AnamnesisTableCompanion(
                anamnesisId: anamnesisId,
                clientId: clientId,
                date: date,
                objective: objective,
                initialWeight: initialWeight,
                observations: observations,
                supplements: supplements,
                allergies: allergies,
                physicalActivity: physicalActivity,
                pathologies: pathologies,
                occupation: occupation,
              ),
          createCompanionCallback:
              ({
                Value<int> anamnesisId = const Value.absent(),
                required int clientId,
                Value<DateTime> date = const Value.absent(),
                Value<String?> objective = const Value.absent(),
                Value<double?> initialWeight = const Value.absent(),
                Value<String?> observations = const Value.absent(),
                Value<String?> supplements = const Value.absent(),
                Value<String?> allergies = const Value.absent(),
                Value<PhysicalActivity?> physicalActivity =
                    const Value.absent(),
                Value<String?> pathologies = const Value.absent(),
                Value<String?> occupation = const Value.absent(),
              }) => AnamnesisTableCompanion.insert(
                anamnesisId: anamnesisId,
                clientId: clientId,
                date: date,
                objective: objective,
                initialWeight: initialWeight,
                observations: observations,
                supplements: supplements,
                allergies: allergies,
                physicalActivity: physicalActivity,
                pathologies: pathologies,
                occupation: occupation,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AnamnesisTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({clientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (clientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.clientId,
                                referencedTable: $$AnamnesisTableTableReferences
                                    ._clientIdTable(db),
                                referencedColumn:
                                    $$AnamnesisTableTableReferences
                                        ._clientIdTable(db)
                                        .clientId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AnamnesisTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnamnesisTableTable,
      AnamnesisTableData,
      $$AnamnesisTableTableFilterComposer,
      $$AnamnesisTableTableOrderingComposer,
      $$AnamnesisTableTableAnnotationComposer,
      $$AnamnesisTableTableCreateCompanionBuilder,
      $$AnamnesisTableTableUpdateCompanionBuilder,
      (AnamnesisTableData, $$AnamnesisTableTableReferences),
      AnamnesisTableData,
      PrefetchHooks Function({bool clientId})
    >;
typedef $$MeasurementsTableCreateCompanionBuilder =
    MeasurementsCompanion Function({
      Value<int> measurementId,
      required int clientId,
      Value<DateTime> date,
      Value<double?> weight,
      Value<double?> bodyFat,
      Value<double?> muscleMass,
      Value<double?> arm,
      Value<double?> thigh,
      Value<double?> chest,
      Value<double?> waist,
      Value<double?> calf,
    });
typedef $$MeasurementsTableUpdateCompanionBuilder =
    MeasurementsCompanion Function({
      Value<int> measurementId,
      Value<int> clientId,
      Value<DateTime> date,
      Value<double?> weight,
      Value<double?> bodyFat,
      Value<double?> muscleMass,
      Value<double?> arm,
      Value<double?> thigh,
      Value<double?> chest,
      Value<double?> waist,
      Value<double?> calf,
    });

final class $$MeasurementsTableReferences
    extends BaseReferences<_$AppDatabase, $MeasurementsTable, Measurement> {
  $$MeasurementsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias(
        $_aliasNameGenerator(db.measurements.clientId, db.clients.clientId),
      );

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<int>('client_id')!;

    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.clientId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MeasurementsTableFilterComposer
    extends Composer<_$AppDatabase, $MeasurementsTable> {
  $$MeasurementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get measurementId => $composableBuilder(
    column: $table.measurementId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bodyFat => $composableBuilder(
    column: $table.bodyFat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get muscleMass => $composableBuilder(
    column: $table.muscleMass,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get arm => $composableBuilder(
    column: $table.arm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get thigh => $composableBuilder(
    column: $table.thigh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get chest => $composableBuilder(
    column: $table.chest,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waist => $composableBuilder(
    column: $table.waist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get calf => $composableBuilder(
    column: $table.calf,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeasurementsTableOrderingComposer
    extends Composer<_$AppDatabase, $MeasurementsTable> {
  $$MeasurementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get measurementId => $composableBuilder(
    column: $table.measurementId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bodyFat => $composableBuilder(
    column: $table.bodyFat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get muscleMass => $composableBuilder(
    column: $table.muscleMass,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get arm => $composableBuilder(
    column: $table.arm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get thigh => $composableBuilder(
    column: $table.thigh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get chest => $composableBuilder(
    column: $table.chest,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waist => $composableBuilder(
    column: $table.waist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get calf => $composableBuilder(
    column: $table.calf,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeasurementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeasurementsTable> {
  $$MeasurementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get measurementId => $composableBuilder(
    column: $table.measurementId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<double> get bodyFat =>
      $composableBuilder(column: $table.bodyFat, builder: (column) => column);

  GeneratedColumn<double> get muscleMass => $composableBuilder(
    column: $table.muscleMass,
    builder: (column) => column,
  );

  GeneratedColumn<double> get arm =>
      $composableBuilder(column: $table.arm, builder: (column) => column);

  GeneratedColumn<double> get thigh =>
      $composableBuilder(column: $table.thigh, builder: (column) => column);

  GeneratedColumn<double> get chest =>
      $composableBuilder(column: $table.chest, builder: (column) => column);

  GeneratedColumn<double> get waist =>
      $composableBuilder(column: $table.waist, builder: (column) => column);

  GeneratedColumn<double> get calf =>
      $composableBuilder(column: $table.calf, builder: (column) => column);

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeasurementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MeasurementsTable,
          Measurement,
          $$MeasurementsTableFilterComposer,
          $$MeasurementsTableOrderingComposer,
          $$MeasurementsTableAnnotationComposer,
          $$MeasurementsTableCreateCompanionBuilder,
          $$MeasurementsTableUpdateCompanionBuilder,
          (Measurement, $$MeasurementsTableReferences),
          Measurement,
          PrefetchHooks Function({bool clientId})
        > {
  $$MeasurementsTableTableManager(_$AppDatabase db, $MeasurementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeasurementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeasurementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MeasurementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> measurementId = const Value.absent(),
                Value<int> clientId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<double?> bodyFat = const Value.absent(),
                Value<double?> muscleMass = const Value.absent(),
                Value<double?> arm = const Value.absent(),
                Value<double?> thigh = const Value.absent(),
                Value<double?> chest = const Value.absent(),
                Value<double?> waist = const Value.absent(),
                Value<double?> calf = const Value.absent(),
              }) => MeasurementsCompanion(
                measurementId: measurementId,
                clientId: clientId,
                date: date,
                weight: weight,
                bodyFat: bodyFat,
                muscleMass: muscleMass,
                arm: arm,
                thigh: thigh,
                chest: chest,
                waist: waist,
                calf: calf,
              ),
          createCompanionCallback:
              ({
                Value<int> measurementId = const Value.absent(),
                required int clientId,
                Value<DateTime> date = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<double?> bodyFat = const Value.absent(),
                Value<double?> muscleMass = const Value.absent(),
                Value<double?> arm = const Value.absent(),
                Value<double?> thigh = const Value.absent(),
                Value<double?> chest = const Value.absent(),
                Value<double?> waist = const Value.absent(),
                Value<double?> calf = const Value.absent(),
              }) => MeasurementsCompanion.insert(
                measurementId: measurementId,
                clientId: clientId,
                date: date,
                weight: weight,
                bodyFat: bodyFat,
                muscleMass: muscleMass,
                arm: arm,
                thigh: thigh,
                chest: chest,
                waist: waist,
                calf: calf,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MeasurementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({clientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (clientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.clientId,
                                referencedTable: $$MeasurementsTableReferences
                                    ._clientIdTable(db),
                                referencedColumn: $$MeasurementsTableReferences
                                    ._clientIdTable(db)
                                    .clientId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MeasurementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MeasurementsTable,
      Measurement,
      $$MeasurementsTableFilterComposer,
      $$MeasurementsTableOrderingComposer,
      $$MeasurementsTableAnnotationComposer,
      $$MeasurementsTableCreateCompanionBuilder,
      $$MeasurementsTableUpdateCompanionBuilder,
      (Measurement, $$MeasurementsTableReferences),
      Measurement,
      PrefetchHooks Function({bool clientId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
  $$AnamnesisTableTableTableManager get anamnesisTable =>
      $$AnamnesisTableTableTableManager(_db, _db.anamnesisTable);
  $$MeasurementsTableTableManager get measurements =>
      $$MeasurementsTableTableManager(_db, _db.measurements);
}
