// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_cubit.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

class TaskImageIsPickingState extends TaskState {}

class TaskImagePickedState extends TaskState {
  File image;

  TaskImagePickedState(this.image);
}

class PermissionPermanentlyDeniedState extends TaskState {}

class SomethingWentWrongState extends TaskState {}


class TaskCreatingState extends TaskState {}

class TaskCreatingSucceededState extends TaskState {
  CreateTaskModel createTaskModel;
  TaskCreatingSucceededState(this.createTaskModel);
}

class TaskCreatingFailedState extends TaskState {
  String errorMessage;
  TaskCreatingFailedState(this.errorMessage);
}

class TaskFetchingState extends TaskState {}

class TaskFetchingSucceededState extends TaskState {
  List<FetchTasksModel> fetchedTasks;
  TaskFetchingSucceededState(this.fetchedTasks);
}

class TaskFetchingFailedState extends TaskState {
  String errorMessage;
  TaskFetchingFailedState(this.errorMessage);
}

class TaskRetrievingState extends TaskState {}

class TaskRetrievingSucceededState extends TaskState {
  RetrieveTaskModel retrieveTaskModel;
  TaskRetrievingSucceededState(this.retrieveTaskModel);
}

class TaskRetrievingFailedState extends TaskState {
  String errorMessage;
  TaskRetrievingFailedState(this.errorMessage);
}

class TaskCancelingState extends TaskState {}

class TaskCancelingSucceededState extends TaskState {
  CancelTaskModel cancelTaskModel;
  TaskCancelingSucceededState(this.cancelTaskModel);
}

class TaskCancelingFailedState extends TaskState {
  String errorMessage;
  TaskCancelingFailedState(this.errorMessage);
}

class TaskCompletingState extends TaskState {}

class TaskCompletingSucceededState extends TaskState {
  CompleteTaskModel completeTaskModel;

  TaskCompletingSucceededState(this.completeTaskModel);
}

class TaskCompletingFailedState extends TaskState {
  String errorMessage;

  TaskCompletingFailedState(this.errorMessage);
}

class TaskAssigningState extends TaskState {}
