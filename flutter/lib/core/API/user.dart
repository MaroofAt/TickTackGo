import 'package:dio/dio.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/data/local_data/local_data.dart';
import '../../data/models/user/all_user.dart';
import '../../data/models/user/user.dart';
import '../functions/refresh_token.dart';
import '../variables/api_variables.dart';

Future<void> getUser() async {
  try {
    final int userId = getUserIdFromToken(token);


    final response = await dio.get(
      '/users/$userId/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      user = User.fromJson(response.data);
    } else {
      throw Exception('Failed to load user: ${response.statusCode}');
    }
  } on DioException catch (e) {
    throw Exception('Dio error: ${e.message}');
  } catch (e) {
    throw Exception('Unexpected error: $e');
  }
}

Future<AllUser> getAllUser() async {
  try {
    if (refresh == null) throw Exception('No token found');
    final response = await dio.get(
      '/users/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      AllUser users = AllUser.fromJson(response.data);
      return users;
    } else {
      throw Exception('Failed to load user: ${response.statusCode}');
    }
  } on DioException catch (e) {
    throw Exception('Dio error: ${e.message}');
  } catch (e) {
    throw Exception('Unexpected error: $e');
  }
}
