import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/auth_cubit/auth_cubit.dart';
import 'package:pr1/core/API/user.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/presentation/screen/home/card_builder.dart';
import 'package:pr1/presentation/screen/home/main_home_page_shimmer.dart';
import 'package:pr1/presentation/screen/home/motivational_section.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    await getUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: user == null
              ? const MainHomePageShimmer()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          // backgroundImage: NetworkImage(user!.image),
                          radius: width(context) * 0.1,
                          child: MyIcons.icon(Icons.person,
                              size: width(context) * 0.1),
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
                      "${user?.username}",
                      textColor: Colors.white,
                      fontSize: 24,
                    ),
                    MyText.text1(
                      "${user?.email}",
                      textColor: Colors.grey,
                      fontSize: 18,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        CardBuilder(
                          color: sleekCyan,
                          label: workspaceText,
                          icon: Icons.work,
                          withShimmer: false,
                          onTap: () {
                            pushNamed(context, workspacesShowPageRoute);
                          },
                        ),
                        CardBuilder(
                          color: greatMagenda,
                          label: invitesText,
                          icon: Icons.event,
                          withShimmer: false,
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
                          icon: Icons.folder_copy,
                          withShimmer: false,
                          onTap: () {
                            pushNamed(context, mainInboxPage);
                          },
                        ),
                        CardBuilder(
                          color: ampleOrange,
                          label: 'logout',
                          icon: Icons.logout_rounded,
                          withShimmer: false,
                          onTap: () {
                            context.read<AuthCubit>().logout(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const MotivationalSection(),
                  ],
                ),
        ),
      ),
    );
  }
}
