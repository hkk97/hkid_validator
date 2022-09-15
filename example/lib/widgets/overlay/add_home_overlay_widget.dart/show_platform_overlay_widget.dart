import 'package:flutter/material.dart';
import 'package:hkid_validator_web_demo/models/support_platform/support_platform.dart';
import 'package:hkid_validator_web_demo/widgets/overlay/add_home_overlay_widget.dart/platform_widget/platform_overlay_widget.dart';

Future<void> showPlatformWidget({
  required BuildContext context,
  required SupportPlatform platform,
}) async {
  late OverlayEntry? overlayEntry;
  late OverlayState overlayState;
  removeOverlay() {
    overlayEntry!.remove();
    overlayEntry = null;
  }

  Widget widget = PlatformOverlayWidget(
    platform: platform,
    close: () => removeOverlay(),
  );
  overlayEntry = OverlayEntry(
    builder: (context) => widget,
  );
  overlayState = Overlay.of(context, rootOverlay: false)!;
  overlayState.insert(overlayEntry!);
}
