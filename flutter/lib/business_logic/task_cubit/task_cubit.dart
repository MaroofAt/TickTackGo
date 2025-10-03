import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pr1/core/API/tasks.dart';
import 'package:pr1/core/functions/image_picker.dart';
import 'package:pr1/core/functions/permissions.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/data/models/tasks/cancel_task_model.dart';
import 'package:pr1/data/models/tasks/complete_task_model.dart';
import 'package:pr1/data/models/tasks/create_task_model.dart';
import 'package:pr1/data/models/tasks/fetch_tasks_model.dart';
import 'package:pr1/data/models/tasks/retrieve_task_model.dart';
import 'package:pr1/data/models/tasks/task_model.dart';

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
  DateTime selectedReminderDate = DateTime.now();
  TimeOfDay startTime = const TimeOfDay(hour: 16, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 14, minute: 0);
  bool locked = false;
  String? selectedParent;
  List<int> assignees = [];
  int? parentTask;
  String selectedPriority = 'medium';
  String selectedStatus = 'pending';
  Map<String, int> tasksTitles = {};
  Map<String, int> assigneesMap = {};

  File? image;

  FilePickerResult? result;

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime.now(),
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
      firstDate: selectedStartDate,
      lastDate: DateTime(2025, 12, 31), // Changed to end of 2025
    );
    if (picked != null && picked != selectedEndDate) {
      selectedEndDate = picked;
      emit(TaskInitial());
    }
  }

  Future<void> selectReminderDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedReminderDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025, 12, 31), // Changed to end of 2025
    );
    if (picked != null && picked != selectedReminderDate) {
      selectedReminderDate = picked;
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

  void fillAssigneesList(bool? checked, int item) {
    checked! ? assignees.add(item) : assignees.remove(item);
    emit(TaskInitial());
  }

  Future<void> createTask(String title, String description, int workspaceId,
      int projectId, List<int> assignees, int parentTask) async {
    if (title.isEmpty || description.isEmpty || assignees.isEmpty) return;
    emit(TaskCreatingState());
    List apiFiles = [];

    if (result != null) {
      List<File> files = result!.paths.map((path) => File(path!)).toList();
      for (var element in files) {
        apiFiles.add(
          await MultipartFile.fromFile(
            element.path,
            filename: element.path.split('/').last,
          ),
        );
      }
    }

    String startDate =
        DateFormat('yyyy-M-d').format(selectedStartDate).toString();
    String dueDate = DateFormat('yyyy-M-d').format(selectedEndDate).toString();
    String reminder = DateFormat('yyyy-M-d').format(selectedReminderDate).toString();

    CreateTaskModel createTaskModel = await TaskApi.createTask(
        title: title,
        description: description,
        startDate: startDate,
        dueDate: dueDate,
        reminder: reminder,
        workspaceId: workspaceId,
        projectId: projectId,
        status: selectedStatus,
        priority: selectedPriority,
        locked: locked,
        parentTask: parentTask,
        assignees: assignees,
        image: image,
        files: apiFiles,
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

  Future<void> completeTask(int taskId) async {
    emit(TaskCompletingState());

    CompleteTaskModel completeTaskModel =
        await TaskApi.completeTask(taskId, token);

    if (completeTaskModel.errorMessage.isEmpty) {
      emit(TaskCompletingSucceededState(completeTaskModel));
    } else {
      emit(TaskCompletingFailedState(completeTaskModel.errorMessage));
    }
  }

  Future<void> uploadAttachments() async {
    result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      emit(TaskInitial());
    }
  }

  Future<void> removeFromAttachments(index) async {
    result!.files.removeAt(index);
    emit(TaskInitial());
  }

  TaskModel convertFetchedTaskToTaskModel(int projectId,
      {FetchTasksModel? fetchTaskModel,
      SubTask? subTask,
      List<String>? assignees}) {
    late TaskModel taskModel;
    if (subTask != null) {
      taskModel = TaskModel(
        id: subTask.id,
        title: subTask.title,
        description: subTask.description,
        startDate: subTask.startDate,
        dueDate: subTask.dueDate,
        completeDate: subTask.completeDate,
        image: subTask.image,
        outDated: subTask.outDated,
        projectId: projectId,
        parentTask: 0,
        assignees: assignees ?? [],
        status: subTask.status,
        priority: subTask.priority,
        locked: subTask.locked,
        reminder: subTask.reminder,
        attachments: [],
        subTasks: [],
        statusMessage: '',
        errorMessage: '',
      );
    } else if (fetchTaskModel != null) {
      taskModel = TaskModel(
        id: fetchTaskModel.id,
        title: fetchTaskModel.title,
        description: fetchTaskModel.description,
        startDate: fetchTaskModel.startDate,
        dueDate: fetchTaskModel.dueDate,
        completeDate: fetchTaskModel.completeDate,
        image: fetchTaskModel.image,
        outDated: fetchTaskModel.outDated,
        parentTask: fetchTaskModel.parentTask,
        assignees: fetchTaskModel.assignees,
        projectId: projectId,
        status: fetchTaskModel.status,
        priority: fetchTaskModel.priority,
        locked: fetchTaskModel.locked,
        reminder: fetchTaskModel.reminder,
        subTasks: fetchTaskModel.subTasks,
        statusMessage: fetchTaskModel.statusMessage,
        attachments: fetchTaskModel.attachments,
        errorMessage: fetchTaskModel.errorMessage,
      );
    }
    return taskModel;
  }
}
