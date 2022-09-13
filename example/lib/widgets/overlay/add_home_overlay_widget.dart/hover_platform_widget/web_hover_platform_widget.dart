import 'package:flutter/material.dart';
import 'package:hkid_validator_web_demo/models/support_platform/support_platform.dart';
import 'package:hkid_validator_web_demo/ser/google_font_ser.dart';
import 'package:hkid_validator_web_demo/widgets/common/env_img_widget.dart';

class WebHoverPlatformWidget extends StatefulWidget {
  final SupportPlatform platform;
  final Function onTap;
  const WebHoverPlatformWidget({
    required this.platform,
    required this.onTap,
    super.key,
  });

  @override
  State<WebHoverPlatformWidget> createState() => _HoverPlatformState();
}

class _HoverPlatformState extends State<WebHoverPlatformWidget> {
  late ValueNotifier<bool> hasHoverNotifi;

  @override
  void initState() {
    hasHoverNotifi = ValueNotifier(false);
    super.initState();
  }

  @override
  void dispose() {
    hasHoverNotifi.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return LayoutBuilder(builder: (
      context,
      constraint,
    ) {
      return GestureDetector(
        onTap: () async => await widget.onTap(),
        child: MouseRegion(
          onEnter: (event) => hasHoverNotifi.value = true,
          onExit: (event) => hasHoverNotifi.value = false,
          child: ValueListenableBuilder<bool>(
            valueListenable: hasHoverNotifi,
            builder: (context, hasHover, child) {
              return Container(
                color: hasHover ? widget.platform.color : null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EnvImgWidget(
                      width: constraint.maxWidth * 0.425,
                      src: widget.platform.imgSrc(),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      widget.platform.name,
                      style: GoogleFontSer().arimo(
                        TextStyle(
                          fontSize: hasHover ? 37.5 : 35.0,
                          color: hasHover ? Colors.white : null,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
