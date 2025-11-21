// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class StepItemGender extends StatelessWidget {
  final bool isActive;
  final IconData icon;
  final Color selectedColor;
  final String text;

  const StepItemGender({
    super.key,
    required this.isActive,
    required this.icon,
    required this.text,
    this.selectedColor = Colors.lightBlue,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: Container(
            key: ValueKey(icon),
            padding: EdgeInsets.all(width * 0.02),
            decoration: BoxDecoration(
              color: isActive ? selectedColor : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(width * 0.04),
              border: isActive
                  ? Border.all(color: selectedColor.withOpacity(0.8), width: 2)
                  : null,
            ),
            child: Icon(
              icon,
              size: width * 0.07,
              color: isActive ? Colors.white : Colors.grey.shade600,
            ),
          ),
        ),
        SizedBox(height: width * 0.015),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            text,
            key: ValueKey(text),
            style: TextStyle(
              fontSize: width * 0.032,
              color: isActive ? selectedColor : Colors.grey.shade600,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
