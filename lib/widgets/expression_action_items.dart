import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:junto_beta_mobile/backend/repositories.dart';
import 'package:junto_beta_mobile/models/expression.dart';
import 'package:junto_beta_mobile/screens/member/member.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
import 'package:junto_beta_mobile/utils/junto_dialog.dart';
import 'package:junto_beta_mobile/utils/junto_overlay.dart';
=======
>>>>>>> project clean up

class ExpressionActionItems extends StatelessWidget {
  const ExpressionActionItems({
    this.expression,
    this.userAddress,
  });

  final CentralizedExpressionResponse expression;
  final String userAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * .4,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * .1,
                      decoration: BoxDecoration(
                          color: Theme.of(context).dividerColor,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                userAddress == expression.creator.address
                    ? _myActionItems(context)
                    : _memberActionItems(context)
              ],
            ),
          ],
        ),
      ),
    );
  }

  // show these action items if the expression was created by user
  Widget _myActionItems(
    BuildContext context,
  ) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            JuntoDialog.showJuntoDialog(
              context,
              'Are you sure you want to delete this expression?',
              <Widget>[
                FlatButton(
                  onPressed: () async {
                    JuntoLoader.showLoader(context);
                    try {
                      await Provider.of<ExpressionRepo>(context, listen: false)
                          .deleteExpression(expression.address);

                      JuntoLoader.hide();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } catch (error) {
                      print(error);
                      print(error.message);
                      Navigator.pop(context);
                      JuntoLoader.hide();
                      JuntoDialog.showJuntoDialog(
                        context,
                        'Sorry, something went wrong',
                        <Widget>[
                          FlatButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            child: const Text('Ok'),
                          )
                        ],
                      );
                    }
                  },
                  child: const Text('Yes'),
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No'))
              ],
            );
            // delete expression
            // Provider.of<ExpressionRepo>(context, listen: false)
            //     .deleteExpression(expression.address);
          },
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          title: Row(
            children: <Widget>[
              Text('Delete Expression',
                  style: Theme.of(context).textTheme.headline),
            ],
          ),
        ),
      ],
    );
  }

  // show these action items if the expression belongs to another user
  Widget _memberActionItems(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.pop(context);
            // view den
            Navigator.push(
              context,
              CupertinoPageRoute<Widget>(
                builder: (BuildContext context) => JuntoMember(
                  profile: expression.creator,
                ),
              ),
            );
          },
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          title: Row(
            children: <Widget>[
              Text('View @' + expression.creator.username + "'s den",
                  style: Theme.of(context).textTheme.headline),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            // subscribe to user
          },
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          title: Row(
            children: <Widget>[
              Text('Subscribe @' + expression.creator.username,
                  style: Theme.of(context).textTheme.headline),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            // connect with user
          },
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          title: Row(
            children: <Widget>[
              Text('Connect @' + expression.creator.username,
                  style: Theme.of(context).textTheme.headline),
            ],
          ),
        ),
      ],
    );
  }
}
