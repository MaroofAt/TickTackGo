part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}
/////login state
final class AuthInitial extends AuthState {}

// THIS IS THE KEY CHANGE: A unified state for any authenticated user.
final class AuthAuthenticated extends AuthState {}

final class AuthUnauthenticated extends AuthState {}

final class LoginLoadingState extends AuthState{}
final class SuccessfulyLoginState extends AuthState{}
final class FailedLoginState extends AuthState {
  final String errorMessage;
  FailedLoginState(this.errorMessage);
}


//// signup state
final class SignupLoadingState extends AuthState{}
final class OTPSentSuccess  extends AuthState{}
final class SignupVerifiedSuccessState  extends AuthState{}

final class FailedSignupState extends AuthState {
  final String message;
  FailedSignupState(this.message);
}

///// log out
final class LogoutLoadingState extends AuthState{}
final class LogoutSuccessState  extends AuthState{}
final class LogoutFailedState  extends AuthState {
  final String message;
  LogoutFailedState(this.message);
}
