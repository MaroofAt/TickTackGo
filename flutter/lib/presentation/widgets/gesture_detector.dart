import 'package:flutter/cupertino.dart';

class MyGestureDetector{
  static gestureDetector({void Function()? onTap, Widget? child}){
    return GestureDetector(
      onTap: onTap,
      child: child,
    );
  }
}