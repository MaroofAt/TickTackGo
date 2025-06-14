import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/presentation/screen/auth/signin.dart';
import 'package:pr1/presentation/screen/auth/signinnew.dart';
import 'package:pr1/presentation/screen/auth/signup.dart';
import 'package:pr1/presentation/screen/auth/signupnew.dart';
import 'package:pr1/presentation/screen/onboarding/final_onboarding_page.dart';
import 'package:pr1/presentation/screen/onboarding/onboarding_main.dart';

Map<String, Widget Function(BuildContext)> routes = {
  signupRoute: (context) => Signupnew(),
  signinRoute: (context) => Signinnew(),
  onboardingMainRoute: (context) => const OnboardingMain(),
  finalOnboardingPageRoute: (context) => const FinalOnboardingPage(),
};

