import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../variables/api_variables.dart';
import '../variables/global_var.dart';

Future<void> initOneSignal() async {
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  // Initialize with your OneSignal App ID
  OneSignal.initialize("972c2f0d-d622-4793-ba9d-2648e39485c3");
  await Permission.notification.request();
  // Use this method to prompt for push notifications.
  // We recommend removing this method after testing and instead use In-App Messages to prompt for notification permission.
  OneSignal.Notifications.requestPermission(true);

  //
  // OneSignal.User.pushSubscription.addObserver((state) {
  //   final id = OneSignal.User.pushSubscription.id;
  //   FCMuserToken = OneSignal.User.pushSubscription.token;
  //   print("=====================================================================");
  //   print("  the id: $id =====================================================================");
  //   print(" the token: $FCMuserToken =====================================================================");
  //   // sendTokenToServer(FCMuserToken!, id!);
  // });
  OneSignal.User.pushSubscription.addObserver((state) {
    final token = OneSignal.User.pushSubscription.token;
    final id = OneSignal.User.pushSubscription.id;
    //
    // print("================ OneSignal Subscription Observer ================");
    // print("🔥 Push Token: ${token ?? 'null'}");
    // print("📦 OneSignal ID: ${id ?? 'null'}");
    // print("===============================================================");
    //
    // if (token != null && token.isNotEmpty && id != null) {
    //   // sendTokenToServer(token, id);
    // } else {
    //   print("⚠️ No token or ID yet. Waiting...");
    // }
  });



  // await getPlayerId();
  // OneSignal.User.pushSubscription.addObserver((state) {
  //   print(OneSignal.User.pushSubscription.optedIn);
  //   print(OneSignal.User.pushSubscription.id);
  //   final id = OneSignal.User.pushSubscription.id;
  //   FCMuserToken = OneSignal.User.pushSubscription.token;
  //   String? onesignalId = OneSignal.User.pushSubscription.id;
  //   print(FCMuserToken);
  //   print(onesignalId);
  //   print(state.current.jsonRepresentation());
  // });
  //
  // print(
  //     "=====================================================================");
  // OneSignal.Notifications.addForegroundWillDisplayListener((event) {
  //
  //   showDialog(
  //     context: navigatorKey.currentContext!,
  //     builder: (_) => AlertDialog(
  //       title: Text(event.notification.title ?? "New Notification"),
  //       content: Text(event.notification.body ?? ""),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(navigatorKey.currentContext!),
  //           child: Text("OK"),
  //         ),
  //       ],
  //     ),
  //   );
  //   // event.notification.display();
  //
  // });

}
  Future<void> sendTokenToServer( String pushToken,String id) async {
    const url = "https://your-django-api.com/api/register-device/";
    try {
      var response = await dio.request(
        '/users/send_otp/',
        options: Options(
          method: 'POST',
        ),
      data: {
      "push_token": pushToken,
        'user_id': id
      },
      );

      print(" Token sent to server: ${response.data}");
    } catch (e) {
      print(" Error sending token: $e");
    }
  }



