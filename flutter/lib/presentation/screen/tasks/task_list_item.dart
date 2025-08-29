import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pr1/business_logic/task_cubit/task_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/data/models/tasks/fetch_tasks_model.dart';
import 'package:pr1/presentation/screen/tasks/task_info_page.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/text.dart';

class TaskListItem extends StatelessWidget {
  final FetchTasksModel fetchTask;
  final Color color;

  const TaskListItem(this.fetchTask, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return MyGestureDetector.gestureDetector(
      onTap: () {
        pushScreen(
          context,
          BlocProvider(
            create: (context) => TaskCubit(),
            child: PopScope(
              onPopInvokedWithResult: (didPop, result) {
                if (didPop && result != null) {
                  BlocProvider.of<TaskCubit>(context)
                      .fetchTasks(fetchTask.project);

                  /*
                  * remove from tasksTitles
                  * so it doesn't appear in the parent projects list
                  */
                  BlocProvider.of<TaskCubit>(context)
                      .tasksTitles
                      .removeWhere((key, value) => key == result);
                }
              },
              child: TaskInfoPage(fetchTask),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.only(left: 5.0, top: 5, bottom: 5),
        height: height(context) * 0.12,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius:
              const BorderRadius.horizontal(left: Radius.circular(16)),
          border: Border(left: BorderSide(color: color, width: 5)),
          boxShadow: [
            BoxShadow(
              color: Colors.white70.withAlpha(50),
              blurRadius: 3,
              spreadRadius: 3,
              offset: const Offset(4, 4),
            )
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: width(context) * 0.32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyText.text1(fetchTask.title,
                      textColor: white, textAlign: TextAlign.center),
                  Container(
                    width: width(context) * 0.25,
                    height: height(context) * 0.04,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(child: MyText.text1(fetchTask.status)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: width(context) * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyText.text1(
                     'Created At:\n ${DateFormat('yyyy-MM-d').format(fetchTask.dueDate!)}',
                      textColor: Colors.grey),

                  MyText.text1(
                      'Due date:\n ${DateFormat('yyyy-MM-d').format(fetchTask.dueDate!)}',
                      textColor: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
