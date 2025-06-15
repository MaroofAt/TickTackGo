import 'package:dio/dio.dart';

const String baseUrl = 'http://10.0.2.2:8000/api';


BaseOptions options = BaseOptions(
  baseUrl: baseUrl,
  sendTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 10),
  receiveDataWhenStatusError: true,
);

final Dio dio = Dio(options);