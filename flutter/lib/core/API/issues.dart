import 'package:dio/dio.dart';

import '../../data/models/issues/list_issues_model.dart';
import '../../data/models/issues/showreplie.dart';
import '../variables/api_variables.dart';
import '../variables/global_var.dart';

class IssueApi {
  Future<void> createIssue({
    required String title,
    required String description,
    required int projectId,
  }) async {
    try {
      final response = await dio.post(
        '/issues/',
        data: {
          "title": title,
          "description": description,
          "project": projectId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Issue created successfully');
      } else {
        throw Exception('Failed to create issue: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future <List<ListIssuesModel>> get_All_Issues({
    required int projectId,
    String? ordering,
    String? search,
  }) async {
    try {
      final queryParams = { if (ordering != null) "ordering": ordering, if (search != null) "search": search, };
      final response = await dio.get( '/issues/',
        queryParameters: queryParams,
        data: { "project": projectId, },
        options: Options(
          headers: { 'Authorization': 'Bearer $token',
            'accept': 'application/json',
            'Content-Type': 'application/json', }, ), );




      if (response.statusCode == 200) {
        print("Issues fetched successfully ✅");

        final data = response.data as List;
        return data.map((e) => ListIssuesModel.fromJson(e)).toList();

      } else {
        throw Exception('Failed to fetch issues: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future <ListIssuesModel> RetrieveIssue({
    required int issueId,
    required int projectId,
  }) async { 
    try {
      final response = await dio.get(
        '/issues/$issueId/',
        data: {
          "project": projectId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Issue $issueId fetched successfully ✅");
        print("Response data: ${response.data}");
        print("Response data type: ${response.data.runtimeType}");
        if (response.data is List<dynamic> && response.data.isNotEmpty) {
          return ListIssuesModel.fromJson(response.data[0]);
        } else {
          throw Exception('No issue found or invalid response format');
        }
      } else {
        throw Exception('Failed to fetch issue: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print("Dio error: ${e.response?.data ?? e.message}");
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<void> createReplie({
    required String body,
    required int issueID,
  }) async {
    try {
      final response = await dio.post(
        '/issues/create_replie/',
        data: {
          "body": body,
          "issue": issueID,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Replie created successfully');
      } else {
        throw Exception('Failed to create issue: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
  Future <List<ShowReplie>> get_Replie({
    required int projectId,  required int issueID,
  }) async {
    try {
      final response = await dio.get( '/issues/list_replie/',
        data: { "project": projectId,
          "issue":issueID
        },
        options: Options(
          headers: { 'Authorization': 'Bearer $token',
            'accept': 'application/json',
            'Content-Type': 'application/json', }, ), );




      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Replie fetched successfully ✅");
        print("Response data: ${response.data}");
        print("Response data type: ${response.data.runtimeType}");
        final data = response.data as List;
        return data.map((e) => ShowReplie.fromJson(e)).toList();



      } else {
        throw Exception('Failed to fetch issues: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
