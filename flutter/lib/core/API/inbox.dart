import 'package:dio/dio.dart';
import 'package:pr1/core/functions/api_error_handling.dart';
import 'package:pr1/core/variables/api_variables.dart';
import 'package:pr1/data/models/inbox/create_inbox_task_model.dart';
import 'package:pr1/data/models/inbox/destroy_inbox_task_model.dart';
import 'package:pr1/data/models/inbox/inbox_tasks_model.dart';
import 'package:pr1/data/models/inbox/retrieve_inbox_task_model.dart';

class InboxApi {
  static Future<CreateInboxTaskModel> createInboxTask(
      String title, String description, String priority,String status,String token) async {
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization':
          'Bearer $token'
    };

    var data = FormData.fromMap({
      'title': title,
      'description': description,
      'status': status,
      'priority': priority,
    });

    late CreateInboxTaskModel createInboxTaskModel;

    try {
      var response = await dio.request(
        '/inbox_tasks/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        createInboxTaskModel = CreateInboxTaskModel.onSuccess(response.data);
      } else {
        createInboxTaskModel = CreateInboxTaskModel.onError(response.data);
      }
    } on DioException catch (e) {
      print(e.toString());
      createInboxTaskModel = CreateInboxTaskModel.error(handleDioError(e));
    }
    return createInboxTaskModel;
  }

  static Future<List<InboxTasksModel>> fetchInboxTasks(String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    late List<InboxTasksModel> inboxTasksModelList;

    try {
      var response = await dio.request(
        '/inbox_tasks/',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        inboxTasksModelList =
            data.map((item) => InboxTasksModel.onSuccess(item)).toList();
      } else {
        inboxTasksModelList = [InboxTasksModel.onError(response.data)];
      }
    } on DioException catch (e) {
      print(e.toString());
      inboxTasksModelList = [InboxTasksModel.error(handleDioError(e))];
    }
    return inboxTasksModelList;
  }

  static Future<RetrieveInboxTaskModel> retrieveInboxTask(int taskId,String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer $token'
    };

    late RetrieveInboxTaskModel retrieveInboxTaskModel;

    try {
      var response = await dio.request(
        '/inbox_tasks/$taskId/',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        retrieveInboxTaskModel =
            RetrieveInboxTaskModel.onSuccess(response.data);
      } else {
        retrieveInboxTaskModel = RetrieveInboxTaskModel.onError(response.data);
      }
    } on DioException catch (e) {
      retrieveInboxTaskModel = RetrieveInboxTaskModel.error(handleDioError(e));
    }
    return retrieveInboxTaskModel;
  }

  static Future<RetrieveInboxTaskModel> updateInboxTask(int taskId,String token,
      {required String title,
      required String description,
      required String priority,
      required String status}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer $token'
    };
    var data = {
      "title": title,
      "description": description,
      "priority": priority,
      "status": status,
    };

    late RetrieveInboxTaskModel retrieveInboxTaskModel;

    try {
      var response = await dio.request(
        '/inbox_tasks/$taskId/',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        retrieveInboxTaskModel =
            RetrieveInboxTaskModel.onSuccess(response.data);
      } else {
        retrieveInboxTaskModel = RetrieveInboxTaskModel.onError(response.data);
      }
    } on DioException catch (e) {
      retrieveInboxTaskModel = RetrieveInboxTaskModel.error(handleDioError(e));
    }
    return retrieveInboxTaskModel;
  }

  static Future<DestroyInboxTaskModel> destroyTaskModel(int taskId, String token) async {
    var headers = {
      'Authorization':
          'Bearer $token'
    };

    late DestroyInboxTaskModel destroyInboxTaskModel;

    try {
      var response = await dio.request(
        '/inbox_tasks/$taskId/',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        destroyInboxTaskModel = DestroyInboxTaskModel.onSuccess(response.data);
      } else {
        destroyInboxTaskModel = DestroyInboxTaskModel.onError(response.data);
      }
    } on DioException catch (e) {
      destroyInboxTaskModel = DestroyInboxTaskModel.error(handleDioError(e));
    }
    return destroyInboxTaskModel;
  }
}
