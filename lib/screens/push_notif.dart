// import 'dart:convert';
// import 'dart:math';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class CloudMessaging {
//   static Future<void> initialize() async {
//     await Firebase.initializeApp();

//     FirebaseMessaging.instance.requestPermission();

//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       if (message != null) {
//         NotificationHelper.payload.value = jsonEncode({
//           "title": message.notification?.title,
//           "body": message.notification?.body,
//           "data": message.data,
//         });
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       NotificationHelper.payload.value = jsonEncode({
//         "title": message.notification?.title,
//         "body": message.notification?.body,
//         "data": message.data,
//       });
//     });

//     FirebaseMessaging.onMessage.listen((message) async {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;

//       if (notification != null && android != null && !kIsWeb) {
//         await NotificationHelper.flutterLocalNotificationsPlugin.show(
//           Random().nextInt(99),
//           notification.title,
//           notification.body,
//           NotificationHelper.notificationDetails,
//           payload: jsonEncode({
//             "title": notification.title,
//             "body": notification.body,
//             "data": message.data,
//           }),
//         );
//       }
//     });
//   }
// }
