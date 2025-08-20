import 'package:dio/dio.dart';
import 'package:pr1/core/functions/api_error_handling.dart';
import 'package:pr1/core/variables/api_variables.dart';
import 'package:pr1/data/models/auth/refresh_token.dart';

class SplashApi {
  static Future<RefreshTokenModel> refreshToken(String refresh) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var data = {
      "refresh": refresh,
    };

    late RefreshTokenModel refreshTokenModel;

    try {
      var response = await dio.request(
        '/users/token/refresh/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        refreshTokenModel = RefreshTokenModel.onSuccess(response.data);
      } else {
        refreshTokenModel = RefreshTokenModel.onError(response.data);
      }
    } on DioException catch (e) {
      refreshTokenModel = RefreshTokenModel.error(handleDioError(e));
    }
    return refreshTokenModel;
  }
}
