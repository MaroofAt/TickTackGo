import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/variables/intro_questions_variables.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/text.dart';

class QuestionsPageView extends StatefulWidget {
  const QuestionsPageView({super.key});

  @override
  State<QuestionsPageView> createState() => _QuestionsPageViewState();
}

class _QuestionsPageViewState extends State<QuestionsPageView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        itemCount: introQuestions.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: height(context),
            width: width(context),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  height: height(context) * 0.1,
                  width: width(context) * 0.85,
                  decoration: const BoxDecoration(
                    color: transparent,
                  ),
                  child: MyText.text1(
                    introQuestions[index].question,
                    textColor: white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: introQuestions[index].answers.length,
                    itemBuilder: (context, answerIndex) {
                      return MyGestureDetector.gestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOption = introQuestions[index]
                                .answers[answerIndex];
                          });
                          selectedOptions[index] = introQuestions[index].answers[answerIndex];
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 8.0),
                          height: width(context) * 0.2,
                          width: width(context) * 0.85,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .scaffoldBackgroundColor,
                            border: Border.all(
                                color: introQuestions[index]
                                    .answers[answerIndex] ==
                                    selectedOption
                                    ? Theme.of(context).secondaryHeaderColor
                                    : white,
                                width: 2),
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Center(
                            child: MyText.text1(
                                introQuestions[index]
                                    .answers[answerIndex],
                                textColor: introQuestions[index]
                                    .answers[answerIndex] ==
                                    selectedOption
                                    ? Theme.of(context).secondaryHeaderColor
                                    : white,
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

