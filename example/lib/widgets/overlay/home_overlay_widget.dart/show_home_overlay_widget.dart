import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkid_validator_web_demo/ser/google_font_ser.dart';

Future<void> showHomeOverlayWidget({
  required BuildContext context,
}) async {
  late OverlayEntry? overlayEntry;
  late OverlayState overlayState;
  overlayEntry = OverlayEntry(
    builder: (context) => SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'addToMainPage'.tr,
            style: GoogleFontSer().arimo(
              TextStyle(
                color: Colors.grey.shade800,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.close,
                    size: 28.0,
                    color: Colors.grey.shade800,
                  ),
                ),
                onTap: () {
                  overlayEntry!.remove();
                  overlayEntry = null;
                },
              ),
            )
          ],
        ),
        body: Container(
          color: Colors.white,
        ),
      ),
    ),
  );
  overlayState = Overlay.of(context, rootOverlay: true)!;
  overlayState.insert(overlayEntry!);
}
