import 'package:flutter/material.dart';

class SelectedRadioTextWidget extends StatelessWidget {
  final bool isSelected;
  final String text;
  final Function onTap;
  const SelectedRadioTextWidget({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
        children: [
          Radio<bool>(
            activeColor: Colors.white,
            hoverColor: Colors.black12,
            value: true,
            groupValue: isSelected,
            onChanged: (value) {
              onTap();
            },
          ),
          const SizedBox(
            width: 2.5,
          ),
          Text(
            text,
            style: TextStyle(
              color: isSelected == true ? Colors.white : Colors.black54,
              fontSize: isSelected == true ? 18 : 16,
            ),
          ),
        ],
      ),
    );
  }
}
