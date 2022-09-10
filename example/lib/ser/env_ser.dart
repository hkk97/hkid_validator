import 'package:hkid_validator_web_demo/models/config/app_config.dart';
import 'package:hkid_validator_web_demo/models/config/base_config.dart';

class EnvSer {
  EnvSer._internal();
  static final EnvSer _utility = EnvSer._internal();
  factory EnvSer() => _utility;

  static const String dev = 'DEV';
  static const String prod = 'PROD';

  static late AppConfig _config;
  initConfig(String env) => _config = _getConfig(env);

  static AppConfig getConfig() => _config;
  AppConfig _getConfig(String env) {
    switch (env) {
      case prod:
        return ProdConfig();
      case dev:
      default:
        return DevConfig();
    }
  }

  bool isDev() => _config.isMatch(DevConfig());

  String assetsSrc({required String src}) =>
      _config.enableHttps == true ? "https://${_config.host}$src" : src;
}
