import 'package:dio/dio.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../variables/api_variables.dart';
import '../variables/global_var.dart';
//
Future<void> getPlayerId() async {
  FCMuserId=OneSignal.User.pushSubscription.id;
print(OneSignal.User.pushSubscription.id);
}

void _handleGetOnesignalId() async {
  var onesignalId = await OneSignal.User.getOnesignalId();
  print('OneSignal ID: $onesignalId');
}

Future<void> initOneSignal() async {

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  // Initialize with your OneSignal App ID
  OneSignal.initialize("972c2f0d-d622-4793-ba9d-2648e39485c3");
  // Use this method to prompt for push notifications.
  // We recommend removing this method after testing and instead use In-App Messages to prompt for notification permission.
  OneSignal.Notifications.requestPermission(false);
  // await getPlayerId();
  OneSignal.User.pushSubscription.addObserver((state) {
    print(OneSignal.User.pushSubscription.optedIn);
    print(OneSignal.User.pushSubscription.id);
    final id = OneSignal.User.pushSubscription.id;

    if (id != null && id.isNotEmpty) {
      FCMuserId = id;
      print("✅ Got userId: $FCMuserId");

      // await SendFCMId(); // 📤 أرسل الـ ID فقط بعد التعيين
    } else {
      print("❌ No OneSignal User ID available yet.");
    }
    print(OneSignal.User.pushSubscription.token);
    print(state.current.jsonRepresentation());
  });

  print("m,jvbgtr=fnhgfnh=======================================mg$FCMuserId");
//   await SendFCMId();
//
//  /// opened notification out bage
//   OneSignal.shared.setNotificationOpenedHandler((openedResult) {
//     var notification = openedResult.notification;
//     print("Notification opened: ${notification.jsonRepresentation()}");
//   });
// //// in the bage
//   OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
//     var notification = event.notification;
//     print("Notification received in foreground: ${notification.jsonRepresentation()}");
//     event.complete(notification);
//   });
// }
//
// Future<void> SendFCMId() async {
//
//   Map<String, dynamic> data = {
//     "one_signal_user_id": FCMuserId,
//   };
//
//   try {
//     var response = await dio.request(
//       '/users/id/',
//       options: Options(
//         method: 'POST',
//         validateStatus: (status) => status! < 500,
//       ),
//       data: data,
//     );
//
//     if (response.statusCode == 200 && response.data.isNotEmpty) {
//       print("success");
//       print(response.data);
//     }
//   } catch (e) {
//     print(e.toString());
//   }
}

