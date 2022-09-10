import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkid_validator/hkid_validator.dart';
import 'package:hkid_validator_web_demo/const/const.dart';
import 'package:hkid_validator_web_demo/ser/google_font_ser.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb_ser.dart';
import 'package:hkid_validator_web_demo/widgets/common/copied_text_widget.dart';
import 'package:hkid_validator_web_demo/widgets/common/custom_switch.dart';
import 'package:hkid_validator_web_demo/widgets/common/selected_radio_text_widget.dart';

class GeneratedHKIDWidget extends StatefulWidget {
  const GeneratedHKIDWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<GeneratedHKIDWidget> createState() => _GeneratedHKIDState();
}

class _GeneratedHKIDState extends State<GeneratedHKIDWidget>
    with AfterLayoutMixin {
  late ValueNotifier<CopyStatus> copyNotifi;
  late ValueNotifier<String?> validateHKIDNotifi;
  late ValueNotifier<bool> eightNumNotifi;
  late ValueNotifier<bool> hoverGenerateBtnNotifi;
  late ValueNotifier<bool> parenthesesNotifi;

  @override
  void initState() {
    copyNotifi = ValueNotifier(CopyStatus.idle);
    eightNumNotifi = ValueNotifier(true);
    hoverGenerateBtnNotifi = ValueNotifier(false);
    parenthesesNotifi = ValueNotifier(false);
    validateHKIDNotifi = ValueNotifier(null);
    super.initState();
  }

  @override
  void dispose() {
    copyNotifi.dispose();
    eightNumNotifi.dispose();
    hoverGenerateBtnNotifi.dispose();
    validateHKIDNotifi.dispose();
    parenthesesNotifi.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Container(
      color: const Color.fromRGBO(85, 193, 133, 1.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'hkidCard'.tr,
            style: GoogleFontSer().arimo(
              const TextStyle(
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            'numGenerator'.tr,
            style: GoogleFontSer().arimo(
              const TextStyle(
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ValueListenableBuilder<bool>(
                valueListenable: parenthesesNotifi,
                builder: (context, withPARES, child) {
                  return ValueListenableBuilder<String?>(
                    valueListenable: validateHKIDNotifi,
                    builder: (context, hkid, child) {
                      if (hkid == null) {
                        return const SizedBox();
                      }
                      return CopiedTextWidget(
                        text: withPARES ? hkid.withPARES() : hkid,
                        child: Text(
                          withPARES ? hkid.withPARES() : hkid,
                          maxLines: 1,
                          style: GoogleFontSer().arimo(
                            TextStyle(
                              fontSize: withPARES ? 40 : 44.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 10.0,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
          const SizedBox(
            height: 35,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ValueListenableBuilder<bool>(
              valueListenable: eightNumNotifi,
              builder: (context, isEightNum, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SelectedRadioTextWidget(
                      text: 'eightDigits'.tr,
                      isSelected: isEightNum,
                      onTap: () {
                        eightNumNotifi.value = true;
                        if (validateHKIDNotifi.value!.length == 9) {
                          updateHKID();
                        }
                      },
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    SelectedRadioTextWidget(
                      text: 'nineDigits'.tr,
                      isSelected: isEightNum ? false : true,
                      onTap: () {
                        eightNumNotifi.value = false;
                        if (validateHKIDNotifi.value!.length == 8) {
                          updateHKID();
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ValueListenableBuilder<bool>(
            valueListenable: parenthesesNotifi,
            builder: (context, withPARES, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'withPARES'.tr,
                    style: GoogleFontSer().arimo(
                      TextStyle(
                        color: withPARES ? Colors.white : Colors.black54,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  SizedBox(
                    height: 22.5,
                    child: CustomSwitch(
                      value: withPARES,
                      onChanged: (bool val) {
                        parenthesesNotifi.value = val;
                      },
                    ),
                  )
                ],
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          MouseRegion(
            onExit: (event) => hoverGenerateBtnNotifi.value = false,
            onEnter: (event) => hoverGenerateBtnNotifi.value = true,
            child: GestureDetector(
              onTap: () async => updateHKID(),
              child: ValueListenableBuilder<bool>(
                valueListenable: hoverGenerateBtnNotifi,
                builder: (context, isHover, child) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                        color: Colors.white,
                        width: 2.5,
                      ),
                    ),
                    color: isHover
                        ? Colors.white
                        : const Color.fromRGBO(85, 193, 133, 1.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.5, horizontal: 35.0),
                      child: Text(
                        'generate'.tr,
                        style: GoogleFontSer().arimo(
                          TextStyle(
                            color: isHover
                                ? const Color.fromRGBO(85, 193, 133, 1.0)
                                : Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> updateHKID() async {
    final hkid = HKIDValidator().genValidHKID(isEight: eightNumNotifi.value);
    validateHKIDNotifi.value = hkid;
    await IndexedDBSer().writeGeneratedID(hkid: hkid);
  }

  @override
  FutureOr<void> afterFirstLayout(context) async {
    updateHKID();
  }
}
