import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/presentation/widgets/images.dart';
import 'package:pr1/presentation/widgets/text.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildText(
          upperText,
          28,
          FontWeight.bold,
        ),
        Container(
          child: MyImages.assetImage(page1ImagePath),
        ),
        Column(
          children: [
            _buildText(page1lowerFirstText, 20),
            _buildText(page1lowerSecondText, 20),
          ],
        ),
      ],
    );
  }

  Widget _buildText(String text, double fontSize, [FontWeight? fontWeight]) {
    return MyText.text1(
      text,
      textColor: white,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}
