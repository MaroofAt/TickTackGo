import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MyText {
  static AutoSizeText text1(String text,
      {Color? textColor,
      double? fontSize,
      FontWeight? fontWeight,
      TextAlign? textAlign,
      TextStyle? style,
      int? maxLines,
      double? letterSpacing,
      double? wordSpacing,
      bool? softWrap,
      TextOverflow overflow = TextOverflow.clip}) {
    return AutoSizeText(
      text,
      softWrap: softWrap,
      maxLines: maxLines,
      textAlign: textAlign,
      style: style ??
          TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            overflow: overflow,
            fontFamily: 'PTSerif',
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
          ),
    );
  }
}
