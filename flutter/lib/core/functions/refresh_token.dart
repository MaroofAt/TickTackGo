import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../variables/api_variables.dart';

Future<void> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString("token");

    if (refreshToken == null) {
      print("not found token");
      return;
    }

    try {
      final response = await dio.post(
        "/api/token/refresh/",
        data: {"refresh": refreshToken},
      );

      final newAccessToken = response.data["access"];
      await prefs.setString("access_token", newAccessToken);
    } on DioException catch (e) {
      print(e.response?.data);
    }
  }
