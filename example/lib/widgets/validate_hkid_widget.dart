import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hkid_validator/hkid_validator.dart';
import 'package:hkid_validator_web_demo/const/const.dart';
import 'package:hkid_validator_web_demo/formatter/upper_case_text_formatter.dart';
import 'package:hkid_validator_web_demo/ser/google_font_ser.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb/indexeddb_ser.dart';

class ValidateHKIDWidget extends StatefulWidget {
  final Widget bottomIndicatorBtn;
  final ValueNotifier<AnimatedStatus> animatedStatus;
  final ValueNotifier<double> lastOffsetNotifi;
  final Function reverse;
  const ValidateHKIDWidget({
    required this.animatedStatus,
    required this.lastOffsetNotifi,
    required this.bottomIndicatorBtn,
    required this.reverse,
    Key? key,
  }) : super(key: key);

  @override
  State<ValidateHKIDWidget> createState() => _ValidateHKIDState();
}

class _ValidateHKIDState extends State<ValidateHKIDWidget> {
  late TextEditingController hkidController;
  late ValueNotifier<bool?> hkidValidateNotifi;
  final ScrollController _scrolContrl =
      ScrollController(initialScrollOffset: 0.0);

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
    _scrolContrl.dispose();
    super.dispose();
  }

  Future<void> updateHKID(String value) async {
    final isValid = HKIDValidator().isHKIDValid(
        value.substring(0, value.length - 1),
        value.substring(value.length - 1));
    hkidValidateNotifi.value = isValid;
    await IndexedDBSer().validatedDBSer().write(hkid: value, isValid: isValid);
  }

  @override
  Widget build(context) {
    return Container(
      color: const Color.fromRGBO(85, 184, 193, 1.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notify) {
          if (widget.animatedStatus.value == AnimatedStatus.idle) {
            if (widget.lastOffsetNotifi.value != _scrolContrl.offset) {
              if (widget.lastOffsetNotifi.value > _scrolContrl.offset) {
                widget.reverse();
              }
              widget.animatedStatus.value = AnimatedStatus.animating;
            }
          }
          return true;
        },
        child: ListView(
          controller: _scrolContrl,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
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
                          'numValidator'.tr,
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
                                style: GoogleFontSer().arimo(
                                  const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    letterSpacing: 3.0,
                                  ),
                                ),
                                cursorWidth: 4.5,
                                cursorRadius: const Radius.circular(3.5),
                                maxLines: 1,
                                onChanged: ((value) async {
                                  if (value.isNotEmpty &&
                                      (value.length == 8 ||
                                          value.length == 9)) {
                                    await updateHKID(value);
                                  }
                                }),
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isDense: false,
                                  filled: true,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 25.0),
                                  hintText: 'e.g. A998877A',
                                  hintStyle: GoogleFontSer().arimo(
                                    const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 30.0,
                                      letterSpacing: 3.0,
                                    ),
                                  ),
                                ),
                              ),
                              ValueListenableBuilder<bool?>(
                                valueListenable: hkidValidateNotifi,
                                builder: (context, isValid, child) {
                                  return ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0)),
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
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                        ),
                                      )
                                    : Text(
                                        'inCorrectMsg'.tr,
                                        textAlign: TextAlign.center,
                                        style: GoogleFontSer().arimo(
                                          const TextStyle(
                                            color: Colors.red,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 30.0,
                    ),
                    child: widget.bottomIndicatorBtn,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
