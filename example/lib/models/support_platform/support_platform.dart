import 'package:flutter/material.dart';

class InstallStep {
  final String desc;
  final String installStepSrc;
  InstallStep({
    required this.desc,
    required this.installStepSrc,
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

  static final SupportPlatform _android = SupportPlatform._(
    name: 'Android',
    imgName: 'android',
    color: const Color.fromRGBO(175, 213, 38, 1.0),
    installSteps: [
      InstallStep(
        desc: 'aosAppInstall1Step1',
        installStepSrc: "demo/android/step_1.png",
      ),
      InstallStep(
        desc: 'aosAppInstall1Step2',
        installStepSrc: "demo/android/step_2.png",
      ),
      InstallStep(
        desc: 'aosAppInstall1Step3',
        installStepSrc: "demo/android/step_3.png",
      ),
    ],
  );

  static final SupportPlatform _ios = SupportPlatform._(
    name: 'iOS',
    imgName: 'ios',
    color: const Color.fromRGBO(68, 158, 248, 1.0),
    installSteps: [
      InstallStep(
        desc: 'iosAppInstallStep1',
        installStepSrc: "demo/ios/step_1.png",
      ),
      InstallStep(
        desc: 'iosAppInstallStep2',
        installStepSrc: "demo/ios/step_2.png",
      ),
      InstallStep(
        desc: 'iosAppInstallStep3',
        installStepSrc: "demo/ios/step_3.png",
      ),
      InstallStep(
        desc: 'iosAppInstallStep4',
        installStepSrc: "demo/ios/step_4.png",
      ),
    ],
  );

  static final SupportPlatform _chrome = SupportPlatform._(
    name: 'Chrome',
    imgName: 'chrome',
    color: const Color.fromRGBO(252, 103, 92, 1.0),
    installSteps: [
      InstallStep(
        desc: 'chromAppInstallStep1',
        installStepSrc: "demo/chrome/step_1.png",
      ),
      InstallStep(
        desc: 'chromAppInstallStep2',
        installStepSrc: "demo/chrome/step_2.png",
      ),
    ],
  );

  static final values = [_android, _ios, _chrome];
}
