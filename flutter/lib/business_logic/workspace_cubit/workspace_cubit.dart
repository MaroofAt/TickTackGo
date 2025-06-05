import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pr1/core/functions/image_picker.dart';
import 'package:pr1/core/functions/permissions.dart';

part 'workspace_state.dart';

class WorkspaceCubit extends Cubit<WorkspaceState> {
  WorkspaceCubit() : super(WorkspaceInitial());
  File? image;

  Future<void> getUserImage() async {
    PermissionStatus checkStoragePermissionStatus =
        await checkPermissionStatus(Permission.storage);

    if (checkStoragePermissionStatus.isGranted) {
      image = await pickImage();
    } else if (checkStoragePermissionStatus.isDenied) {
      PermissionStatus storageStatus =
          await requestPermission(Permission.storage);
      getUserImage();
      return;
    } else if (checkStoragePermissionStatus.isPermanentlyDenied) {
      //TODO show alert dialog to alert the user that he permanently denied this permission
    } else {
      //TODO show something went wrong alert dialog
    }

    if (image != null) {
      emit(WorkspaceImagePickedState(image!));
    } else {
      emit(WorkspaceInitial());
    }
  }
}
