import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pr1/business_logic/inbox_cubit/inbox_cubit.dart';
import 'package:pr1/business_logic/intro_questions_cubit/intro_questions_cubit.dart';
import 'package:pr1/business_logic/invitation_cubit/invitation_cubit.dart';
import 'package:pr1/business_logic/issues/issues_cubit.dart';
import 'package:pr1/business_logic/points_cubit/points_cubit.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/business_logic/splash_cubit/splash_cubit.dart';
import 'package:pr1/business_logic/task_cubit/task_cubit.dart';
import 'package:pr1/business_logic/workspace_cubit/workspace_cubit.dart';
import 'package:pr1/core/API/issues.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/presentation/screen/auth/sign_in_new.dart';
import 'package:pr1/presentation/screen/auth/signupnew.dart';
import 'package:pr1/presentation/screen/auth/verifypage.dart';
import 'package:pr1/presentation/screen/gannt_chart/gantt_chart.dart';
import 'package:pr1/presentation/screen/home/main_home_page.dart';
import 'package:pr1/presentation/screen/inbox/inbox_info_page.dart';
import 'package:pr1/presentation/screen/inbox/main_inbox_page.dart';
import 'package:pr1/presentation/screen/intro_questions/intro_questions_main.dart';
import 'package:pr1/presentation/screen/invitation/invitation_search.dart';
import 'package:pr1/presentation/screen/invitation/received_invitations.dart';
import 'package:pr1/presentation/screen/issues/all_issues.dart';

import 'package:pr1/presentation/screen/issues/detalies_issue.dart';
import 'package:pr1/presentation/screen/onboarding/final_onboarding_page.dart';
import 'package:pr1/presentation/screen/onboarding/onboarding_main.dart';
import 'package:pr1/presentation/screen/onboarding/splash_screen.dart';
import 'package:pr1/presentation/screen/projects/build_workspace_members_list.dart';
import 'package:pr1/presentation/screen/projects/project_info.dart';
import 'package:pr1/presentation/screen/tasks/create_task_page.dart';
import 'package:pr1/presentation/screen/tasks/main_show_tasks_page.dart';
import 'package:pr1/presentation/screen/tasks/task_info_page.dart';
import 'package:pr1/presentation/screen/workspace/create_update_workspace_page.dart';
import 'package:pr1/presentation/screen/workspace/sent_invites_page.dart';
import 'package:pr1/presentation/screen/workspace/workspace_info_page.dart';
import 'package:pr1/presentation/screen/workspace/workspaces_show_page.dart';
import 'package:pr1/presentation/screen/workspace_points/points_statistics.dart';

import '../../business_logic/auth_cubit/auth_cubit.dart';

class AppRouter {
  static final AppRouter _appRouter = AppRouter._internal();

  factory AppRouter() {
    return _appRouter;
  }

  AppRouter._internal();

  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: splashScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => SplashCubit(),
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: signInRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const SignInNew(),
        ),
      ),
      GoRoute(
        path: signupRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const SignUpNew(),
        ),
      ),
      GoRoute(
        path: verifyRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const VerifyPage(),
        ),
      ),
      GoRoute(
        path: issuesDetails,
        builder: (context, state) => const IssueDetails(),
      ),
      GoRoute(
        path: onboardingMainRoute,
        builder: (context, state) => const OnboardingMain(),
      ),
      GoRoute(
        path: introQuestionsRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => IntroQuestionsCubit(),
          child: const IntroQuestionsMain(),
        ),
      ),
      GoRoute(
        path: finalOnboardingPageRoute,
        builder: (context, state) => const IntroQuestionsMain(),
      ),
      GoRoute(
        path: workspacesShowPageRoute,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider<WorkspaceCubit>(create: (context) => WorkspaceCubit()),
            BlocProvider<ProjectsCubit>(create: (context) => ProjectsCubit()),
          ],
          child: const WorkspacesShowPage(),
        ),
      ),
      GoRoute(
        path: receivedInvitationPageRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => InvitationCubit(),
          child: const ReceivedInvitations(),
        ),
      ),
      GoRoute(
        path: mainHomePageRoute,
        builder: (context, state) => const MainHomePage(),
      ),
      GoRoute(
        path: mainInboxPage,
        builder: (context, state) => BlocProvider(
          create: (context) => InboxCubit(),
          child: const MainInboxPage(),
        ),
      ),
      GoRoute(
        path: mainShowTasksPage,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProjectsCubit()),
            BlocProvider(create: (context) => TaskCubit()),
          ],
          child: const MainShowTasksPage(),
        ),
      ),
      GoRoute(
        path: createUpdateWorkspacePage,
        builder: (context, state) => BlocProvider(
          create: (context) => ProjectsCubit(),
          child: const CreateUpdateWorkspacePage(),
        ),
      ),
      GoRoute(
        path: inboxInfoPage,
        builder: (context, state) => const InboxInfoPage(),
      ),
      GoRoute(
        path: invitationSearch,
        builder: (context, state) => BlocProvider(
          create: (context) => InvitationCubit(),
          child: const InvitationSearch(),
        ),
      ),
      GoRoute(
        path: projectInfo,
        builder: (context, state) => BlocProvider(
          create: (context) => ProjectsCubit(),
          child: const ProjectInfo(),
        ),
      ),
      GoRoute(
        path: taskInfoPage,
        builder: (context, state) => BlocProvider(
          create: (context) => TaskCubit(),
          child: const TaskInfoPage(),
        ),
      ),
      GoRoute(
        path: pointsStatistics,
        builder: (context, state) => BlocProvider(
          create: (context) => PointsCubit(),
          child: const PointsStatistics(),
        ),
      ),
      GoRoute(
        path: workspaceInfoPage,
        builder: (context, state) => BlocProvider(
          create: (context) => WorkspaceCubit(),
          child: const WorkspaceInfoPage(),
        ),
      ),
      GoRoute(
        path: tasksGanttChart,
        builder: (context, state) => BlocProvider(
          create: (context) => WorkspaceCubit(),
          child: const TasksGanttChart(),
        ),
      ),
      GoRoute(
        path: buildWorkspaceMembersList,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (c) => ProjectsCubit()),
            BlocProvider(create: (c) => WorkspaceCubit()),
          ],
          child: const BuildWorkspaceMembersList(),
        ),
      ),
      GoRoute(
        path: allIssues,
        builder: (context, state) => BlocProvider(
          create: (context) => IssuesCubit(IssueApi()),
          child: const AllIssues(),
        ),
      ),
      GoRoute(
        path: sentInvitesPage,
        builder: (context, state) => BlocProvider(
          create: (context) => WorkspaceCubit(),
          child: const SentInvitesPage(),
        ),
      ),
    ],
  );

  GoRouter get router => _router;
}