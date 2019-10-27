import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junto_beta_mobile/app/styles.dart';
import 'package:junto_beta_mobile/models/expression.dart';
import 'package:junto_beta_mobile/models/user_model.dart';
import 'package:junto_beta_mobile/screens/member/member.dart';
import 'package:junto_beta_mobile/widgets/expression_action_items.dart';

class ExpressionPreviewTop extends StatelessWidget {
  const ExpressionPreviewTop({
    Key key,
    this.expression,
  }) : super(key: key);

  final CentralizedExpressionResponse expression;

  @override
  Widget build(BuildContext context) {
    //ignore: unused_local_variable
    final String firstName = expression.creator.firstName;
    //ignore: unused_local_variable
    final String lastName = expression.creator.lastName;
    final String username = expression.creator.username;
    final String profilePicture = expression.creator.profilePicture;

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: JuntoStyles.horizontalPadding, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute<dynamic>(
                  builder: (
                    BuildContext context,
                  ) =>
                      JuntoMember(
                    profile: UserProfile(
                      address: '',
                      firstName: firstName,
                      lastName: lastName,
                      bio: 'This is a test',
                      profilePicture: profilePicture,
                      username: username,
                      verified: false,
                    ),
                  ),
                ),
              );
            },
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // profile picture
                  ClipOval(
                    child: Image.asset(
                      profilePicture.isEmpty
                          ? 'assets/images/junto-mobile__junto.png'
                          : profilePicture,
                      height: 38.0,
                      width: 38.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    child: Text(
                      username,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return const ExpressionActionsItems();
                    },
                  );
                },
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xff555555),
                  size: 20,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
