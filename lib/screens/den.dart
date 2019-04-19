
import 'package:flutter/material.dart';

import './../palette.dart';
import '../style.dart';
import './../custom_icons.dart';
import './../components/bottom_nav/bottom_nav.dart';

import '../components/appbar_border/appbar_border.dart';


class JuntoDen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: 
        PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(
            backgroundColor: JuntoPalette.juntoWhite,
            // backgroundColor: Colors.blue,
            brightness: Brightness.light,
            elevation: 0,   
            title: 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Row(
                children: <Widget>[
                  Image.asset('assets/images/junto-mobile__logo--den.png',
                      height: 20.0, width: 20.0),
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'DEN',
                      textAlign: TextAlign.center,
                      style: JuntoStyles.appbarTitle

                    ),
                  ),
                ],
              ),

          IconButton(
              alignment: Alignment.centerRight,
              icon: Icon(CustomIcons.moon),
              iconSize: 20.0,
              color: JuntoPalette.juntoSleek,
              tooltip: 'open notifcations',
              onPressed: () {
                // ...
              },
            ),
          ])
        ),),

        body: Column(
          children: <Widget>[
            // App bar border
            AppbarBorder(JuntoPalette.juntoGrey)
          ],
        ),
        bottomNavigationBar: BottomNav());
  }
}
