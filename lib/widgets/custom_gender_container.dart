// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CustomContainerGender extends StatelessWidget {
  const CustomContainerGender({
    super.key,
    required this.image,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.selectedColor = Colors.lightBlue,
  });

  final String image;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 800),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: child,
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: isSelected ? 0.9 : 0.7,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  width: width * 0.35,
                  height: width * 0.35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? selectedColor.withOpacity(0.2)
                        : Colors.grey.shade300,
                    border: Border.all(
                      color: isSelected ? selectedColor : Colors.grey.shade400,
                      width: isSelected ? 0 : 2,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: selectedColor.withOpacity(0.5),
                              blurRadius: 20,
                              spreadRadius: 15,
                            )
                          ]
                        : [],
                  ),
                  child: ClipOval(
                    child: ColorFiltered(
                      colorFilter: isSelected
                          ? const ColorFilter.mode(
                              Colors.transparent,
                              BlendMode.dst,
                            )
                          : const ColorFilter.mode(
                              Colors.grey,
                              BlendMode.saturation,
                            ),
                      child: Image.asset(
                        image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Text(
                label,
                style: TextStyle(
                  fontSize: width * 0.05,
                  color: isSelected ? selectedColor : Colors.grey.shade600,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
