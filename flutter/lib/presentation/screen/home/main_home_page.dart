import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/workspace_cubit/workspace_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/presentation/screen/home/card_builder.dart';
import 'package:pr1/presentation/screen/home/fetching_workspace_failed_popup_menu.dart';
import 'package:pr1/presentation/screen/home/home_popup_menu_button.dart';
import 'package:pr1/presentation/screen/home/task_card.dart';
import 'package:pr1/presentation/widgets/animated_dropdown.dart';
import 'package:pr1/presentation/widgets/circle.dart';
import 'package:pr1/presentation/widgets/dropdown_button2.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    // backgroundImage: AssetImage(''),
                    radius: width(context) * 0.1,
                    child:
                        MyIcons.icon(Icons.person, size: width(context) * 0.1),
                  ),
                  // BlocBuilder<WorkspaceCubit, WorkspaceState>(
                  //   builder: (context, state) {
                  //     if (state is WorkspacesFetchingSucceededState) {
                  //       return HomePopupMenuButton(state.fetchWorkspacesModel);
                  //     } else if (state is WorkspacesFetchingFailedState) {
                  //       return FetchingWorkspaceFailedPopupMenu(
                  //           state.errorMessage);
                  //     } else {
                  //       return FetchingWorkspaceFailedPopupMenu('something went wrong\nrefresh?');
                  //     }
                  //   },
                  // ),
                ],
              ),
              const SizedBox(height: 16),
              MyText.text1(
                '$hiText,\nUser Name',
                textColor: Colors.white,
                fontSize: 24,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  CardBuilder(
                    color: sleekCyan,
                    label: workspaceText,
                    content: '',
                    icon: Icons.work,
                    onTap: () {
                      pushNamed(context, workspacesShowPageRoute);
                    },
                  ),
                  CardBuilder(
                    color: greatMagenda,
                    label: invitesText,
                    content: receivedInviteText,
                    icon: Icons.auto_awesome,
                    onTap: () {
                      pushNamed(context, receivedInvitationPageRoute);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  CardBuilder(
                    color: parrotGreen,
                    label: inboxText,
                    content: '17 $tasksText',
                    icon: Icons.folder_copy,
                    onTap: () {
                      pushNamed(context, mainInboxPage);
                    },
                  ),
                  // CardBuilder(
                  //   color: ampleOrange,
                  //   label: 'Cancel',
                  //   taskCount: '02 tasks',
                  //   icon: Icons.cancel,
                  //
                  //   onTap: () {},
                  // ),
                ],
              ),
              const SizedBox(height: 16),
              MyText.text1(
                allTasksText,
                textColor: Colors.white,
                fontSize: 18,
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView(
                  children: const [
                    TaskCard(),
                    TaskCard(),
                    TaskCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
