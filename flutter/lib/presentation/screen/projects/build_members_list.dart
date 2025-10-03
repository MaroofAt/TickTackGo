import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/data/models/projects/retrieve_project_model.dart';
import 'package:pr1/data/models/projects/show_member_info_dialog.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class BuildMembersList extends StatelessWidget {
  final RetrieveProjectModel retrieveProjectModel;
  int selectedUserId = 0;

  BuildMembersList(this.retrieveProjectModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: retrieveProjectModel.members.length,
      itemBuilder: (context, index) {
        return buildOneMemberCard(context, index);
      },
    );
  }

  Container buildOneMemberCard(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.only(right: 12.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width(context) * 0.5,
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: MyText.text1(
                  retrieveProjectModel.members[index].member.username,
                  textColor: Colors.white),
            ),
          ),
          index == 0
              ? MyText.text1(retrieveProjectModel.members[index].role,
                  textColor: Colors.white70)
              : MyGestureDetector.gestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BlocProvider(
                          create: (context) => ProjectsCubit(),
                          child: ShowMemberInfoDialog(
                            retrieveProjectModel.members[index],
                            retrieveProjectModel.id,
                            retrieveProjectModel.members[0].member.id,
                          ),
                        );
                      },
                    );
                  },
                  child: MyIcons.icon(Icons.info_outline, color: lightGrey),
                ),
          // : BlocBuilder<ProjectsCubit, ProjectsState>(
          //     builder: (context, state) {
          //       String selectedRole = retrieveProjectModel.members[index].role;
          //       if (state is ChangingUserRoleState &&
          //           retrieveProjectModel.id == selectedUserId) {
          //         return Center(
          //           child: LoadingIndicator.circularProgressIndicator(),
          //         );
          //       }
          //       return WordSwitch(
          //         firstOption: 'editor',
          //         secondOption: 'viewer',
          //         selectedValue: selectedRole,
          //         onChanged: (String value) {
          //           selectedUserId = retrieveProjectModel.id;
          //           BlocProvider.of<ProjectsCubit>(context).changeUserRole(
          //             retrieveProjectModel.members[index].member.id,
          //             selectedUserId,
          //             value,
          //             retrieveProjectModel,
          //           );
          //         },
          //         selectedColor: Theme.of(context).primaryColor,
          //         selectedTextColor: black,
          //       );
          //     },
          //   ),
        ],
      ),
    );
  }
}
