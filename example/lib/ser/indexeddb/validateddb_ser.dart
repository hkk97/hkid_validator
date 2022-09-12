import 'package:flutter/material.dart';
import 'package:hkid_validator_web_demo/models/record/validated_record.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb/db_ser.dart';
import 'package:sembast/sembast.dart';

class ValidatedDBSer extends DBSer {
  late ValueNotifier<List<ValidatedRecord?>?> _validatedIDNotifi;
  ValueNotifier<List<ValidatedRecord?>?> validatedIDNotifi() =>
      _validatedIDNotifi;
  ValidatedDBSer({
    required super.name,
    required super.dbstore,
    required super.dbFactory,
  }) {
    _validatedIDNotifi = ValueNotifier(null);
  }

  Future<void> init() async {
    List<ValidatedRecord?>? res = await read();
    if (res != null) {
      _validatedIDNotifi.value = res;
    }
  }

  Future<void> dispose() async {
    _validatedIDNotifi.dispose();
  }

  Future<void> write({required String hkid, required bool isValid}) async {
    final validatedRecord = ValidatedRecord(
        validatedAt: DateTime.now(), id: hkid, isValid: isValid);
    final db = await dbFactory.openDatabase(name, version: 1);
    await dbstore.add(
      db,
      validatedRecord.toJson(),
    );
    db.close();
    _validatedIDNotifi.value!.add(validatedRecord);
  }

  Future<List<ValidatedRecord?>?> read() async {
    final db = await dbFactory.openDatabase(name, version: 1);
    List<int> keys = await dbstore.findKeys(db);
    List<RecordSnapshot<int, Map<String, Object?>>?> resSnapshot =
        await dbstore.records(keys).getSnapshots(db);
    return resSnapshot.isEmpty
        ? null
        : resSnapshot
            .map((recordSnapshot) =>
                ValidatedRecord.fromJson(recordSnapshot!.value))
            .toList();
  }
}
