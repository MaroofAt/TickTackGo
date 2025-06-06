import 'package:pr1/core/variables/api_variables.dart';
import 'package:pr1/data/workspace/create_workspace_model.dart';
import 'package:dio/dio.dart';

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
      createWorkspaceModel = CreateWorkspaceModel.onError(e.response!.data);
    }
    return createWorkspaceModel;
  }
}
