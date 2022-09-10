import 'package:flutter/material.dart';
import 'package:hkid_validator_web_demo/ser/app_ser.dart';
import 'package:hkid_validator_web_demo/ser/env_ser.dart';

class EnvImgWidget extends StatelessWidget {
  final String src;
  final Color? color;
  final double? scale;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final BoxFit? boxFit;
  const EnvImgWidget({
    this.scale = 1.0,
    required this.src,
    this.color,
    this.width,
    this.height,
    this.boxFit = BoxFit.fill,
    this.padding = EdgeInsets.zero,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    EnvSer envSer = AppSer().envSer();
    String assetsSrc = envSer.assetsSrc(src: src);

    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: padding,
        child: envSer.isDev()
            ? Image(
                color: color,
                image: AssetImage(
                  assetsSrc,
                ),
                fit: boxFit,
              )
            : Image.network(
                assetsSrc,
                color: color,
                fit: boxFit,
                scale: scale!,
              ),
      ),
    );
  }
}
