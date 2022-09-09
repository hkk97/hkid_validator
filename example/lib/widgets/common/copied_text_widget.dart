import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hkid_validator_web_demo/ser/google_font_ser.dart';

class CopiedTextWidget extends StatefulWidget {
  final String text;
  final Widget child;
  final TextStyle style;

  const CopiedTextWidget({
    Key? key,
    required this.text,
    this.style = const TextStyle(
      fontSize: 44.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: 10.0,
    ),
    required this.child,
  }) : super(key: key);

  @override
  State<CopiedTextWidget> createState() => _CopiedTextState();
}

class _CopiedTextState extends State<CopiedTextWidget> {
  late ValueNotifier<bool> isCopyingNotifi;

  @override
  void initState() {
    isCopyingNotifi = ValueNotifier(false);
    super.initState();
  }

  @override
  void dispose() {
    isCopyingNotifi.dispose();
    super.dispose();
  }

  Future<void> setData(String data) async {
    await Clipboard.setData(
      ClipboardData(
        text: data,
      ),
    ).whenComplete(() async {
      isCopyingNotifi.value = true;
      await Future.delayed(const Duration(seconds: 1), () {
        isCopyingNotifi.value = false;
      });
    });
  }

  @override
  Widget build(context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isCopyingNotifi,
      builder: (context, isCopying, child) {
        return IgnorePointer(
          ignoring: isCopying ? true : false,
          child: GestureDetector(
            onDoubleTap: () async {
              await setData(
                widget.text,
              );
            },
            child: isCopying
                ? Center(
                    child: Text(
                      'Copied'.tr,
                      style: GoogleFontSer().arimo(widget.style),
                    ),
                  )
                : Center(
                    child: widget.child,
                  ),
          ),
        );
      },
    );
  }
}
