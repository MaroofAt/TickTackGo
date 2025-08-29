import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/data/models/tasks/fetch_tasks_model.dart';
import 'package:pr1/presentation/screen/tasks/sub_task_list_item.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';

class ShowSubTasks extends StatelessWidget {
  final List<SubTask> subTask;
  final Color color;
  final int projectId;

  const ShowSubTasks(this.subTask, this.color, this.projectId, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * 0.72,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: subTask.length,
        itemBuilder: (context, index) {
          return SubTaskListItem(subTask[index], color, projectId);
        },
      ),
    );
  }
}
