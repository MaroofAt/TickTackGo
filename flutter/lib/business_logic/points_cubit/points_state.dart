part of 'points_cubit.dart';

@immutable
sealed class PointsState {}

final class PointsInitial extends PointsState {}

class GettingPointsStatisticsState extends PointsState {}

class GettingPointsStatisticsSucceededState extends PointsState {
  GetPointsStatisticsModel getPointsStatisticsModel;

  GettingPointsStatisticsSucceededState(this.getPointsStatisticsModel);
}

class GettingPointsStatisticsFailedState extends PointsState {
  String errorMessage;

  GettingPointsStatisticsFailedState(this.errorMessage);
}

class GettingUserPointsState extends PointsState {}

class GettingUserPointsSucceededState extends PointsState {
  GetUserPointsModel getUserPointsModel;

  GettingUserPointsSucceededState(this.getUserPointsModel);
}

class GettingUserPointsFailedState extends PointsState {
  String errorMessage;

  GettingUserPointsFailedState(this.errorMessage);
}
