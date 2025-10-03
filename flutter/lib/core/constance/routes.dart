import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pr1/business_logic/inbox_cubit/inbox_cubit.dart';
import 'package:pr1/business_logic/intro_questions_cubit/intro_questions_cubit.dart';
import 'package:pr1/business_logic/invitation_cubit/invitation_cubit.dart';
import 'package:pr1/business_logic/issues/issues_cubit.dart';
import 'package:pr1/business_logic/points_cubit/points_cubit.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/business_logic/task_cubit/task_cubit.dart';
import 'package:pr1/business_logic/workspace_cubit/workspace_cubit.dart';
import 'package:pr1/core/API/issues.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/presentation/screen/auth/signinnew.dart';
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

Map<String, Widget Function(BuildContext)> routes = {
  signupRoute: (context) => const Signupnew(),
  signinRoute: (context) => const Signinnew(),
  verfiyeRoute: (context) => BlocProvider(
        create: (context) => AuthCubit(),
        child: const Verifypage(),
      ),
  issuesdetalies: (context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final issueid = args["issueId"] as int;
    final projectid = args["projectId"] as int;
    return IssueDetails(
      issueId: issueid,
      projectId: projectid,
    );
  },
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
  mainShowTasksPage: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TaskCubit()),
          BlocProvider(create: (context) => ProjectsCubit()),
        ],
        child: const MainShowTasksPage(),
      ),
  createUpdateWorkspacePage: (context) => BlocProvider(
        create: (context) => WorkspaceCubit(),
        child: const CreateUpdateWorkspacePage(),
      ),
  inboxInfoPage: (context) => const InboxInfoPage(),
  invitationSearch: (context) => BlocProvider(
        create: (context) => InvitationCubit(),
        child: const InvitationSearch(),
      ),
  projectInfo: (context) => BlocProvider(
        create: (context) => ProjectsCubit(),
        child: const ProjectInfo(),
      ),
  taskInfoPage: (context) => BlocProvider(
        create: (context) => TaskCubit(),
        child: const TaskInfoPage(),
      ),
  pointsStatistics: (context) => BlocProvider(
        create: (context) => PointsCubit(),
        child: const PointsStatistics(),
      ),
  workspaceInfoPage: (context) => BlocProvider(
        create: (context) => WorkspaceCubit(),
        child: const WorkspaceInfoPage(),
      ),
  tasksGanttChart: (context) => BlocProvider(
        create: (context) => WorkspaceCubit(),
        child: const TasksGanttChart(),
      ),
  buildWorkspaceMembersList: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (c) => ProjectsCubit()),
          BlocProvider(create: (c) => WorkspaceCubit())
        ],
        child: const BuildWorkspaceMembersList(),
      ),
  allIssues: (context) => BlocProvider(
        create: (context) => IssuesCubit(IssueApi()),
        child: const AllIssues(),
      ),
  createTaskPage: (context) => BlocProvider(
        create: (_) => TaskCubit(),
        child: const CreateTaskPage(),
      ),
  sentInvitesPage: (context) => BlocProvider(
        create: (_) => WorkspaceCubit(),
        child: const SentInvitesPage(),
      ),
};
