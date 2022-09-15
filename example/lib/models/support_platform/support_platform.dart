import 'package:flutter/material.dart';

class InstallStep {
  final String desc;
  InstallStep({
    required this.desc,
  });
}

class SupportPlatform {
  final String name;
  final String imgName;
  final Color color;
  final List<InstallStep> installSteps;

  SupportPlatform._({
    required this.name,
    required this.imgName,
    required this.color,
    required this.installSteps,
  });

  String imgSrc() => "icons/${imgName}_512x512.png";
  String shortCutSrc() => "demo/$imgName/screen_shortcut.png";
  String installStepSrc({required int index}) =>
      "demo/$imgName/step_${index.toString()}.png";

  static final SupportPlatform _android = SupportPlatform._(
    name: 'Android',
    imgName: 'android',
    color: const Color.fromRGBO(175, 213, 38, 1.0),
    installSteps: [
      InstallStep(desc: 'aosAppInstall1Step1'),
      InstallStep(desc: 'aosAppInstall1Step2'),
      InstallStep(desc: 'aosAppInstall1Step3'),
    ],
  );

  static final SupportPlatform _ios = SupportPlatform._(
    name: 'iOS',
    imgName: 'ios',
    color: const Color.fromRGBO(68, 158, 248, 1.0),
    installSteps: [
      InstallStep(desc: 'iosAppInstallStep1'),
      InstallStep(desc: 'iosAppInstallStep2'),
      InstallStep(desc: 'iosAppInstallStep3'),
      InstallStep(desc: 'iosAppInstallStep4'),
    ],
  );

  static final SupportPlatform _chrome = SupportPlatform._(
    name: 'Chrome',
    imgName: 'chrome',
    color: const Color.fromRGBO(252, 103, 92, 1.0),
    installSteps: [
      InstallStep(desc: 'chromAppInstallStep1'),
      InstallStep(desc: 'chromAppInstallStep2'),
    ],
  );

  static final values = [_android, _ios, _chrome];
}
