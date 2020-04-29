import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junto_beta_mobile/app/custom_icons.dart';
import 'package:junto_beta_mobile/screens/notifications/notifications.dart';
import 'package:junto_beta_mobile/screens/notifications/notifications_handler.dart';
import 'package:provider/provider.dart';

class NotificationsLunarIcon extends StatelessWidget {
  const NotificationsLunarIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationsHandler>(
      builder: (context, data, child) {
        return NotificationsIcon(unread: data.unreadNotifications);
      },
    );
  }
}

class NotificationsIcon extends StatelessWidget {
  final bool unread;

  const NotificationsIcon({
    Key key,
    this.unread,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Notifications',
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => NotificationsScreen(),
            ),
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            Icon(
              CustomIcons.moon,
              size: 22,
              color: Theme.of(context).primaryColor,
            ),
            if (unread)
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    color: Theme.of(context).accentColor,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
