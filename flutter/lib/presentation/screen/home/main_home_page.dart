import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/data/local_data/local_data.dart';
import 'package:pr1/presentation/screen/auth/signupnew.dart';
import 'package:pr1/presentation/screen/home/card_builder.dart';
import 'package:pr1/presentation/screen/home/task_card.dart';
import 'package:pr1/presentation/screen/onboarding/splash_screen.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';

import '../../../business_logic/auth_cubit/auth_cubit.dart';
import '../../../core/API/user.dart';
import '../auth/signinnew.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor
        ,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    // backgroundImage: AssetImage("${theuser?.image}"),
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
                '$hiText\n' + "${theuser?.username}",
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
                      print(theuser?.email);
                    },
                  ),
                   CardBuilder(
                      color: ampleOrange,
                      label: 'logout',
                      icon: Icons.logout_rounded,
                      onTap: () {
                        context.read<AuthCubit>().logout(context);
                      },
                      content: '',
                    ),

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
