import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/task_cubit/task_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/presentation/screen/tasks/create_task_page.dart';
import 'package:pr1/presentation/screen/tasks/show_tasks_app_bar.dart';
import 'package:pr1/presentation/screen/tasks/task_list_view_page.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class MainShowTasksPage extends StatefulWidget {
  final int projectId;
  final int workspaceId;
  final Color color;

  const MainShowTasksPage(this.projectId, this.color, this.workspaceId,
      {super.key});

  @override
  State<MainShowTasksPage> createState() => _MainShowTasksPageState();
}

class _MainShowTasksPageState extends State<MainShowTasksPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TaskCubit>(context).fetchTasks(widget.projectId);
  }

  Map<String, int> tasksTitles = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushScreen(
            context,
            BlocProvider(
              create: (context) => TaskCubit(),
              child: PopScope(
                onPopInvokedWithResult: (didPop, result) {
                  if (didPop && result != null) {
                    BlocProvider.of<TaskCubit>(context)
                        .fetchTasks(widget.projectId);
                  }
                },
                child: CreateTaskPage(
                    widget.projectId, widget.workspaceId, tasksTitles),
              ),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Center(child: MyIcons.icon(Icons.add)),
      ),
      appBar: ShowTasksAppBar.showTasksAppBar(context),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskFetchingSucceededState) {
            if (state.fetchedTasks.isEmpty) {
              return Center(
                child: MyText.text1('No tasks here',
                    textColor: white, fontSize: 22),
              );
            }
            for (var element in state.fetchedTasks) {
              tasksTitles.addAll({element.title: element.id});
            }
            tasksTitles.addAll({'canceled': 0});
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(),
                TaskListViewPage(state.fetchedTasks, widget.color),
              ],
            );
          }
          return Center(child: LoadingIndicator.circularProgressIndicator());
        },
      ),
    );
  }
}
