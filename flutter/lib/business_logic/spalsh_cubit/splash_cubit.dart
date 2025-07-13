import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/core/API/splash_api.dart';
import 'package:pr1/data/local_data/local_data.dart';
import 'package:pr1/data/models/auth/refresh_token.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<bool> checkExistingToken() async {
    String? token = await getAccessToken();
    return token != null;
  }

  Future<String?> getRefreshToken() async {
    return await getRefreshToken();
  }

  Future<void> refreshToken(String refresh) async {
    emit(RefreshTokenLoadingState());

    RefreshTokenModel refreshTokenModel = await SplashApi.refreshToken(refresh);
    if(refreshTokenModel.errorMessage.isEmpty){
      emit(RefreshTokenSucceededState(refreshTokenModel.access));
    }else{
      emit(RefreshTokenFailedState(refreshTokenModel.errorMessage));
    }
  }

}
