
import 'package:flutter/material.dart';

import './../../palette.dart';
import './../../custom_icons.dart';
import '../../style.dart';

import '../../components/appbar_border/appbar_border.dart';
import '../../components/bottom_nav/bottom_nav.dart';

import '../../models/perspective.dart';

import './perspective_template.dart';

class JuntoPerspectives extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _JuntoPerspectivesState();
  }
}

class _JuntoPerspectivesState extends State {

  List perspectives;

  @override
  void initState() {
    super.initState();

    perspectives = Perspective.fetchPerspective();
  }

  @override
  Widget build(BuildContext context) {  

    return Scaffold(
      backgroundColor: Colors.white,
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
                      'PERSPECTIVES',
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
            AppbarBorder(JuntoPalette.juntoGrey),

            // Expanded(child: ListView(
            //   children: 
            //     // Collective perspective widget
            //     PerspectiveTemplate('COLLECTIVE'),

            //     // Selective perspective widget
            //     PerspectiveTemplate('SELECTIVE'),

            //     perspectives.map((perspective) => PerspectiveTemplate(perspective.perspectiveTitle)).toList(),


              
            // ),)

              Expanded(
                child: ListView(
                children:               
                  perspectives.map((perspective) => 
                  PerspectiveTemplate(perspective.perspectiveTitle)).toList(),
              ))                
            
          ],
        ),

        bottomNavigationBar: BottomNav(),
    );
  }
}
