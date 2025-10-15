import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/business_logic/task_cubit/task_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/core/functions/show_snack_bar.dart';
import 'package:pr1/core/functions/user_functions.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/data/models/projects/retrieve_project_model.dart';
import 'package:pr1/data/models/tasks/task_model.dart';
import 'package:pr1/presentation/screen/tasks/create_task_floating_button.dart';
import 'package:pr1/presentation/screen/tasks/show_tasks_app_bar.dart';
import 'package:pr1/presentation/screen/tasks/task_list_view_page.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class MainShowTasksPage extends StatefulWidget {
  final int projectId;
  final int workspaceId;
  final Color color;

  const MainShowTasksPage(
      {required this.projectId,
      required this.workspaceId,
      required this.color,
      super.key});

  @override
  State<MainShowTasksPage> createState() => _MainShowTasksPageState();
}

class _MainShowTasksPageState extends State<MainShowTasksPage> {
  @override
  void initState() {
    super.initState();
    _getNeededData();
    setState(() {});
  }

  _getNeededData() {
    BlocProvider.of<ProjectsCubit>(context).retrieveProject(widget.projectId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsCubit, ProjectsState>(
      builder: (context, state) {
        if (state is ProjectRetrievingSucceededState) {
          BlocProvider.of<ProjectsCubit>(context)
              .setAssignees(state.retrieveProjectModel);
          BlocProvider.of<TaskCubit>(context).fetchTasks(widget.projectId);
          List<int> editors = [];
          for (var element in state.retrieveProjectModel.members) {
            if (element.role == 'editor') {
              editors.add(element.member.id);
            }
          }
          return buildTaskList(context, state.retrieveProjectModel, editors);
        }
        return Scaffold(
          body: Center(
            child: LoadingIndicator.circularProgressIndicator(),
          ),
        );
      },
    );
  }

  Scaffold buildTaskList(BuildContext context,
      RetrieveProjectModel retrieveProjectModel, List<int> editors) {
    return Scaffold(
      floatingActionButton:
          isAdmin(retrieveProjectModel.members[0].member.id) ||
                  editors.contains(user!.id)
              ? CreateTaskFloatingButton(widget.projectId, widget.workspaceId)
              : null,
      appBar:
          ShowTasksAppBar.showTasksAppBar(context, retrieveProjectModel.title),
      body: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {
          if (state is TaskFetchingFailedState) {
            BlocProvider.of<TaskCubit>(context).close();
            showSnackBar(
              context,
              state.errorMessage,
              backgroundColor: Colors.red,
              seconds: 1,
            );
            popScreen(context);
          }
        },
        builder: (context, state) {
          if (state is TaskFetchingSucceededState) {
            if (state.fetchedTasks.isEmpty) {
              return Center(
                child: MyText.text1('No tasks here',
                    textColor: white, fontSize: 22),
              );
            }
            List<TaskModel> tasks = [];
            for (var element in state.fetchedTasks) {
              if (element.status != 'completed') {
                BlocProvider.of<TaskCubit>(context)
                    .tasksTitles
                    .addAll({element.title: element.id});
              }
              tasks.add(BlocProvider.of<TaskCubit>(context)
                  .convertFetchedTaskToTaskModel(element.project,
                      fetchTaskModel: element));
            }
            BlocProvider.of<TaskCubit>(context)
                .tasksTitles
                .addAll({'canceled': 0});
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(),
                TaskListViewPage(tasks, widget.color),
              ],
            );
          }
          return Center(child: LoadingIndicator.circularProgressIndicator());
        },
      ),
    );
  }
}
