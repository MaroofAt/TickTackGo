import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/task_cubit/task_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/presentation/screen/tasks/show_tasks_app_bar.dart';
import 'package:pr1/presentation/screen/tasks/task_list_view_page.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class MainShowTasksPage extends StatefulWidget {
  final int projectId;
  final Color color;
  const MainShowTasksPage(this.projectId, this.color, {super.key});

  @override
  State<MainShowTasksPage> createState() => _MainShowTasksPageState();
}

class _MainShowTasksPageState extends State<MainShowTasksPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TaskCubit>(context).fetchTasks(widget.projectId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
