import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/issues/issues_cubit.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/business_logic/task_cubit/task_cubit.dart';
import 'package:pr1/core/API/issues.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/data/models/workspace/fetch_workspaces_model.dart';
import 'package:pr1/presentation/screen/projects/build_projects_list.dart';
import 'package:pr1/presentation/screen/projects/project_info.dart';
import 'package:pr1/presentation/screen/tasks/main_show_tasks_page.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';

import '../issues/all_issues.dart';

class BuildProjectListItem extends StatelessWidget {
  final Project projectsModel;
  final Color color;
  final double containerWidth;
  final double marginFromLeft;
  final int workspaceId;

  const BuildProjectListItem(this.projectsModel, this.color,
      this.containerWidth, this.marginFromLeft, this.workspaceId,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return MyGestureDetector.gestureDetector(
      onTap: () {
        pushScreen(
          context,
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => TaskCubit()),
              BlocProvider(create: (context) => ProjectsCubit()),
            ],
            child: MainShowTasksPage(projectsModel.id, color, workspaceId),
          ),
        );
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: containerWidth,
              height: height(context) * 0.08,
              margin: EdgeInsets.only(left: marginFromLeft, bottom: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: color.withAlpha(50),
                    offset: const Offset(2, 2),
                    blurRadius: 2,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        height: height(context),
                        width: width(context) * 0.05,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(16)),
                        ),
                      ),
                      MyText.text1(projectsModel.title, textColor: white),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: MyGestureDetector.gestureDetector(
                          onTap: () {
                            pushScreen(
                              context,
                              BlocProvider(
                                  create: (context) => IssuesCubit(IssueApi()),
                                  child: All_Issues(
                                    project_Id: projectsModel.id,
                                  )),
                            );
                          },
                          child: MyIcons.icon(Icons.bug_report_outlined,
                              color: lightGrey),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        margin: const EdgeInsets.only(right: 15.0),
                        child: MyGestureDetector.gestureDetector(
                          onTap: () {
                            pushScreen(
                              context,
                              BlocProvider(
                                create: (context) => ProjectsCubit(),
                                child: ProjectInfo(
                                    projectsModel.id, color, workspaceId),
                              ),
                            );
                          },
                          child: MyIcons.icon(Icons.info_outline,
                              color: lightGrey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            projectsModel.subProjects.isNotEmpty
                ? BuildProjectsList(
                    projectsModel.subProjects,
                    workspaceId,
                    newWidth: width(context) * 0.62,
                    newMargin: marginFromLeft * 1.5,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
