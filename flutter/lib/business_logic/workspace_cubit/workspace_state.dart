part of 'workspace_cubit.dart';

@immutable
sealed class WorkspaceState {}

final class WorkspaceInitial extends WorkspaceState {}

class WorkSpaceImageIsPickingState extends WorkspaceState {}

class WorkspaceImagePickedState extends WorkspaceState {
  File image;

  WorkspaceImagePickedState(this.image);
}

class PermissionPermanentlyDeniedState extends WorkspaceState {}

class SomethingWentWrongState extends WorkspaceState {}

class CreatingWorkspaceState extends WorkspaceState {}

class CreatedWorkspaceState extends WorkspaceState {
  CreateWorkspaceModel createWorkspaceModel;

  CreatedWorkspaceState(this.createWorkspaceModel);
}

class CreateWorkspaceFailedState extends WorkspaceState {
  String errorMessage;

  CreateWorkspaceFailedState(this.errorMessage);
}

class WorkspacesFetchingState extends WorkspaceState {}

class WorkspacesFetchingSucceededState extends WorkspaceState {
  List<dynamic> fetchWorkspacesModel;

  WorkspacesFetchingSucceededState(this.fetchWorkspacesModel);
}

class WorkspacesFetchingFailedState extends WorkspaceState {
  String errorMessage;

  WorkspacesFetchingFailedState(this.errorMessage);
}



