import 'package:flutter/material.dart';

class RoundedBtn extends StatelessWidget {
  final bool isSelected;
  final Function onTap;
  const RoundedBtn({
    Key? key,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 20,
        height: 25,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : null,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: isSelected ? 3 : 2, color: Colors.white),
        ),
      ),
    );
  }
}
