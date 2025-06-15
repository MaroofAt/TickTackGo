import 'package:pr1/core/functions/api_error_handling.dart';
import 'package:pr1/core/variables/api_variables.dart';
import 'package:pr1/data/models/workspace/create_workspace_model.dart';
import 'package:dio/dio.dart';
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

  static Future<List<dynamic>> fetchWorkspaces(int userId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ5OTA0Mzc2LCJpYXQiOjE3NDk5MDA3NzYsImp0aSI6ImY2NzdjYmJkMmZkNzQ3ODY5Y2I1MGJkYzg0NzdhODM3IiwidXNlcl9pZCI6MX0.2V65kOtCA4KicqMvrXke4iyPvuBlM5DTYxK3Y-qOaq4'
    };

      late List<dynamic> getWorkspacesModel;

    try {
      var response = await dio.request(
        '/workspaces/',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        getWorkspacesModel = response.data
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
}
