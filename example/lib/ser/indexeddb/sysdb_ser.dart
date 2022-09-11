import 'package:flutter/cupertino.dart';
import 'package:hkid_validator_web_demo/const/const.dart';
import 'package:hkid_validator_web_demo/models/sys/sys.dart';
import 'package:sembast/sembast.dart';

class SysDBSer {
  static const _sysDBName = 'SysDB';
  final DatabaseFactory factory;
  final StoreRef<int, Map<String, Object?>> store;
  late ValueNotifier<Sys?> _sysNotifi;
  SysDBSer({
    required this.factory,
    required this.store,
  }) {
    _sysNotifi = ValueNotifier(null);
  }

  ValueNotifier<Sys?> sysNotifi() => _sysNotifi;

  Future<void> init() async {
    Sys? sys = await readSys();
    sys == null
        ? writeSys(sec: Section.generate, localeName: 'en')
        : _sysNotifi.value = sys;
  }

  void dispose() {
    _sysNotifi.dispose();
  }

  Future<void> writeSys({
    Section? sec,
    String? localeName,
  }) async {
    final db = await factory.openDatabase(_sysDBName, version: 1);
    if (_sysNotifi.value == null && (sec != null || localeName != null)) {
      var data =
          await store.add(db, Sys(sec: sec!, localeName: localeName!).toJson());
      db.close();
      RecordSnapshot<int, Map<String, Object?>>? recordSnapshot =
          await store.record(data).getSnapshot(db);
      _sysNotifi.value = Sys.fromJson(recordSnapshot!.value);
    } else if (_sysNotifi.value != null) {
      Sys sys = _sysNotifi.value!.copyWith(sec: sec, localeName: localeName);
      if (!_sysNotifi.value!.isMatch(sys)) {
        int? key = await store.findKey(db);
        RecordSnapshot<int, Map<String, Object?>>? recordSnapshot =
            await readSnapshot(refDB: db);
        if (recordSnapshot != null) {
          int updatedCount = await store.update(db, {
            key.toString():
                Sys.fromJson(recordSnapshot.value).mergeWith(sys).toJson()
          });
          db.close();
          if (updatedCount != 0) {
            _sysNotifi.value = sys;
          }
        }
      }
    } else {}
  }

  Future<Sys?> readSys() async {
    final res = await readSnapshot();
    return Sys.fromJson(res!.value);
  }

  Future<RecordSnapshot<int, Map<String, Object?>>?> readSnapshot({
    Database? refDB,
  }) async {
    final db = refDB ?? await factory.openDatabase(_sysDBName, version: 1);
    int? key = await store.findKey(db);
    return await store.record(key!).getSnapshot(db);
  }
}
