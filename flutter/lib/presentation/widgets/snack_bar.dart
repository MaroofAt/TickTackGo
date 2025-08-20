import 'package:flutter/material.dart';
import 'package:pr1/presentation/widgets/text.dart';

class MySnackBar {
  static SnackBar mySnackBar(String content, {
    Color? backgroundColor,
  }) {
    return SnackBar(
      duration: const Duration(milliseconds: 800),
      backgroundColor: backgroundColor,
      content: MyText.text1(content),
    );
  }
}
