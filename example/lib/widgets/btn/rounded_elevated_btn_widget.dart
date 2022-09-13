import 'package:flutter/material.dart';

class RoundedElevatedBtnWidget extends StatelessWidget {
  final Widget child;
  final Function? onClick;
  final Size? minimumSize;
  final double borderRadius;
  final Color? bgColr;
  final Color? borderColor;
  final double? borderWidth;
  final double btnHeight;
  const RoundedElevatedBtnWidget({
    Key? key,
    required this.child,
    this.onClick,
    this.borderColor,
    this.bgColr,
    this.minimumSize,
    this.borderWidth,
    this.btnHeight = 45,
    this.borderRadius = 18.0,
  }) : super(key: key);

  @override
  Widget build(context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: bgColr ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 1.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
        ),
        minimumSize: Size(
          double.infinity,
          btnHeight,
        ),
      ),
      child: child,
      onPressed: () async {
        if (onClick != null) {
          await onClick!();
        }
      },
    );
  }
}
