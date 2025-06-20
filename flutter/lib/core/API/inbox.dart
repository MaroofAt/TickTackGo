import 'package:dio/dio.dart';
import 'package:pr1/core/functions/api_error_handling.dart';
import 'package:pr1/core/variables/api_variables.dart';
import 'package:pr1/data/models/inbox/create_inbox_task_model.dart';
import 'package:pr1/data/models/inbox/destroy_inbox_task_model.dart';
import 'package:pr1/data/models/inbox/inbox_tasks_model.dart';
import 'package:pr1/data/models/inbox/retrieve_inbox_task_model.dart';

class InboxApi {
  static Future<CreateInboxTaskModel> createInboxTask(
      String title, String description, String priority) async {
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUwNDE5NTkwLCJpYXQiOjE3NTA0MTU5OTAsImp0aSI6ImRkYjk0Y2ZhZmJhMTQwNGU5NGEyMWIzY2JkMGMxZTczIiwidXNlcl9pZCI6MX0.uGjdDQHjStXxrDz2PYeqLAGV1YjqyAD764jhxdNorz0'
    };

    var data = FormData.fromMap({
      'title': title,
      'description': description,
      'status': 'pending',
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
      createInboxTaskModel = CreateInboxTaskModel.error(handleDioError(e));
    }
    return createInboxTaskModel;
  }

  static Future<List<InboxTasksModel>> fetchInboxTasks() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUwNDE5NTkwLCJpYXQiOjE3NTA0MTU5OTAsImp0aSI6ImRkYjk0Y2ZhZmJhMTQwNGU5NGEyMWIzY2JkMGMxZTczIiwidXNlcl9pZCI6MX0.uGjdDQHjStXxrDz2PYeqLAGV1YjqyAD764jhxdNorz0'
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
      inboxTasksModelList = [InboxTasksModel.error(handleDioError(e))];
    }
    return inboxTasksModelList;
  }

  static Future<RetrieveInboxTaskModel> retrieveInboxTask(int taskId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUwNDE5NTkwLCJpYXQiOjE3NTA0MTU5OTAsImp0aSI6ImRkYjk0Y2ZhZmJhMTQwNGU5NGEyMWIzY2JkMGMxZTczIiwidXNlcl9pZCI6MX0.uGjdDQHjStXxrDz2PYeqLAGV1YjqyAD764jhxdNorz0'
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

  static Future<RetrieveInboxTaskModel> updateInboxTask(int taskId,
      {required String title,
      required String description,
      required String priority,
      required String status}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUwNDE5NTkwLCJpYXQiOjE3NTA0MTU5OTAsImp0aSI6ImRkYjk0Y2ZhZmJhMTQwNGU5NGEyMWIzY2JkMGMxZTczIiwidXNlcl9pZCI6MX0.uGjdDQHjStXxrDz2PYeqLAGV1YjqyAD764jhxdNorz0'
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

  static Future<DestroyInboxTaskModel> destroyTaskModel(int taskId) async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUwNDE5NTkwLCJpYXQiOjE3NTA0MTU5OTAsImp0aSI6ImRkYjk0Y2ZhZmJhMTQwNGU5NGEyMWIzY2JkMGMxZTczIiwidXNlcl9pZCI6MX0.uGjdDQHjStXxrDz2PYeqLAGV1YjqyAD764jhxdNorz0'
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
