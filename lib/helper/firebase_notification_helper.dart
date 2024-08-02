import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mini_project_3/main.dart';

class Firebase_Notification {
  final _firebaseMessaging = FirebaseMessaging.instance;
  // final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics();
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    initPushNotification();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      '/notification_firebase',
      arguments: message,
    );
  }

  Future initPushNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
