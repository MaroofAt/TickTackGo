import 'package:flutter/material.dart';

class MyButtons {
  static Widget primaryButton(void Function()? onPressed, Color color, {Widget? child}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(color)),
      child: child,
    );
  }
}
