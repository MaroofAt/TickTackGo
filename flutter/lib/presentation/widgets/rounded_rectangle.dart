import 'package:flutter/material.dart';

class RoundedRectangle {
  static Container roundedRectangle(double width, double height,
      {Color? color, Widget? child, String? imagePath}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
        image: imagePath != null && imagePath.isNotEmpty
            ? DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        )
            : null,
      ),
      child: child,
    );
  }
}
