import 'package:flutter/material.dart';
import 'package:hkid_validator_web_demo/models/record/generated_record.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb/db_ser.dart';
import 'package:sembast/sembast.dart';

class GeneratedDBSer extends DBSerClient {
  late ValueNotifier<List<GeneratedRecord?>?> _genIDNotifi;

  GeneratedDBSer({super.dbSer}) {
    _genIDNotifi = ValueNotifier([]);
  }

  ValueNotifier<List<GeneratedRecord?>?> genIDNotifi() => _genIDNotifi;

  @override
  Future<void> init() async {
    List<GeneratedRecord?>? res = await read();
    if (res != null) {
      _genIDNotifi.value = res;
    }
  }

  Future<void> dispose() async {
    await dbSer!.dispose();
    _genIDNotifi.dispose();
  }

  Future<void> write({required String hkid}) async {
    final genratedRecord = GeneratedRecord(createdAt: DateTime.now(), id: hkid);
    await dbSer!.dbstore.add(
      dbSer!.db,
      genratedRecord.toJson(),
    );
    _genIDNotifi.value!.add(genratedRecord);
  }

  Future<List<GeneratedRecord?>?> read() async {
    List<int> keys = await dbSer!.dbstore.findKeys(dbSer!.db);
    List<RecordSnapshot<int, Map<String, Object?>>?> resSnapshot =
        await dbSer!.dbstore.records(keys).getSnapshots(dbSer!.db);
    return resSnapshot.isEmpty
        ? null
        : resSnapshot
            .map((recordSnapshot) =>
                GeneratedRecord.fromJson(recordSnapshot!.value))
            .toList();
  }
}
