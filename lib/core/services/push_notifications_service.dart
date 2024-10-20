import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class IPushNotificationService {
  Future<void> init();
}

class PushNotificationService extends IPushNotificationService {

  @override
  Future<void> init() async {
    try {
      final notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true);

      print('akjfdhgkdfjahkjnzvj;ds;kjfzjlxfh $notificationSettings');
      final apnsToken = await FirebaseMessaging.instance.getToken();
      log('TOKEN: $apnsToken');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print('Message also contained a notification: ${message.notification}');
        }
      });
    }
    catch (e) {
      print('akjfdhgkdfjahkjnzvj;ds;kjfzjlxfh');
      print(e);
    }

  }
}