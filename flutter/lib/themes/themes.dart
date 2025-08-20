import 'package:flutter/material.dart';

import '../core/constance/colors.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: greatMagenda,
    secondaryHeaderColor: parrotGreen,
    hintColor: ash,
    dividerColor: ampleOrange,
    disabledColor: darkGrey,
    indicatorColor: sleekCyan,
    scaffoldBackgroundColor: primaryColor,
    dialogBackgroundColor: primaryColor,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: white,
          fontFamily: 'PTSerif'),
      headlineMedium: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: black,
          fontFamily: 'PTSerif'),
      headlineSmall: TextStyle(
          fontSize: 20,
          color: white,
          fontFamily: "PTSerif",
          fontWeight: FontWeight.normal),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: const Color(0xFFBBDEFB),
      iconColor: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      menuPadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.grey[800],
    ),
  );
}
