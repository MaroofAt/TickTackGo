import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/intro_questions_cubit/intro_questions_cubit.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/presentation/screen/intro_questions/intro_questions_main.dart';
import 'package:pr1/presentation/screen/onbording/onboarding_main.dart';

Map<String, Widget Function(BuildContext)> routes = {
  onboardingMainRoute: (context) => const OnboardingMain(),
  introQuestionsRoute: (context) => BlocProvider(
        create: (context) => IntroQuestionsCubit(),
        child: const IntroQuestionsMain(),
      ),
};
