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

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<int> noteId = GeneratedColumn<int>(
    'note_id',
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
  @override
  late final GeneratedColumnWithTypeConverter<NoteType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(NoteType.general.index),
      ).withConverter<NoteType>($NotesTable.$convertertype);
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [noteId, clientId, date, type, content];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Note> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('note_id')) {
      context.handle(
        _noteIdMeta,
        noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta),
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
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {noteId};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      noteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}note_id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      type: $NotesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<NoteType, int, int> $convertertype =
      const EnumIndexConverter<NoteType>(NoteType.values);
}

class Note extends DataClass implements Insertable<Note> {
  final int noteId;
  final int clientId;
  final DateTime date;
  final NoteType type;
  final String content;
  const Note({
    required this.noteId,
    required this.clientId,
    required this.date,
    required this.type,
    required this.content,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['note_id'] = Variable<int>(noteId);
    map['client_id'] = Variable<int>(clientId);
    map['date'] = Variable<DateTime>(date);
    {
      map['type'] = Variable<int>($NotesTable.$convertertype.toSql(type));
    }
    map['content'] = Variable<String>(content);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      noteId: Value(noteId),
      clientId: Value(clientId),
      date: Value(date),
      type: Value(type),
      content: Value(content),
    );
  }

  factory Note.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      noteId: serializer.fromJson<int>(json['noteId']),
      clientId: serializer.fromJson<int>(json['clientId']),
      date: serializer.fromJson<DateTime>(json['date']),
      type: $NotesTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'noteId': serializer.toJson<int>(noteId),
      'clientId': serializer.toJson<int>(clientId),
      'date': serializer.toJson<DateTime>(date),
      'type': serializer.toJson<int>($NotesTable.$convertertype.toJson(type)),
      'content': serializer.toJson<String>(content),
    };
  }

  Note copyWith({
    int? noteId,
    int? clientId,
    DateTime? date,
    NoteType? type,
    String? content,
  }) => Note(
    noteId: noteId ?? this.noteId,
    clientId: clientId ?? this.clientId,
    date: date ?? this.date,
    type: type ?? this.type,
    content: content ?? this.content,
  );
  Note copyWithCompanion(NotesCompanion data) {
    return Note(
      noteId: data.noteId.present ? data.noteId.value : this.noteId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      date: data.date.present ? data.date.value : this.date,
      type: data.type.present ? data.type.value : this.type,
      content: data.content.present ? data.content.value : this.content,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('noteId: $noteId, ')
          ..write('clientId: $clientId, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(noteId, clientId, date, type, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.noteId == this.noteId &&
          other.clientId == this.clientId &&
          other.date == this.date &&
          other.type == this.type &&
          other.content == this.content);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> noteId;
  final Value<int> clientId;
  final Value<DateTime> date;
  final Value<NoteType> type;
  final Value<String> content;
  const NotesCompanion({
    this.noteId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.date = const Value.absent(),
    this.type = const Value.absent(),
    this.content = const Value.absent(),
  });
  NotesCompanion.insert({
    this.noteId = const Value.absent(),
    required int clientId,
    this.date = const Value.absent(),
    this.type = const Value.absent(),
    required String content,
  }) : clientId = Value(clientId),
       content = Value(content);
  static Insertable<Note> custom({
    Expression<int>? noteId,
    Expression<int>? clientId,
    Expression<DateTime>? date,
    Expression<int>? type,
    Expression<String>? content,
  }) {
    return RawValuesInsertable({
      if (noteId != null) 'note_id': noteId,
      if (clientId != null) 'client_id': clientId,
      if (date != null) 'date': date,
      if (type != null) 'type': type,
      if (content != null) 'content': content,
    });
  }

  NotesCompanion copyWith({
    Value<int>? noteId,
    Value<int>? clientId,
    Value<DateTime>? date,
    Value<NoteType>? type,
    Value<String>? content,
  }) {
    return NotesCompanion(
      noteId: noteId ?? this.noteId,
      clientId: clientId ?? this.clientId,
      date: date ?? this.date,
      type: type ?? this.type,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (noteId.present) {
      map['note_id'] = Variable<int>(noteId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (type.present) {
      map['type'] = Variable<int>($NotesTable.$convertertype.toSql(type.value));
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('noteId: $noteId, ')
          ..write('clientId: $clientId, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

class $NutritionCalculationsTable extends NutritionCalculations
    with TableInfo<$NutritionCalculationsTable, NutritionCalculation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NutritionCalculationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _calculationIdMeta = const VerificationMeta(
    'calculationId',
  );
  @override
  late final GeneratedColumn<int> calculationId = GeneratedColumn<int>(
    'calculation_id',
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
  @override
  late final GeneratedColumnWithTypeConverter<GoalType, int> goalType =
      GeneratedColumn<int>(
        'goal_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<GoalType>($NutritionCalculationsTable.$convertergoalType);
  @override
  late final GeneratedColumnWithTypeConverter<BmrFormula, int> bmrFormula =
      GeneratedColumn<int>(
        'bmr_formula',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(BmrFormula.mifflinStJeor.index),
      ).withConverter<BmrFormula>(
        $NutritionCalculationsTable.$converterbmrFormula,
      );
  static const VerificationMeta _bmrMeta = const VerificationMeta('bmr');
  @override
  late final GeneratedColumn<double> bmr = GeneratedColumn<double>(
    'bmr',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tdeeMeta = const VerificationMeta('tdee');
  @override
  late final GeneratedColumn<double> tdee = GeneratedColumn<double>(
    'tdee',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kcalTargetMeta = const VerificationMeta(
    'kcalTarget',
  );
  @override
  late final GeneratedColumn<double> kcalTarget = GeneratedColumn<double>(
    'kcal_target',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinsMeta = const VerificationMeta(
    'proteins',
  );
  @override
  late final GeneratedColumn<double> proteins = GeneratedColumn<double>(
    'proteins',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbohydratesMeta = const VerificationMeta(
    'carbohydrates',
  );
  @override
  late final GeneratedColumn<double> carbohydrates = GeneratedColumn<double>(
    'carbohydrates',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatsMeta = const VerificationMeta('fats');
  @override
  late final GeneratedColumn<double> fats = GeneratedColumn<double>(
    'fats',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightUsedMeta = const VerificationMeta(
    'weightUsed',
  );
  @override
  late final GeneratedColumn<double> weightUsed = GeneratedColumn<double>(
    'weight_used',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightUsedMeta = const VerificationMeta(
    'heightUsed',
  );
  @override
  late final GeneratedColumn<int> heightUsed = GeneratedColumn<int>(
    'height_used',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ageUsedMeta = const VerificationMeta(
    'ageUsed',
  );
  @override
  late final GeneratedColumn<int> ageUsed = GeneratedColumn<int>(
    'age_used',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activityFactorMeta = const VerificationMeta(
    'activityFactor',
  );
  @override
  late final GeneratedColumn<double> activityFactor = GeneratedColumn<double>(
    'activity_factor',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proteinPerKgMeta = const VerificationMeta(
    'proteinPerKg',
  );
  @override
  late final GeneratedColumn<double> proteinPerKg = GeneratedColumn<double>(
    'protein_per_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fatPerKgMeta = const VerificationMeta(
    'fatPerKg',
  );
  @override
  late final GeneratedColumn<double> fatPerKg = GeneratedColumn<double>(
    'fat_per_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    calculationId,
    clientId,
    date,
    goalType,
    bmrFormula,
    bmr,
    tdee,
    kcalTarget,
    proteins,
    carbohydrates,
    fats,
    weightUsed,
    heightUsed,
    ageUsed,
    activityFactor,
    proteinPerKg,
    fatPerKg,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrition_calculations';
  @override
  VerificationContext validateIntegrity(
    Insertable<NutritionCalculation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('calculation_id')) {
      context.handle(
        _calculationIdMeta,
        calculationId.isAcceptableOrUnknown(
          data['calculation_id']!,
          _calculationIdMeta,
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
    if (data.containsKey('bmr')) {
      context.handle(
        _bmrMeta,
        bmr.isAcceptableOrUnknown(data['bmr']!, _bmrMeta),
      );
    } else if (isInserting) {
      context.missing(_bmrMeta);
    }
    if (data.containsKey('tdee')) {
      context.handle(
        _tdeeMeta,
        tdee.isAcceptableOrUnknown(data['tdee']!, _tdeeMeta),
      );
    } else if (isInserting) {
      context.missing(_tdeeMeta);
    }
    if (data.containsKey('kcal_target')) {
      context.handle(
        _kcalTargetMeta,
        kcalTarget.isAcceptableOrUnknown(data['kcal_target']!, _kcalTargetMeta),
      );
    } else if (isInserting) {
      context.missing(_kcalTargetMeta);
    }
    if (data.containsKey('proteins')) {
      context.handle(
        _proteinsMeta,
        proteins.isAcceptableOrUnknown(data['proteins']!, _proteinsMeta),
      );
    } else if (isInserting) {
      context.missing(_proteinsMeta);
    }
    if (data.containsKey('carbohydrates')) {
      context.handle(
        _carbohydratesMeta,
        carbohydrates.isAcceptableOrUnknown(
          data['carbohydrates']!,
          _carbohydratesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_carbohydratesMeta);
    }
    if (data.containsKey('fats')) {
      context.handle(
        _fatsMeta,
        fats.isAcceptableOrUnknown(data['fats']!, _fatsMeta),
      );
    } else if (isInserting) {
      context.missing(_fatsMeta);
    }
    if (data.containsKey('weight_used')) {
      context.handle(
        _weightUsedMeta,
        weightUsed.isAcceptableOrUnknown(data['weight_used']!, _weightUsedMeta),
      );
    }
    if (data.containsKey('height_used')) {
      context.handle(
        _heightUsedMeta,
        heightUsed.isAcceptableOrUnknown(data['height_used']!, _heightUsedMeta),
      );
    }
    if (data.containsKey('age_used')) {
      context.handle(
        _ageUsedMeta,
        ageUsed.isAcceptableOrUnknown(data['age_used']!, _ageUsedMeta),
      );
    }
    if (data.containsKey('activity_factor')) {
      context.handle(
        _activityFactorMeta,
        activityFactor.isAcceptableOrUnknown(
          data['activity_factor']!,
          _activityFactorMeta,
        ),
      );
    }
    if (data.containsKey('protein_per_kg')) {
      context.handle(
        _proteinPerKgMeta,
        proteinPerKg.isAcceptableOrUnknown(
          data['protein_per_kg']!,
          _proteinPerKgMeta,
        ),
      );
    }
    if (data.containsKey('fat_per_kg')) {
      context.handle(
        _fatPerKgMeta,
        fatPerKg.isAcceptableOrUnknown(data['fat_per_kg']!, _fatPerKgMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {calculationId};
  @override
  NutritionCalculation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NutritionCalculation(
      calculationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calculation_id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      goalType: $NutritionCalculationsTable.$convertergoalType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}goal_type'],
        )!,
      ),
      bmrFormula: $NutritionCalculationsTable.$converterbmrFormula.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}bmr_formula'],
        )!,
      ),
      bmr: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bmr'],
      )!,
      tdee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tdee'],
      )!,
      kcalTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kcal_target'],
      )!,
      proteins: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}proteins'],
      )!,
      carbohydrates: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbohydrates'],
      )!,
      fats: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fats'],
      )!,
      weightUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_used'],
      ),
      heightUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height_used'],
      ),
      ageUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age_used'],
      ),
      activityFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}activity_factor'],
      ),
      proteinPerKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_per_kg'],
      ),
      fatPerKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_per_kg'],
      ),
    );
  }

  @override
  $NutritionCalculationsTable createAlias(String alias) {
    return $NutritionCalculationsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<GoalType, int, int> $convertergoalType =
      const EnumIndexConverter<GoalType>(GoalType.values);
  static JsonTypeConverter2<BmrFormula, int, int> $converterbmrFormula =
      const EnumIndexConverter<BmrFormula>(BmrFormula.values);
}

class NutritionCalculation extends DataClass
    implements Insertable<NutritionCalculation> {
  final int calculationId;
  final int clientId;
  final DateTime date;
  final GoalType goalType;
  final BmrFormula bmrFormula;
  final double bmr;
  final double tdee;
  final double kcalTarget;
  final double proteins;
  final double carbohydrates;
  final double fats;
  final double? weightUsed;
  final int? heightUsed;
  final int? ageUsed;
  final double? activityFactor;
  final double? proteinPerKg;
  final double? fatPerKg;
  const NutritionCalculation({
    required this.calculationId,
    required this.clientId,
    required this.date,
    required this.goalType,
    required this.bmrFormula,
    required this.bmr,
    required this.tdee,
    required this.kcalTarget,
    required this.proteins,
    required this.carbohydrates,
    required this.fats,
    this.weightUsed,
    this.heightUsed,
    this.ageUsed,
    this.activityFactor,
    this.proteinPerKg,
    this.fatPerKg,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['calculation_id'] = Variable<int>(calculationId);
    map['client_id'] = Variable<int>(clientId);
    map['date'] = Variable<DateTime>(date);
    {
      map['goal_type'] = Variable<int>(
        $NutritionCalculationsTable.$convertergoalType.toSql(goalType),
      );
    }
    {
      map['bmr_formula'] = Variable<int>(
        $NutritionCalculationsTable.$converterbmrFormula.toSql(bmrFormula),
      );
    }
    map['bmr'] = Variable<double>(bmr);
    map['tdee'] = Variable<double>(tdee);
    map['kcal_target'] = Variable<double>(kcalTarget);
    map['proteins'] = Variable<double>(proteins);
    map['carbohydrates'] = Variable<double>(carbohydrates);
    map['fats'] = Variable<double>(fats);
    if (!nullToAbsent || weightUsed != null) {
      map['weight_used'] = Variable<double>(weightUsed);
    }
    if (!nullToAbsent || heightUsed != null) {
      map['height_used'] = Variable<int>(heightUsed);
    }
    if (!nullToAbsent || ageUsed != null) {
      map['age_used'] = Variable<int>(ageUsed);
    }
    if (!nullToAbsent || activityFactor != null) {
      map['activity_factor'] = Variable<double>(activityFactor);
    }
    if (!nullToAbsent || proteinPerKg != null) {
      map['protein_per_kg'] = Variable<double>(proteinPerKg);
    }
    if (!nullToAbsent || fatPerKg != null) {
      map['fat_per_kg'] = Variable<double>(fatPerKg);
    }
    return map;
  }

  NutritionCalculationsCompanion toCompanion(bool nullToAbsent) {
    return NutritionCalculationsCompanion(
      calculationId: Value(calculationId),
      clientId: Value(clientId),
      date: Value(date),
      goalType: Value(goalType),
      bmrFormula: Value(bmrFormula),
      bmr: Value(bmr),
      tdee: Value(tdee),
      kcalTarget: Value(kcalTarget),
      proteins: Value(proteins),
      carbohydrates: Value(carbohydrates),
      fats: Value(fats),
      weightUsed: weightUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(weightUsed),
      heightUsed: heightUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(heightUsed),
      ageUsed: ageUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(ageUsed),
      activityFactor: activityFactor == null && nullToAbsent
          ? const Value.absent()
          : Value(activityFactor),
      proteinPerKg: proteinPerKg == null && nullToAbsent
          ? const Value.absent()
          : Value(proteinPerKg),
      fatPerKg: fatPerKg == null && nullToAbsent
          ? const Value.absent()
          : Value(fatPerKg),
    );
  }

  factory NutritionCalculation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NutritionCalculation(
      calculationId: serializer.fromJson<int>(json['calculationId']),
      clientId: serializer.fromJson<int>(json['clientId']),
      date: serializer.fromJson<DateTime>(json['date']),
      goalType: $NutritionCalculationsTable.$convertergoalType.fromJson(
        serializer.fromJson<int>(json['goalType']),
      ),
      bmrFormula: $NutritionCalculationsTable.$converterbmrFormula.fromJson(
        serializer.fromJson<int>(json['bmrFormula']),
      ),
      bmr: serializer.fromJson<double>(json['bmr']),
      tdee: serializer.fromJson<double>(json['tdee']),
      kcalTarget: serializer.fromJson<double>(json['kcalTarget']),
      proteins: serializer.fromJson<double>(json['proteins']),
      carbohydrates: serializer.fromJson<double>(json['carbohydrates']),
      fats: serializer.fromJson<double>(json['fats']),
      weightUsed: serializer.fromJson<double?>(json['weightUsed']),
      heightUsed: serializer.fromJson<int?>(json['heightUsed']),
      ageUsed: serializer.fromJson<int?>(json['ageUsed']),
      activityFactor: serializer.fromJson<double?>(json['activityFactor']),
      proteinPerKg: serializer.fromJson<double?>(json['proteinPerKg']),
      fatPerKg: serializer.fromJson<double?>(json['fatPerKg']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'calculationId': serializer.toJson<int>(calculationId),
      'clientId': serializer.toJson<int>(clientId),
      'date': serializer.toJson<DateTime>(date),
      'goalType': serializer.toJson<int>(
        $NutritionCalculationsTable.$convertergoalType.toJson(goalType),
      ),
      'bmrFormula': serializer.toJson<int>(
        $NutritionCalculationsTable.$converterbmrFormula.toJson(bmrFormula),
      ),
      'bmr': serializer.toJson<double>(bmr),
      'tdee': serializer.toJson<double>(tdee),
      'kcalTarget': serializer.toJson<double>(kcalTarget),
      'proteins': serializer.toJson<double>(proteins),
      'carbohydrates': serializer.toJson<double>(carbohydrates),
      'fats': serializer.toJson<double>(fats),
      'weightUsed': serializer.toJson<double?>(weightUsed),
      'heightUsed': serializer.toJson<int?>(heightUsed),
      'ageUsed': serializer.toJson<int?>(ageUsed),
      'activityFactor': serializer.toJson<double?>(activityFactor),
      'proteinPerKg': serializer.toJson<double?>(proteinPerKg),
      'fatPerKg': serializer.toJson<double?>(fatPerKg),
    };
  }

  NutritionCalculation copyWith({
    int? calculationId,
    int? clientId,
    DateTime? date,
    GoalType? goalType,
    BmrFormula? bmrFormula,
    double? bmr,
    double? tdee,
    double? kcalTarget,
    double? proteins,
    double? carbohydrates,
    double? fats,
    Value<double?> weightUsed = const Value.absent(),
    Value<int?> heightUsed = const Value.absent(),
    Value<int?> ageUsed = const Value.absent(),
    Value<double?> activityFactor = const Value.absent(),
    Value<double?> proteinPerKg = const Value.absent(),
    Value<double?> fatPerKg = const Value.absent(),
  }) => NutritionCalculation(
    calculationId: calculationId ?? this.calculationId,
    clientId: clientId ?? this.clientId,
    date: date ?? this.date,
    goalType: goalType ?? this.goalType,
    bmrFormula: bmrFormula ?? this.bmrFormula,
    bmr: bmr ?? this.bmr,
    tdee: tdee ?? this.tdee,
    kcalTarget: kcalTarget ?? this.kcalTarget,
    proteins: proteins ?? this.proteins,
    carbohydrates: carbohydrates ?? this.carbohydrates,
    fats: fats ?? this.fats,
    weightUsed: weightUsed.present ? weightUsed.value : this.weightUsed,
    heightUsed: heightUsed.present ? heightUsed.value : this.heightUsed,
    ageUsed: ageUsed.present ? ageUsed.value : this.ageUsed,
    activityFactor: activityFactor.present
        ? activityFactor.value
        : this.activityFactor,
    proteinPerKg: proteinPerKg.present ? proteinPerKg.value : this.proteinPerKg,
    fatPerKg: fatPerKg.present ? fatPerKg.value : this.fatPerKg,
  );
  NutritionCalculation copyWithCompanion(NutritionCalculationsCompanion data) {
    return NutritionCalculation(
      calculationId: data.calculationId.present
          ? data.calculationId.value
          : this.calculationId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      date: data.date.present ? data.date.value : this.date,
      goalType: data.goalType.present ? data.goalType.value : this.goalType,
      bmrFormula: data.bmrFormula.present
          ? data.bmrFormula.value
          : this.bmrFormula,
      bmr: data.bmr.present ? data.bmr.value : this.bmr,
      tdee: data.tdee.present ? data.tdee.value : this.tdee,
      kcalTarget: data.kcalTarget.present
          ? data.kcalTarget.value
          : this.kcalTarget,
      proteins: data.proteins.present ? data.proteins.value : this.proteins,
      carbohydrates: data.carbohydrates.present
          ? data.carbohydrates.value
          : this.carbohydrates,
      fats: data.fats.present ? data.fats.value : this.fats,
      weightUsed: data.weightUsed.present
          ? data.weightUsed.value
          : this.weightUsed,
      heightUsed: data.heightUsed.present
          ? data.heightUsed.value
          : this.heightUsed,
      ageUsed: data.ageUsed.present ? data.ageUsed.value : this.ageUsed,
      activityFactor: data.activityFactor.present
          ? data.activityFactor.value
          : this.activityFactor,
      proteinPerKg: data.proteinPerKg.present
          ? data.proteinPerKg.value
          : this.proteinPerKg,
      fatPerKg: data.fatPerKg.present ? data.fatPerKg.value : this.fatPerKg,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NutritionCalculation(')
          ..write('calculationId: $calculationId, ')
          ..write('clientId: $clientId, ')
          ..write('date: $date, ')
          ..write('goalType: $goalType, ')
          ..write('bmrFormula: $bmrFormula, ')
          ..write('bmr: $bmr, ')
          ..write('tdee: $tdee, ')
          ..write('kcalTarget: $kcalTarget, ')
          ..write('proteins: $proteins, ')
          ..write('carbohydrates: $carbohydrates, ')
          ..write('fats: $fats, ')
          ..write('weightUsed: $weightUsed, ')
          ..write('heightUsed: $heightUsed, ')
          ..write('ageUsed: $ageUsed, ')
          ..write('activityFactor: $activityFactor, ')
          ..write('proteinPerKg: $proteinPerKg, ')
          ..write('fatPerKg: $fatPerKg')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    calculationId,
    clientId,
    date,
    goalType,
    bmrFormula,
    bmr,
    tdee,
    kcalTarget,
    proteins,
    carbohydrates,
    fats,
    weightUsed,
    heightUsed,
    ageUsed,
    activityFactor,
    proteinPerKg,
    fatPerKg,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NutritionCalculation &&
          other.calculationId == this.calculationId &&
          other.clientId == this.clientId &&
          other.date == this.date &&
          other.goalType == this.goalType &&
          other.bmrFormula == this.bmrFormula &&
          other.bmr == this.bmr &&
          other.tdee == this.tdee &&
          other.kcalTarget == this.kcalTarget &&
          other.proteins == this.proteins &&
          other.carbohydrates == this.carbohydrates &&
          other.fats == this.fats &&
          other.weightUsed == this.weightUsed &&
          other.heightUsed == this.heightUsed &&
          other.ageUsed == this.ageUsed &&
          other.activityFactor == this.activityFactor &&
          other.proteinPerKg == this.proteinPerKg &&
          other.fatPerKg == this.fatPerKg);
}

class NutritionCalculationsCompanion
    extends UpdateCompanion<NutritionCalculation> {
  final Value<int> calculationId;
  final Value<int> clientId;
  final Value<DateTime> date;
  final Value<GoalType> goalType;
  final Value<BmrFormula> bmrFormula;
  final Value<double> bmr;
  final Value<double> tdee;
  final Value<double> kcalTarget;
  final Value<double> proteins;
  final Value<double> carbohydrates;
  final Value<double> fats;
  final Value<double?> weightUsed;
  final Value<int?> heightUsed;
  final Value<int?> ageUsed;
  final Value<double?> activityFactor;
  final Value<double?> proteinPerKg;
  final Value<double?> fatPerKg;
  const NutritionCalculationsCompanion({
    this.calculationId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.date = const Value.absent(),
    this.goalType = const Value.absent(),
    this.bmrFormula = const Value.absent(),
    this.bmr = const Value.absent(),
    this.tdee = const Value.absent(),
    this.kcalTarget = const Value.absent(),
    this.proteins = const Value.absent(),
    this.carbohydrates = const Value.absent(),
    this.fats = const Value.absent(),
    this.weightUsed = const Value.absent(),
    this.heightUsed = const Value.absent(),
    this.ageUsed = const Value.absent(),
    this.activityFactor = const Value.absent(),
    this.proteinPerKg = const Value.absent(),
    this.fatPerKg = const Value.absent(),
  });
  NutritionCalculationsCompanion.insert({
    this.calculationId = const Value.absent(),
    required int clientId,
    this.date = const Value.absent(),
    required GoalType goalType,
    this.bmrFormula = const Value.absent(),
    required double bmr,
    required double tdee,
    required double kcalTarget,
    required double proteins,
    required double carbohydrates,
    required double fats,
    this.weightUsed = const Value.absent(),
    this.heightUsed = const Value.absent(),
    this.ageUsed = const Value.absent(),
    this.activityFactor = const Value.absent(),
    this.proteinPerKg = const Value.absent(),
    this.fatPerKg = const Value.absent(),
  }) : clientId = Value(clientId),
       goalType = Value(goalType),
       bmr = Value(bmr),
       tdee = Value(tdee),
       kcalTarget = Value(kcalTarget),
       proteins = Value(proteins),
       carbohydrates = Value(carbohydrates),
       fats = Value(fats);
  static Insertable<NutritionCalculation> custom({
    Expression<int>? calculationId,
    Expression<int>? clientId,
    Expression<DateTime>? date,
    Expression<int>? goalType,
    Expression<int>? bmrFormula,
    Expression<double>? bmr,
    Expression<double>? tdee,
    Expression<double>? kcalTarget,
    Expression<double>? proteins,
    Expression<double>? carbohydrates,
    Expression<double>? fats,
    Expression<double>? weightUsed,
    Expression<int>? heightUsed,
    Expression<int>? ageUsed,
    Expression<double>? activityFactor,
    Expression<double>? proteinPerKg,
    Expression<double>? fatPerKg,
  }) {
    return RawValuesInsertable({
      if (calculationId != null) 'calculation_id': calculationId,
      if (clientId != null) 'client_id': clientId,
      if (date != null) 'date': date,
      if (goalType != null) 'goal_type': goalType,
      if (bmrFormula != null) 'bmr_formula': bmrFormula,
      if (bmr != null) 'bmr': bmr,
      if (tdee != null) 'tdee': tdee,
      if (kcalTarget != null) 'kcal_target': kcalTarget,
      if (proteins != null) 'proteins': proteins,
      if (carbohydrates != null) 'carbohydrates': carbohydrates,
      if (fats != null) 'fats': fats,
      if (weightUsed != null) 'weight_used': weightUsed,
      if (heightUsed != null) 'height_used': heightUsed,
      if (ageUsed != null) 'age_used': ageUsed,
      if (activityFactor != null) 'activity_factor': activityFactor,
      if (proteinPerKg != null) 'protein_per_kg': proteinPerKg,
      if (fatPerKg != null) 'fat_per_kg': fatPerKg,
    });
  }

  NutritionCalculationsCompanion copyWith({
    Value<int>? calculationId,
    Value<int>? clientId,
    Value<DateTime>? date,
    Value<GoalType>? goalType,
    Value<BmrFormula>? bmrFormula,
    Value<double>? bmr,
    Value<double>? tdee,
    Value<double>? kcalTarget,
    Value<double>? proteins,
    Value<double>? carbohydrates,
    Value<double>? fats,
    Value<double?>? weightUsed,
    Value<int?>? heightUsed,
    Value<int?>? ageUsed,
    Value<double?>? activityFactor,
    Value<double?>? proteinPerKg,
    Value<double?>? fatPerKg,
  }) {
    return NutritionCalculationsCompanion(
      calculationId: calculationId ?? this.calculationId,
      clientId: clientId ?? this.clientId,
      date: date ?? this.date,
      goalType: goalType ?? this.goalType,
      bmrFormula: bmrFormula ?? this.bmrFormula,
      bmr: bmr ?? this.bmr,
      tdee: tdee ?? this.tdee,
      kcalTarget: kcalTarget ?? this.kcalTarget,
      proteins: proteins ?? this.proteins,
      carbohydrates: carbohydrates ?? this.carbohydrates,
      fats: fats ?? this.fats,
      weightUsed: weightUsed ?? this.weightUsed,
      heightUsed: heightUsed ?? this.heightUsed,
      ageUsed: ageUsed ?? this.ageUsed,
      activityFactor: activityFactor ?? this.activityFactor,
      proteinPerKg: proteinPerKg ?? this.proteinPerKg,
      fatPerKg: fatPerKg ?? this.fatPerKg,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (calculationId.present) {
      map['calculation_id'] = Variable<int>(calculationId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (goalType.present) {
      map['goal_type'] = Variable<int>(
        $NutritionCalculationsTable.$convertergoalType.toSql(goalType.value),
      );
    }
    if (bmrFormula.present) {
      map['bmr_formula'] = Variable<int>(
        $NutritionCalculationsTable.$converterbmrFormula.toSql(
          bmrFormula.value,
        ),
      );
    }
    if (bmr.present) {
      map['bmr'] = Variable<double>(bmr.value);
    }
    if (tdee.present) {
      map['tdee'] = Variable<double>(tdee.value);
    }
    if (kcalTarget.present) {
      map['kcal_target'] = Variable<double>(kcalTarget.value);
    }
    if (proteins.present) {
      map['proteins'] = Variable<double>(proteins.value);
    }
    if (carbohydrates.present) {
      map['carbohydrates'] = Variable<double>(carbohydrates.value);
    }
    if (fats.present) {
      map['fats'] = Variable<double>(fats.value);
    }
    if (weightUsed.present) {
      map['weight_used'] = Variable<double>(weightUsed.value);
    }
    if (heightUsed.present) {
      map['height_used'] = Variable<int>(heightUsed.value);
    }
    if (ageUsed.present) {
      map['age_used'] = Variable<int>(ageUsed.value);
    }
    if (activityFactor.present) {
      map['activity_factor'] = Variable<double>(activityFactor.value);
    }
    if (proteinPerKg.present) {
      map['protein_per_kg'] = Variable<double>(proteinPerKg.value);
    }
    if (fatPerKg.present) {
      map['fat_per_kg'] = Variable<double>(fatPerKg.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NutritionCalculationsCompanion(')
          ..write('calculationId: $calculationId, ')
          ..write('clientId: $clientId, ')
          ..write('date: $date, ')
          ..write('goalType: $goalType, ')
          ..write('bmrFormula: $bmrFormula, ')
          ..write('bmr: $bmr, ')
          ..write('tdee: $tdee, ')
          ..write('kcalTarget: $kcalTarget, ')
          ..write('proteins: $proteins, ')
          ..write('carbohydrates: $carbohydrates, ')
          ..write('fats: $fats, ')
          ..write('weightUsed: $weightUsed, ')
          ..write('heightUsed: $heightUsed, ')
          ..write('ageUsed: $ageUsed, ')
          ..write('activityFactor: $activityFactor, ')
          ..write('proteinPerKg: $proteinPerKg, ')
          ..write('fatPerKg: $fatPerKg')
          ..write(')'))
        .toString();
  }
}

class $NutritionPlansTable extends NutritionPlans
    with TableInfo<$NutritionPlansTable, NutritionPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NutritionPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<int> planId = GeneratedColumn<int>(
    'plan_id',
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
  static const VerificationMeta _calculationIdMeta = const VerificationMeta(
    'calculationId',
  );
  @override
  late final GeneratedColumn<int> calculationId = GeneratedColumn<int>(
    'calculation_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES nutrition_calculations (calculation_id)',
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
  @override
  late final GeneratedColumnWithTypeConverter<PlanStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(PlanStatus.draft.index),
      ).withConverter<PlanStatus>($NutritionPlansTable.$converterstatus);
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mealsCountMeta = const VerificationMeta(
    'mealsCount',
  );
  @override
  late final GeneratedColumn<int> mealsCount = GeneratedColumn<int>(
    'meals_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kcalSnapshotMeta = const VerificationMeta(
    'kcalSnapshot',
  );
  @override
  late final GeneratedColumn<double> kcalSnapshot = GeneratedColumn<double>(
    'kcal_snapshot',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<GoalType?, int> goalType =
      GeneratedColumn<int>(
        'goal_type',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<GoalType?>($NutritionPlansTable.$convertergoalTypen);
  static const VerificationMeta _pdfFileMeta = const VerificationMeta(
    'pdfFile',
  );
  @override
  late final GeneratedColumn<String> pdfFile = GeneratedColumn<String>(
    'pdf_file',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    planId,
    clientId,
    calculationId,
    name,
    status,
    description,
    mealsCount,
    kcalSnapshot,
    goalType,
    pdfFile,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrition_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<NutritionPlan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
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
    if (data.containsKey('calculation_id')) {
      context.handle(
        _calculationIdMeta,
        calculationId.isAcceptableOrUnknown(
          data['calculation_id']!,
          _calculationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_calculationIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('meals_count')) {
      context.handle(
        _mealsCountMeta,
        mealsCount.isAcceptableOrUnknown(data['meals_count']!, _mealsCountMeta),
      );
    }
    if (data.containsKey('kcal_snapshot')) {
      context.handle(
        _kcalSnapshotMeta,
        kcalSnapshot.isAcceptableOrUnknown(
          data['kcal_snapshot']!,
          _kcalSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('pdf_file')) {
      context.handle(
        _pdfFileMeta,
        pdfFile.isAcceptableOrUnknown(data['pdf_file']!, _pdfFileMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {planId};
  @override
  NutritionPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NutritionPlan(
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plan_id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      )!,
      calculationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calculation_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      status: $NutritionPlansTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      mealsCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meals_count'],
      ),
      kcalSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kcal_snapshot'],
      ),
      goalType: $NutritionPlansTable.$convertergoalTypen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}goal_type'],
        ),
      ),
      pdfFile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pdf_file'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $NutritionPlansTable createAlias(String alias) {
    return $NutritionPlansTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PlanStatus, int, int> $converterstatus =
      const EnumIndexConverter<PlanStatus>(PlanStatus.values);
  static JsonTypeConverter2<GoalType, int, int> $convertergoalType =
      const EnumIndexConverter<GoalType>(GoalType.values);
  static JsonTypeConverter2<GoalType?, int?, int?> $convertergoalTypen =
      JsonTypeConverter2.asNullable($convertergoalType);
}

class NutritionPlan extends DataClass implements Insertable<NutritionPlan> {
  final int planId;
  final int clientId;
  final int calculationId;
  final String name;
  final PlanStatus status;
  final String? description;
  final int? mealsCount;
  final double? kcalSnapshot;
  final GoalType? goalType;
  final String? pdfFile;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const NutritionPlan({
    required this.planId,
    required this.clientId,
    required this.calculationId,
    required this.name,
    required this.status,
    this.description,
    this.mealsCount,
    this.kcalSnapshot,
    this.goalType,
    this.pdfFile,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['plan_id'] = Variable<int>(planId);
    map['client_id'] = Variable<int>(clientId);
    map['calculation_id'] = Variable<int>(calculationId);
    map['name'] = Variable<String>(name);
    {
      map['status'] = Variable<int>(
        $NutritionPlansTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || mealsCount != null) {
      map['meals_count'] = Variable<int>(mealsCount);
    }
    if (!nullToAbsent || kcalSnapshot != null) {
      map['kcal_snapshot'] = Variable<double>(kcalSnapshot);
    }
    if (!nullToAbsent || goalType != null) {
      map['goal_type'] = Variable<int>(
        $NutritionPlansTable.$convertergoalTypen.toSql(goalType),
      );
    }
    if (!nullToAbsent || pdfFile != null) {
      map['pdf_file'] = Variable<String>(pdfFile);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  NutritionPlansCompanion toCompanion(bool nullToAbsent) {
    return NutritionPlansCompanion(
      planId: Value(planId),
      clientId: Value(clientId),
      calculationId: Value(calculationId),
      name: Value(name),
      status: Value(status),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      mealsCount: mealsCount == null && nullToAbsent
          ? const Value.absent()
          : Value(mealsCount),
      kcalSnapshot: kcalSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(kcalSnapshot),
      goalType: goalType == null && nullToAbsent
          ? const Value.absent()
          : Value(goalType),
      pdfFile: pdfFile == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfFile),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory NutritionPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NutritionPlan(
      planId: serializer.fromJson<int>(json['planId']),
      clientId: serializer.fromJson<int>(json['clientId']),
      calculationId: serializer.fromJson<int>(json['calculationId']),
      name: serializer.fromJson<String>(json['name']),
      status: $NutritionPlansTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      description: serializer.fromJson<String?>(json['description']),
      mealsCount: serializer.fromJson<int?>(json['mealsCount']),
      kcalSnapshot: serializer.fromJson<double?>(json['kcalSnapshot']),
      goalType: $NutritionPlansTable.$convertergoalTypen.fromJson(
        serializer.fromJson<int?>(json['goalType']),
      ),
      pdfFile: serializer.fromJson<String?>(json['pdfFile']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'planId': serializer.toJson<int>(planId),
      'clientId': serializer.toJson<int>(clientId),
      'calculationId': serializer.toJson<int>(calculationId),
      'name': serializer.toJson<String>(name),
      'status': serializer.toJson<int>(
        $NutritionPlansTable.$converterstatus.toJson(status),
      ),
      'description': serializer.toJson<String?>(description),
      'mealsCount': serializer.toJson<int?>(mealsCount),
      'kcalSnapshot': serializer.toJson<double?>(kcalSnapshot),
      'goalType': serializer.toJson<int?>(
        $NutritionPlansTable.$convertergoalTypen.toJson(goalType),
      ),
      'pdfFile': serializer.toJson<String?>(pdfFile),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  NutritionPlan copyWith({
    int? planId,
    int? clientId,
    int? calculationId,
    String? name,
    PlanStatus? status,
    Value<String?> description = const Value.absent(),
    Value<int?> mealsCount = const Value.absent(),
    Value<double?> kcalSnapshot = const Value.absent(),
    Value<GoalType?> goalType = const Value.absent(),
    Value<String?> pdfFile = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => NutritionPlan(
    planId: planId ?? this.planId,
    clientId: clientId ?? this.clientId,
    calculationId: calculationId ?? this.calculationId,
    name: name ?? this.name,
    status: status ?? this.status,
    description: description.present ? description.value : this.description,
    mealsCount: mealsCount.present ? mealsCount.value : this.mealsCount,
    kcalSnapshot: kcalSnapshot.present ? kcalSnapshot.value : this.kcalSnapshot,
    goalType: goalType.present ? goalType.value : this.goalType,
    pdfFile: pdfFile.present ? pdfFile.value : this.pdfFile,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  NutritionPlan copyWithCompanion(NutritionPlansCompanion data) {
    return NutritionPlan(
      planId: data.planId.present ? data.planId.value : this.planId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      calculationId: data.calculationId.present
          ? data.calculationId.value
          : this.calculationId,
      name: data.name.present ? data.name.value : this.name,
      status: data.status.present ? data.status.value : this.status,
      description: data.description.present
          ? data.description.value
          : this.description,
      mealsCount: data.mealsCount.present
          ? data.mealsCount.value
          : this.mealsCount,
      kcalSnapshot: data.kcalSnapshot.present
          ? data.kcalSnapshot.value
          : this.kcalSnapshot,
      goalType: data.goalType.present ? data.goalType.value : this.goalType,
      pdfFile: data.pdfFile.present ? data.pdfFile.value : this.pdfFile,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NutritionPlan(')
          ..write('planId: $planId, ')
          ..write('clientId: $clientId, ')
          ..write('calculationId: $calculationId, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('description: $description, ')
          ..write('mealsCount: $mealsCount, ')
          ..write('kcalSnapshot: $kcalSnapshot, ')
          ..write('goalType: $goalType, ')
          ..write('pdfFile: $pdfFile, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    planId,
    clientId,
    calculationId,
    name,
    status,
    description,
    mealsCount,
    kcalSnapshot,
    goalType,
    pdfFile,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NutritionPlan &&
          other.planId == this.planId &&
          other.clientId == this.clientId &&
          other.calculationId == this.calculationId &&
          other.name == this.name &&
          other.status == this.status &&
          other.description == this.description &&
          other.mealsCount == this.mealsCount &&
          other.kcalSnapshot == this.kcalSnapshot &&
          other.goalType == this.goalType &&
          other.pdfFile == this.pdfFile &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class NutritionPlansCompanion extends UpdateCompanion<NutritionPlan> {
  final Value<int> planId;
  final Value<int> clientId;
  final Value<int> calculationId;
  final Value<String> name;
  final Value<PlanStatus> status;
  final Value<String?> description;
  final Value<int?> mealsCount;
  final Value<double?> kcalSnapshot;
  final Value<GoalType?> goalType;
  final Value<String?> pdfFile;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const NutritionPlansCompanion({
    this.planId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.calculationId = const Value.absent(),
    this.name = const Value.absent(),
    this.status = const Value.absent(),
    this.description = const Value.absent(),
    this.mealsCount = const Value.absent(),
    this.kcalSnapshot = const Value.absent(),
    this.goalType = const Value.absent(),
    this.pdfFile = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  NutritionPlansCompanion.insert({
    this.planId = const Value.absent(),
    required int clientId,
    required int calculationId,
    required String name,
    this.status = const Value.absent(),
    this.description = const Value.absent(),
    this.mealsCount = const Value.absent(),
    this.kcalSnapshot = const Value.absent(),
    this.goalType = const Value.absent(),
    this.pdfFile = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : clientId = Value(clientId),
       calculationId = Value(calculationId),
       name = Value(name);
  static Insertable<NutritionPlan> custom({
    Expression<int>? planId,
    Expression<int>? clientId,
    Expression<int>? calculationId,
    Expression<String>? name,
    Expression<int>? status,
    Expression<String>? description,
    Expression<int>? mealsCount,
    Expression<double>? kcalSnapshot,
    Expression<int>? goalType,
    Expression<String>? pdfFile,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (planId != null) 'plan_id': planId,
      if (clientId != null) 'client_id': clientId,
      if (calculationId != null) 'calculation_id': calculationId,
      if (name != null) 'name': name,
      if (status != null) 'status': status,
      if (description != null) 'description': description,
      if (mealsCount != null) 'meals_count': mealsCount,
      if (kcalSnapshot != null) 'kcal_snapshot': kcalSnapshot,
      if (goalType != null) 'goal_type': goalType,
      if (pdfFile != null) 'pdf_file': pdfFile,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  NutritionPlansCompanion copyWith({
    Value<int>? planId,
    Value<int>? clientId,
    Value<int>? calculationId,
    Value<String>? name,
    Value<PlanStatus>? status,
    Value<String?>? description,
    Value<int?>? mealsCount,
    Value<double?>? kcalSnapshot,
    Value<GoalType?>? goalType,
    Value<String?>? pdfFile,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return NutritionPlansCompanion(
      planId: planId ?? this.planId,
      clientId: clientId ?? this.clientId,
      calculationId: calculationId ?? this.calculationId,
      name: name ?? this.name,
      status: status ?? this.status,
      description: description ?? this.description,
      mealsCount: mealsCount ?? this.mealsCount,
      kcalSnapshot: kcalSnapshot ?? this.kcalSnapshot,
      goalType: goalType ?? this.goalType,
      pdfFile: pdfFile ?? this.pdfFile,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (planId.present) {
      map['plan_id'] = Variable<int>(planId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (calculationId.present) {
      map['calculation_id'] = Variable<int>(calculationId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $NutritionPlansTable.$converterstatus.toSql(status.value),
      );
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (mealsCount.present) {
      map['meals_count'] = Variable<int>(mealsCount.value);
    }
    if (kcalSnapshot.present) {
      map['kcal_snapshot'] = Variable<double>(kcalSnapshot.value);
    }
    if (goalType.present) {
      map['goal_type'] = Variable<int>(
        $NutritionPlansTable.$convertergoalTypen.toSql(goalType.value),
      );
    }
    if (pdfFile.present) {
      map['pdf_file'] = Variable<String>(pdfFile.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NutritionPlansCompanion(')
          ..write('planId: $planId, ')
          ..write('clientId: $clientId, ')
          ..write('calculationId: $calculationId, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('description: $description, ')
          ..write('mealsCount: $mealsCount, ')
          ..write('kcalSnapshot: $kcalSnapshot, ')
          ..write('goalType: $goalType, ')
          ..write('pdfFile: $pdfFile, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
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
  late final $NotesTable notes = $NotesTable(this);
  late final $NutritionCalculationsTable nutritionCalculations =
      $NutritionCalculationsTable(this);
  late final $NutritionPlansTable nutritionPlans = $NutritionPlansTable(this);
  late final ClientDao clientDao = ClientDao(this as AppDatabase);
  late final AnamnesisDao anamnesisDao = AnamnesisDao(this as AppDatabase);
  late final MeasurementDao measurementDao = MeasurementDao(
    this as AppDatabase,
  );
  late final NoteDao noteDao = NoteDao(this as AppDatabase);
  late final NutritionCalculationDao nutritionCalculationDao =
      NutritionCalculationDao(this as AppDatabase);
  late final NutritionPlanDao nutritionPlanDao = NutritionPlanDao(
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
    notes,
    nutritionCalculations,
    nutritionPlans,
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

  static MultiTypedResultKey<$NotesTable, List<Note>> _notesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.notes,
    aliasName: $_aliasNameGenerator(db.clients.clientId, db.notes.clientId),
  );

  $$NotesTableProcessedTableManager get notesRefs {
    final manager = $$NotesTableTableManager($_db, $_db.notes).filter(
      (f) => f.clientId.clientId.sqlEquals($_itemColumn<int>('client_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_notesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $NutritionCalculationsTable,
    List<NutritionCalculation>
  >
  _nutritionCalculationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.nutritionCalculations,
        aliasName: $_aliasNameGenerator(
          db.clients.clientId,
          db.nutritionCalculations.clientId,
        ),
      );

  $$NutritionCalculationsTableProcessedTableManager
  get nutritionCalculationsRefs {
    final manager =
        $$NutritionCalculationsTableTableManager(
          $_db,
          $_db.nutritionCalculations,
        ).filter(
          (f) => f.clientId.clientId.sqlEquals($_itemColumn<int>('client_id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _nutritionCalculationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$NutritionPlansTable, List<NutritionPlan>>
  _nutritionPlansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.nutritionPlans,
    aliasName: $_aliasNameGenerator(
      db.clients.clientId,
      db.nutritionPlans.clientId,
    ),
  );

  $$NutritionPlansTableProcessedTableManager get nutritionPlansRefs {
    final manager = $$NutritionPlansTableTableManager($_db, $_db.nutritionPlans)
        .filter(
          (f) => f.clientId.clientId.sqlEquals($_itemColumn<int>('client_id')!),
        );

    final cache = $_typedResult.readTableOrNull(_nutritionPlansRefsTable($_db));
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

  Expression<bool> notesRefs(
    Expression<bool> Function($$NotesTableFilterComposer f) f,
  ) {
    final $$NotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotesTableFilterComposer(
            $db: $db,
            $table: $db.notes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> nutritionCalculationsRefs(
    Expression<bool> Function($$NutritionCalculationsTableFilterComposer f) f,
  ) {
    final $$NutritionCalculationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.clientId,
          referencedTable: $db.nutritionCalculations,
          getReferencedColumn: (t) => t.clientId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NutritionCalculationsTableFilterComposer(
                $db: $db,
                $table: $db.nutritionCalculations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> nutritionPlansRefs(
    Expression<bool> Function($$NutritionPlansTableFilterComposer f) f,
  ) {
    final $$NutritionPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.nutritionPlans,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NutritionPlansTableFilterComposer(
            $db: $db,
            $table: $db.nutritionPlans,
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

  Expression<T> notesRefs<T extends Object>(
    Expression<T> Function($$NotesTableAnnotationComposer a) f,
  ) {
    final $$NotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotesTableAnnotationComposer(
            $db: $db,
            $table: $db.notes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> nutritionCalculationsRefs<T extends Object>(
    Expression<T> Function($$NutritionCalculationsTableAnnotationComposer a) f,
  ) {
    final $$NutritionCalculationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.clientId,
          referencedTable: $db.nutritionCalculations,
          getReferencedColumn: (t) => t.clientId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NutritionCalculationsTableAnnotationComposer(
                $db: $db,
                $table: $db.nutritionCalculations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> nutritionPlansRefs<T extends Object>(
    Expression<T> Function($$NutritionPlansTableAnnotationComposer a) f,
  ) {
    final $$NutritionPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.nutritionPlans,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NutritionPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.nutritionPlans,
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
            bool notesRefs,
            bool nutritionCalculationsRefs,
            bool nutritionPlansRefs,
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
              ({
                anamnesisTableRefs = false,
                measurementsRefs = false,
                notesRefs = false,
                nutritionCalculationsRefs = false,
                nutritionPlansRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (anamnesisTableRefs) db.anamnesisTable,
                    if (measurementsRefs) db.measurements,
                    if (notesRefs) db.notes,
                    if (nutritionCalculationsRefs) db.nutritionCalculations,
                    if (nutritionPlansRefs) db.nutritionPlans,
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
                      if (notesRefs)
                        await $_getPrefetchedData<Client, $ClientsTable, Note>(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._notesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(db, table, p0).notesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.clientId,
                              ),
                          typedResults: items,
                        ),
                      if (nutritionCalculationsRefs)
                        await $_getPrefetchedData<
                          Client,
                          $ClientsTable,
                          NutritionCalculation
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._nutritionCalculationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).nutritionCalculationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.clientId,
                              ),
                          typedResults: items,
                        ),
                      if (nutritionPlansRefs)
                        await $_getPrefetchedData<
                          Client,
                          $ClientsTable,
                          NutritionPlan
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._nutritionPlansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).nutritionPlansRefs,
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
      PrefetchHooks Function({
        bool anamnesisTableRefs,
        bool measurementsRefs,
        bool notesRefs,
        bool nutritionCalculationsRefs,
        bool nutritionPlansRefs,
      })
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
typedef $$NotesTableCreateCompanionBuilder =
    NotesCompanion Function({
      Value<int> noteId,
      required int clientId,
      Value<DateTime> date,
      Value<NoteType> type,
      required String content,
    });
typedef $$NotesTableUpdateCompanionBuilder =
    NotesCompanion Function({
      Value<int> noteId,
      Value<int> clientId,
      Value<DateTime> date,
      Value<NoteType> type,
      Value<String> content,
    });

final class $$NotesTableReferences
    extends BaseReferences<_$AppDatabase, $NotesTable, Note> {
  $$NotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias(
        $_aliasNameGenerator(db.notes.clientId, db.clients.clientId),
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

class $$NotesTableFilterComposer extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get noteId => $composableBuilder(
    column: $table.noteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<NoteType, NoteType, int> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
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

class $$NotesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get noteId => $composableBuilder(
    column: $table.noteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
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

class $$NotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get noteId =>
      $composableBuilder(column: $table.noteId, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumnWithTypeConverter<NoteType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

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

class $$NotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotesTable,
          Note,
          $$NotesTableFilterComposer,
          $$NotesTableOrderingComposer,
          $$NotesTableAnnotationComposer,
          $$NotesTableCreateCompanionBuilder,
          $$NotesTableUpdateCompanionBuilder,
          (Note, $$NotesTableReferences),
          Note,
          PrefetchHooks Function({bool clientId})
        > {
  $$NotesTableTableManager(_$AppDatabase db, $NotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> noteId = const Value.absent(),
                Value<int> clientId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<NoteType> type = const Value.absent(),
                Value<String> content = const Value.absent(),
              }) => NotesCompanion(
                noteId: noteId,
                clientId: clientId,
                date: date,
                type: type,
                content: content,
              ),
          createCompanionCallback:
              ({
                Value<int> noteId = const Value.absent(),
                required int clientId,
                Value<DateTime> date = const Value.absent(),
                Value<NoteType> type = const Value.absent(),
                required String content,
              }) => NotesCompanion.insert(
                noteId: noteId,
                clientId: clientId,
                date: date,
                type: type,
                content: content,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$NotesTableReferences(db, table, e)),
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
                                referencedTable: $$NotesTableReferences
                                    ._clientIdTable(db),
                                referencedColumn: $$NotesTableReferences
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

typedef $$NotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotesTable,
      Note,
      $$NotesTableFilterComposer,
      $$NotesTableOrderingComposer,
      $$NotesTableAnnotationComposer,
      $$NotesTableCreateCompanionBuilder,
      $$NotesTableUpdateCompanionBuilder,
      (Note, $$NotesTableReferences),
      Note,
      PrefetchHooks Function({bool clientId})
    >;
typedef $$NutritionCalculationsTableCreateCompanionBuilder =
    NutritionCalculationsCompanion Function({
      Value<int> calculationId,
      required int clientId,
      Value<DateTime> date,
      required GoalType goalType,
      Value<BmrFormula> bmrFormula,
      required double bmr,
      required double tdee,
      required double kcalTarget,
      required double proteins,
      required double carbohydrates,
      required double fats,
      Value<double?> weightUsed,
      Value<int?> heightUsed,
      Value<int?> ageUsed,
      Value<double?> activityFactor,
      Value<double?> proteinPerKg,
      Value<double?> fatPerKg,
    });
typedef $$NutritionCalculationsTableUpdateCompanionBuilder =
    NutritionCalculationsCompanion Function({
      Value<int> calculationId,
      Value<int> clientId,
      Value<DateTime> date,
      Value<GoalType> goalType,
      Value<BmrFormula> bmrFormula,
      Value<double> bmr,
      Value<double> tdee,
      Value<double> kcalTarget,
      Value<double> proteins,
      Value<double> carbohydrates,
      Value<double> fats,
      Value<double?> weightUsed,
      Value<int?> heightUsed,
      Value<int?> ageUsed,
      Value<double?> activityFactor,
      Value<double?> proteinPerKg,
      Value<double?> fatPerKg,
    });

final class $$NutritionCalculationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $NutritionCalculationsTable,
          NutritionCalculation
        > {
  $$NutritionCalculationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias(
        $_aliasNameGenerator(
          db.nutritionCalculations.clientId,
          db.clients.clientId,
        ),
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

  static MultiTypedResultKey<$NutritionPlansTable, List<NutritionPlan>>
  _nutritionPlansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.nutritionPlans,
    aliasName: $_aliasNameGenerator(
      db.nutritionCalculations.calculationId,
      db.nutritionPlans.calculationId,
    ),
  );

  $$NutritionPlansTableProcessedTableManager get nutritionPlansRefs {
    final manager = $$NutritionPlansTableTableManager($_db, $_db.nutritionPlans)
        .filter(
          (f) => f.calculationId.calculationId.sqlEquals(
            $_itemColumn<int>('calculation_id')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(_nutritionPlansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$NutritionCalculationsTableFilterComposer
    extends Composer<_$AppDatabase, $NutritionCalculationsTable> {
  $$NutritionCalculationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get calculationId => $composableBuilder(
    column: $table.calculationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<GoalType, GoalType, int> get goalType =>
      $composableBuilder(
        column: $table.goalType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<BmrFormula, BmrFormula, int> get bmrFormula =>
      $composableBuilder(
        column: $table.bmrFormula,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get bmr => $composableBuilder(
    column: $table.bmr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tdee => $composableBuilder(
    column: $table.tdee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kcalTarget => $composableBuilder(
    column: $table.kcalTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteins => $composableBuilder(
    column: $table.proteins,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbohydrates => $composableBuilder(
    column: $table.carbohydrates,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fats => $composableBuilder(
    column: $table.fats,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightUsed => $composableBuilder(
    column: $table.weightUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heightUsed => $composableBuilder(
    column: $table.heightUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ageUsed => $composableBuilder(
    column: $table.ageUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get activityFactor => $composableBuilder(
    column: $table.activityFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinPerKg => $composableBuilder(
    column: $table.proteinPerKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatPerKg => $composableBuilder(
    column: $table.fatPerKg,
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

  Expression<bool> nutritionPlansRefs(
    Expression<bool> Function($$NutritionPlansTableFilterComposer f) f,
  ) {
    final $$NutritionPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.calculationId,
      referencedTable: $db.nutritionPlans,
      getReferencedColumn: (t) => t.calculationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NutritionPlansTableFilterComposer(
            $db: $db,
            $table: $db.nutritionPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NutritionCalculationsTableOrderingComposer
    extends Composer<_$AppDatabase, $NutritionCalculationsTable> {
  $$NutritionCalculationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get calculationId => $composableBuilder(
    column: $table.calculationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goalType => $composableBuilder(
    column: $table.goalType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bmrFormula => $composableBuilder(
    column: $table.bmrFormula,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bmr => $composableBuilder(
    column: $table.bmr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tdee => $composableBuilder(
    column: $table.tdee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kcalTarget => $composableBuilder(
    column: $table.kcalTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteins => $composableBuilder(
    column: $table.proteins,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbohydrates => $composableBuilder(
    column: $table.carbohydrates,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fats => $composableBuilder(
    column: $table.fats,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightUsed => $composableBuilder(
    column: $table.weightUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heightUsed => $composableBuilder(
    column: $table.heightUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ageUsed => $composableBuilder(
    column: $table.ageUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get activityFactor => $composableBuilder(
    column: $table.activityFactor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinPerKg => $composableBuilder(
    column: $table.proteinPerKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatPerKg => $composableBuilder(
    column: $table.fatPerKg,
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

class $$NutritionCalculationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NutritionCalculationsTable> {
  $$NutritionCalculationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get calculationId => $composableBuilder(
    column: $table.calculationId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GoalType, int> get goalType =>
      $composableBuilder(column: $table.goalType, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BmrFormula, int> get bmrFormula =>
      $composableBuilder(
        column: $table.bmrFormula,
        builder: (column) => column,
      );

  GeneratedColumn<double> get bmr =>
      $composableBuilder(column: $table.bmr, builder: (column) => column);

  GeneratedColumn<double> get tdee =>
      $composableBuilder(column: $table.tdee, builder: (column) => column);

  GeneratedColumn<double> get kcalTarget => $composableBuilder(
    column: $table.kcalTarget,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteins =>
      $composableBuilder(column: $table.proteins, builder: (column) => column);

  GeneratedColumn<double> get carbohydrates => $composableBuilder(
    column: $table.carbohydrates,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fats =>
      $composableBuilder(column: $table.fats, builder: (column) => column);

  GeneratedColumn<double> get weightUsed => $composableBuilder(
    column: $table.weightUsed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get heightUsed => $composableBuilder(
    column: $table.heightUsed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ageUsed =>
      $composableBuilder(column: $table.ageUsed, builder: (column) => column);

  GeneratedColumn<double> get activityFactor => $composableBuilder(
    column: $table.activityFactor,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinPerKg => $composableBuilder(
    column: $table.proteinPerKg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatPerKg =>
      $composableBuilder(column: $table.fatPerKg, builder: (column) => column);

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

  Expression<T> nutritionPlansRefs<T extends Object>(
    Expression<T> Function($$NutritionPlansTableAnnotationComposer a) f,
  ) {
    final $$NutritionPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.calculationId,
      referencedTable: $db.nutritionPlans,
      getReferencedColumn: (t) => t.calculationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NutritionPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.nutritionPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NutritionCalculationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NutritionCalculationsTable,
          NutritionCalculation,
          $$NutritionCalculationsTableFilterComposer,
          $$NutritionCalculationsTableOrderingComposer,
          $$NutritionCalculationsTableAnnotationComposer,
          $$NutritionCalculationsTableCreateCompanionBuilder,
          $$NutritionCalculationsTableUpdateCompanionBuilder,
          (NutritionCalculation, $$NutritionCalculationsTableReferences),
          NutritionCalculation,
          PrefetchHooks Function({bool clientId, bool nutritionPlansRefs})
        > {
  $$NutritionCalculationsTableTableManager(
    _$AppDatabase db,
    $NutritionCalculationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NutritionCalculationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$NutritionCalculationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NutritionCalculationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> calculationId = const Value.absent(),
                Value<int> clientId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<GoalType> goalType = const Value.absent(),
                Value<BmrFormula> bmrFormula = const Value.absent(),
                Value<double> bmr = const Value.absent(),
                Value<double> tdee = const Value.absent(),
                Value<double> kcalTarget = const Value.absent(),
                Value<double> proteins = const Value.absent(),
                Value<double> carbohydrates = const Value.absent(),
                Value<double> fats = const Value.absent(),
                Value<double?> weightUsed = const Value.absent(),
                Value<int?> heightUsed = const Value.absent(),
                Value<int?> ageUsed = const Value.absent(),
                Value<double?> activityFactor = const Value.absent(),
                Value<double?> proteinPerKg = const Value.absent(),
                Value<double?> fatPerKg = const Value.absent(),
              }) => NutritionCalculationsCompanion(
                calculationId: calculationId,
                clientId: clientId,
                date: date,
                goalType: goalType,
                bmrFormula: bmrFormula,
                bmr: bmr,
                tdee: tdee,
                kcalTarget: kcalTarget,
                proteins: proteins,
                carbohydrates: carbohydrates,
                fats: fats,
                weightUsed: weightUsed,
                heightUsed: heightUsed,
                ageUsed: ageUsed,
                activityFactor: activityFactor,
                proteinPerKg: proteinPerKg,
                fatPerKg: fatPerKg,
              ),
          createCompanionCallback:
              ({
                Value<int> calculationId = const Value.absent(),
                required int clientId,
                Value<DateTime> date = const Value.absent(),
                required GoalType goalType,
                Value<BmrFormula> bmrFormula = const Value.absent(),
                required double bmr,
                required double tdee,
                required double kcalTarget,
                required double proteins,
                required double carbohydrates,
                required double fats,
                Value<double?> weightUsed = const Value.absent(),
                Value<int?> heightUsed = const Value.absent(),
                Value<int?> ageUsed = const Value.absent(),
                Value<double?> activityFactor = const Value.absent(),
                Value<double?> proteinPerKg = const Value.absent(),
                Value<double?> fatPerKg = const Value.absent(),
              }) => NutritionCalculationsCompanion.insert(
                calculationId: calculationId,
                clientId: clientId,
                date: date,
                goalType: goalType,
                bmrFormula: bmrFormula,
                bmr: bmr,
                tdee: tdee,
                kcalTarget: kcalTarget,
                proteins: proteins,
                carbohydrates: carbohydrates,
                fats: fats,
                weightUsed: weightUsed,
                heightUsed: heightUsed,
                ageUsed: ageUsed,
                activityFactor: activityFactor,
                proteinPerKg: proteinPerKg,
                fatPerKg: fatPerKg,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NutritionCalculationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({clientId = false, nutritionPlansRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (nutritionPlansRefs) db.nutritionPlans,
                  ],
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
                                    referencedTable:
                                        $$NutritionCalculationsTableReferences
                                            ._clientIdTable(db),
                                    referencedColumn:
                                        $$NutritionCalculationsTableReferences
                                            ._clientIdTable(db)
                                            .clientId,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (nutritionPlansRefs)
                        await $_getPrefetchedData<
                          NutritionCalculation,
                          $NutritionCalculationsTable,
                          NutritionPlan
                        >(
                          currentTable: table,
                          referencedTable:
                              $$NutritionCalculationsTableReferences
                                  ._nutritionPlansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$NutritionCalculationsTableReferences(
                                db,
                                table,
                                p0,
                              ).nutritionPlansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.calculationId == item.calculationId,
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

typedef $$NutritionCalculationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NutritionCalculationsTable,
      NutritionCalculation,
      $$NutritionCalculationsTableFilterComposer,
      $$NutritionCalculationsTableOrderingComposer,
      $$NutritionCalculationsTableAnnotationComposer,
      $$NutritionCalculationsTableCreateCompanionBuilder,
      $$NutritionCalculationsTableUpdateCompanionBuilder,
      (NutritionCalculation, $$NutritionCalculationsTableReferences),
      NutritionCalculation,
      PrefetchHooks Function({bool clientId, bool nutritionPlansRefs})
    >;
typedef $$NutritionPlansTableCreateCompanionBuilder =
    NutritionPlansCompanion Function({
      Value<int> planId,
      required int clientId,
      required int calculationId,
      required String name,
      Value<PlanStatus> status,
      Value<String?> description,
      Value<int?> mealsCount,
      Value<double?> kcalSnapshot,
      Value<GoalType?> goalType,
      Value<String?> pdfFile,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$NutritionPlansTableUpdateCompanionBuilder =
    NutritionPlansCompanion Function({
      Value<int> planId,
      Value<int> clientId,
      Value<int> calculationId,
      Value<String> name,
      Value<PlanStatus> status,
      Value<String?> description,
      Value<int?> mealsCount,
      Value<double?> kcalSnapshot,
      Value<GoalType?> goalType,
      Value<String?> pdfFile,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

final class $$NutritionPlansTableReferences
    extends BaseReferences<_$AppDatabase, $NutritionPlansTable, NutritionPlan> {
  $$NutritionPlansTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias(
        $_aliasNameGenerator(db.nutritionPlans.clientId, db.clients.clientId),
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

  static $NutritionCalculationsTable _calculationIdTable(_$AppDatabase db) =>
      db.nutritionCalculations.createAlias(
        $_aliasNameGenerator(
          db.nutritionPlans.calculationId,
          db.nutritionCalculations.calculationId,
        ),
      );

  $$NutritionCalculationsTableProcessedTableManager get calculationId {
    final $_column = $_itemColumn<int>('calculation_id')!;

    final manager = $$NutritionCalculationsTableTableManager(
      $_db,
      $_db.nutritionCalculations,
    ).filter((f) => f.calculationId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_calculationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NutritionPlansTableFilterComposer
    extends Composer<_$AppDatabase, $NutritionPlansTable> {
  $$NutritionPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PlanStatus, PlanStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mealsCount => $composableBuilder(
    column: $table.mealsCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kcalSnapshot => $composableBuilder(
    column: $table.kcalSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<GoalType?, GoalType, int> get goalType =>
      $composableBuilder(
        column: $table.goalType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get pdfFile => $composableBuilder(
    column: $table.pdfFile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
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

  $$NutritionCalculationsTableFilterComposer get calculationId {
    final $$NutritionCalculationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.calculationId,
          referencedTable: $db.nutritionCalculations,
          getReferencedColumn: (t) => t.calculationId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NutritionCalculationsTableFilterComposer(
                $db: $db,
                $table: $db.nutritionCalculations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$NutritionPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $NutritionPlansTable> {
  $$NutritionPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mealsCount => $composableBuilder(
    column: $table.mealsCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kcalSnapshot => $composableBuilder(
    column: $table.kcalSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goalType => $composableBuilder(
    column: $table.goalType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pdfFile => $composableBuilder(
    column: $table.pdfFile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
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

  $$NutritionCalculationsTableOrderingComposer get calculationId {
    final $$NutritionCalculationsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.calculationId,
          referencedTable: $db.nutritionCalculations,
          getReferencedColumn: (t) => t.calculationId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NutritionCalculationsTableOrderingComposer(
                $db: $db,
                $table: $db.nutritionCalculations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$NutritionPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $NutritionPlansTable> {
  $$NutritionPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PlanStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get mealsCount => $composableBuilder(
    column: $table.mealsCount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get kcalSnapshot => $composableBuilder(
    column: $table.kcalSnapshot,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<GoalType?, int> get goalType =>
      $composableBuilder(column: $table.goalType, builder: (column) => column);

  GeneratedColumn<String> get pdfFile =>
      $composableBuilder(column: $table.pdfFile, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

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

  $$NutritionCalculationsTableAnnotationComposer get calculationId {
    final $$NutritionCalculationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.calculationId,
          referencedTable: $db.nutritionCalculations,
          getReferencedColumn: (t) => t.calculationId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NutritionCalculationsTableAnnotationComposer(
                $db: $db,
                $table: $db.nutritionCalculations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$NutritionPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NutritionPlansTable,
          NutritionPlan,
          $$NutritionPlansTableFilterComposer,
          $$NutritionPlansTableOrderingComposer,
          $$NutritionPlansTableAnnotationComposer,
          $$NutritionPlansTableCreateCompanionBuilder,
          $$NutritionPlansTableUpdateCompanionBuilder,
          (NutritionPlan, $$NutritionPlansTableReferences),
          NutritionPlan,
          PrefetchHooks Function({bool clientId, bool calculationId})
        > {
  $$NutritionPlansTableTableManager(
    _$AppDatabase db,
    $NutritionPlansTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NutritionPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NutritionPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NutritionPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> planId = const Value.absent(),
                Value<int> clientId = const Value.absent(),
                Value<int> calculationId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<PlanStatus> status = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int?> mealsCount = const Value.absent(),
                Value<double?> kcalSnapshot = const Value.absent(),
                Value<GoalType?> goalType = const Value.absent(),
                Value<String?> pdfFile = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => NutritionPlansCompanion(
                planId: planId,
                clientId: clientId,
                calculationId: calculationId,
                name: name,
                status: status,
                description: description,
                mealsCount: mealsCount,
                kcalSnapshot: kcalSnapshot,
                goalType: goalType,
                pdfFile: pdfFile,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> planId = const Value.absent(),
                required int clientId,
                required int calculationId,
                required String name,
                Value<PlanStatus> status = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int?> mealsCount = const Value.absent(),
                Value<double?> kcalSnapshot = const Value.absent(),
                Value<GoalType?> goalType = const Value.absent(),
                Value<String?> pdfFile = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => NutritionPlansCompanion.insert(
                planId: planId,
                clientId: clientId,
                calculationId: calculationId,
                name: name,
                status: status,
                description: description,
                mealsCount: mealsCount,
                kcalSnapshot: kcalSnapshot,
                goalType: goalType,
                pdfFile: pdfFile,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NutritionPlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({clientId = false, calculationId = false}) {
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
                                referencedTable: $$NutritionPlansTableReferences
                                    ._clientIdTable(db),
                                referencedColumn:
                                    $$NutritionPlansTableReferences
                                        ._clientIdTable(db)
                                        .clientId,
                              )
                              as T;
                    }
                    if (calculationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.calculationId,
                                referencedTable: $$NutritionPlansTableReferences
                                    ._calculationIdTable(db),
                                referencedColumn:
                                    $$NutritionPlansTableReferences
                                        ._calculationIdTable(db)
                                        .calculationId,
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

typedef $$NutritionPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NutritionPlansTable,
      NutritionPlan,
      $$NutritionPlansTableFilterComposer,
      $$NutritionPlansTableOrderingComposer,
      $$NutritionPlansTableAnnotationComposer,
      $$NutritionPlansTableCreateCompanionBuilder,
      $$NutritionPlansTableUpdateCompanionBuilder,
      (NutritionPlan, $$NutritionPlansTableReferences),
      NutritionPlan,
      PrefetchHooks Function({bool clientId, bool calculationId})
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
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
  $$NutritionCalculationsTableTableManager get nutritionCalculations =>
      $$NutritionCalculationsTableTableManager(_db, _db.nutritionCalculations);
  $$NutritionPlansTableTableManager get nutritionPlans =>
      $$NutritionPlansTableTableManager(_db, _db.nutritionPlans);
}
