import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkid_validator_web_demo/ser/google_font_ser.dart';
import 'package:hkid_validator_web_demo/widgets/btn/rounded_elevated_btn_widget.dart';
import 'package:hkid_validator_web_demo/widgets/common/env_img_widget.dart';

class ChromeOverlayWidget extends StatefulWidget {
  final Function close;
  const ChromeOverlayWidget({
    required this.close,
    super.key,
  });

  @override
  State<ChromeOverlayWidget> createState() => _ChromeOverlayState();
}

class _ChromeOverlayState extends State<ChromeOverlayWidget> {
  final List<Widget> steps = [];
  //Destiption Fc

  @override
  Widget build(context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.black54,
            ),
          ),
          Positioned(
            child: Center(
              child: SizedBox(
                height: 500,
                width: 500,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 35,
                      horizontal: 15,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const EnvImgWidget(
                                height: 90,
                                width: 90,
                                src: "icons/chrome_512x512.png",
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "understandHowAdd".tr,
                                      style: GoogleFontSer().arimo(
                                        const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    const TextSpan(text: "\t"),
                                    TextSpan(
                                      text: "hkidValidator".tr,
                                      style: GoogleFontSer().arimo(
                                        const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 18.5,
                                        ),
                                      ),
                                    ),
                                    const TextSpan(text: "\t"),
                                    TextSpan(
                                      text: "addToMainScreenEsailyUse".tr,
                                      style: GoogleFontSer().arimo(
                                        const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Card(
                                    color: Colors.white70,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                        left: 25.0,
                                        right: 25.0,
                                        top: 15.0,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        child: EnvImgWidget(
                                          boxFit: BoxFit.fitWidth,
                                          src:
                                              'demo/chrome/screen_shortcut.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 55,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () => widget.close(),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    'later'.tr,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(175, 213, 38, 1.0),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: RoundedElevatedBtnWidget(
                                  btnHeight: 55,
                                  bgColr:
                                      const Color.fromRGBO(175, 213, 38, 1.0),
                                  child: Text(
                                    'understand'.tr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
