// Rozet Modeli
import 'package:flutter/material.dart';

class Badgee {
  final String id;
  final String name;
  final String description;
  final IconData iconData;
  final bool isUnlocked;

  Badgee({
    required this.id,
    required this.name,
    required this.description,
    required this.iconData,
    this.isUnlocked = false,
  });

  Badgee copyWith({bool? isUnlocked}) {
    return Badgee(
      id: id,
      name: name,
      description: description,
      iconData: iconData,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }
}
