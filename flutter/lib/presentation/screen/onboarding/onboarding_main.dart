import 'package:flutter/material.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/core/variables/onboarding_variables.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class OnboardingMain extends StatefulWidget {
  const OnboardingMain({super.key});

  @override
  State<OnboardingMain> createState() => _OnboardingMainState();
}

class _OnboardingMainState extends State<OnboardingMain> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: height(context),
        child: Stack(
          children: [
            Positioned(
              top: height(context) * 0.1,
              height: height(context) * 0.8,
              width: width(context),
              child: PageView(
                controller: _pageController,
                children: onboardingPages,
              ),
            ),
            Positioned(
              bottom: 10,
              width: width(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildOnboardingSkipButtons(
                      context,
                      nextButtonText,
                      () {
                        if (_pageController.page! <
                            onboardingPages.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          pushReplacementNamed(context, introQuestionsRoute);
                        }
                      },
                    ),
                    buildOnboardingSkipButtons(
                      context,
                      skipButtonText,
                      () {
                        pushReplacementNamed(context, introQuestionsRoute);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnboardingSkipButtons(
      BuildContext context, String text, void Function() onPressed) {
    return SizedBox(
      width: width(context) * 0.3,
      child: MyButtons.primaryButton(
        onPressed,
        Theme.of(context).primaryColor,
        child: MyText.text1(text,fontSize: 18,textColor: Theme.of(context).scaffoldBackgroundColor),
      ),
    );
  }
}
