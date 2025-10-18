import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/business_logic/task_cubit/task_cubit.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_service.dart';
import 'package:pr1/presentation/widgets/icons.dart';

class CreateTaskFloatingButton extends StatelessWidget {
  final int projectId;
  final int workspaceId;

  const CreateTaskFloatingButton(this.projectId, this.workspaceId, {super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        NavigationService().push(context, '$createTaskPageRoute/$workspaceId/$projectId', args: {
          'tasksTitles': BlocProvider.of<TaskCubit>(context).tasksTitles,
          'assignees': BlocProvider.of<ProjectsCubit>(context).assignees,
          'taskCubit': context.read<TaskCubit>(),
        });
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: Center(child: MyIcons.icon(Icons.add)),
    );
  }
}
