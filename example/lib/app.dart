import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hkid_validator_web_demo/controller/theme_controller.dart';
import 'package:hkid_validator_web_demo/page/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hkid_validator_web_demo/ser/locale_ser.dart';

class App extends StatelessWidget {
  final LocaleSer localeSer;

  const App({
    Key? key,
    required this.localeSer,
  }) : super(key: key);
  final String appTitle = 'HKID Validator';

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appTitle,
      theme: ThemeController().theme().value,
      debugShowCheckedModeBanner: false,
      locale: localeSer.locale(),
      fallbackLocale: localeSer.fallbackLocale,
      translations: localeSer,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomePage(),
    );
  }
}
