import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/core/API/points_statistics.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/data/models/workspace_points/get_points_statistics_model.dart';
import 'package:pr1/data/models/workspace_points/get_user_points_model.dart';

part 'points_state.dart';

class PointsCubit extends Cubit<PointsState> {
  PointsCubit() : super(PointsInitial());

  Future<void> getPointsStatistics(int workspaceId) async {
    emit(GettingPointsStatisticsState());

    GetPointsStatisticsModel getPointsStatisticsModel =
        await PointsStatisticsApi.getPointsStatistics(workspaceId, token);

    if (getPointsStatisticsModel.errorMessage.isEmpty) {
      emit(GettingPointsStatisticsSucceededState(getPointsStatisticsModel));
    }else {
      emit(GettingPointsStatisticsFailedState(getPointsStatisticsModel.errorMessage));
    }
  }

  Future<void> getUserPoints(int workspaceId, int userId) async {
    emit(GettingUserPointsState());

    GetUserPointsModel getUserPointsModel =
    await PointsStatisticsApi.getUserPoints(userId, workspaceId, token);

    if (getUserPointsModel.errorMessage.isEmpty) {
      emit(GettingUserPointsSucceededState(getUserPointsModel));
    }else {
      emit(GettingUserPointsFailedState(getUserPointsModel.errorMessage));
    }
  }
}
