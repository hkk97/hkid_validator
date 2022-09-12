import 'package:flutter/cupertino.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb/generateddb_ser.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb/sysdb_ser.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb/validateddb_ser.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

class IndexedDBSer {
  static final IndexedDBSer _ser = IndexedDBSer._internal();
  factory IndexedDBSer() => _ser;
  IndexedDBSer._internal();

  late DatabaseFactory _factory;
  late SysDBSer _sysDBSer;
  late GeneratedDBSer _generatedDBSer;
  late ValidatedDBSer _validatedDBSer;

  SysDBSer sysDBSer() => _sysDBSer;
  GeneratedDBSer generatedDBSer() => _generatedDBSer;
  ValidatedDBSer validatedDBSer() => _validatedDBSer;

  late StoreRef<int, Map<String, Object?>> _dbStore;

  Future<void> init() async {
    _factory = databaseFactoryWeb;
    _dbStore = intMapStoreFactory.store("records");
    _sysDBSer = SysDBSer(name: 'SysDB', dbFactory: _factory, dbstore: _dbStore);
    await _sysDBSer.init();
    _generatedDBSer = GeneratedDBSer(
        name: 'GeneratedDB', dbFactory: _factory, dbstore: _dbStore);
    await _generatedDBSer.init();
    _validatedDBSer = ValidatedDBSer(
        name: 'ValidatedDB', dbFactory: _factory, dbstore: _dbStore);
    await _generatedDBSer.init();
  }

  Future<void> dispose() async {
    _sysDBSer.dispose();
    _generatedDBSer.dispose();
    _validatedDBSer.dispose();
  }
}
