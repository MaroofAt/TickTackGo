import 'dart:io';

import 'package:pr1/core/functions/api_error_handling.dart';
import 'package:pr1/core/variables/api_variables.dart';
import 'package:pr1/data/local_data/local_data.dart';
import 'package:pr1/data/models/workspace/create_workspace_model.dart';
import 'package:dio/dio.dart';
import 'package:pr1/data/models/workspace/delete_workspace_model.dart';
import 'package:pr1/data/models/workspace/fetch_workspaces_model.dart';
import 'package:pr1/data/models/workspace/get_workspace_model.dart';

class WorkspaceApi {
  static Future<CreateWorkspaceModel> createWorkspace(
      String title, String description, File? image, String token) async {
    Map<String, String> headers;
    Object data;

    if (image == null) {
      headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

      data = {
        'title': title,
        'description': description,
      };
    } else {
      headers = {'Authorization': 'Bearer $token'};

      data = FormData.fromMap({
        'title': title,
        'description': description,
        'image': await MultipartFile.fromFile(
          image.path,
          filename: '$title.jpg',
        ),
      });
    }

    late CreateWorkspaceModel createWorkspaceModel;
    try {
      var response = await dio.request(
        '/workspaces/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        createWorkspaceModel = CreateWorkspaceModel.onSuccess(response.data);
      } else {
        createWorkspaceModel = CreateWorkspaceModel.onError(response.data);
      }
    } on DioException catch (e) {
      print(e.toString());
      createWorkspaceModel = CreateWorkspaceModel.error(handleDioError(e));
    }
    return createWorkspaceModel;
  }

  static Future<List<FetchWorkspacesModel>> fetchWorkspaces(
      String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    late List<FetchWorkspacesModel> getWorkspacesModel;

    try {
      var response = await dio.request(
        '/workspaces/',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        getWorkspacesModel = data
            .map((json) =>
                FetchWorkspacesModel.onSuccess(json, response.statusCode!))
            .toList();
      } else {
        getWorkspacesModel = [
          FetchWorkspacesModel.onError(response.data, response.statusCode!)
        ];
      }
    } on DioException catch (e) {
      getWorkspacesModel = [
        FetchWorkspacesModel.error(handleDioError(e), e.response!.statusCode!)
      ];
    }
    return getWorkspacesModel;
  }

  static Future<RetrieveWorkspaceModel> retrieveWorkspace(
      int workspaceId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    late RetrieveWorkspaceModel retrieveWorkspace;

    try {
      var response = await dio.request(
        '/workspaces/$workspaceId/',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        retrieveWorkspace = RetrieveWorkspaceModel.onSuccess(response.data);
      } else {
        retrieveWorkspace = RetrieveWorkspaceModel.onError(response.data);
      }
    } on DioException catch (e) {
      retrieveWorkspace = RetrieveWorkspaceModel.error(handleDioError(e));
    }
    return retrieveWorkspace;
  }

  static Future<DeleteWorkspaceModel> deleteWorkspace(int workspaceId, String token) async {
    var headers = {
      'Authorization': 'Bearer $token'
    };

    late DeleteWorkspaceModel deleteWorkspaceModel;

    try {
      var response = await dio.request(
        '/workspaces/$workspaceId/',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );

      if (response.statusCode == 204) {
        deleteWorkspaceModel = DeleteWorkspaceModel.onSuccess();
      } else {
        deleteWorkspaceModel = DeleteWorkspaceModel.onError(response.data);
      }
    } on DioException catch (e) {
      deleteWorkspaceModel = DeleteWorkspaceModel.error(handleDioError(e));
    }
    return deleteWorkspaceModel;
  }
}
