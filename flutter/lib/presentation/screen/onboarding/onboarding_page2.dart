import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/presentation/widgets/images.dart';
import 'package:pr1/presentation/widgets/text.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: height(context) * 0.1,
          child: Column(
            children: [
              _buildText(
                upperFirstText,
                28,
                FontWeight.bold,
              ),
              _buildText(
                upperSecondText,
                28,
                FontWeight.bold,
              ),
            ],
          ),
        ),
        SizedBox(
          width: width(context),
          height: width(context),
          child: MyImages.assetImage(page2ImagePath),
        ),
        Column(
          children: [
            _buildText(page2lowerFirstText, 20),
            _buildText(page2lowerSecondText, 20),
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
