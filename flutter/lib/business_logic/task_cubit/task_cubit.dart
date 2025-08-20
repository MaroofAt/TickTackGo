import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pr1/core/API/tasks.dart';
import 'package:pr1/core/functions/image_picker.dart';
import 'package:pr1/core/functions/permissions.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/data/models/tasks/cancel_task_model.dart';
import 'package:pr1/data/models/tasks/create_task_model.dart';
import 'package:pr1/data/models/tasks/fetch_tasks_model.dart';
import 'package:pr1/data/models/tasks/retrieve_task_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  Future<void> getTaskImage() async {
    PermissionStatus checkStoragePermissionStatus =
        await checkPermissionStatus(Permission.storage);

    if (checkStoragePermissionStatus.isGranted) {
      image = await pickImage();
    } else if (checkStoragePermissionStatus.isDenied) {
      PermissionStatus storageStatus =
          await requestPermission(Permission.storage);
      getTaskImage();
      return;
    } else if (checkStoragePermissionStatus.isPermanentlyDenied) {
      emit(PermissionPermanentlyDeniedState());
    } else {
      emit(SomethingWentWrongState());
    }

    if (image != null) {
      emit(TaskImagePickedState(image!));
    } else {
      emit(TaskInitial());
    }
  }

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  TimeOfDay startTime = const TimeOfDay(hour: 16, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 14, minute: 0);
  bool locked = false;
  String? selectedParent;
  int? parentTask;
  String selectedPriority = 'medium';
  String selectedStatus = 'pending';

  File? image;

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025, 12, 31),
    );
    if (picked != null && picked != selectedStartDate) {
      selectedStartDate = picked;
      emit(TaskInitial());
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025, 12, 31), // Changed to end of 2025
    );
    if (picked != null && picked != selectedEndDate) {
      selectedEndDate = picked;
      emit(TaskInitial());
    }
  }

  Future<void> selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (picked != null && picked != startTime) {
      startTime = picked;
      emit(TaskInitial());
    }
  }

  Future<void> selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTime,
    );
    if (picked != null && picked != endTime) {
      endTime = picked;
      emit(TaskInitial());
    }
  }

  void changeSelectedStatus(String newStatus) {
    selectedStatus = newStatus;
    emit(TaskInitial());
  }

  void changeSelectedPriority(String newPriority) {
    selectedPriority = newPriority;
    emit(TaskInitial());
  }

  void changeTaskLocked() {
    locked = !locked;
    emit(TaskInitial());
  }

  Future<void> createTask(String title, String description, int workspaceId, int projectId) async {
    if (title.isEmpty || description.isEmpty) return;
    emit(TaskCreatingState());

    String startDate =
        DateFormat('yyyy-M-d').format(selectedStartDate).toString();
    String dueDate = DateFormat('yyyy-M-d').format(selectedEndDate).toString();

    CreateTaskModel createTaskModel = await TaskApi.createTask(
        title: title,
        description: description,
        startDate: startDate,
        dueDate: dueDate,
        workspaceId: workspaceId,
        projectId: projectId,
        status: selectedStatus,
        priority: selectedPriority,
        locked: locked,
        parentTask: parentTask,
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
