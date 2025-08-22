import 'dart:io';

import 'package:flutter/material.dart';

class MyImages {
  static Widget assetImage(String image,
      {double? height, double? width, BoxFit fit = BoxFit.cover}) {
    return Image.asset(
      height: height,
      width: width,
      image,
      fit: fit,
    );
  }

  static Widget fileImage(File file,
      {double? height, double? width, BoxFit fit = BoxFit.cover}) {
    return Image.file(
      file,
      height: height,
      width: width,
      fit: fit,
    );
  }

  static DecorationImage decorationImage(
      {required bool isAssetImage,
      required String image,
      BoxFit fit = BoxFit.cover}) {
    if (!isAssetImage) {
      image = image.replaceFirst('127.0.0.1', '10.0.2.2');
    }
    return DecorationImage(
      onError: (exception, stackTrace) {
        return;
      },
      image: isAssetImage ? AssetImage(image) : NetworkImage(image),
      fit: fit,
    );
  }

  static Widget networkImage(
    String imageUrl, {
    String placeholder = 'assets/gifs/loading_indicator.gif',
    double? height,
    double? width,
  }) {
    return FadeInImage.assetNetwork(
      placeholder: placeholder,
      image: imageUrl,
      height: height,
      width: width,
      fit: BoxFit.cover,
    );
  }

  static DecorationImage decorationFileImage(
      {required File image, BoxFit fit = BoxFit.cover}) {
    return DecorationImage(image: FileImage(image), fit: fit);
  }
}
