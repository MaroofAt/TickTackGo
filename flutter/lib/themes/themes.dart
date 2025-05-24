import 'package:flutter/material.dart';

import '../core/constance/colors.dart';

ThemeData theme() {
    return ThemeData(
      primaryColor: creat_magenda,
      secondaryHeaderColor: parrot_green,
      hintColor: ash,
      dividerColor: Ample_orang,
      disabledColor: darkGrey,
      indicatorColor: sleek_cyan,
      scaffoldBackgroundColor: primaryColor,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
            color: primaryColor,
            fontFamily: 'Coda'),
        headlineMedium: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: black,
            fontFamily: 'Coda'),
        headlineSmall: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: darkGrey,
            fontFamily: 'Coda'),
      ),
    );
}
