import 'package:dio/dio.dart';

const String baseUrl = 'https://tawana-tritheistical-nonconcordantly.ngrok-free.dev/api';

BaseOptions options = BaseOptions(
  baseUrl: baseUrl,
  sendTimeout: const Duration(seconds: 20),
  receiveTimeout: const Duration(seconds: 20),
  receiveDataWhenStatusError: true,
);

final Dio dio = Dio(options);
