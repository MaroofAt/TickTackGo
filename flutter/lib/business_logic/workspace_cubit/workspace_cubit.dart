import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pr1/core/API/workspace.dart';
import 'package:pr1/core/functions/image_picker.dart';
import 'package:pr1/core/functions/permissions.dart';
import 'package:pr1/data/models/workspace/create_workspace_model.dart';
import 'package:pr1/data/models/workspace/get_workspace_model.dart';
import 'package:pr1/data/models/workspace/get_workspaces_model.dart';

part 'workspace_state.dart';

class WorkspaceCubit extends Cubit<WorkspaceState> {
  WorkspaceCubit() : super(WorkspaceInitial());
  File? image;

  Future<void> getWorkspaceImage() async {
    PermissionStatus checkStoragePermissionStatus =
        await checkPermissionStatus(Permission.storage);

    if (checkStoragePermissionStatus.isGranted) {
      image = await pickImage();
    } else if (checkStoragePermissionStatus.isDenied) {
      PermissionStatus storageStatus =
          await requestPermission(Permission.storage);
      getWorkspaceImage();
      return;
    } else if (checkStoragePermissionStatus.isPermanentlyDenied) {
      emit(PermissionPermanentlyDeniedState());
    } else {
      emit(SomethingWentWrongState());
    }

    if (image != null) {
      emit(WorkspaceImagePickedState(image!));
    } else {
      emit(WorkspaceInitial());
    }
  }

  Future<void> createWorkSpace(String title, String description) async {
    emit(CreatingWorkspaceState());
    //TODO send user token
    CreateWorkspaceModel createWorkspaceModel =
        await WorkspaceApi.createWorkspace(title, description, '');
    if (createWorkspaceModel.errorMessage.isEmpty) {
      emit(CreatedWorkspaceState(createWorkspaceModel));
    } else {
      emit(CreateWorkspaceFailedState(createWorkspaceModel.errorMessage));
    }
  }

  Future<void> fetchWorkspaces() async {
    emit(WorkspacesFetchingState());
    List<FetchWorkspacesModel> fetchWorkspacesModel = await WorkspaceApi.fetchWorkspaces();

    if (fetchWorkspacesModel[0].errorMessage.isEmpty) {
      emit(WorkspacesFetchingSucceededState(fetchWorkspacesModel));
    } else {
      emit(WorkspacesFetchingFailedState(fetchWorkspacesModel[0].errorMessage));
    }
  }

  Future<void> fetchWorkspace(int workspaceId) async {
    emit(WorkspaceRetrievingState());

    RetrieveWorkspace retrieveWorkspace =
        await WorkspaceApi.retrieveWorkspace(workspaceId);

    if (retrieveWorkspace.errorMessage.isEmpty) {
      emit(WorkspaceRetrievingSucceededState(retrieveWorkspace));
    } else {
      emit(WorkspaceRetrievingFailedState(retrieveWorkspace.errorMessage));
    }
  }
}
