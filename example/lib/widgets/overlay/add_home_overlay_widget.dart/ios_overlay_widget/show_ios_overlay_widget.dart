import 'package:flutter/material.dart';
import 'package:hkid_validator_web_demo/widgets/overlay/add_home_overlay_widget.dart/ios_overlay_widget/ios_overlay_widget.dart';

Future<void> showIOSOverlayWidget({
  required BuildContext context,
}) async {
  late OverlayEntry? overlayEntry;
  late OverlayState overlayState;
  overlayEntry = OverlayEntry(
    builder: (context) => IOSOverlayWidget(
      close: () {
        overlayEntry!.remove();
        overlayEntry = null;
      },
    ),
  );
  overlayState = Overlay.of(context, rootOverlay: true)!;
  overlayState.insert(overlayEntry!);
}
