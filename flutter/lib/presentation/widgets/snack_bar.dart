import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/presentation/widgets/text.dart';

class MySnackBar {
  static SnackBar mySnackBar(
    String content, {
    Color? backgroundColor,
    Color textColor = white,
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliseconds = 0,
  }) {
    return SnackBar(
      duration: Duration(
        days: days,
        hours: hours,
        minutes: minutes,
        seconds: seconds,
      ),
      backgroundColor: backgroundColor,
      content: MyText.text1(content, textColor: textColor),
    );
  }
}
