import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectedActionItems extends StatelessWidget {
  const ConnectedActionItems({
    this.subscribeToUser,
    this.connectWithUser,
    this.inviteToPack,
  });

  final Future<void> subscribeToUser;
  final Future<void> connectWithUser;
  final Future<void> inviteToPack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border(
                bottom: BorderSide(
                    color: Theme.of(context).dividerColor, width: .5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'SUBSCRIBED',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.none,
                      letterSpacing: 1.2),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).backgroundColor, width: 1.2),
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: const <double>[0.1, 0.9],
                      colors: <Color>[
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.primary
                      ],
                    ),
                  ),
                  child: Icon(Icons.check, size: 15, color: Colors.white),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Theme.of(context).dividerColor, width: .5),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'CONNECTED',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.none,
                      letterSpacing: 1.2),
                ),
                Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).backgroundColor, width: 1.2),
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: const <double>[0.1, 0.9],
                        colors: <Color>[
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).colorScheme.primary
                        ],
                      ),
                    ),
                    child: Icon(Icons.check, size: 15, color: Colors.white))
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Theme.of(context).dividerColor, width: .5),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'INVITE TO PACK',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.none,
                      letterSpacing: 1.2),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 1.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(Icons.add,
                      size: 15, color: Theme.of(context).primaryColor),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
