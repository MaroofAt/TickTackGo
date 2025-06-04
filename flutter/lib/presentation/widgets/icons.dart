import 'package:flutter/material.dart';

class MyIcons {
  static Widget icon(IconData icon, {double? size, Color? color}) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}
