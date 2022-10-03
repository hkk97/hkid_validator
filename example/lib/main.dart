import 'package:flutter/material.dart';
import 'package:hkid_validator_web_demo/app.dart';
import 'package:hkid_validator_web_demo/ser/app_ser.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:hkid_validator_web_demo/ser/env_ser.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());
  const String env = String.fromEnvironment(
    'ENV',
    defaultValue: EnvSer.prod,
  );
  await AppSer().init(env: env);
  runApp(
    App(
      key: UniqueKey(),
      localeSer: AppSer().localeSer(),
    ),
  );
}
