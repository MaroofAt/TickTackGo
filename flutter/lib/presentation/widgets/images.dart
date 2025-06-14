import 'package:flutter/material.dart';

class MyImages {
  static Widget assetImage(String image, {double? height, double? width}) {
    return Image.asset(
      height: height,
      width: width,
      image,
      fit: BoxFit.cover,
    );
  }

  static DecorationImage decorationImage(
      {required bool isAssetImage, required String image, BoxFit? fit}) {
    return DecorationImage(
      image: isAssetImage ? AssetImage(image) : NetworkImage(image),
      fit: fit?? BoxFit.cover,
    );
  }

  static Widget networkImage(
    String imageUrl, {
    String placeholder = 'assets/gifs/loading_indicator.gif',
  }) {
    return FadeInImage.assetNetwork(
      placeholder: placeholder,
      image: imageUrl,
      fit: BoxFit.cover,
    );
  }
}
