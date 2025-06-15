import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/intro_questions_cubit/intro_questions_cubit.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/core/variables/intro_questions_variables.dart';
import 'package:pr1/presentation/screen/intro_questions/intro_questions_header.dart';
import 'package:pr1/presentation/screen/intro_questions/questions_page_view.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class IntroQuestionsMain extends StatefulWidget {
  const IntroQuestionsMain({super.key});

  @override
  State<IntroQuestionsMain> createState() => _IntroQuestionsMainState();
}

class _IntroQuestionsMainState extends State<IntroQuestionsMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: height(context),
          width: width(context),
          child: Column(
            children: [
              const IntroQuestionsHeader(),
              BlocListener<IntroQuestionsCubit, IntroQuestionsState>(
                listener: (context, state) {
                  if(state is QuestionsFinishedState){
                    pushReplacementNamed(context, finalOnboardingPageRoute);
                  }
                },
                child: QuestionsPageView(),
              ),
              buildNextButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Container buildNextButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      width: width(context) * 0.65,
      height: width(context) * 0.12,
      child: MyButtons.primaryButton(
        BlocProvider.of<IntroQuestionsCubit>(context).nextQuestion,
        Theme.of(context).primaryColor,
        child: MyText.text1(
          'Next',
          fontSize: 20,
          textColor: Theme.of(context).scaffoldBackgroundColor,
          letterSpacing: 3.5,
        ),
      ),
    );
  }
}
