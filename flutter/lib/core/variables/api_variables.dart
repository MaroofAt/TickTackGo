import 'package:dio/dio.dart';

const String baseUrl = 'http://10.0.2.2:8000/api';
const String outbaseurl= 'http://192.168.43.55:8000/api';

BaseOptions options = BaseOptions(
  baseUrl: outbaseurl,
  sendTimeout: const Duration(seconds: 20),
  receiveTimeout: const Duration(seconds: 20),
  receiveDataWhenStatusError: true,
);

final Dio dio = Dio(options);
