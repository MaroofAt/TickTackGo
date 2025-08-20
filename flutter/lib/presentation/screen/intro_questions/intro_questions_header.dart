import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/intro_questions_cubit/intro_questions_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/variables/intro_questions_variables.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';

class IntroQuestionsHeader extends StatefulWidget {
  const IntroQuestionsHeader({super.key});

  @override
  State<IntroQuestionsHeader> createState() => _IntroQuestionsHeaderState();
}

class _IntroQuestionsHeaderState extends State<IntroQuestionsHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Row(
        children: [
          MyGestureDetector.gestureDetector(
            onTap: () {
              BlocProvider.of<IntroQuestionsCubit>(context).previousQuestion();
            },
            child: Container(
              height: width(context) * 0.08,
              width: width(context) * 0.08,
              decoration: const BoxDecoration(
                // color: white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: darkGrey, spreadRadius: 5, blurRadius: 5),
                ],
              ),
              child: Center(
                child: MyIcons.icon(
                  Icons.arrow_circle_left_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 35,
                ),
              ),
            ),
          ),
          BlocBuilder<IntroQuestionsCubit, IntroQuestionsState>(
            builder: (context, state) {
              return SizedBox(
                width: width(context) * 0.7,
                child: LinearProgressIndicator(
                  value: (currentQuestionIndex + 1) / introQuestions.length,
                  minHeight: 8,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
