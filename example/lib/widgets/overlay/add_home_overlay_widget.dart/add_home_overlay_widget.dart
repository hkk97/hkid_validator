import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkid_validator_web_demo/const/const.dart';
import 'package:hkid_validator_web_demo/models/support_platform/support_platform.dart';
import 'package:hkid_validator_web_demo/ser/google_font_ser.dart';
import 'package:hkid_validator_web_demo/widgets/overlay/add_home_overlay_widget.dart/hover_platform_widget/mobile_hover_platform_widget.dart';
import 'package:hkid_validator_web_demo/widgets/overlay/add_home_overlay_widget.dart/hover_platform_widget/web_hover_platform_widget.dart';
import 'package:hkid_validator_web_demo/widgets/overlay/add_home_overlay_widget.dart/show_platform_overlay_widget.dart';

class AddHomeOverlayWidget extends StatefulWidget {
  final Function close;
  const AddHomeOverlayWidget({
    required this.close,
    super.key,
  });

  @override
  State<AddHomeOverlayWidget> createState() => _AddHomeOverlayState();
}

class _AddHomeOverlayState extends State<AddHomeOverlayWidget> {
  late ValueNotifier<HomeScreenPlatform?> selectedPlatform;

  @override
  void initState() {
    selectedPlatform = ValueNotifier(null);
    super.initState();
  }

  @override
  void dispose() {
    selectedPlatform.dispose();
    super.dispose();
  }

  Future<void> showPlatformOverlay({required SupportPlatform platform}) async =>
      await showPlatformWidget(context: context, platform: platform);

  @override
  Widget build(context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2.25,
          centerTitle: true,
          title: Text(
            "addToMainPage".tr,
            style: GoogleFontSer().arimo(
              TextStyle(
                color: Colors.grey.shade800,
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
                onTap: () => widget.close(),
              ),
            )
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraint) {
            final isMobileMode = constraint.maxWidth < 650;
            if (isMobileMode) {
              return ListView(
                children: SupportPlatform.values
                    .map(
                      (platform) => SizedBox(
                        height: constraint.maxHeight / 2.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: MobileHoverPlatformWidget(
                                platform: platform,
                                onTap: () async => await showPlatformOverlay(
                                  platform: platform,
                                ),
                              ),
                            ),
                            SupportPlatform.values.indexOf(platform) !=
                                    SupportPlatform.values.length
                                ? const Divider(
                                    height: 2,
                                    thickness: 1.25,
                                    color: Colors.grey,
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              );
            }
            return Row(
              children: SupportPlatform.values
                  .map(
                    (platform) => Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: WebHoverPlatformWidget(
                              platform: platform,
                              onTap: () async => await showPlatformOverlay(
                                platform: platform,
                              ),
                            ),
                          ),
                          SupportPlatform.values.indexOf(platform) !=
                                  SupportPlatform.values.length
                              ? const VerticalDivider(
                                  width: 2,
                                  thickness: 1.25,
                                  color: Colors.grey,
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
