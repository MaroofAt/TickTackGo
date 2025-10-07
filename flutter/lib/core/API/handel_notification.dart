import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pr1/core/variables/global_var.dart';

class NotificationHandel {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final AndroidNotificationChannel _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.defaultImportance,
  );

  final FlutterLocalNotificationsPlugin _localNotification =
  FlutterLocalNotificationsPlugin();

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('message title: ${message.notification?.title}');
    print('message body: ${message.notification?.body}');
    print('message payload: ${message.data}');
    final notification = message.notification;
    if (notification == null) return;
    _localNotification.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          sound: _androidChannel.sound,
          icon: '@mipmap/ic_launcher', // ✅ استخدام الأيقونة الجاهزة
        ),
      ),
      payload: jsonEncode(message.toMap()),
    );
  }

  Future pushNotification() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
    );
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    await _firebaseMessaging.getToken().then((value) {
      FCMuserToken = value ?? '';
      print(FCMuserToken);
    });
    await initLocalNotification();
    await initPushNotification();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    final notification = message.notification;
    if (notification == null) return;
    _localNotification.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          sound: _androidChannel.sound,
          icon: '@mipmap/ic_launcher', // ✅ استخدام الأيقونة الجاهزة
        ),
      ),
      payload: jsonEncode(message.toMap()),
    );
    // navigatorKey.currentState!.pushNamed(
    //   'home',
    //   arguments: message,
    // );
  }

  Future<void> initPushNotification() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            sound: _androidChannel.sound,
            icon: '@mipmap/ic_launcher', // ✅ استخدام الأيقونة الجاهزة
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> initLocalNotification() async {
    // ✅ تعريف AndroidInitializationSettings بشكل صحيح
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings darwinInitializationSettings =
    DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );

    await _localNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final String data = jsonEncode(details);
        final message = RemoteMessage.fromMap(jsonDecode(data));
        handleMessage(message);
      },
    );

    final AndroidFlutterLocalNotificationsPlugin? platform =
    _localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }
}
