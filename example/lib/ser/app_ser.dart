import 'package:hkid_validator_web_demo/ser/local_storage_ser.dart';
import 'package:hkid_validator_web_demo/ser/locale_ser.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb_ser.dart';

class AppSer {
  static final AppSer _ser = AppSer._internal();
  factory AppSer() => _ser;
  AppSer._internal();

  late LocaleSer _localeSer;
  late IndexedDBSer _indexedDBSer;
  LocaleSer localeSer() => _localeSer;
  IndexedDBSer indexedDBSer() => _indexedDBSer;

  Future<void> init() async {
    await LocalStorageSer().init();
    _localeSer = LocaleSer()..init();
    _indexedDBSer = IndexedDBSer();
    _indexedDBSer.init();
  }

  Future<void> dispose() async {}
}
