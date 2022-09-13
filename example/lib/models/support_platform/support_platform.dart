import 'package:flutter/material.dart';

class SupportPlatform {
  final String name;
  final String imgName;
  final Color color;

  SupportPlatform._({
    required this.name,
    required this.imgName,
    required this.color,
  });

  String imgSrc() => "icons/${imgName}_512x512.png";

  static final SupportPlatform _android = SupportPlatform._(
    name: 'Android',
    imgName: 'android',
    color: const Color.fromRGBO(175, 213, 38, 1.0),
  );

  static final SupportPlatform _ios = SupportPlatform._(
    name: 'iOS',
    imgName: 'ios',
    color: const Color.fromRGBO(68, 158, 248, 1.0),
  );

  static final SupportPlatform _chrome = SupportPlatform._(
    name: 'Chrome',
    imgName: 'chrome',
    color: const Color.fromRGBO(252, 103, 92, 1.0),
  );

  static final values = [_android, _ios, _chrome];
}
