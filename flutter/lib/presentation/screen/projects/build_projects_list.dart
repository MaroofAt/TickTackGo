import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/business_logic/workspace_cubit/workspace_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/data/models/workspace/fetch_workspaces_model.dart';
import 'package:pr1/presentation/screen/projects/build_project_list_item.dart';
import 'package:pr1/presentation/screen/projects/create_project.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class BuildProjectsList extends StatelessWidget {
  final int workspaceId;
  final List<Project> projects;
  final double? newWidth;
  final double? newMargin;

  const BuildProjectsList(this.projects, this.workspaceId,
      {this.newWidth, this.newMargin, super.key});

  void _showAddProjectDialog(BuildContext context) {
    Map<String, int> parentProjects = {};

    for (var element in projects) {
      parentProjects.addAll({element.title: element.id});
    }

    showDialog(
      context: context,
      builder: (_) => BlocProvider(
        create: (BuildContext context) => ProjectsCubit(),
        child: PopScope(
          onPopInvokedWithResult: (didPop, result) {
            if (didPop && result != null) {
              final projectsCubit =
                  BlocProvider.of<ProjectsCubit>(context, listen: false);
              final workspaceCubit =
                  BlocProvider.of<WorkspaceCubit>(context, listen: false);

              projectsCubit.onArrowTap(0);
              workspaceCubit.fetchWorkspaces();
            }
          },
          child: CreateProjectDialog(workspaceId, parentProjects),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: projects.length + 1,
      itemBuilder: (context, index) {
        Color color = transparent;
        if (index == projects.length) {
          if (newMargin == null) {
            return buildAddProjectButton(context);
          } else {
            return Container();
          }
        } else {
          String hex = projects[index].color.replaceFirst('#', '');
          if (hex.length == 6) hex = 'ff$hex'; // Adds opacity if not provided
          color = Color(int.parse(hex, radix: 16));
        }
        return BuildProjectListItem(
            projects[index],
            color,
            newWidth ?? width(context) * 0.7,
            newMargin ?? width(context) * 0.01,
            workspaceId);
      },
    );
  }

  Widget buildAddProjectButton(BuildContext context) {
    return Container(
      height: height(context) * 0.06,
      margin: EdgeInsets.only(left: width(context) * 0.2, bottom: 20),
      child: MyButtons.primaryButton(
        () {
          _showAddProjectDialog(context);
        },
        Theme.of(context).secondaryHeaderColor,
        child: Center(
          child: MyText.text1('Add new project?', fontSize: 18),
        ),
      ),
    );
  }
}
