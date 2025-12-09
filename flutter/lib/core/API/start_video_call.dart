// import 'package:dio/dio.dart';
// import 'package:pr1/core/functions/api_error_handling.dart';
// import 'package:pr1/core/variables/api_variables.dart';

// class StartVideoCall {
//   Future<StartVideoCallModel> startVideoCall(int id, String title,
//       String description, String image, String token) async {
//     var headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token'
//     };
//     var data = {
//       "title": title,
//       "description": description,
//       "image": image,
//     };

//     late StartVideoCallModel startVideoCallModel;

//     try {
//       var response = await dio.request(
//         '/workspaces/$id/start_video_call_notification/',
//         options: Options(
//           method: 'POST',
//           headers: headers,
//         ),
//         data: data,
//       );

//       if (response.statusCode == 200) {
//         startVideoCallModel = StartVideoCallModel.onSuccess(response.data);
//       } else {
//         startVideoCallModel = StartVideoCallModel.onError(response.data);
//       }
//     } on DioException catch (e) {
//       startVideoCallModel = StartVideoCallModel.error(handleDioError(e));
//     }

//     return startVideoCallModel;

//   }
// }
