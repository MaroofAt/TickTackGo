import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../variables/global_var.dart';
import '../variables/api_variables.dart';

class NotificationApi {

  Future<void> registerDevice({required String registrationId, required String deviceType,}) async {
    try {
      final response = await dio.post(
        '/users/register_device/',
        data: {
          "registration_id": registrationId,
          "device_type": deviceType,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Device registered successfully ✅');
      } else {
        throw Exception('Failed to register device: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<void> getDeviceToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    String? device = Platform.isAndroid ? "android" : "ios";
    if (token != null) {
      FCMuserToken = token;
      deviceType = Platform.isAndroid ? "android" : "ios";
      print('FCM: $FCMuserToken');
      print("-------------------------------------------------------");
      print("Device: $deviceType");
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      FCMuserToken = newToken;
    });
  }
}
