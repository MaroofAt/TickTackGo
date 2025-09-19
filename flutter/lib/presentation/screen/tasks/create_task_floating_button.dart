import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/business_logic/task_cubit/task_cubit.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/presentation/screen/tasks/create_task_page.dart';
import 'package:pr1/presentation/widgets/icons.dart';

class CreateTaskFloatingButton extends StatelessWidget {
  final int projectId;
  final int workspaceId;

  const CreateTaskFloatingButton(this.projectId, this.workspaceId, {super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        pushScreen(
          context,
          BlocProvider(
            create: (context) => TaskCubit(),
            child: PopScope(
              onPopInvokedWithResult: (didPop, result) {
                if (didPop && result != null) {
                  BlocProvider.of<TaskCubit>(context).fetchTasks(projectId);
                }
              },
              child: CreateTaskPage(
                projectId,
                workspaceId,
                BlocProvider.of<TaskCubit>(context).tasksTitles,
                BlocProvider.of<ProjectsCubit>(context).assignees,
              ),
            ),
          ),
        );
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: Center(child: MyIcons.icon(Icons.add)),
    );
  }
}
