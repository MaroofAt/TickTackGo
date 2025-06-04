import 'package:flutter/material.dart';

class MyDivider{

  static Widget horizontalDivider({double? thickness,required Color color}){
    return Divider(
      thickness: thickness,
      color: color,
    );
  }

  static Widget verticalDivider(double? thickness,Color color){
    return VerticalDivider(
      color: color,
      thickness: thickness,
    );
  }

}