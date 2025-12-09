import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/services/notification_service.dart';
import 'package:pr1/data/models/auth/sign_up_model.dart';

import '../../core/functions/navigation_service.dart';
import '../../core/variables/api_variables.dart';
import '../../core/variables/global_var.dart';
import '../../core/variables/intro_questions_variables.dart';
import '../../data/local_data/local_data.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  NotificationService _notificationApi = NotificationService();
  bool isLoading = false;

  ///////////SignUp
  Future<void> sendEmailForOTP(
      String email, String name, String password, BuildContext context) async {
    emit(SignupLoadingState());
    isLoading = true;

    print("trying...");

    var data = FormData.fromMap({
      "username": name,
      "email": email,
      "password": password,
      "what_do_you_do": selectedOptions[0],
      "how_to_use_website": selectedOptions[1],
      "how_did_you_get_here": selectedOptions[2]
    });

    try {
      var response = await dio.request(
        '/users/send_otp/',
        options: Options(
          method: 'POST',
          validateStatus: (status) => status! < 500,
        ),
        data: data,
      );

      if (response.statusCode == 200 && response.data.isNotEmpty) {
        NavigationService().push(context, verifyRoute);
        emit(OTPSentSuccess());
      } else if (response.statusCode == 400 && response.data.isNotEmpty) {
        final errorData = response.data;
        print('Error: ${response.data}');

        String errorMessage = "";

        if (errorData.containsKey('username')) {
          errorMessage +=
              "Username: ${List<String>.from(errorData['username']).join(', ')}\n";
        }
        if (errorData.containsKey('email')) {
          errorMessage +=
              "Email: ${List<String>.from(errorData['email']).join(', ')}";
        }

        showErrorDialog(context, "Registration Error", errorMessage);

        isLoading = false;
        emit(FailedSignupState(response.data));
      }
    } catch (e) {
      isLoading = false;
      print(e.toString());
      emit(FailedSignupState("Registration failed"));
    }
  }

  void initializeModel(String name, String password, String email) {
    globalSignUpModel = SignUpModel(
      username: name,
      email: email,
      password: password,
      howToUseWebsite: "small_team",
      whatDoYouDo: "software_or_it",
      howDidYouGetHere: "friends",
    );
  }

  Future<void> verify_SignUp(String otpCode, BuildContext context) async {
    if (globalSignUpModel == null) {
      emit(FailedSignupState("SignUp process not started properly"));
      print("Model initialized: ${globalSignUpModel?.toJson()}");
      print("no model there");
    }

    emit(SignupLoadingState());
    isLoading = true;
    print("trying verify...");

    try {
      final requestData = {
        "username": globalSignUpModel!.username,
        "email": globalSignUpModel!.email,
        "password": globalSignUpModel!.password,
        "how_to_use_website": globalSignUpModel!.howToUseWebsite.isNotEmpty
            ? globalSignUpModel!.howToUseWebsite
            : "small_team",
        "what_do_you_do": globalSignUpModel!.whatDoYouDo.isNotEmpty
            ? globalSignUpModel!.whatDoYouDo
            : "software_or_it",
        "how_did_you_get_here": globalSignUpModel!.howDidYouGetHere.isNotEmpty
            ? globalSignUpModel!.howDidYouGetHere
            : "friends",
        "otp": otpCode,
      };

      print("Request Data: $requestData");

      var response = await dio.post(
        '/users/verify_register/',
        data: requestData,
      );

      print("Response: ${response.data}");

      if (response.statusCode == 201) {
        print("Verification success!");
        NavigationService().pushReplacementNamed(context, mainHomePageName);
        login(globalSignUpModel!.email, globalSignUpModel!.password, context);
        emit(SignupVerifiedSuccessState());
      } else {
        print('Error: ${response.statusCode} - ${response.data}');
        emit(FailedSignupState(response.data.toString()));
      }
    } on DioException catch (e) {
      print("Dio Error: ${e.response?.data}");
      emit(FailedSignupState(
          e.response?.data?['message'] ?? "Verification failed"));
    } finally {
      isLoading = false;
    }
  }

  ///////login
  Future<void> login(
      String email, String password, BuildContext context) async {
    // await _notificationhandel.initNotification();
    isLoading = true;
    emit(LoginLoadingState());

    try {
      await _notificationApi.initNotification();
      // TODO send FCM token with login request when backend supports it
      final response = await dio.post(
        '/users/token/',
        options: Options(
          method: 'POST',
          validateStatus: (status) => status! < 500,
        ),
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 && response.data.isNotEmpty) {
        final accessToken = response.data['access'];
        final refreshToken = response.data['refresh'];
        await saveTokens(accessToken, refreshToken);
        token = accessToken;
        refresh = refreshToken;
        emit(AuthAuthenticated());
      } else if (response.statusCode == 401 && response.data.isNotEmpty) {
        final errorDetail = response.data['detail'] ?? 'Invalid credentials';
        emit(FailedLoginState(errorDetail.toString()));
        showErrorDialog(context, "Login Failed",
            errorDetail is String ? errorDetail : "Invalid email or password");
      } else {
        print("Login failed: ${response.data}");
        emit(FailedLoginState(response.data.toString()));
      }
    } on DioException catch (e) {
      print("Dio Error: ${e.type} - ${e.message}");
      emit(FailedLoginState("Failed to connect to server"));
    } catch (e) {
      print("General Error: $e");
      emit(FailedLoginState("An unexpected error occurred"));
    } finally {
      isLoading = false;
    }
  }

//// logout
  Future<void> logout(BuildContext context) async {
    try {
      emit(LogoutLoadingState());
      await clearTokens();

      token = "";
      refresh = '';
      user = null;
      globalSignUpModel = null;
      await clearTokens();

      emit(LogoutSuccessState());
      NavigationService().pushReplacementNamed(context, signupName);
    } catch (e) {
      print('Error during logout: $e');
      emit(LogoutFailedState('Failed to logout: $e'));
      showErrorDialog(
          context, "Logout Error", "Failed to logout. Please try again.");
    }
  }

  void showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(title),
        content: Text(
          message,
          style: const TextStyle(color: white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
