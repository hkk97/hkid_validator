import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:hkid_validator_web_demo/const/locale/ch_ch.dart';
import 'package:hkid_validator_web_demo/const/locale/en_us.dart';
import 'package:hkid_validator_web_demo/const/locale/hk_ch.dart';
import 'package:hkid_validator_web_demo/model/app_locale.dart';
import 'package:hkid_validator_web_demo/ser/local_storage_ser.dart';

class LocaleSer extends Translations {
  // Default locale
  static Locale _locale = const Locale('en', 'US');
  ValueNotifier<AppLocale> _appLocaleNotifi = ValueNotifier(AppLocale.en());

  Locale locale() => _locale;
  ValueNotifier<AppLocale> appLocaleNotifi() => _appLocaleNotifi;

  // fallbackLocale saves the day when the locale gets in trouble
  final fallbackLocale = const Locale('en', 'US');

  // Supported languages
  // Needs to be same order with locales
  static final langs = [
    'English',
    'Chinese (Simplified)',
    'Chinese (Tradition)',
  ];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    const Locale('en', 'US'),
    const Locale('ch', 'CH'),
    const Locale('hk', 'CH'),
  ];

  Map<String, Locale> nameToLocale = {
    'en': const Locale('en', 'US'),
    'ch': const Locale('ch', 'CH'),
    'hk': const Locale('hk', 'CH'),
  };

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'ch_CH': chCH,
        'hk_CH': hkCH,
      };

  void init() {
    String? refLocale = LocalStorageSer().readSysConfig('locale');
    if (refLocale != null && nameToLocale.containsKey(refLocale)) {
      _locale = nameToLocale[refLocale]!;
      _appLocaleNotifi.value = AppLocale.appLocale(refLocale);
    }
  }

  void dispose() {
    _appLocaleNotifi.dispose();
  }

  void updateLocale(String name) {
    if (nameToLocale.containsKey(name)) {
      Locale newLocale = nameToLocale[name]!;
      LocalStorageSer().setSysConfig('locale', name);
      _locale = newLocale;
      _appLocaleNotifi.value = AppLocale.appLocale(name);
      Get.updateLocale(newLocale);
    }
  }
}
