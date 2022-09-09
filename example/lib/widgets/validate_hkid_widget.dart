import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hkid_validator/hkid_validator.dart';
import 'package:hkid_validator_web_demo/formatter/upper_case_text_formatter.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb_ser.dart';

class ValidateHKIDWidget extends StatefulWidget {
  const ValidateHKIDWidget({Key? key}) : super(key: key);

  @override
  State<ValidateHKIDWidget> createState() => _ValidateHKIDState();
}

class _ValidateHKIDState extends State<ValidateHKIDWidget> {
  late TextEditingController hkidController;
  late ValueNotifier<bool?> hkidValidateNotifi;

  @override
  void initState() {
    hkidController = TextEditingController();
    hkidValidateNotifi = ValueNotifier(null);
    super.initState();
  }

  @override
  void dispose() {
    hkidController.dispose();
    hkidValidateNotifi.dispose();
    super.dispose();
  }

  Future<void> updateHKID(String value) async {
    final isValid = HKIDValidator().isHKIDValid(
        value.substring(0, value.length - 1),
        value.substring(value.length - 1));
    hkidValidateNotifi.value = isValid;
    await IndexedDBSer().writeValidatedID(hkid: value, isValid: isValid);
  }

  @override
  Widget build(context) {
    return Container(
      color: const Color.fromRGBO(85, 184, 193, 1.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'hkidCard'.tr,
            style: const TextStyle(
              fontSize: 30.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            'numValidator'.tr,
            style: const TextStyle(
              fontSize: 30.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width < 550
                ? MediaQuery.of(context).size.width - 50
                : MediaQuery.of(context).size.width / 3 < 550
                    ? MediaQuery.of(context).size.width - 50
                    : MediaQuery.of(context).size.width / 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: hkidController,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  inputFormatters: <TextInputFormatter>[
                    UpperCaseTextFormatter()
                  ],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    letterSpacing: 3.0,
                  ),
                  cursorWidth: 4.5,
                  cursorRadius: const Radius.circular(3.5),
                  maxLines: 1,
                  onChanged: ((value) async {
                    if (value.isNotEmpty &&
                        (value.length == 8 || value.length == 9)) {
                      await updateHKID(value);
                    }
                  }),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: false,
                    filled: true,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 25.0),
                    hintText: 'e.g. A998877A',
                    hintStyle: TextStyle(
                      color: Colors.white54,
                      fontSize: 30.0,
                      letterSpacing: 3.0,
                    ),
                  ),
                ),
                ValueListenableBuilder<bool?>(
                  valueListenable: hkidValidateNotifi,
                  builder: (context, isValid, child) {
                    return ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      child: Divider(
                        indent: 0,
                        endIndent: 0,
                        color: isValid == null || isValid == true
                            ? Colors.white
                            : Colors.red,
                        height: 5,
                        thickness: 5,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 35.0,
            ),
            child: ValueListenableBuilder<bool?>(
              valueListenable: hkidValidateNotifi,
              builder: (context, isValid, child) {
                if (isValid == null) {
                  return const SizedBox();
                }
                return Center(
                  child: isValid
                      ? Text(
                          'correctMsg'.tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        )
                      : Text(
                          'inCorrectMsg'.tr,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
