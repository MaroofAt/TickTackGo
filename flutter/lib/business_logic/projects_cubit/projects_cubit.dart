import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/core/API/projects.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/data/models/projects/add_member_to_project.dart';
import 'package:pr1/data/models/projects/create_project_model.dart';
import 'package:pr1/data/models/projects/delete_project_model.dart';
import 'package:pr1/data/models/projects/fetch_projects_model.dart';
import 'package:pr1/data/models/projects/retrieve_project_model.dart';

part 'projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit() : super(ProjectsInitial());

  Future<void> fetchProjects(int projectId) async {
    emit(ProjectsFetchingState());

    List<FetchProjectsModel> projects =
        await ProjectsApi.fetchProjects(projectId, token);
    if (projects[0].errorMessage.isEmpty) {
      emit(ProjectsFetchingSucceededState(projects));
    } else {
      emit(ProjectsFetchingFailedState(projects[0].errorMessage));
    }
  }

  Future<void> createProject(
      String title, int workspaceId, String color) async {
    emit(ProjectCreatingState());

    CreateProjectModel createProjectModel =
        await ProjectsApi.createProject(title, workspaceId, color, token);
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
}
