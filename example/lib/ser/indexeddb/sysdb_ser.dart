import 'package:flutter/cupertino.dart';
import 'package:hkid_validator_web_demo/const/const.dart';
import 'package:hkid_validator_web_demo/models/sys/sys.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb/db_ser.dart';
import 'package:sembast/sembast.dart';

class SysDBSer extends DBSerClient {
  late ValueNotifier<Sys?> _sysNotifi;

  SysDBSer({super.dbSer}) {
    _sysNotifi = ValueNotifier(null);
  }

  ValueNotifier<Sys?> sysNotifi() => _sysNotifi;

  @override
  Future<void> init() async {
    Sys? sys = await read();
    sys == null
        ? write(sec: Section.generate, localeName: 'en')
        : _sysNotifi.value = sys;
  }

  Future<void> dispose() async {
    await dbSer!.dispose();
    _sysNotifi.dispose();
  }

  Future<void> write({
    Section? sec,
    String? localeName,
  }) async {
    if (_sysNotifi.value == null && (sec != null || localeName != null)) {
      var data = await dbSer!.dbstore
          .add(dbSer!.db, Sys(sec: sec!, localeName: localeName!).toJson());
      RecordSnapshot<int, Map<String, Object?>>? recordSnapshot =
          await dbSer!.dbstore.record(data).getSnapshot(dbSer!.db);
      _sysNotifi.value = Sys.fromJson(recordSnapshot!.value);
    } else if (_sysNotifi.value != null) {
      Sys sys = _sysNotifi.value!.copyWith(sec: sec, localeName: localeName);
      if (!_sysNotifi.value!.isMatch(sys)) {
        RecordSnapshot<int, Map<String, Object?>>? recordSnapshot =
            await _readSnapshot();
        if (recordSnapshot != null) {
          int updatedCount = await dbSer!.dbstore.update(dbSer!.db,
              Sys.fromJson(recordSnapshot.value).mergeWith(sys).toJson());
          if (updatedCount != 0) {
            _sysNotifi.value = sys;
          }
        }
      }
    } else {}
  }

  Future<Sys?> read() async {
    RecordSnapshot<int, Map<String, Object?>>? res = await _readSnapshot();
    return res == null ? null : Sys.fromJson(res.value);
  }

  Future<RecordSnapshot<int, Map<String, Object?>>?> _readSnapshot() async {
    late var res;
    int? key = await dbSer!.dbstore.findKey(dbSer!.db);
    res = key == null
        ? null
        : await dbSer!.dbstore.record(key).getSnapshot(dbSer!.db);
    return res;
  }
}
