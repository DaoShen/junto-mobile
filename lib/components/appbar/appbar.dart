import 'package:flutter/material.dart';

// typography + icons
import '../../custom_icons.dart';
import '../../typography/palette.dart';
import '../../typography/style.dart';

class juntoAppBar {

   static getJuntoAppBar(_juntoAppBarLogo, _juntoAppBarTitle) {
    return PreferredSize(
      preferredSize: Size.fromHeight(45.0),
      child: AppBar(
        backgroundColor: JuntoPalette.juntoWhite,
        // backgroundColor: Colors.blue,
        brightness: Brightness.light,
        elevation: 0,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: <Widget>[
              Image.asset(_juntoAppBarLogo,
                  height: 20.0, width: 20.0),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Text(_juntoAppBarTitle,
                    textAlign: TextAlign.center,
                    style: JuntoStyles.appbarTitle),
              ),
            ],
          ),
          IconButton(
            alignment: Alignment.centerRight,
            icon: Icon(CustomIcons.moon),
            iconSize: 20.0,
            color: JuntoPalette.juntoSleek,
            tooltip: 'open notifcations',
            onPressed: () {},
          ),
        ]),
      ),
    );
  }
}
