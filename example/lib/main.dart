import 'package:flutter/material.dart';
import 'package:hkid_validator_web_demo/app.dart';
import 'package:hkid_validator_web_demo/ser/app_ser.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSer().init();
  runApp(
    App(
      key: UniqueKey(),
      localeSer: AppSer().localeSer(),
    ),
  );
}
