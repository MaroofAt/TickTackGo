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
        path: splashScreenRoute,
        name: splashScreenName,
        builder: (context, state) => BlocProvider(
          create: (context) => SplashCubit(),
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: signInRoute,
        name: signInName,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const SignInNew(),
        ),
      ),
      GoRoute(
        path: signupRoute,
        name: signupName,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const SignUpNew(),
        ),
      ),
      GoRoute(
        path: verifyRoute,
        name: verifyName,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const VerifyPage(),
        ),
      ),
      GoRoute(
        path: issuesDetailsRoute,
        name: issuesDetailsName,
        builder: (context, state) => const IssueDetails(),
      ),
      GoRoute(
        path: onboardingMainRoute,
        name: onboardingMainName,
        builder: (context, state) => const OnboardingMain(),
      ),
      GoRoute(
        path: introQuestionsRoute,
        name: introQuestionsName,
        builder: (context, state) => BlocProvider(
          create: (context) => IntroQuestionsCubit(),
          child: const IntroQuestionsMain(),
        ),
      ),
      GoRoute(
        path: finalOnboardingPageRoute,
        name: finalOnboardingPageName,
        builder: (context, state) => const FinalOnboardingPage(),
      ),
      GoRoute(
        path: workspacesShowPageRoute,
        name: workspacesShowPageName,
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
        name: receivedInvitationPageName,
        builder: (context, state) => BlocProvider(
          create: (context) => InvitationCubit(),
          child: const ReceivedInvitations(),
        ),
      ),
      GoRoute(
        path: mainHomePageRoute,
        name: mainHomePageName,
        builder: (context, state) => const MainHomePage(),
      ),
      GoRoute(
        path: mainInboxPageRoute,
        name: mainInboxPageName,
        builder: (context, state) => BlocProvider(
          create: (context) => InboxCubit(),
          child: const MainInboxPage(),
        ),
      ),
      GoRoute(
        path: mainShowTasksPageRoute,
        name: mainShowTasksPageName,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProjectsCubit()),
            BlocProvider(create: (context) => TaskCubit()),
          ],
          child: const MainShowTasksPage(),
        ),
      ),
      GoRoute(
        path: createUpdateWorkspacePageRoute,
        name: createUpdateWorkspacePageName,
        builder: (context, state) => BlocProvider(
          create: (context) => ProjectsCubit(),
          child: const CreateUpdateWorkspacePage(),
        ),
      ),
      GoRoute(
        path: inboxInfoPageRoute,
        name: inboxInfoPageName,
        builder: (context, state) => const InboxInfoPage(),
      ),
      GoRoute(
        path: invitationSearchRoute,
        name: invitationSearchName,
        builder: (context, state) => BlocProvider(
          create: (context) => InvitationCubit(),
          child: const InvitationSearch(),
        ),
      ),
      GoRoute(
        path: projectInfoRoute,
        name: projectInfoName,
        builder: (context, state) => BlocProvider(
          create: (context) => ProjectsCubit(),
          child: const ProjectInfo(),
        ),
      ),
      GoRoute(
        path: taskInfoPageRoute,
        name: taskInfoPageName,
        builder: (context, state) => BlocProvider(
          create: (context) => TaskCubit(),
          child: const TaskInfoPage(),
        ),
      ),
      GoRoute(
        path: pointsStatisticsRoute,
        name: pointsStatisticsName,
        builder: (context, state) => BlocProvider(
          create: (context) => PointsCubit(),
          child: const PointsStatistics(),
        ),
      ),
      GoRoute(
        path: workspaceInfoPageRoute,
        name: workspaceInfoPageName,
        builder: (context, state) => BlocProvider(
          create: (context) => WorkspaceCubit(),
          child: const WorkspaceInfoPage(),
        ),
      ),
      GoRoute(
        path: tasksGanttChartRoute,
        name: tasksGanttChartName,
        builder: (context, state) => BlocProvider(
          create: (context) => WorkspaceCubit(),
          child: const TasksGanttChart(),
        ),
      ),
      GoRoute(
        path: buildWorkspaceMembersListRoute,
        name: buildWorkspaceMembersListName,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (c) => ProjectsCubit()),
            BlocProvider(create: (c) => WorkspaceCubit()),
          ],
          child: const BuildWorkspaceMembersList(),
        ),
      ),
      GoRoute(
        path: allIssuesRoute,
        name: allIssuesName,
        builder: (context, state) => BlocProvider(
          create: (context) => IssuesCubit(IssueApi()),
          child: const AllIssues(),
        ),
      ),
      GoRoute(
        path: sentInvitesPageRoute,
        name: sentInvitesPageName,
        builder: (context, state) => BlocProvider(
          create: (context) => WorkspaceCubit(),
          child: const SentInvitesPage(),
        ),
      ),
    ],
  );

  GoRouter get router => _router;
}