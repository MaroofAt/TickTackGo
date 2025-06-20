import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pr1/core/API/inbox.dart';
import 'package:pr1/core/constance/enums.dart';
import 'package:pr1/data/models/inbox/create_inbox_task_model.dart';
import 'package:pr1/data/models/inbox/destroy_inbox_task_model.dart';
import 'package:pr1/data/models/inbox/inbox_tasks_model.dart';
import 'package:pr1/data/models/inbox/retrieve_inbox_task_model.dart';

part 'inbox_state.dart';

class InboxCubit extends Cubit<InboxState> {
  InboxCubit() : super(InboxInitial());

  Future<void> createInboxTask(String title, String description, String priority) async {
    emit(InboxCreatingState());

    CreateInboxTaskModel createInboxTaskModel =
        await InboxApi.createInboxTask(title, description, priority);
    if (createInboxTaskModel.errorMessage.isEmpty) {
      emit(InboxCreatingSucceededState(createInboxTaskModel));
    } else {
      emit(InboxCreatingFailedState(createInboxTaskModel.errorMessage));
    }
  }

  Future<void> fetchInboxTask() async {
    emit(InboxFetchingTasksState());

    List<InboxTasksModel> inboxTasksList = await InboxApi.fetchInboxTasks();
    if (inboxTasksList[0].errorMessage.isEmpty) {
      List<List<InboxTasksModel>> allInboxTasks =
          filterInboxTasks(inboxTasksList);
      emit(InboxFetchingTasksSucceededState(allInboxTasks));
    } else {
      emit(InboxFetchingTasksFailedState(inboxTasksList[0].errorMessage));
    }
  }

  Future<void> retrieveInboxTask(int taskId) async {
    emit(RetrieveInboxTaskState());

    RetrieveInboxTaskModel retrieveInboxTaskModel =
        await InboxApi.retrieveInboxTask(taskId);
    if (retrieveInboxTaskModel.errorMessage.isEmpty) {
      emit(RetrieveInboxTaskSucceededState(retrieveInboxTaskModel));
    } else {
      emit(RetrieveInboxTaskFailedState(retrieveInboxTaskModel.errorMessage));
    }
  }

  Future<void> updateInboxTask(
    int taskId,
    RetrieveInboxTaskModel oldRetrieveInboxTaskModel, {
    String? title,
    String? description,
    String? priority,
    String? status,
  }) async {
    emit(InboxTaskUpdatingState());

    RetrieveInboxTaskModel retrieveInboxTaskModel =
        await InboxApi.updateInboxTask(
      taskId,
      title: title ?? oldRetrieveInboxTaskModel.title,
      description: description ?? oldRetrieveInboxTaskModel.description,
      priority: priority ?? oldRetrieveInboxTaskModel.priority,
      status: status ?? oldRetrieveInboxTaskModel.status,
    );

    if (retrieveInboxTaskModel.errorMessage.isEmpty) {
      emit(InboxTaskUpdatingSucceededState(retrieveInboxTaskModel));
    } else {
      emit(InboxTaskUpdatingFailedState(retrieveInboxTaskModel.errorMessage));
    }
  }

  Future<void> destroyInboxTask(int taskId) async {
    emit(InboxTaskDestroyingState());

    DestroyInboxTaskModel destroyInboxTaskModel =
        await InboxApi.destroyTaskModel(taskId);
    if (destroyInboxTaskModel.errorMessage.isEmpty) {
      emit(InboxTaskDestroyingSucceededState(destroyInboxTaskModel));
    } else {
      emit(InboxTaskDestroyingFailedState(destroyInboxTaskModel.errorMessage));
    }
  }

  List<List<InboxTasksModel>> filterInboxTasks(List<InboxTasksModel> inboxTasks) {
    List<InboxTasksModel> pendingTasks = [];
    List<InboxTasksModel> inProgressTasks = [];
    List<InboxTasksModel> completedTasks = [];
    for (InboxTasksModel item in inboxTasks) {
      if (item.status == TaskStatus.pending.name.toString()) {
        pendingTasks.add(item);
      } else if (item.status == TaskStatus.in_progress.name.toString()) {
        inProgressTasks.add(item);
      } else {
        completedTasks.add(item);
      }
    }
    List<List<InboxTasksModel>> allTasks = [
      pendingTasks,
      inProgressTasks,
      completedTasks
    ];
    return allTasks;
  }

}
