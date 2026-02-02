import 'dart:convert';
import 'dart:io';

import 'package:app/core/shared/imports.dart';
import 'package:app/feature/notifications/data/datasources/notifications_services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../models/notification_helper_model.dart';

class LocalNotificationHelper {
  static final LocalNotificationHelper _singleton = LocalNotificationHelper._();
  static LocalNotificationHelper get i => _singleton;
  LocalNotificationHelper._();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future onSelectNotification(NotificationResponse notificationDetails) async {
    if (notificationDetails.payload == null ||
        notificationDetails.payload!.isEmpty) {
      return;
    }
    logger("notificationDetails.payload ${notificationDetails.payload}");
    handleNotificationClick(json.decode(notificationDetails.payload!));
  }

  Future<void> showNotification(RemoteMessage remoteMessage) async {
    try {
      String? file = await _downloadAndSaveFile(
          Platform.isAndroid
              ? remoteMessage.notification?.android?.imageUrl
              : remoteMessage.notification?.apple?.imageUrl!,
          "image");

      logger("filePath $file");
      AndroidNotificationDetails android = AndroidNotificationDetails(
          pushNotification, Trans.notifications.trans(),
          channelDescription: Trans.notifications.trans(),
          importance: Importance.high,
          priority: Priority.high,
          styleInformation: file == null
              ? null
              : BigPictureStyleInformation(FilePathAndroidBitmap(file)),
          color: Helper.i.context.primaryColor,
          colorized: true);

      DarwinNotificationDetails ios = DarwinNotificationDetails(attachments: [
        if (file != null)
          DarwinNotificationAttachment(file, hideThumbnail: false)
      ]);
      NotificationDetails platform =
          NotificationDetails(android: android, iOS: ios);

      await flutterLocalNotificationsPlugin.show(
          DateTime.now().hour + DateTime.now().minute + DateTime.now().second,
          remoteMessage.notification?.title,
          remoteMessage.notification?.body,
          platform,
          payload:
              json.encode(NotificationHelperModel.fromMap(remoteMessage.data)
                  .copyWith(
                    title: remoteMessage.notification?.title,
                  )
                  .toMap()));
    } catch (e, c) {
      logger("error in show notification $e");
      recoredError(e, c);
    }
  }

  Future<void> init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    InitializationSettings platform = const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings("ic_skylight_notification"));
    await _createNewChannel();
    flutterLocalNotificationsPlugin.initialize(platform,
        onDidReceiveNotificationResponse: onSelectNotification);
  }

  Future<void> _createNewChannel() async {
    try {
      AndroidNotificationChannel channel = AndroidNotificationChannel(
        pushNotification,
        Trans.notifications.trans(),
        description: Trans.notifications.trans(),
        importance: Importance.high,
        playSound: true,
      );
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      logger("channel created");
    } catch (e, c) {
      logger("error in create channel $e");
      recoredError(e, c);
    }
  }
}

Future<String?> _downloadAndSaveFile(String? url, String fileName) async {
  try {
    if (url == null) {
      return null;
    }
    final Directory directory = await getTemporaryDirectory();
    final String filePath = '${directory.path}/$fileName.png';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  } catch (e) {
    logger("error in dowload image $e");
    return null;
  }
}

void handleNotificationNavigation(NotificationHelperModel notification) {
  logger("notification $notification");
  if (notification.jobId == 0 || notification.type == NotificationType.none) {
    return;
  } else if (notification.type == NotificationType.order) {
    // Helper.i.context
    //     .to(JobDetalisScreen(name: notification.title, id: notification.jobId));
  }
}
