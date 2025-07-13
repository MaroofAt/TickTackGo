part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

class RefreshTokenLoadingState extends SplashState {}

class RefreshTokenSucceededState extends SplashState {
  String accessToken;

  RefreshTokenSucceededState(this.accessToken);
}

class RefreshTokenFailedState extends SplashState {
  String errorMessage;

  RefreshTokenFailedState(this.errorMessage);
}
