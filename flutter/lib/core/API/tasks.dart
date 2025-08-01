import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pr1/core/functions/api_error_handling.dart';
import 'package:pr1/core/variables/api_variables.dart';
import 'package:pr1/data/models/tasks/cancel_task_model.dart';
import 'package:pr1/data/models/tasks/create_task_model.dart';
import 'package:pr1/data/models/tasks/fetch_tasks_model.dart';
import 'package:pr1/data/models/tasks/retrieve_task_model.dart';

class TaskApi {
  static Future<CreateTaskModel> createTask(
      {required String title,
      required String description,
      required String startDate,
      required String dueDate,
      required int workspaceId,
      required int projectId,
      required String status,
      required String priority,
      required bool locked,
      required String token,
      required int? parentTask,
      File? image}) async {

    Map<String, String> headers;

    Map<String, Object> data = {
      'title': title,
      'description': description,
      'start_date': startDate,
      'due_date': dueDate,
      'workspace': workspaceId,
      'project': projectId,
      'status': status,
      'priority': priority,
      'locked': locked.toString(),
      'assignees': []
    };

    if(parentTask != null && parentTask != 0) {
      data.addAll({'perent_task': parentTask});
    }

    if (image == null) {
      headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    } else {
      headers = {
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      data.addAll({
        'image': await MultipartFile.fromFile(
          image.path,
          filename: '$title.jpg',
        ),
      });
    }

    late CreateTaskModel createTaskModel;

    try {
      var response = await dio.request(
        '/tasks/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        createTaskModel = CreateTaskModel.onSuccess(response.data);
      } else {
        createTaskModel = CreateTaskModel.onError(response.data);
      }
    } on DioException catch (e) {
      createTaskModel = CreateTaskModel.error(handleDioError(e));
    }
    return createTaskModel;
  }

  static Future<RetrieveTaskModel> retrieveTask(
      int taskId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    late RetrieveTaskModel retrieveTaskModel;

    try {
      var response = await dio.request(
        '/tasks/$taskId/',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        retrieveTaskModel = RetrieveTaskModel.onSuccess(response.data);
      } else {
        retrieveTaskModel = RetrieveTaskModel.onError(response.data);
      }
    } on DioException catch (e) {
      retrieveTaskModel = RetrieveTaskModel.error(handleDioError(e));
    }
    return retrieveTaskModel;
  }

  static Future<List<FetchTasksModel>> fetchTasks(
      int projectId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    Map<String, dynamic> queryParameters = {'project': projectId};

    late List<FetchTasksModel> fetchedTasks;

    try {
      var response = await dio.request(
        '/tasks/',
        queryParameters: queryParameters,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        fetchedTasks =
            data.map((json) => FetchTasksModel.onSuccess(json)).toList();
      } else {
        fetchedTasks = [FetchTasksModel.onError(response.data)];
      }
    } on DioException catch (e) {
      fetchedTasks = [FetchTasksModel.error(handleDioError(e))];
    }
    return fetchedTasks;
  }

  static Future<CancelTaskModel> cancelTask(int taskId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    late CancelTaskModel cancelTaskModel;
    try {
      var response = await dio.request(
        '/tasks/$taskId/cancel/',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        cancelTaskModel = CancelTaskModel.onSuccess(response.data);
      } else {
        cancelTaskModel = CancelTaskModel.onError(response.data);
      }
    } on DioException catch (e) {
      cancelTaskModel = CancelTaskModel.error(handleDioError(e));
    }
    return cancelTaskModel;
  }

  

}
