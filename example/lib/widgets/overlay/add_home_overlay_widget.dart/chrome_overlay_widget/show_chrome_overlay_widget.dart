import 'package:flutter/material.dart';
import 'package:hkid_validator_web_demo/widgets/overlay/add_home_overlay_widget.dart/chrome_overlay_widget/chrome_overlay_widget.dart';

Future<void> showChromeOverlayWidget({
  required BuildContext context,
}) async {
  late OverlayEntry? overlayEntry;
  late OverlayState overlayState;
  overlayEntry = OverlayEntry(
    builder: (context) => ChromeOverlayWidget(
      close: () {
        overlayEntry!.remove();
        overlayEntry = null;
      },
    ),
  );
  overlayState = Overlay.of(context, rootOverlay: true)!;
  overlayState.insert(overlayEntry!);
}
