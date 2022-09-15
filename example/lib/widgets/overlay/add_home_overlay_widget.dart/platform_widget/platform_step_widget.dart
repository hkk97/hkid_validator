import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkid_validator_web_demo/models/support_platform/support_platform.dart';
import 'package:hkid_validator_web_demo/ser/google_font_ser.dart';
import 'package:hkid_validator_web_demo/widgets/btn/rounded_elevated_btn_widget.dart';
import 'package:hkid_validator_web_demo/widgets/common/env_img_widget.dart';

class PlatformStepWidget extends StatefulWidget {
  final int index;
  final SupportPlatform platform;
  final Function onLeftTap;
  final String leftBtnName;
  final Function onRightTap;
  final String rightBtnName;

  const PlatformStepWidget({
    required this.index,
    required this.platform,
    required this.onLeftTap,
    required this.leftBtnName,
    required this.rightBtnName,
    required this.onRightTap,
    super.key,
  });
  @override
  State<PlatformStepWidget> createState() => _PlatformStepState();
}

class _PlatformStepState extends State<PlatformStepWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController animatedController;
  late ValueNotifier<bool> isMaximizedNotifi;

  @override
  void initState() {
    animatedController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();
    isMaximizedNotifi = ValueNotifier(false);
    super.initState();
  }

  @override
  void dispose() {
    isMaximizedNotifi.dispose();
    animatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final currIndex = widget.index + 1;
    return ValueListenableBuilder<bool>(
        valueListenable: isMaximizedNotifi,
        builder: (context, isMaximized, child) {
          return SizedBox(
            width: isMaximized ? MediaQuery.of(context).size.width : 550,
            height: isMaximized ? MediaQuery.of(context).size.height : 550,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 25,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  child: AnimatedBuilder(
                                    animation: animatedController,
                                    child: EnvImgWidget(
                                      src: widget.platform.imgSrc(),
                                    ),
                                    builder: (context, child) {
                                      return Transform.rotate(
                                        angle:
                                            animatedController.value * 2 * pi,
                                        child: child,
                                      );
                                    },
                                  ),
                                ),
                                Tooltip(
                                  message: 'maximized'.tr,
                                  child: IconButton(
                                    padding: const EdgeInsets.all(0.0),
                                    onPressed: () => isMaximizedNotifi.value =
                                        !isMaximizedNotifi.value,
                                    icon: Icon(
                                      isMaximizedNotifi.value
                                          ? Icons.close_fullscreen
                                          : Icons.fullscreen,
                                      size: 35,
                                      color: const Color.fromRGBO(
                                          175, 213, 38, 1.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            widget.platform.installSteps[widget.index].desc.tr,
                            textAlign: TextAlign.center,
                            style: GoogleFontSer().arimo(
                              const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                color: Colors.white70,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 25.0,
                                    right: 25.0,
                                    top: 15.0,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0)),
                                    child: EnvImgWidget(
                                      boxFit: BoxFit.fitWidth,
                                      src: widget
                                          .platform
                                          .installSteps[widget.index]
                                          .installStepSrc,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.5),
                            child: Text(
                              '$currIndex/${widget.platform.installSteps.length.toString()}',
                              style: GoogleFontSer().arimo(
                                const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
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
                            onTap: () => widget.onLeftTap(),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                widget.leftBtnName.tr,
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
                              onClick: () => widget.onRightTap(),
                              btnHeight: 55,
                              bgColr: const Color.fromRGBO(175, 213, 38, 1.0),
                              child: Text(
                                widget.rightBtnName.tr,
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
          );
        });
  }
}
