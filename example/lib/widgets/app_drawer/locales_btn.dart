import 'package:flutter/material.dart';
import 'package:hkid_validator_web_demo/model/app_locale.dart';
import 'package:hkid_validator_web_demo/ser/app_ser.dart';

class LocalesBtn extends StatelessWidget {
  const LocalesBtn({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return SizedBox(
      height: 75,
      child: Center(
        child: SizedBox(
          height: 45,
          width: 350 * 0.6,
          child: Card(
            child: ValueListenableBuilder<AppLocale>(
              valueListenable: AppSer().localeSer().appLocaleNotifi(),
              builder: (context, locale, child) {
                return Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: AppLocale.locales.map(
                      (appLocale) {
                        bool isSelected = appLocale == locale;
                        return Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                isSelected ? Colors.black87 : Colors.white,
                              ),
                            ),
                            onPressed: () {
                              AppSer()
                                  .localeSer()
                                  .updateLocale(appLocale.localeName);
                            },
                            child: Text(
                              appLocale.name,
                              style: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.black87,
                                fontSize: isSelected ? 16 : 14,
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList());
              },
            ),
          ),
        ),
      ),
    );
  }
}
