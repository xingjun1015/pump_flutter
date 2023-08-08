import 'package:flutter/material.dart';

class ExerciseIconSelector extends StatelessWidget {
  final bool isSelected;
  final String imageAsset;
  final void Function(String imageAsset) onTap;

  const ExerciseIconSelector({
    super.key,
    required this.isSelected,
    required this.imageAsset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: GestureDetector(
        onTap: () => onTap(imageAsset),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  width: 3,
                  color: isSelected ? Colors.lightBlueAccent : Colors.transparent)),
          child: Image.asset(imageAsset),
        ),
      ),
    );
  }
}
