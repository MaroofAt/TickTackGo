import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pr1/presentation/widgets/images.dart';

class MyCircle {
  static Container circleWithAssetImage(
    double radius, {
    double? height,
    double? width,
    Color? color,
    required String assetImage,
  }) {
    return Container(
      height: height ?? radius,
      width: width ?? radius,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        image: MyImages.decorationImage(isAssetImage: true, image: assetImage),
      ),
    );
  }

  static Container circleWithNetworkImage(
    double radius, {
    double? height,
    double? width,
    Color? color,
    required String networkImage,
  }) {
    return Container(
      height: height ?? radius,
      width: width ?? radius,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        image:
            MyImages.decorationImage(isAssetImage: false, image: networkImage),
      ),
    );
  }

  static Container circleWithFileImage(
    double radius, {
    double? height,
    double? width,
    Color? color,
    required File file,
  }) {
    return Container(
      height: height ?? radius,
      width: width ?? radius,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        image: MyImages.decorationFileImage(image: file),
      ),
    );
  }

  static Container circle(
    double radius, {
    double? height,
    double? width,
    Color? color,
    Widget? child,
  }) {
    return Container(
      height: height ?? radius,
      width: width ?? radius,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
