import 'package:dio/dio.dart';

import '../../data/models/comments/comment.dart';
import '../variables/api_variables.dart';
import '../variables/global_var.dart';


class Commentapi{
  Future<void> createComment({
    required int taskId,
    required String body,
  }) async {
    try {
      final response = await dio.post(
        '/tasks/$taskId/create_comment/',
        data: {
          "body": body,
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
        print('Comment created successfully');
      } else {
        throw Exception('Failed to create comment: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
  Future<List<Comment>> getCommentsForTask(int taskId) async {
    try {
      final response = await dio.get(
        '/tasks/$taskId/list_comments/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((commentJson) => Comment.fromJson(commentJson))
            .toList();
      } else {
        throw Exception('Failed to fetch comments: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }


}
