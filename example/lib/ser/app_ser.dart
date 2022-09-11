import 'package:hkid_validator_web_demo/controller/theme_controller.dart';
import 'package:hkid_validator_web_demo/models/sys/sys.dart';
import 'package:hkid_validator_web_demo/ser/env_ser.dart';
import 'package:hkid_validator_web_demo/ser/local_storage_ser.dart';
import 'package:hkid_validator_web_demo/ser/locale_ser.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb/indexeddb_ser.dart';

class AppSer {
  static final AppSer _ser = AppSer._internal();
  factory AppSer() => _ser;
  AppSer._internal();

  late LocaleSer _localeSer;
  late IndexedDBSer _indexedDBSer;
  late EnvSer _envSer;
  late ThemeController _themeContrl;
  LocaleSer localeSer() => _localeSer;
  IndexedDBSer indexedDBSer() => _indexedDBSer;
  EnvSer envSer() => _envSer;
  ThemeController themeContrl() => _themeContrl;

  Future<void> init({required String env}) async {
    _indexedDBSer = IndexedDBSer();
    await _indexedDBSer.init();
    Sys? sys = await _indexedDBSer.sysDBSer().readSys();
    _themeContrl = ThemeController();
    await _themeContrl.onInit(section: sys!.sec);
    _localeSer = LocaleSer();
    _localeSer.init(refLocaleName: sys.localeName);
    _envSer = EnvSer()..initConfig(env);
  }

  Future<void> dispose() async {
    _themeContrl.onClose();
    _localeSer.dispose();
    _indexedDBSer.dispose();
  }
}
