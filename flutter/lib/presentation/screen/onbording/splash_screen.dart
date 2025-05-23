import 'package:flutter/material.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/presentation/widgets/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: Center(
          child: Container(
            height: height(context) / 2,
            width: height(context) / 2,
            decoration: BoxDecoration(
              image: MyImages.decorationImage(
                isAssetImage: true,
                image: 'assets/images/logo100.png',
              ),
            ),
            // child: MyImages.assetImage(
            //   'assets/images/logo100.png',
            //   height: height(context) / 2,
            //   width: height(context) / 2,
            // ),
          ),
        ),
      ),
    );
  }
}
