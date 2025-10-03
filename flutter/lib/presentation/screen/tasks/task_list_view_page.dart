import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/task_cubit/task_cubit.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/data/models/tasks/task_model.dart';
import 'package:pr1/presentation/screen/tasks/task_list_item.dart';

class TaskListViewPage extends StatelessWidget {
  double? mainWidth;
  final List<TaskModel> tasks;
  final Color color;

  TaskListViewPage(this.tasks, this.color, {this.mainWidth, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mainWidth ?? width(context) * 0.8,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          List<TaskModel> subTasks = [];
          if (tasks[index].subTasks.isNotEmpty) {
            for (var element in tasks[index].subTasks) {
              subTasks.add(BlocProvider.of<TaskCubit>(context)
                  .convertFetchedTaskToTaskModel(tasks[index].projectId,
                      subTask: element, assignees: tasks[index].assignees));
            }
          }
          return Column(
            children: [
              TaskListItem(
                  tasks[index], color, mainWidth ?? width(context) * 0.8),
              tasks[index].subTasks.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        TaskListViewPage(
                          subTasks,
                          color,
                          mainWidth: width(context) * 0.7,
                        ),
                      ],
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }
}
