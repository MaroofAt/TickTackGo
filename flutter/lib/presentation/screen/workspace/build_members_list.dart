import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/workspace_cubit/workspace_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/core/functions/user_functions.dart';
import 'package:pr1/data/models/workspace/get_workspace_model.dart';
import 'package:pr1/presentation/widgets/alert_dialog.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class BuildMembersList extends StatelessWidget {
  final RetrieveWorkspaceModel retrieveWorkspace;

  const BuildMembersList(this.retrieveWorkspace, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: retrieveWorkspace.members.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return buildOneMemberCard(context, retrieveWorkspace.owner!.username,
              retrieveWorkspace.owner!.id, true);
        }
        return buildOneMemberCard(
            context,
            retrieveWorkspace.members[index - 1].member.username,
            retrieveWorkspace.members[index - 1].member.id);
      },
    );
  }

  Container buildOneMemberCard(BuildContext context, String name, int id,
      [bool showOwner = false]) {
    int selectedId = 0;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: width(context) * 0.6,
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: MyText.text1(name, textColor: Colors.white),
            ),
          ),
          showOwner
              ? MyText.text1('Owner', textColor: Colors.white70)
              : isAdmin(retrieveWorkspace.owner!.id)
                  ? BlocConsumer<WorkspaceCubit, WorkspaceState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is KickingMemberFromWorkspaceState &&
                            selectedId == id) {
                          return LoadingIndicator.circularProgressIndicator();
                        }
                        return MyGestureDetector.gestureDetector(
                            onTap: () {
                              MyAlertDialog.showAlertDialog(
                                context,
                                content: 'Are you sure to kick this member ?',
                                firstButtonText: okText,
                                firstButtonAction: () {
                                  selectedId = id;
                                  popScreen(context);
                                  BlocProvider.of<WorkspaceCubit>(context)
                                      .kickMember(
                                          retrieveWorkspace.id, selectedId);
                                  selectedId = 0;
                                },
                                secondButtonText: cancelText,
                                secondButtonAction: () {
                                  popScreen(context);
                                },
                              );
                            },
                            child: MyText.text1('kick', textColor: red));
                      },
                    )
                  : Container()
        ],
      ),
    );
  }
}
