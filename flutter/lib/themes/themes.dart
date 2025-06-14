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
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: white,
            fontFamily: 'PTSerif'),
        headlineMedium: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: black,
            fontFamily: 'PTSerif'),headlineSmall: TextStyle(
        fontSize: 20,
        color: white,
        fontFamily: "PTSerif",
        fontWeight: FontWeight.normal
      )


      ),
    );
}
