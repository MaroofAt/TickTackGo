// import 'package:dio/dio.dart';
// import 'package:pr1/core/functions/api_error_handling.dart';
// import 'package:pr1/core/variables/api_variables.dart';
// import 'package:pr1/data/models/inbox/create_inbox_task_model.dart';
// import 'package:pr1/data/models/inbox/destroy_inbox_task_model.dart';
// import 'package:pr1/data/models/inbox/inbox_tasks_model.dart';
// import 'package:pr1/data/models/inbox/retrieve_inbox_task_model.dart';
//
// import '../../data/models/auth/otpmodel.dart';
//
// class AuthApi {
//   static Future<OtpResponseModel> sendOtp(String email) async {
//   var data = FormData.fromMap({
//   'email': email
//   });
//
//   try {
//   var response = await dio.request(
//   '/api/users/send_otp/',
//   options: Options(
//   method: 'POST',
//   ),
//   data: data,
//   );
//
//   return OtpResponseModel.fromJson({
//   'status': response.statusCode,
//   'message': response.data['message'],
//   'data': response.data,
//   });
//   } on DioException catch (e) {
//     print('sfd');
//
//   }
//   }
//   }
