// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  static Future initialize(FlutterLocalNotificationsPlugin FNP) async {
    var androidIntitialize =
        const AndroidInitializationSettings("mipmap/ic_launcher");
    var initializationSetting =
        InitializationSettings(android: androidIntitialize);
    await FNP.initialize(initializationSetting);
  }

  static Future showbigTextNotification(
      {var id = 0,
      required String title,
      required String body,
      required String Payload,
      required FlutterLocalNotificationsPlugin FLN}) async {
    AndroidNotificationDetails AND = AndroidNotificationDetails(
        "Nebak", 'be wise',
        importance: Importance.max, priority: Priority.high);
    var not = NotificationDetails(
      android: AND,
    );
    await FLN.show(id, title, body, not);
  }
}


// ignore_for_file: file_names

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationApi {
//   static final _notifications = FlutterLocalNotificationsPlugin();
//   static Future notificationDetails() async {
//     return const NotificationDetails(
//       android: AndroidNotificationDetails('channelId', 'channelName', 'channelDescription',importance: Importance.max)
//     );
//   }

//   static Future showNotification({
//     int id = 0,
//     required String title,
//     required String body,
//     required String Payload,
//   }) async =>
//       _notifications.show(id, title, body, await notificationDetails(),
//           payload: Payload);
// }
