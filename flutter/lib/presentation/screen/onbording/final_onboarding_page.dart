import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/images.dart';
import 'package:pr1/presentation/widgets/text.dart';

class FinalOnboardingPage extends StatelessWidget {
  const FinalOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: height(context),
          width: width(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  _buildText(upperFirstTextForFinalPage, 28, FontWeight.bold),
                  _buildText(upperSecondTextForFinalPage, 28, FontWeight.bold),
                ],
              ),
              Container(
                child: MyImages.assetImage(finalPageImagePath),
              ),
              Column(
                children: [
                  _buildText(finalPageLowerFirstText, 20),
                  _buildText(finalPageLowerSecondText, 20),
                ],
              ),
              SizedBox(
                width: width(context) * 0.3,
                child: MyButtons.primaryButton(
                  () {
                    //TODO navigate to register page
                  },
                  Theme.of(context).secondaryHeaderColor,
                  child: MyText.text1(
                    finalPageButtonText,
                    textColor: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 18,
                    wordSpacing: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
