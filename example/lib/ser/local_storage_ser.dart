import 'package:get_storage/get_storage.dart';

class LocalStorageSer {
  static final _secureStorage = LocalStorageSer._internal();
  factory LocalStorageSer() => _secureStorage;
  static late GetStorage _sensitiveStorage;
  static late GetStorage _sysConfigStorage;
  static late GetStorage _containerStorage;
  LocalStorageSer._internal();

  Future<void> init() async {
    await GetStorage.init("secureStorage");
    await GetStorage.init("sysConfig");
    await GetStorage.init('container');
    _sensitiveStorage = GetStorage('secureStorage');
    _sysConfigStorage = GetStorage('sysConfig');
    _containerStorage = GetStorage("container");
  }

  void clearUserInfo() {
    _sensitiveStorage.erase();
    _sysConfigStorage.erase();
    _containerStorage.erase();
  }

  T? readSecureStorage<T>(String key) => _sensitiveStorage.read(key);
  T? readSysConfig<T>(String key) => _sysConfigStorage.read(key);
  T? readContainerStorage<T>(String key) => _containerStorage.read(key);

  void rmSecureStorage(String key) => _sensitiveStorage.remove(key);
  void rmSysConfig(String key) => _sysConfigStorage.remove(key);
  void rmContainerStorage(String key) => _containerStorage.remove(key);

  void setSecureStorage(String key, dynamic value) =>
      _sensitiveStorage.write(key, value);
  void setSysConfig(String key, dynamic value) =>
      _sysConfigStorage.write(key, value);
  void setContainerStorage(String key, dynamic value) =>
      _containerStorage.write(key, value);
}
