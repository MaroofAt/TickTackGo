import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/dependency_cubit/dependency_cubit.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/data/models/tasks/fetch_tasks_model.dart';
import 'package:pr1/presentation/screen/dependencies/create_dependency.dart';
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
        itemCount: fetchedTasks.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return MyGestureDetector.gestureDetector(
              onTap: () {
                Map<String, int> tasks = {};
                for (var element in fetchedTasks) {
                  tasks.addAll({element.title: element.id});
                }
                showDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => DependencyCubit(),
                      child: PopScope(
                        onPopInvokedWithResult: (didPop, result) {
                          if (didPop && result != null) {
                            MySnackBar.mySnackBar(
                              'Created successfully',
                              backgroundColor: Colors.green,
                            );
                          }
                        },
                        child: CreateDependency(tasks),
                      ),
                    );
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                width: width(context),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: MyText.text1(
                  'Create dependency?',
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
