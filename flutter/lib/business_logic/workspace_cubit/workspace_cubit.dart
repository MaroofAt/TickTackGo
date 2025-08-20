import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pr1/core/API/workspace.dart';
import 'package:pr1/core/functions/image_picker.dart';
import 'package:pr1/core/functions/permissions.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/data/models/workspace/create_workspace_model.dart';
import 'package:pr1/data/models/workspace/delete_workspace_model.dart';
import 'package:pr1/data/models/workspace/get_workspace_model.dart';
import 'package:pr1/data/models/workspace/fetch_workspaces_model.dart';
import 'package:pr1/data/models/workspace/kick_member_from_workspace.dart';
import 'package:pr1/data/models/workspace/sent_invites_model.dart';

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
    if (title.isEmpty || description.isEmpty) return;
    emit(CreatingWorkspaceState());
    CreateWorkspaceModel createWorkspaceModel =
        await WorkspaceApi.createWorkspace(title, description, image, token);
    if (createWorkspaceModel.errorMessage.isEmpty) {
      emit(CreatedWorkspaceState(createWorkspaceModel));
      fetchWorkspaces();
    } else {
      emit(CreateWorkspaceFailedState(createWorkspaceModel.errorMessage));
    }
  }

  Future<void> fetchWorkspaces() async {
    emit(WorkspacesFetchingState());
    List<FetchWorkspacesModel> fetchWorkspacesModel =
        await WorkspaceApi.fetchWorkspaces(token);
    if (fetchWorkspacesModel.isEmpty ||
        fetchWorkspacesModel[0].errorMessage.isEmpty) {
      emit(WorkspacesFetchingSucceededState(fetchWorkspacesModel));
    } else {
      if (fetchWorkspacesModel[0].statusCode == 401) {
        emit(RefreshTokenState());
      } else {
        emit(WorkspacesFetchingFailedState(
            fetchWorkspacesModel[0].errorMessage));
      }
    }
  }

  Future<void> retrieveWorkspace(int workspaceId) async {
    emit(WorkspaceRetrievingState());

    RetrieveWorkspaceModel retrieveWorkspace =
        await WorkspaceApi.retrieveWorkspace(workspaceId, token);

    if (retrieveWorkspace.errorMessage.isEmpty) {
      emit(WorkspaceRetrievingSucceededState(retrieveWorkspace));
    } else {
      emit(WorkspaceRetrievingFailedState(retrieveWorkspace.errorMessage));
    }
  }

  Future<void> deleteWorkspace(int workspaceId) async {
    emit(DeletingWorkspaceState());
    DeleteWorkspaceModel deleteWorkspaceModel =
        await WorkspaceApi.deleteWorkspace(workspaceId, token);
    if (deleteWorkspaceModel.errorMessage.isEmpty) {
      emit(DeletingWorkspaceSucceededState(deleteWorkspaceModel));
    } else {
      emit(DeletingWorkspaceFailedState(deleteWorkspaceModel.errorMessage));
    }
  }

  Future<void> kickMember(int workspaceId, int memberId) async {
    emit(KickingMemberFromWorkspaceState());

    KickMemberFromWorkspaceModel kickMemberFromWorkspaceModel =
        await WorkspaceApi.kickMember(workspaceId, memberId, token);

    if (kickMemberFromWorkspaceModel.errorMessage.isEmpty) {
      emit(KickingMemberFromWorkspaceSucceededState(
          kickMemberFromWorkspaceModel));
      retrieveWorkspace(workspaceId);
    } else {
      emit(KickingMemberFromWorkspaceFailedState(
          kickMemberFromWorkspaceModel.errorMessage));
    }
  }

  Future<void> sentInvites(int workspaceId) async {
    emit(SentInvitesRetrievingState());

    SentInvitesModel sentInvitesModel =
        await WorkspaceApi.sentInvites(workspaceId, token);

    if (sentInvitesModel.errorMessage.isEmpty) {
      emit(SentInvitesRetrievingSucceededState(sentInvitesModel));
    } else {
      emit(SentInvitesRetrievingFailedState(sentInvitesModel.errorMessage));
    }
  }
}
