import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/core/API/projects.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/data/models/projects/add_member_to_project.dart';
import 'package:pr1/data/models/projects/change_user_role_model.dart';
import 'package:pr1/data/models/projects/create_project_model.dart';
import 'package:pr1/data/models/projects/delete_project_model.dart';
import 'package:pr1/data/models/projects/fetch_projects_model.dart';
import 'package:pr1/data/models/projects/retrieve_project_model.dart';

part 'projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit() : super(ProjectsInitial());
  bool projectsAreOpened = false;
  int? selectedWorkspaceId;

  Map<String, int> assignees = {};

  bool checkOwnerOrEditor() {
    List<int> ownerAndEditorIds = [];
    return true;
  }

  Future<void> fetchProjects(int workspaceId) async {
    emit(ProjectsFetchingState());

    List<FetchProjectsModel> projects =
        await ProjectsApi.fetchProjects(workspaceId, token);
    if (projects.isEmpty || projects[0].errorMessage.isEmpty) {
      emit(ProjectsFetchingSucceededState(projects));
    } else {
      emit(ProjectsFetchingFailedState(projects[0].errorMessage));
    }
  }

  Future<void> createProject(
      String title, int workspaceId, Color color, int? parentId) async {
    if (title.isEmpty) return;

    emit(ProjectCreatingState());

    final String colorHex = '#${color.value.toRadixString(16).substring(2)}';

    CreateProjectModel createProjectModel = await ProjectsApi.createProject(
        title, workspaceId, colorHex, parentId, token);
    if (createProjectModel.errorMessage.isEmpty) {
      emit(ProjectCreatingSucceededState(createProjectModel));
    } else {
      emit(ProjectCreatingFailedState(createProjectModel.errorMessage));
    }
  }

  Future<void> retrieveProject(int projectId) async {
    emit(ProjectRetrievingState());

    RetrieveProjectModel retrieveProjectModel =
        await ProjectsApi.retrieveProject(projectId, token);
    if (retrieveProjectModel.errorMessage.isEmpty) {
      emit(ProjectRetrievingSucceededState(retrieveProjectModel));
    } else {
      emit(ProjectRetrievingFailedState(retrieveProjectModel.errorMessage));
    }
  }

  Future<void> addMemberToProject(int projectId, int userId) async {
    emit(AddingMemberToProjectState());

    AddMemberToProjectModel addMemberToProjectModel =
        await ProjectsApi.addMemberToProject(projectId, userId, token);
    if (addMemberToProjectModel.errorMessage.isEmpty) {
      emit(AddingMemberToProjectSucceededState(addMemberToProjectModel));
    } else {
      emit(AddingMemberToProjectFailedState(
          addMemberToProjectModel.errorMessage));
    }
  }

  Future<void> deleteProject(int projectId) async {
    emit(ProjectDeletingState());

    DeleteProjectModel deleteProjectModel =
        await ProjectsApi.deleteProject(projectId, token);
    if (deleteProjectModel.errorMessage.isEmpty) {
      emit(ProjectDeletingSucceededState());
    } else {
      emit(ProjectDeletingFailedState(deleteProjectModel.errorMessage));
    }
  }

  Future<void> changeUserRole(int userId, int projectId, String newRole) async {
    emit(ChangingUserRoleState());

    ChangeUserRoleModel changeUserRoleModel =
        await ProjectsApi.changeUserRole(projectId, newRole, userId, token);
    if (changeUserRoleModel.errorMessage.isEmpty) {
      emit(ChangingUserRoleSucceededState(changeUserRoleModel));
    } else {
      emit(ChangingUserRoleFailedState(changeUserRoleModel.errorMessage));
    }
  }

  void onArrowTap(int id) {
    if (projectsAreOpened) {
      closeArrow();
    } else {
      openArrow(id);
    }
  }

  void openArrow(int id) {
    selectedWorkspaceId = id;
    changeOpenedProjectValue();
    fetchProjects(id);
  }

  void closeArrow() {
    selectedWorkspaceId = null;
    changeOpenedProjectValue();
    emit(ProjectsInitial());
  }

  void changeOpenedProjectValue() {
    projectsAreOpened = !projectsAreOpened;
  }

  bool checkForIconType(int workspaceId) {
    return projectsAreOpened && selectedWorkspaceId == workspaceId;
  }
}
