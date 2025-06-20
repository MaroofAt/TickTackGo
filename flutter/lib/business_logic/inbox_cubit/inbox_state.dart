part of 'inbox_cubit.dart';

@immutable
sealed class InboxState {}

final class InboxInitial extends InboxState {}

//create inbox task
class InboxCreatingState extends InboxState {}
class InboxCreatingSucceededState extends InboxState {
  CreateInboxTaskModel createInboxTaskModel;

  InboxCreatingSucceededState(this.createInboxTaskModel);
}
class InboxCreatingFailedState extends InboxState {
  String errorMessage;

  InboxCreatingFailedState(this.errorMessage);
}

//list inbox tasks
class InboxFetchingTasksState extends InboxState {}
class InboxFetchingTasksSucceededState extends InboxState {
  List<InboxTasksModel> inboxTasksModelList;

  InboxFetchingTasksSucceededState(this.inboxTasksModelList);
}
class InboxFetchingTasksFailedState extends InboxState {
  String errorMessage;

  InboxFetchingTasksFailedState(this.errorMessage);
}

//retrieve inbox task
class RetrieveInboxTaskState extends InboxState {}
class RetrieveInboxTaskSucceededState extends InboxState {
  RetrieveInboxTaskModel retrieveInboxTaskModel;

  RetrieveInboxTaskSucceededState(this.retrieveInboxTaskModel);
}
class RetrieveInboxTaskFailedState extends InboxState {
  String errorMessage;

  RetrieveInboxTaskFailedState(this.errorMessage);
}

//update inbox task
class InboxTaskUpdatingState extends InboxState {}
class InboxTaskUpdatingSucceededState extends InboxState {
  RetrieveInboxTaskModel retrieveInboxTaskModel;

  InboxTaskUpdatingSucceededState(this.retrieveInboxTaskModel);
}
class InboxTaskUpdatingFailedState extends InboxState {
  String errorMessage;

  InboxTaskUpdatingFailedState(this.errorMessage);
}

//destroy inbox task
class InboxTaskDestroyingState extends InboxState {}
class InboxTaskDestroyingSucceededState extends InboxState {
  DestroyInboxTaskModel destroyInboxTaskModel;

  InboxTaskDestroyingSucceededState(this.destroyInboxTaskModel);
}
class InboxTaskDestroyingFailedState extends InboxState {
  String errorMessage;

  InboxTaskDestroyingFailedState(this.errorMessage);
}
