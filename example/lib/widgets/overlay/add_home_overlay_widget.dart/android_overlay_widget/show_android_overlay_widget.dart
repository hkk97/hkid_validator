import 'package:flutter/material.dart';
import 'package:hkid_validator_web_demo/widgets/overlay/add_home_overlay_widget.dart/android_overlay_widget/android_overlay_widget.dart';

Future<void> showAndroidOverlayWidget({
  required BuildContext context,
}) async {
  late OverlayEntry? overlayEntry;
  late OverlayState overlayState;
  overlayEntry = OverlayEntry(
    builder: (context) => AndroidOverlayWidget(
      close: () {
        overlayEntry!.remove();
        overlayEntry = null;
      },
    ),
  );
  overlayState = Overlay.of(context, rootOverlay: false)!;
  overlayState.insert(overlayEntry!);
}
