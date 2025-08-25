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

//create workspace states
class CreatingWorkspaceState extends WorkspaceState {}

class CreatedWorkspaceState extends WorkspaceState {
  CreateWorkspaceModel createWorkspaceModel;

  CreatedWorkspaceState(this.createWorkspaceModel);
}

class CreateWorkspaceFailedState extends WorkspaceState {
  String errorMessage;

  CreateWorkspaceFailedState(this.errorMessage);
}

//fetch workspaces states
class WorkspacesFetchingState extends WorkspaceState {}

class WorkspacesFetchingSucceededState extends WorkspaceState {
  List<FetchWorkspacesModel> fetchWorkspacesModel;

  WorkspacesFetchingSucceededState(this.fetchWorkspacesModel);
}

class WorkspacesFetchingFailedState extends WorkspaceState {
  String errorMessage;

  WorkspacesFetchingFailedState(this.errorMessage);
}

//retrieve workspace states
class WorkspaceRetrievingState extends WorkspaceState {}

class WorkspaceRetrievingSucceededState extends WorkspaceState{
  RetrieveWorkspaceModel retrieveWorkspace;

  WorkspaceRetrievingSucceededState(this.retrieveWorkspace);
}

class WorkspaceRetrievingFailedState extends WorkspaceState {
  String errorMessage;

  WorkspaceRetrievingFailedState(this.errorMessage);
}

class RefreshTokenState extends WorkspaceState {}

class DeletingWorkspaceState extends WorkspaceState {}

class DeletingWorkspaceSucceededState extends WorkspaceState {
  DeleteWorkspaceModel deleteWorkspaceModel;

  DeletingWorkspaceSucceededState(this.deleteWorkspaceModel);
}

class DeletingWorkspaceFailedState extends WorkspaceState {
  String errorMessage;

  DeletingWorkspaceFailedState(this.errorMessage);
}

class KickingMemberFromWorkspaceState extends WorkspaceState {}

class KickingMemberFromWorkspaceSucceededState extends WorkspaceState {
  KickMemberFromWorkspaceModel kickMemberFromWorkspaceModel;

  KickingMemberFromWorkspaceSucceededState(this.kickMemberFromWorkspaceModel);
}

class KickingMemberFromWorkspaceFailedState extends WorkspaceState {
  String errorMessage;

  KickingMemberFromWorkspaceFailedState(this.errorMessage);
}

class SentInvitesRetrievingState extends WorkspaceState {}

class SentInvitesRetrievingSucceededState extends WorkspaceState {
  List<SentInvitesModel> sentInvitesModel;

  SentInvitesRetrievingSucceededState(this.sentInvitesModel);
}

class SentInvitesRetrievingFailedState extends WorkspaceState {
  String errorMessage;

  SentInvitesRetrievingFailedState(this.errorMessage);
}

class InviteCancelingState extends WorkspaceState {}

class InviteCancelingSucceededState extends WorkspaceState {
  CancelInviteModel cancelInviteModel;

  InviteCancelingSucceededState(this.cancelInviteModel);
}

class InviteCancelingFailedState extends WorkspaceState {
  String errorMessage;

  InviteCancelingFailedState(this.errorMessage);
}
