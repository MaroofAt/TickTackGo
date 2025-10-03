import 'package:dio/dio.dart';
import 'package:pr1/core/functions/api_error_handling.dart';
import 'package:pr1/core/variables/api_variables.dart';
import 'package:pr1/data/models/workspace_points/get_points_statistics_model.dart';
import 'package:pr1/data/models/workspace_points/get_user_points_model.dart';

class PointsStatisticsApi {
  static Future<GetPointsStatisticsModel> getPointsStatistics(
      int workspaceId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    late GetPointsStatisticsModel getPointsStatisticsModel;

    try {
      var response = await dio.request(
        '/workspaces/$workspaceId/get_points_statistics/',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        getPointsStatisticsModel = GetPointsStatisticsModel.onSuccess(response.data);
      } else {
        getPointsStatisticsModel = GetPointsStatisticsModel.onError(response.data);
      }
    } on DioException catch (e) {
        getPointsStatisticsModel = GetPointsStatisticsModel.error(handleDioError(e));
    }
    return getPointsStatisticsModel;
  }

  static Future<GetUserPointsModel> getUserPoints(int userId, int workspaceId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    late GetUserPointsModel getUserPointsModel;

    try {
      var response = await dio.request(
        '/workspaces/$workspaceId/get_user_points/?user=$userId',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        getUserPointsModel = GetUserPointsModel.onSuccess(response.data);
      } else {
        getUserPointsModel = GetUserPointsModel.onError(response.data);
      }
    } on DioException catch (e) {
      getUserPointsModel = GetUserPointsModel.error(handleDioError(e));
    }
    return getUserPointsModel;
  }

}
