import 'package:flutter/material.dart';
import 'package:junto_beta_mobile/models/notification.dart';
import 'package:junto_beta_mobile/screens/notifications/widgets/user_profile_picture.dart';
import 'package:junto_beta_mobile/screens/notifications/widgets/accept_connection_request.dart';
import 'package:junto_beta_mobile/screens/notifications/utils/username_text_span.dart';

class ConnectionRequestNotification extends StatelessWidget {
  final JuntoNotification item;

  const ConnectionRequestNotification({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          UserProfilePicture(item: item),
          const SizedBox(width: 10),
          Flexible(
            child: RichText(
              text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
                  children: <TextSpan>[
                    UsernameTextspan(item: item).retrieveTextSpan(context),
                    TextSpan(text: 'sent you a connection request.')
                  ]),
            ),
          ),
          const SizedBox(width: 10),
          AcceptConnectionRequest(userAddress: item.user.address),
        ],
      ),
    );
  }
}
