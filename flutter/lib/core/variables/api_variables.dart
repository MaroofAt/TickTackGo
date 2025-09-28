import 'package:dio/dio.dart';

const String ip = '10.0.2.2';
const String baseUrl = 'http://$ip:8000/api';

BaseOptions options = BaseOptions(
  baseUrl: baseUrl,
  sendTimeout: const Duration(seconds: 20),
  receiveTimeout: const Duration(seconds: 20),
  receiveDataWhenStatusError: true,
);

final Dio dio = Dio(options);
