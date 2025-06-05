part of 'workspace_cubit.dart';

@immutable
sealed class WorkspaceState {}

final class WorkspaceInitial extends WorkspaceState {}

class WorkSpaceImageIsPickingState extends WorkspaceState {}

class WorkspaceImagePickedState extends WorkspaceState {
  File image;

  WorkspaceImagePickedState(this.image);
}





