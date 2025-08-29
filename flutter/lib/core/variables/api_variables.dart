import 'package:dio/dio.dart';

const String baseUrl = 'http://10.0.2.2:8000/api';
const String outbaseurl= 'http://192.168.1.129:8000/api';

BaseOptions options = BaseOptions(
  baseUrl: baseUrl,
  sendTimeout: const Duration(seconds: 20),
  receiveTimeout: const Duration(seconds: 20),
  receiveDataWhenStatusError: true,
);

final Dio dio = Dio(options);