import 'package:flutter/material.dart';
import 'package:hkid_validator_web_demo/models/record/generated_record.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb/db_ser.dart';
import 'package:sembast/sembast.dart';

class GeneratedDBSer extends DBSer {
  late ValueNotifier<List<GeneratedRecord?>?> _genIDNotifi;
  ValueNotifier<List<GeneratedRecord?>?> genIDNotifi() => _genIDNotifi;
  GeneratedDBSer({
    required super.name,
    required super.dbstore,
    required super.dbFactory,
  }) {
    _genIDNotifi = ValueNotifier(null);
  }

  Future<void> init() async {
    List<GeneratedRecord?>? res = await read();
    if (res != null) {
      _genIDNotifi.value = res;
    }
  }

  Future<void> dispose() async {
    _genIDNotifi.dispose();
  }

  Future<void> write({required String hkid}) async {
    final genratedRecord = GeneratedRecord(createdAt: DateTime.now(), id: hkid);
    final db = await dbFactory.openDatabase(name, version: 1);
    await dbstore.add(
      db,
      genratedRecord.toJson(),
    );
    db.close();
    _genIDNotifi.value!.add(genratedRecord);
  }

  Future<List<GeneratedRecord?>?> read() async {
    final db = await dbFactory.openDatabase(name, version: 1);
    List<int> keys = await dbstore.findKeys(db);
    List<RecordSnapshot<int, Map<String, Object?>>?> resSnapshot =
        await dbstore.records(keys).getSnapshots(db);
    return resSnapshot.isEmpty
        ? null
        : resSnapshot
            .map((recordSnapshot) =>
                GeneratedRecord.fromJson(recordSnapshot!.value))
            .toList();
  }
}
