import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkid_validator_web_demo/const/const.dart';
import 'package:hkid_validator_web_demo/const/themes.dart';

class ThemeController extends GetxController {
  final RxObjectMixin<ThemeData> _theme = Themes.generatedTheme.obs;

  RxObjectMixin<ThemeData> theme() => _theme;

  void updateTheme({required Section section}) {
    _theme.value = section == Section.generate
        ? Themes.generatedTheme
        : Themes.validatedTheme;
    Get.changeTheme(_theme.value);
  }

  @override
  void onClose() {
    _theme.close();
    super.onClose();
  }

  @override
  Future onInit({Section? section}) async {
    ThemeData themeData = section == null
        ? Themes.generatedTheme
        : section == Section.validate
            ? Themes.validatedTheme
            : Themes.generatedTheme;
    _theme.value = themeData;
    Get.changeTheme(_theme.value);
    super.onInit();
  }
}
