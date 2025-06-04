import 'package:flutter/material.dart';

class ButtonWidget{
  static IconButton iconButton({required onPress,required Icon icon,required BuildContext context,Color? color}){
    return IconButton(onPressed: onPress, icon: icon,color:color
      ,);
  }
}