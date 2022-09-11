import 'package:flutter/cupertino.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb/sys_ser.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

class IndexedDBSer {
  static final IndexedDBSer _ser = IndexedDBSer._internal();
  factory IndexedDBSer() => _ser;
  IndexedDBSer._internal();

  static const _generatedDBName = 'GeneratedID';
  static const _validatedDBName = 'ValidatedID';
  static const _sysDBName = 'SysDB';

  late DatabaseFactory _factory;
  late SysDBSer _sysDBSer;

  SysDBSer sysDBSer() => _sysDBSer;
  late StoreRef<int, Map<String, Object?>> _store;

  final ValueNotifier<List<RecordSnapshot?>?> _genRCDNotifi =
      ValueNotifier(null);
  final ValueNotifier<List<RecordSnapshot?>?> _validatedRCDNotifi =
      ValueNotifier(null);

  ValueNotifier<List<RecordSnapshot?>?> genRCDNotifi() => _genRCDNotifi;
  ValueNotifier<List<RecordSnapshot?>?> validatedRCDNotifi() =>
      _validatedRCDNotifi;

  Future<RecordSnapshot<int, Map<String, Object?>>?> readSys({
    Database? refDB,
  }) async {
    final db = refDB ?? await _factory.openDatabase(_sysDBName, version: 1);
    int? key = await _store.findKey(db);
    return await _store.record(key!).getSnapshot(db);
  }

  Future<void> writeGeneratedID({required String hkid}) async {
    final db = await _factory.openDatabase(_generatedDBName, version: 1);
    var data = await _store.add(
      db,
      {
        'createdAt': DateTime.now().toIso8601String(),
        'id': hkid,
      },
    );
    db.close();
    _genRCDNotifi.value!.add(await _store.record(data).getSnapshot(db));
  }

  Future<void> writeValidatedID(
      {required String hkid, required bool isValid}) async {
    final db = await _factory.openDatabase(_validatedDBName, version: 1);
    var data = await _store.add(
      db,
      {
        'validatedAt': DateTime.now().toIso8601String(),
        'id': hkid,
        'isValid': isValid,
      },
    );
    db.close();
    _validatedRCDNotifi.value!.add(await _store.record(data).getSnapshot(db));
  }

  Future<List<RecordSnapshot?>?> readGeneratedID() async {
    final db = await _factory.openDatabase(_generatedDBName, version: 1);
    List<int> keys = await _store.findKeys(db);
    return await _store.records(keys).getSnapshots(db);
  }

  Future<List<RecordSnapshot?>?> readValidatedID() async {
    final db = await _factory.openDatabase(_validatedDBName, version: 1);
    List<int> keys = await _store.findKeys(db);
    return await _store.records(keys).getSnapshots(db);
  }

  Future<void> init() async {
    _factory = databaseFactoryWeb;
    _store = intMapStoreFactory.store("records");
    _sysDBSer = SysDBSer(factory: _factory, store: _store);
    _sysDBSer.init();
    // RecordSnapshot<int, Map<String, Object?>>? recordSnapshot = await readSys();
    // if (recordSnapshot == null) {
    //   final sys = Sys(sec: Section.generate, localeName: 'generate')
    //   _sysNotifi.value = sys;
    //   await writeSys(sys: sys);
    // } else {
    //   _sysNotifi.value = Sys.fromJson(recordSnapshot.value);
    // }
    _genRCDNotifi.value = await readGeneratedID();
    _validatedRCDNotifi.value = await readValidatedID();
  }

  Future<void> dispose() async {
    _genRCDNotifi.dispose();
    _sysDBSer.dispose();
    _validatedRCDNotifi.dispose();
  }

  Future<Database> _openDB(String name, version) async =>
      await _factory.openDatabase(
        name,
        version: version,
      );
}
