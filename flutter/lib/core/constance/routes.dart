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
import 'package:pr1/core/constance/colors.dart';
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
import 'package:pr1/presentation/screen/workspace_invite_link/accept_reject_invite_link.dart';
import 'package:pr1/presentation/screen/workspace_points/points_statistics.dart';

import '../../business_logic/auth_cubit/auth_cubit.dart';

class AppRouter {
  static final AppRouter _appRouter = AppRouter._internal();

  factory AppRouter() {
    return _appRouter;
  }

  AppRouter._internal();

  final GoRouter _router = GoRouter(
    initialLocation: splashScreenRoute,
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
        path: '$issuesDetailsRoute/:projectId/:issueId',
        name: issuesDetailsName,
        builder: (context, state) {
          int projectId = int.parse(state.pathParameters['projectId']!);
          int issueId = int.parse(state.pathParameters['issueId']!);
          return IssueDetails(
            projectId: projectId,
            issueId: issueId,
          );
        },
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
        path: '$mainShowTasksPageRoute/:workspaceId/:projectId',
        name: mainShowTasksPageName,
        builder: (context, state) {
          int workspaceId = int.parse(state.pathParameters['workspaceId']!);
          int projectId = int.parse(state.pathParameters['projectId']!);
          Color? color = state.extra as Color?;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ProjectsCubit()),
              BlocProvider(create: (context) => TaskCubit()),
            ],
            child: MainShowTasksPage(
              workspaceId: projectId,
              projectId: workspaceId,
              color: color ?? lightGrey,
            ),
          );
        },
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
        path: '$invitationSearchRoute/:workspaceId/:senderId',
        name: invitationSearchName,
        builder: (context, state) {
          int workspaceId = int.parse(state.pathParameters['workspaceId']!);
          int senderId = int.parse(state.pathParameters['senderId']!);
          return BlocProvider(
            create: (context) => InvitationCubit(),
            child: InvitationSearch(
              workspaceId: workspaceId,
              senderId: senderId,
            ),
          );
        },
      ),
      GoRoute(
        path: '$projectInfoRoute/:workspaceId/:projectId',
        name: projectInfoName,
        builder: (context, state) {
          int workspaceId = int.parse(state.pathParameters['workspaceId']!);
          int projectId = int.parse(state.pathParameters['projectId']!);
          Color? color = state.extra as Color?;
          return BlocProvider(
            create: (context) => ProjectsCubit(),
            child: ProjectInfo(
              workspaceId: workspaceId,
              projectId: projectId,
              color: color ?? lightGrey,
            ),
          );
        },
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
        path: '$pointsStatisticsRoute/:workspaceId/:workspaceName',
        name: pointsStatisticsName,
        builder: (context, state) {
          String workspaceName = state.pathParameters['workspaceName']!;
          int workspaceId = int.parse(state.pathParameters['workspaceId']!);
          return BlocProvider(
          create: (context) => PointsCubit(),
          child: PointsStatistics(
            workspaceId: workspaceId,
            workspaceName: workspaceName,
          ),
        );
        },
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
        path: '$allIssuesRoute/:projectId',
        name: allIssuesName,
        builder: (context, state) {
          int projectId = int.parse(state.pathParameters['projectId']!);
          return BlocProvider(
          create: (context) => IssuesCubit(IssueApi()),
          child: AllIssues(
            projectId: projectId,
          ),
        );
        },
      ),
      GoRoute(
        path: sentInvitesPageRoute,
        name: sentInvitesPageName,
        builder: (context, state) {
          int workspaceId = int.parse(state.pathParameters['workspaceId']!);
          return BlocProvider(
          create: (context) => WorkspaceCubit(),
          child: SentInvitesPage(workspaceId: workspaceId),
        );
        },
      ),
      GoRoute(
        path: '$acceptRejectInviteLinkRoute/:token',
        name: acceptRejectInviteLinkName,
        builder: (context, state) {
          final senderToken = state.pathParameters['token'] ?? state.extra as String;
          return AcceptRejectInviteLink(senderToken: senderToken);
        },
      )
    ],
  );

  GoRouter get router => _router;
}
