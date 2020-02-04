import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junto_beta_mobile/app/custom_icons.dart';
import 'package:junto_beta_mobile/backend/repositories.dart';
import 'package:junto_beta_mobile/models/models.dart';
import 'package:junto_beta_mobile/screens/member/member.dart';
import 'package:junto_beta_mobile/utils/junto_dialog.dart';
import 'package:junto_beta_mobile/utils/junto_exception.dart';
import 'package:junto_beta_mobile/utils/junto_overlay.dart';
import 'package:provider/provider.dart';

class RelationshipRequest extends StatelessWidget {
  const RelationshipRequest(this.user);

  final UserProfile user;

  Future<void> _acceptConnection(
    BuildContext context,
    UserProfile _connection,
  ) async {
    try {
      JuntoLoader.showLoader(context);
      await Provider.of<UserRepo>(context, listen: false).respondToConnection(
        user.address,
        true,
      );
      JuntoLoader.hide();
      Navigator.pop(context);
    } on JuntoException catch (error) {
      JuntoDialog.showJuntoDialog(context, '${error.message}', <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Ok'),
        ),
      ]);
      print('Error accepting connection ${error.message}');
    }
  }

  Future<void> _rejectConnection(
    BuildContext context,
    UserProfile _connection,
  ) async {
    try {
      JuntoLoader.showLoader(context);
      await Provider.of<UserRepo>(context).respondToConnection(
        user.address,
        false,
      );
      JuntoLoader.hide();
    } on JuntoException catch (error) {
      JuntoLoader.hide();

      JuntoDialog.showJuntoDialog(context, '${error.message}', <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Ok'),
        ),
      ]);
      print('Error rejecting connection ${error.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute<dynamic>(
            builder: (BuildContext context) => JuntoMember(profile: user),
          ),
        );
      },
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 45.0,
                  width: 45.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: const <double>[0.3, 0.9],
                      colors: <Color>[
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.primary
                      ],
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Image.asset(
                      'assets/images/junto-mobile__logo--white.png',
                      height: 15),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 75,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: .5,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            user.username,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(user.name,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyText1)
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              _acceptConnection(context, user);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 1),
                              ),
                              height: 38,
                              width: 38,
                              child: Icon(CustomIcons.check,
                                  size: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              _rejectConnection(context, user);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 1),
                              ),
                              height: 38,
                              width: 38,
                              child: Icon(CustomIcons.cancel,
                                  size: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
