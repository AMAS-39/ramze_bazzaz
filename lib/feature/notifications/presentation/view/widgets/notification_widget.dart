import 'package:app/core/shared/imports.dart';
import 'package:app/feature/notifications/data/datasources/local_notifications.dart';
import 'package:app/feature/notifications/data/models/mark_as_read_model.dart';
import 'package:app/feature/notifications/data/models/notifications_model.dart';
import 'package:app/feature/notifications/presentation/blocs/all/notifications_bloc.dart';
import 'package:app/widgets/image_cheker.dart';
import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationModel notification;
  const NotificationWidget({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (notification.readAt == null) {
            sl<NotificationsBloc>().add(NotificationMarkOneEvent(
                model: MarkNotificationAsReadModel(id: notification.id)));
          }
          handleNotificationNavigation(notification.toNotificationHelper);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ImageChecker(
                    imageUrl: null,
                    radius: 360,
                    errorImage: appConfig.logo,
                    height: 40,
                    width: 40,
                  ),
                  if (notification.readAt == null)
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 2)),
                        )),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.data.title ?? "",
                      style: context.style16W500B,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.createdAt.getChatMessage,
                      style: context.style12W400B,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
