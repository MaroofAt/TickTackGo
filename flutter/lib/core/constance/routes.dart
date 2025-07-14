import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pr1/business_logic/inbox_cubit/inbox_cubit.dart';
import 'package:pr1/business_logic/intro_questions_cubit/intro_questions_cubit.dart';
import 'package:pr1/business_logic/invitation_cubit/invitation_cubit.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/business_logic/workspace_cubit/workspace_cubit.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/presentation/screen/auth/signinnew.dart';
import 'package:pr1/presentation/screen/auth/signupnew.dart';
import 'package:pr1/presentation/screen/auth/verifypage.dart';
import 'package:pr1/presentation/screen/home/main_home_page.dart';
import 'package:pr1/presentation/screen/inbox/main_inbox_page.dart';
import 'package:pr1/presentation/screen/intro_questions/intro_questions_main.dart';
import 'package:pr1/presentation/screen/invitation/invitation_search.dart';
import 'package:pr1/presentation/screen/invitation/received_invitations.dart';
import 'package:pr1/presentation/screen/onboarding/final_onboarding_page.dart';
import 'package:pr1/presentation/screen/onboarding/onboarding_main.dart';
import 'package:pr1/presentation/screen/workspace/create_workspace_page.dart';
import 'package:pr1/presentation/screen/workspace/workspace_info_page.dart';
import 'package:pr1/presentation/screen/workspace/workspaces_show_page.dart';

import '../../business_logic/auth_cubit/auth_cubit.dart';

Map<String, Widget Function(BuildContext)> routes = {
  signupRoute: (context) => const Signupnew(),
  signinRoute: (context) => const Signinnew(),
  verfiyeRoute: (context) => BlocProvider(
        create: (context) => AuthCubit(),
        child: Verifypage(),
      ),
  onboardingMainRoute: (context) => const OnboardingMain(),
  introQuestionsRoute: (context) => BlocProvider(
        create: (context) => IntroQuestionsCubit(),
        child: const IntroQuestionsMain(),
      ),
  finalOnboardingPageRoute: (context) => const FinalOnboardingPage(),
  workspacesShowPageRoute: (context) => MultiBlocProvider(
        providers: [
          BlocProvider<WorkspaceCubit>(create: (context) => WorkspaceCubit()),
          BlocProvider<ProjectsCubit>(create: (context) => ProjectsCubit()),
        ],
        child: const WorkspacesShowPage(),
      ),
  receivedInvitationPageRoute: (context) => BlocProvider(
        create: (context) => InvitationCubit(),
        child: const ReceivedInvitations(),
      ),
  mainHomePageRoute: (context) => BlocProvider(
        create: (context) => WorkspaceCubit(),
        child: const MainHomePage(),
      ),
  mainInboxPage: (context) => BlocProvider(
        create: (context) => InboxCubit(),
        child: const MainInboxPage(),
      ),
};
