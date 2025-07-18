import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pr1/data/local_data/local_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../variables/api_variables.dart';

// refreshToken(BuildContext context, refresh) async {
//   await BlocProvider.of<SplashCubit>(context).refreshToken(refresh);
// }

Future<void> refreshToken() async {
  final prefs = await SharedPreferences.getInstance();
  final refreshToken = await getRefreshToken();

  if (refreshToken == null) {
    print("not found token");
    return;
  }

  try {
    final response = await dio.post(
      "/token/refresh/",
      data: {"refresh": refreshToken},
    );

    final newAccessToken = response.data["access"];
    await prefs.setString("access_token", newAccessToken);
  } on DioException catch (e) {
    print(e.response?.data);
  }
}

int getUserIdFromToken(String token) {
  try {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    if (decodedToken.containsKey('user_id')) {
      return decodedToken['user_id'] as int;
    } else {
      throw Exception('User ID not found in token');
    }
  } catch (e) {
    throw Exception('Failed to decode token: $e');
  }
}
