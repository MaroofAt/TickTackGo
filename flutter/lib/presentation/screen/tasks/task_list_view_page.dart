import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/data/models/tasks/fetch_tasks_model.dart';
import 'package:pr1/presentation/screen/tasks/task_list_item.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/text.dart';

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
        itemCount: fetchedTasks.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return MyGestureDetector.gestureDetector(
              onTap: () {

              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                width: width(context),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: MyText.text1(
                  'check dependencies',
                  textColor: Colors.blue,
                  textAlign: TextAlign.start,
                  fontSize: 22,
                ),
              ),
            );
          }
          print(fetchedTasks[index - 1].id);
          return TaskListItem(fetchedTasks[index - 1], color);
        },
      ),
    );
  }
}
