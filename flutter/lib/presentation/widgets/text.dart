import 'package:flutter/material.dart';

class MyText {
  static Widget textFromLocalization(String text, BuildContext context,
      {Color? textColor,
      double? fontSize,
      FontWeight? fontWeight,
      TextOverflow overflow = TextOverflow.clip}) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w500,
        overflow: overflow,
        fontFamily: 'Coda',
      ),
    );
  }

  static Widget text1(String text,
      {Color? textColor,
      double? fontSize,
      FontWeight? fontWeight,
      TextAlign? textAlign,
      TextStyle? style,
      double? letterSpacing,
      TextOverflow overflow = TextOverflow.clip}) {
    return Text(
      text,
      textAlign: textAlign,
      style: style ??
          TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            overflow: overflow,
            fontFamily: 'Coda',
            letterSpacing: letterSpacing,
          ),
    );
  }
}
