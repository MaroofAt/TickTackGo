import 'package:flutter/material.dart';

class MyFloatingActionButton {
  static FloatingActionButton floatingActionButton(
    BuildContext context, {
    required void Function() onPressed,
    Color? backGroundColor,
    Widget? child,
  }) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backGroundColor ?? Theme.of(context).dividerColor,
      child: Center(
        child: child,
      ),
    );
  }
}
