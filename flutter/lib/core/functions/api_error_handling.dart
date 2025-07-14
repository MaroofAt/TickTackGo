import 'package:dio/dio.dart';

String handleDioError(DioException e) {
  if (e.response != null) {
      return e.runtimeType is String
      ? 'something went wrong please Try again later'
      : e.response!.data["detail"] ??
        e.response!.data["message"] ??
        'something went wrong please Try again later';
  }

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return "Connection Timeout. Please try again.";
    case DioExceptionType.receiveTimeout:
      return "Server response took too long. Try again.";
    case DioExceptionType.badResponse:
      return "Invalid response from server.";
    case DioExceptionType.cancel:
      return "Request was canceled.";
    case DioExceptionType.unknown:
    default:
      return "An unexpected error occurred.";
  }
}
