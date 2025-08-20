import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pr1/core/API/inbox.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/data/models/inbox/create_inbox_task_model.dart';
import 'package:pr1/data/models/inbox/destroy_inbox_task_model.dart';
import 'package:pr1/data/models/inbox/inbox_tasks_model.dart';
import 'package:pr1/data/models/inbox/retrieve_inbox_task_model.dart';

part 'inbox_state.dart';

class InboxCubit extends Cubit<InboxState> {
  InboxCubit() : super(InboxInitial());

  String selectedPriority = 'medium';
  String selectedStatus = 'pending';
  String titleErrorMessage = '';
  final Map<String, String> statuses = {
    'pending': 'pending',
    'in progress': 'in_progress',
    'completed': 'completed',
  };


  Future<void> createInboxTask(String title, String description) async {
    if (title.isEmpty || description.isEmpty) return;

    emit(InboxCreatingState());

    CreateInboxTaskModel createInboxTaskModel = await InboxApi.createInboxTask(
        title, description, selectedPriority, statuses[selectedStatus]!, token);
    if (createInboxTaskModel.errorMessage.isEmpty) {
      emit(InboxCreatingSucceededState(createInboxTaskModel));
    } else {
      emit(InboxCreatingFailedState(createInboxTaskModel.errorMessage));
    }
  }

  Future<List<List<InboxTasksModel>>> fetchInboxTask() async {
    emit(InboxFetchingTasksState());

    List<InboxTasksModel> inboxTasksList =
        await InboxApi.fetchInboxTasks(token);
    List<List<InboxTasksModel>> allInboxTasks =
        filterInboxTasks(inboxTasksList);
    if (inboxTasksList.isEmpty || inboxTasksList[0].errorMessage.isEmpty) {
      emit(InboxFetchingTasksSucceededState(allInboxTasks));
    } else {
      emit(InboxFetchingTasksFailedState(inboxTasksList[0].errorMessage));
    }
    return allInboxTasks;
  }

  Future<void> retrieveInboxTask(int taskId) async {
    emit(RetrieveInboxTaskState());

    RetrieveInboxTaskModel retrieveInboxTaskModel =
        await InboxApi.retrieveInboxTask(taskId, token);
    if (retrieveInboxTaskModel.errorMessage.isEmpty) {
      emit(RetrieveInboxTaskSucceededState(retrieveInboxTaskModel));
    } else {
      emit(RetrieveInboxTaskFailedState(retrieveInboxTaskModel.errorMessage));
    }
  }

  Future<void> updateInboxTask(
    int taskId,
    InboxTasksModel inboxTasksModel, {
    required String title,
    required String description,
    String? priority,
    String? status,
  }) async {
    emit(InboxTaskUpdatingState());

    RetrieveInboxTaskModel retrieveInboxTaskModel =
        await InboxApi.updateInboxTask(
      taskId,
      token,
      title: title.isNotEmpty ? title : inboxTasksModel.title,
      description:
          description.isNotEmpty ? description : inboxTasksModel.description,
      priority: priority ?? inboxTasksModel.priority,
      status: status ?? inboxTasksModel.status,
    );

    InboxTasksModel inboxTasksModelNew = InboxTasksModel(
      id: retrieveInboxTaskModel.id,
      title: retrieveInboxTaskModel.title,
      description: retrieveInboxTaskModel.description,
      user: retrieveInboxTaskModel.user,
      status: retrieveInboxTaskModel.status,
      priority: retrieveInboxTaskModel.priority,
      errorMessage: retrieveInboxTaskModel.errorMessage,
    );

    if (retrieveInboxTaskModel.errorMessage.isEmpty) {
      emit(InboxTaskUpdatingSucceededState(inboxTasksModelNew));
    } else {
      emit(InboxTaskUpdatingFailedState(retrieveInboxTaskModel.errorMessage));
    }
  }

  Future<void> destroyInboxTask(int taskId) async {
    emit(InboxTaskDestroyingState());

    DestroyInboxTaskModel destroyInboxTaskModel =
        await InboxApi.destroyTaskModel(taskId, token);
    if (destroyInboxTaskModel.errorMessage.isEmpty) {
      emit(InboxTaskDestroyingSucceededState(destroyInboxTaskModel));
    } else {
      emit(InboxTaskDestroyingFailedState(destroyInboxTaskModel.errorMessage));
    }
  }

  List<List<InboxTasksModel>> filterInboxTasks(
      List<InboxTasksModel> inboxTasks) {
    List<InboxTasksModel> pendingTasks = [];
    List<InboxTasksModel> inProgressTasks = [];
    List<InboxTasksModel> completedTasks = [];
    for (InboxTasksModel item in inboxTasks) {
      if (item.status == 'pending') {
        pendingTasks.add(item);
      } else if (item.status == 'in_progress') {
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

  void changePriorityInCreateTask(String newValue) {
    selectedPriority = newValue;
    emit(InboxInitial());
  }

  void changeStatusInCreateTask(String newValue) {
    selectedStatus = newValue;
    emit(InboxInitial());
  }
}
