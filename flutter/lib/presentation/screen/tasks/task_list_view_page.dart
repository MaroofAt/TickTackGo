import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/dependency_cubit/dependency_cubit.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/data/models/tasks/fetch_tasks_model.dart';
import 'package:pr1/presentation/screen/dependencies/create_dependency.dart';
import 'package:pr1/presentation/screen/tasks/show_sub_tasks.dart';
import 'package:pr1/presentation/screen/tasks/task_list_item.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/snack_bar.dart';
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
        itemCount: fetchedTasks.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              TaskListItem(fetchedTasks[index], color),
              // fetchedTasks[index - 1].subTasks.isNotEmpty
              //     ? Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Container(),
              //           ShowSubTasks(fetchedTasks[index - 1].subTasks, color,
              //               fetchedTasks[index].project),
              //         ],
              //       )
              //     : Container(),
            ],
          );
        },
      ),
    );
  }
}
