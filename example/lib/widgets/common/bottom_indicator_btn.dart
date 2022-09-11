import 'package:flutter/material.dart';
import 'package:hkid_validator_web_demo/const/const.dart';
import 'package:hkid_validator_web_demo/widgets/common/rounded_btn.dart';

class BottomIndicatorBtn extends StatelessWidget {
  final ValueNotifier<Section> sectionNotifi;
  final Function(Section section) onTapGoSection;

  const BottomIndicatorBtn({
    required this.sectionNotifi,
    required this.onTapGoSection,
    super.key,
  });

  @override
  Widget build(context) {
    return SizedBox(
      height: 50,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<Section>(
              valueListenable: sectionNotifi,
              builder: (context, section, child) {
                return RoundedBtn(
                  isSelected: section == Section.generate,
                  onTap: () => onTapGoSection(Section.generate),
                );
              },
            ),
            const SizedBox(
              width: 8.0,
            ),
            ValueListenableBuilder<Section>(
              valueListenable: sectionNotifi,
              builder: (context, section, child) {
                return RoundedBtn(
                  isSelected: section == Section.validate,
                  onTap: () => onTapGoSection(Section.validate),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
