import 'package:flutter/material.dart';
import 'package:hkid_validator_web_demo/models/support_platform/support_platform.dart';
import 'package:hkid_validator_web_demo/widgets/overlay/add_home_overlay_widget.dart/platform_widget/platform_display_widget.dart';
import 'package:hkid_validator_web_demo/widgets/overlay/add_home_overlay_widget.dart/platform_widget/platform_step_widget.dart';

class PlatformOverlayWidget extends StatefulWidget {
  final SupportPlatform platform;
  final Function close;

  const PlatformOverlayWidget({
    required this.platform,
    required this.close,
    super.key,
  });

  @override
  State<PlatformOverlayWidget> createState() => _PlatformOverlayWidget();
}

class _PlatformOverlayWidget extends State<PlatformOverlayWidget> {
  late ValueNotifier<int> statusNotifi;
  late List<Widget> stepsWidget;

  @override
  void initState() {
    statusNotifi = ValueNotifier(0);
    stepsWidget = [
      PlatformDisplayWidget(
        platform: widget.platform,
        close: () => widget.close(),
        next: () => statusNotifi.value += 1,
      ),
    ];
    stepsWidget.addAll(
      widget.platform.installSteps
          .map(
            (step) => PlatformStepWidget(
              index: widget.platform.installSteps.indexOf(step),
              platform: widget.platform,
              onLeftTap: () => statusNotifi.value -= 1,
              onRightTap: () => widget.platform.installSteps.indexOf(step) ==
                      widget.platform.installSteps.length - 1
                  ? widget.close()
                  : statusNotifi.value += 1,
              leftBtnName: 'back',
              rightBtnName: widget.platform.installSteps.indexOf(step) ==
                      widget.platform.installSteps.length - 1
                  ? 'close'
                  : 'next',
            ),
          )
          .toList(),
    );
    super.initState();
  }

  @override
  void dispose() {
    statusNotifi.dispose();
    super.dispose();
  }

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
              child: ValueListenableBuilder<int>(
                valueListenable: statusNotifi,
                builder: (context, index, child) => stepsWidget[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
