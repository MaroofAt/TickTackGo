import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/spalsh_cubit/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../variables/api_variables.dart';

refreshToken(BuildContext context, refresh) async {
  await BlocProvider.of<SplashCubit>(context).refreshToken(refresh);
}

// Future<void> refreshToken() async {
//   final prefs = await SharedPreferences.getInstance();
//   final refreshToken = prefs.getString("token");
//
//   if (refreshToken == null) {
//     print("not found token");
//     return;
//   }
//
//   try {
//     final response = await dio.post(
//       "/api/token/refresh/",
//       data: {"refresh": refreshToken},
//     );
//
//     final newAccessToken = response.data["access"];
//     await prefs.setString("access_token", newAccessToken);
//   } on DioException catch (e) {
//     print(e.response?.data);
//   }
// }
