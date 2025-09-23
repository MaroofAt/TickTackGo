import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/presentation/widgets/snack_bar.dart';

void showSnackBar(
  BuildContext context,
  String content, {
  Color? backgroundColor,
  Color textColor = white,
  int days = 0,
  int hours = 0,
  int minutes = 0,
  int seconds = 0,
  int milliseconds = 0,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    MySnackBar.mySnackBar(
      content,
      backgroundColor: backgroundColor,
      textColor: textColor,
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
    ),
  );
}
