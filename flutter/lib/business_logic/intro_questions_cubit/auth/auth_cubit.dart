import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // Future<void> loginUser( String email, String password) async {
  //   emit(LoginLoadingState());
  //   try {
  //     final response = await dio.post(
  //       '/login',
  //       data: {
  //         'email': email,
  //         'password': password,
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //
  //       emit(SuccessfulyLoginState());
  //     } else {
  //       emit(FailedLoginState());
  //     }
  //   }on DioException catch (e) {
//     final errorMessage = e.response?.data['message'] ?? 'Something happen';
//     emit(FailedLoginState(errorMessage));
//   } catch (e) {
//     emit(FailedLoginState(''));
//   }
  // }
  // Future<void> signupUser(String name, String email, String password, Emitter<AuthState> emit) async {
  //   emit(SignupLoadingState());
  //   try {
  //     final response = await dio.post(
  //       '/register',
  //       data: {
  //         'name': name,
  //         'email': email,
  //         'password': password,
  //       },
  //     );
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       emit(SuccessfulySignupState());
  //     } else {
  //       emit(FailedSignupState());
  //     }
  //   }  on DioException catch (e) {
//     final errorMessage = e.response?.data['message'] ?? '';
//     emit(FailedSignupState(errorMessage));
//   } catch (e) {
//     emit(FailedSignupState(''));
//   }
  // }

}
