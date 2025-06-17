import 'package:pr1/core/functions/api_error_handling.dart';
import 'package:pr1/core/variables/api_variables.dart';
import 'package:pr1/data/models/workspace/create_workspace_model.dart';
import 'package:dio/dio.dart';
import 'package:pr1/data/models/workspace/get_workspace_model.dart';
import 'package:pr1/data/models/workspace/get_workspaces_model.dart';

class WorkspaceApi {
  static Future<CreateWorkspaceModel> createWorkspace(
      String title, String description, String token) async {
    var headers = {'Authorization': 'Bearer $token'};
    var data = FormData.fromMap({'title': title, 'description': description});

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
      createWorkspaceModel = CreateWorkspaceModel.error(handleDioError(e));
    }
    return createWorkspaceModel;
  }

  static Future<List<FetchWorkspacesModel>> fetchWorkspaces() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUwMTc0ODc2LCJpYXQiOjE3NTAxNzEyNzYsImp0aSI6IjE4NGVlNzAxYzcwNjQyMGJiNGVjYjNlNjYxYzk2M2ZjIiwidXNlcl9pZCI6MX0.VOV_Cyi3Ln0zYWuHXnIN16FgQUgO55001N8iHo2hRCI'
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
            .map((json) => FetchWorkspacesModel.onSuccess(json))
            .toList();
      } else {
        getWorkspacesModel = [FetchWorkspacesModel.onError(response.data)];
      }
    }on DioException catch (e) {
      getWorkspacesModel = [FetchWorkspacesModel.error(handleDioError(e))];
    }
    return getWorkspacesModel;
  }

  static Future<RetrieveWorkspace> retrieveWorkspace (int workspaceId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUwMTc0ODc2LCJpYXQiOjE3NTAxNzEyNzYsImp0aSI6IjE4NGVlNzAxYzcwNjQyMGJiNGVjYjNlNjYxYzk2M2ZjIiwidXNlcl9pZCI6MX0.VOV_Cyi3Ln0zYWuHXnIN16FgQUgO55001N8iHo2hRCI'
    };

    late RetrieveWorkspace retrieveWorkspace;

    try {
      var response = await dio.request(
        '/workspaces/$workspaceId/',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        retrieveWorkspace = RetrieveWorkspace.onSuccess(response.data);
      } else {
        retrieveWorkspace = RetrieveWorkspace.onError(response.data);
      }
    } on DioException catch (e) {
      retrieveWorkspace = RetrieveWorkspace.error(handleDioError(e));
    }
    return retrieveWorkspace;
  }
}
