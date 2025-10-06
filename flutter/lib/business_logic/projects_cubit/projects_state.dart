part of 'projects_cubit.dart';

@immutable
sealed class ProjectsState {}

final class ProjectsInitial extends ProjectsState {}

class ProjectsFetchingState extends ProjectsState {}

class ProjectsFetchingSucceededState extends ProjectsState {
  List<FetchProjectsModel> projects;

  ProjectsFetchingSucceededState(this.projects);
}

class ProjectsFetchingFailedState extends ProjectsState {
  String errorMessage;

  ProjectsFetchingFailedState(this.errorMessage);
}

class ProjectCreatingState extends ProjectsState {}

class ProjectCreatingSucceededState extends ProjectsState {
  CreateProjectModel createProjectModel;

  ProjectCreatingSucceededState(this.createProjectModel);
}

class ProjectCreatingFailedState extends ProjectsState {
  String errorMessage;

  ProjectCreatingFailedState(this.errorMessage);
}

class ProjectRetrievingState extends ProjectsState {}

class ProjectRetrievingSucceededState extends ProjectsState {
  RetrieveProjectModel retrieveProjectModel;

  ProjectRetrievingSucceededState(this.retrieveProjectModel);
}

class ProjectRetrievingFailedState extends ProjectsState {
  String errorMessage;

  ProjectRetrievingFailedState(this.errorMessage);
}

class AddingMemberToProjectState extends ProjectsState {}

class AddingMemberToProjectSucceededState extends ProjectsState {
  AddMemberToProjectModel addMemberToProjectModel;

  AddingMemberToProjectSucceededState(this.addMemberToProjectModel);
}

class AddingMemberToProjectFailedState extends ProjectsState {
  String errorMessage;

  AddingMemberToProjectFailedState(this.errorMessage);
}

class ProjectDeletingState extends ProjectsState {}

class ProjectDeletingSucceededState extends ProjectsState {}

class ProjectDeletingFailedState extends ProjectsState {
  String errorMessage;

  ProjectDeletingFailedState(this.errorMessage);
}

class ChangingUserRoleState extends ProjectsState {}

class ChangingUserRoleSucceededState extends ProjectsState {
  ChangeUserRoleModel changeUserRoleModel;

  ChangingUserRoleSucceededState(this.changeUserRoleModel);
}

class ChangingUserRoleFailedState extends ProjectsState {
  String errorMessage;

  ChangingUserRoleFailedState(this.errorMessage);
}

class ArchivingProjectState extends ProjectsState {}

class ArchivingProjectSucceededState extends ProjectsState {
  ArchiveProjectModel archiveProjectModel;

  ArchivingProjectSucceededState(this.archiveProjectModel);
}

class ArchivingProjectFailedState extends ProjectsState {
  String errorMessage;

  ArchivingProjectFailedState(this.errorMessage);
}
