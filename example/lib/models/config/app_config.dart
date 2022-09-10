import 'package:hkid_validator_web_demo/models/config/base_config.dart';

class DevConfig extends AppConfig {
  @override
  String get host => 'localhost';
  @override
  bool get enableHttps => false;
}

class ProdConfig extends AppConfig {
  @override
  String get host => 'www.wchklaus.github.io/hkid_validator/';
  @override
  bool get enableHttps => true;
}
