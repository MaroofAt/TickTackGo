import 'package:flutter/material.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/data/models/tasks/fetch_tasks_model.dart';
import 'package:pr1/presentation/screen/tasks/task_list_item.dart';

class TaskListViewPage extends StatelessWidget {
  final List<FetchTasksModel> fetchedTasks;
  final Color color;
  const TaskListViewPage(this.fetchedTasks, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * 0.8,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: fetchedTasks.length,
        itemBuilder: (context, index) {
          print(fetchedTasks[0].id);
          return TaskListItem(fetchedTasks[index], color);
        },
      ),
    );
  }
}
