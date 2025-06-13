part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}
/////login state
final class AuthInitial extends AuthState {}
final class LoginLoadingState extends AuthState{}
final class SuccessfulyLoginState extends AuthState{}
final class FailedLoginState extends AuthState {
  final String errorMessage;
  FailedLoginState(this.errorMessage);
}


//// signup state
final class SignupLoadingState extends AuthState{}
final class SuccessfulySignupState extends AuthState{}
final class FailedSignupState extends AuthState {
  final String errorMessage;
  FailedSignupState(this.errorMessage);
}

