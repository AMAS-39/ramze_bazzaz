import 'package:app/core/shared/imports.dart';
import 'package:app/core/shared/language.dart';
import 'package:app/feature/account/data/datasources/account_remote_data_source.dart';
import 'package:app/feature/account/presentation/bloc/account/account_bloc.dart';
import 'package:app/feature/notifications/data/datasources/local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../models/notification_helper_model.dart';

class NotificationHelper {
  static final NotificationHelper _singleton = NotificationHelper._();
  static NotificationHelper get i => _singleton;
  NotificationHelper._();

  Future<void> initFirebase() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    await LocalNotificationHelper.i.init();

    try {
      final String? newToken = await firebaseMessaging.getToken();
      _saveNewToken(newToken);
    } catch (e) {
      logger("Error in get token");
    }

    firebaseMessaging.onTokenRefresh.listen((String? newToken) {
      _saveNewToken(newToken);
    });
    getNotificationPermission();
    FirebaseMessaging.onMessage.listen((message) {
      _onRefresh();
      logger("onMessage ${message.toMap()}");
      LocalNotificationHelper.i.showNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _onRefresh();
      logger("onMessageOpenedApp ${message.toMap()}");

      handleNotificationClick(message.data);
    });

    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        handleNotificationClick(value.data);
      }
    });
    if (sl<AccountBloc>().info != null) {
      subscribe(sl<AccountBloc>().info!.id.toString(), appConfig.test);
    }
  }

  Future<void> _onRefresh() async {
    // sl<NotificationsBloc>().add(const NotificationLoadEvent());
  }

  void getNotificationPermission() async {
    final res = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      sound: true,
    );
    logger("NotificationSettings  $res");
  }

  void _saveNewToken(String? token) {
    logger("token $token");
    if (checkIsNull(token)) {
      return;
    }
    if (sl<AccountBloc>().info != null && token != null) {
      sl<AccountRemoteSrc>().updateToken(token: token);
    }
  }

  void setNewLang(String newLang) async {
    for (var element in languages) {
      await unSubscribe(element.code.name, true);
      await unSubscribe(element.code.name, false);
    }
    subscribe(newLang, appConfig.test);
  }

  Future<void> subscribe(String topic, bool isTestP) async {
    logger("topic $topic");
    if (kIsWeb) {
      return;
    }
    try {
      if (checkIsNull(topic)) {
        logger("topic is null $topic");
        return;
      }
      FirebaseMessaging.instance.subscribeToTopic(_getTopic(topic, isTestP));
    } catch (e, c) {
      logger("Error in subscribe $e");
      recoredError(e, c);
    }
  }

  Future<void> unSubscribe(String newLang, bool isTestP) async {
    try {
      if (kIsWeb) {
        return;
      }
      FirebaseMessaging.instance
          .unsubscribeFromTopic(_getTopic(newLang, isTestP));
    } catch (e) {
      logger("e   $e");
    }
  }

  String _getTopic(String lang, bool isTestP) {
    if (isTestP) {
      return "debug_$lang";
    }
    return lang;
  }
}

void handleNotificationClick(Map<String, dynamic> data) {
  NotificationHelperModel notification = NotificationHelperModel.fromMap(data);
  handleNotificationNavigation(notification);
}
