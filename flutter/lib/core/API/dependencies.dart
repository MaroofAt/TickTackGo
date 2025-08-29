import 'package:dio/dio.dart';
import 'package:pr1/core/functions/api_error_handling.dart';
import 'package:pr1/core/variables/api_variables.dart';
import 'package:pr1/data/models/dependencies/create_dependencies_model.dart';
import 'package:pr1/data/models/dependencies/fetch_dependencies_model.dart';
import 'package:pr1/presentation/screen/dependencies/delete_dependency_model.dart';

class DependenciesApi {
  static Future<CreateDependencyModel> createDependency(
      int conditionTask, int targetTask, String type, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var data = {
      "condition_task": conditionTask,
      "target_task": targetTask,
      "type": type,
    };

    late CreateDependencyModel createDependencyModel;

    try {
      var response = await dio.request(
        '/tasks-dependencies/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        createDependencyModel = CreateDependencyModel.onSuccess(response.data);
      } else {
        createDependencyModel = CreateDependencyModel.onError(response.data);
      }
    } on DioException catch (e) {
      createDependencyModel = CreateDependencyModel.error(handleDioError(e));
    }
    return createDependencyModel;
  }

  static Future<DeleteDependencyModel> deleteDependency(
      int dependencyId, String token) async {
    var headers = {'Authorization': 'Bearer $token'};

    late DeleteDependencyModel deleteDependencyModel;

    try {
      var response = await dio.request(
        '/tasks-dependencies/$dependencyId/',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );

      if (response.statusCode == 204) {
        deleteDependencyModel = DeleteDependencyModel.onSuccess();
      } else {
        deleteDependencyModel = DeleteDependencyModel.onError(response.data);
      }
    } on DioException catch (e) {
      deleteDependencyModel = DeleteDependencyModel.error(handleDioError(e));
    }
    return deleteDependencyModel;
  }
}
