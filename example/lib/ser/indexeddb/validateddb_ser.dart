import 'package:flutter/material.dart';
import 'package:hkid_validator_web_demo/models/record/validated_record.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb/db_ser.dart';
import 'package:logger/logger.dart';
import 'package:sembast/sembast.dart';

class ValidatedDBSer extends DBSerClient {
  late ValueNotifier<List<ValidatedRecord?>?> _validatedIDNotifi;

  ValidatedDBSer({super.dbSer}) {
    _validatedIDNotifi = ValueNotifier([]);
  }

  ValueNotifier<List<ValidatedRecord?>?> validatedIDNotifi() =>
      _validatedIDNotifi;

  @override
  Future<void> init() async {
    List<ValidatedRecord?>? res = await read();
    if (res != null) {
      _validatedIDNotifi.value = res;
    }
  }

  Future<void> dispose() async {
    await dbSer!.dispose();
    _validatedIDNotifi.dispose();
  }

  Future<void> write({required String hkid, required bool isValid}) async {
    final validatedRecord = ValidatedRecord(
        validatedAt: DateTime.now(), id: hkid, isValid: isValid);
    await dbSer!.dbstore.add(
      dbSer!.db,
      validatedRecord.toJson(),
    );
    _validatedIDNotifi.value!.add(validatedRecord);
  }

  Future<List<ValidatedRecord?>?> read() async {
    List<int> keys = await dbSer!.dbstore.findKeys(dbSer!.db);
    List<RecordSnapshot<int, Map<String, Object?>>?> resSnapshot =
        await dbSer!.dbstore.records(keys).getSnapshots(dbSer!.db);
    return resSnapshot.isEmpty
        ? null
        : resSnapshot
            .map((recordSnapshot) =>
                ValidatedRecord.fromJson(recordSnapshot!.value))
            .toList();
  }
}
