import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/business_logic/workspace_cubit/workspace_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/core/functions/user_functions.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/data/models/projects/retrieve_project_model.dart';
import 'package:pr1/presentation/screen/projects/build_members_list.dart';
import 'package:pr1/presentation/screen/projects/build_workspace_members_list.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';

import '../../../core/API/tasks.dart';
import '../../../data/models/tasks/fetch_tasks_model.dart';
import '../gannt_chart/gantt_chart.dart';

class BuildProjectInfoPage extends StatelessWidget {
  final int workspaceId;
  final RetrieveProjectModel retrieveProjectModel;
  final int projectId;

  BuildProjectInfoPage(this.retrieveProjectModel, this.workspaceId,
      {required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: width(context),
      height: height(context),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText.text1(
                  retrieveProjectModel.title,
                  textColor: white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                MyGestureDetector.gestureDetector(
                  onTap: () async {
                    List<FetchTasksModel> fetchedTasks =
                        await TaskApi.fetchTasks(projectId, token);
                    pushScreen(context, TasksGanttChart(tasks: fetchedTasks));
                  },
                  child: Container(
                      margin: const EdgeInsets.only(left: 30),
                      padding: const EdgeInsets.all(10),
                      height: height(context) * 0.05,
                      width: width(context) * 0.4,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Row(
                          children: [
                            MyText.text1("Gantt chart", fontSize: 20),
                            SizedBox(
                              width: width(context) * 0.03,
                            ),
                            MyIcons.icon(Icons.arrow_forward_rounded,
                                color: Colors.black45)
                          ],
                        ),
                      )),
                ),
              ],
            ),
            const SizedBox(height: 20),
            buildCreateAtRow(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildCompletedRow(),
                isAdmin(retrieveProjectModel.members[0].member.id)
                    ? MyGestureDetector.gestureDetector(
                        onTap: () {
                          //TODO send End-Project API
                        },
                        child: Container(
                          height: height(context) * 0.05,
                          width: width(context) * 0.3,
                          decoration: BoxDecoration(
                              color: Theme.of(context).secondaryHeaderColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: MyText.text1('End Project?'),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.text1('project members: ',
                        textColor: white, fontSize: 20),
                    MyGestureDetector.gestureDetector(
                      onTap: () {
                        pushScreen(
                          context,
                          MultiBlocProvider(
                            providers: [
                              BlocProvider(create: (c) => ProjectsCubit()),
                              BlocProvider(create: (c) => WorkspaceCubit())
                            ],
                            child: PopScope(
                              onPopInvokedWithResult: (didPop, result) {
                                if (didPop && result != null) {
                                  BlocProvider.of<ProjectsCubit>(context)
                                      .retrieveProject(retrieveProjectModel.id);
                                }
                              },
                              child: BuildWorkspaceMembersList(
                                  workspaceId, retrieveProjectModel),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: height(context) * 0.05,
                        width: width(context) * 0.3,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: MyText.text1('add members'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 20),
                SizedBox(
                  height: height(context) * 0.5,
                  child: BlocProvider(
                    create: (context) => ProjectsCubit(),
                    child: BuildMembersList(retrieveProjectModel),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row buildCompletedRow() {
    return Row(
      children: [
        MyText.text1('completed: ', textColor: white, fontSize: 18),
        MyText.text1(retrieveProjectModel.ended.toString(),
            textColor: white, fontSize: 18),
      ],
    );
  }

  Row buildCreateAtRow() {
    return Row(
      children: [
        MyText.text1('Created at: ', textColor: white, fontSize: 18),
        MyText.text1(
            DateFormat('yyyy - M - dd').format(retrieveProjectModel.createdAt!),
            textColor: white,
            fontSize: 18),
      ],
    );
  }
}
