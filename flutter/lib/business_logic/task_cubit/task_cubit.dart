import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/core/API/tasks.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/data/models/tasks/cancel_task_model.dart';
import 'package:pr1/data/models/tasks/create_task_model.dart';
import 'package:pr1/data/models/tasks/fetch_tasks_model.dart';
import 'package:pr1/data/models/tasks/retrieve_task_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  Future<void> createTask(
      String title,
      String description,
      String startDate,
      String dueDate,
      int workspaceId,
      int projectId,
      String status,
      String priority,
      bool locked) async {
    emit(TaskCreatingState());

    CreateTaskModel createTaskModel = await TaskApi.createTask(
        title: title,
        description: description,
        startDate: startDate,
        dueDate: dueDate,
        workspaceId: workspaceId,
        projectId: projectId,
        status: status,
        priority: priority,
        locked: locked,
        token: token);

    if (createTaskModel.errorMessage.isEmpty) {
      emit(TaskCreatingSucceededState(createTaskModel));
    } else {
      emit(TaskCreatingFailedState(createTaskModel.errorMessage));
    }
  }

  Future<void> fetchTasks(int projectId) async {
    emit(TaskFetchingState());

    List<FetchTasksModel> fetchedTasks =
        await TaskApi.fetchTasks(projectId, token);

    if (fetchedTasks.isEmpty || fetchedTasks[0].errorMessage.isEmpty) {
      emit(TaskFetchingSucceededState(fetchedTasks));
    } else {
      emit(TaskFetchingFailedState(fetchedTasks[0].errorMessage));
    }
  }

  Future<void> retrieveTask(int taskId) async {
    emit(TaskRetrievingState());

    RetrieveTaskModel retrieveTaskModel =
        await TaskApi.retrieveTask(taskId, token);

    if (retrieveTaskModel.errorMessage.isEmpty) {
      emit(TaskRetrievingSucceededState(retrieveTaskModel));
    } else {
      emit(TaskRetrievingFailedState(retrieveTaskModel.errorMessage));
    }
  }

  Future<void> cancelTask(int taskId) async {
    emit(TaskCancelingState());

    CancelTaskModel cancelTaskModel = await TaskApi.cancelTask(taskId, token);

    if (cancelTaskModel.errorMessage.isEmpty) {
      emit(TaskCancelingSucceededState(cancelTaskModel));
    } else {
      emit(TaskCancelingFailedState(cancelTaskModel.errorMessage));
    }
  }
}
