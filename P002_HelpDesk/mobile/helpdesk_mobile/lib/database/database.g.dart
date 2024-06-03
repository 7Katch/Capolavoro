// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  Dao? _daoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `piano` (`codice` INTEGER NOT NULL, `nome` INTEGER NOT NULL, PRIMARY KEY (`codice`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `stanza` (`codice` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `nome` TEXT NOT NULL, `piano` INTEGER NOT NULL, `tipo` INTEGER NOT NULL, FOREIGN KEY (`piano`) REFERENCES `piano` (`codice`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Dispositivo` (`codice` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `nome` TEXT NOT NULL, `tipo` INTEGER NOT NULL, `codice_stanza` INTEGER NOT NULL, FOREIGN KEY (`codice_stanza`) REFERENCES `stanza` (`codice`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  Dao get dao {
    return _daoInstance ??= _$Dao(database, changeListener);
  }
}

class _$Dao extends Dao {
  _$Dao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _pianoInsertionAdapter = InsertionAdapter(
            database,
            'piano',
            (Piano item) => <String, Object?>{
                  'codice': item.codice,
                  'nome': item.nome.index
                }),
        _stanzaInsertionAdapter = InsertionAdapter(
            database,
            'stanza',
            (Stanza item) => <String, Object?>{
                  'codice': item.codice,
                  'nome': item.nome,
                  'piano': item.piano,
                  'tipo': item.tipo.index
                }),
        _dispositivoInsertionAdapter = InsertionAdapter(
            database,
            'Dispositivo',
            (Dispositivo item) => <String, Object?>{
                  'codice': item.codice,
                  'nome': item.nome,
                  'tipo': item.tipo.index,
                  'codice_stanza': item.codice_stanza
                }),
        _pianoDeletionAdapter = DeletionAdapter(
            database,
            'piano',
            ['codice'],
            (Piano item) => <String, Object?>{
                  'codice': item.codice,
                  'nome': item.nome.index
                }),
        _stanzaDeletionAdapter = DeletionAdapter(
            database,
            'stanza',
            ['codice'],
            (Stanza item) => <String, Object?>{
                  'codice': item.codice,
                  'nome': item.nome,
                  'piano': item.piano,
                  'tipo': item.tipo.index
                }),
        _dispositivoDeletionAdapter = DeletionAdapter(
            database,
            'Dispositivo',
            ['codice'],
            (Dispositivo item) => <String, Object?>{
                  'codice': item.codice,
                  'nome': item.nome,
                  'tipo': item.tipo.index,
                  'codice_stanza': item.codice_stanza
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Piano> _pianoInsertionAdapter;

  final InsertionAdapter<Stanza> _stanzaInsertionAdapter;

  final InsertionAdapter<Dispositivo> _dispositivoInsertionAdapter;

  final DeletionAdapter<Piano> _pianoDeletionAdapter;

  final DeletionAdapter<Stanza> _stanzaDeletionAdapter;

  final DeletionAdapter<Dispositivo> _dispositivoDeletionAdapter;

  @override
  Future<List<Piano>> getPiani() async {
    return _queryAdapter.queryList('SELECT * FROM piano',
        mapper: (Map<String, Object?> row) =>
            Piano(row['codice'] as int, TipoPiano.values[row['nome'] as int]));
  }

  @override
  Future<void> cancellaTuttiPiani() async {
    await _queryAdapter.queryNoReturn('DELETE FROM piano WHERE TRUE');
  }

  @override
  Future<List<Stanza>> getStanze() async {
    return _queryAdapter.queryList('SELECT * FROM stanza',
        mapper: (Map<String, Object?> row) => Stanza(
            row['codice'] as int,
            row['nome'] as String,
            row['piano'] as int,
            TipoStanza.values[row['tipo'] as int]));
  }

  @override
  Future<List<Stanza>> getStanzaById(int codice) async {
    return _queryAdapter.queryList('SELECT * FROM stanza WHERE codice = ?1',
        mapper: (Map<String, Object?> row) => Stanza(
            row['codice'] as int,
            row['nome'] as String,
            row['piano'] as int,
            TipoStanza.values[row['tipo'] as int]),
        arguments: [codice]);
  }

  @override
  Future<void> cancellaTutteLeStanze() async {
    await _queryAdapter.queryNoReturn('DELETE FROM stanza');
  }

  @override
  Future<List<Dispositivo>> getDispositivi() async {
    return _queryAdapter.queryList('SELECT * FROM Dispositivo',
        mapper: (Map<String, Object?> row) => Dispositivo(
            row['codice'] as int,
            row['nome'] as String,
            TipoDispositivo.values[row['tipo'] as int],
            row['codice_stanza'] as int));
  }

  @override
  Future<List<Dispositivo>> getDispositivoById(int codice) async {
    return _queryAdapter.queryList(
        'SELECT * FROM dispositivo WHERE codice = ?1',
        mapper: (Map<String, Object?> row) => Dispositivo(
            row['codice'] as int,
            row['nome'] as String,
            TipoDispositivo.values[row['tipo'] as int],
            row['codice_stanza'] as int),
        arguments: [codice]);
  }

  @override
  Future<List<Dispositivo>> getDispositiviByStanza(int codice_stanza) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Dispositivo WHERE codice_stanza = ?1',
        mapper: (Map<String, Object?> row) => Dispositivo(
            row['codice'] as int,
            row['nome'] as String,
            TipoDispositivo.values[row['tipo'] as int],
            row['codice_stanza'] as int),
        arguments: [codice_stanza]);
  }

  @override
  Future<void> cancellaTuttiIDispositivi() async {
    await _queryAdapter.queryNoReturn('DELETE FROM dispositivo');
  }

  @override
  Future<void> inserisciPiano(Piano piano) async {
    await _pianoInsertionAdapter.insert(piano, OnConflictStrategy.abort);
  }

  @override
  Future<void> inserisciStanza(Stanza stanza) async {
    await _stanzaInsertionAdapter.insert(stanza, OnConflictStrategy.abort);
  }

  @override
  Future<void> inserisciDispositivo(Dispositivo dispositivo) async {
    await _dispositivoInsertionAdapter.insert(
        dispositivo, OnConflictStrategy.abort);
  }

  @override
  Future<void> cancellaPiano(Piano piano) async {
    await _pianoDeletionAdapter.delete(piano);
  }

  @override
  Future<void> cancellaStanza(Stanza stanza) async {
    await _stanzaDeletionAdapter.delete(stanza);
  }

  @override
  Future<void> cancellaDispositivo(Dispositivo dispositivo) async {
    await _dispositivoDeletionAdapter.delete(dispositivo);
  }
}
