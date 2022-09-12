import 'dart:async';

import 'package:hkid_validator_web_demo/ser/indexeddb/db_ser.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb/generateddb_ser.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb/sysdb_ser.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb/validateddb_ser.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

class IndexedDBSer {
  static final IndexedDBSer _ser = IndexedDBSer._internal();
  factory IndexedDBSer() => _ser;
  IndexedDBSer._internal();

  late DatabaseFactory _dbFactory;
  late SysDBSer _sysDBSer;
  late GeneratedDBSer _generatedDBSer;
  late ValidatedDBSer _validatedDBSer;
  late StoreRef<int, Map<String, Object?>> _dbStore;

  SysDBSer sysDBSer() => _sysDBSer;
  GeneratedDBSer generatedDBSer() => _generatedDBSer;
  ValidatedDBSer validatedDBSer() => _validatedDBSer;

  FutureOr<DBSer> _dbClient({
    required String name,
    required int dbVersion,
  }) async {
    Database db = await _dbFactory.openDatabase(name, version: dbVersion);
    return DBSer.client(name, dbVersion, db, _dbFactory, _dbStore);
  }

  Future<void> _initDBClient({
    required DBSerClient dbSerClient,
    required String name,
    required int version,
  }) async {
    final dbSer = await _dbClient(name: name, dbVersion: 1);
    dbSerClient.setSer(dbSer);
    dbSerClient.init();
  }

  Future<void> init() async {
    _dbFactory = databaseFactoryWeb;
    _dbStore = intMapStoreFactory.store("records");
    _sysDBSer = SysDBSer();
    _generatedDBSer = GeneratedDBSer();
    _validatedDBSer = ValidatedDBSer();
    await _initDBClient(dbSerClient: _sysDBSer, name: 'SysDB', version: 1);
    await _initDBClient(
        dbSerClient: _generatedDBSer, name: 'GeneratedDB', version: 1);
    await _initDBClient(
        dbSerClient: _validatedDBSer, name: 'validatedDB', version: 1);
  }

  Future<void> dispose() async {
    _sysDBSer.dispose();
    _generatedDBSer.dispose();
    _validatedDBSer.dispose();
  }
}
