import 'package:dio/dio.dart';

const String baseUrl = 'http://127.0.0.1:8000/api';


BaseOptions options = BaseOptions(
  baseUrl: baseUrl,
  sendTimeout: const Duration(seconds: 15),
  receiveTimeout: const Duration(seconds: 15),
  receiveDataWhenStatusError: true,
);

final Dio dio = Dio(options);