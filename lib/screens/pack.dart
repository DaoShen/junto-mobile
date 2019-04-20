
import 'package:flutter/material.dart';

import './../palette.dart';
import '../style.dart';
import './../custom_icons.dart';
import './../components/bottom_nav/bottom_nav.dart';

import '../components/appbar_border/appbar_border.dart';

import '../models/pack.dart';
import './pack/pack_preview.dart';


class JuntoPack extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _JuntoPackState();
  }
}

class _JuntoPackState extends State {
  List packs;

  @override
  void initState() {
    super.initState();

    packs = Pack.fetchPack();
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
                  Image.asset('assets/images/junto-mobile__logo--pack.png',
                      height: 20.0, width: 20.0),
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'PACKS',
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
            AppbarBorder(JuntoPalette.juntoPurple),

            // My Pack
            Container(
              height: 90.0,
              padding: EdgeInsets.symmetric(horizontal: 17.0),
              color: Colors.white,
              foregroundDecoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: .75, color: Color(0xffeeeeee)),
                ),
              ),              
              child: Row(
                children: <Widget>[
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipOval(                                                                        
                          child: Image.asset(
                            'assets/images/junto-mobile__eric.png',
                            height: 36.0,
                            width: 36.0,
                            fit: BoxFit.cover,
                            
                          ),
                        ),                    

                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('The Gnarly Nomads', textAlign: TextAlign.start,),
                            Text('Eric Yang', textAlign: TextAlign.start,)
                          ],
                        ),)
                  ],),

                ],
              )

            ),

                // Search packs text field
                Container(
                  alignment: Alignment.center,
                  height: 75.0,
                  padding: EdgeInsets.symmetric(horizontal: 17.0),
                  width: 1000,
                  color: Colors.white,
                  foregroundDecoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: .75, color: Color(0xffeeeeee)),
                    ),
                  ),
                  child: 
                    TextField(
                      cursorColor: JuntoPalette.juntoGrey,
                      cursorWidth: 1.0,
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, size: 14.0, color: JuntoPalette.juntoGrey),            
                        border: InputBorder.none,
                        hintText: 'filter by channel',
                        hintStyle: TextStyle(color: JuntoPalette.juntoGrey, fontSize: 14.0)
                      
                      ),
                    )
                ) ,

                Expanded(
                  child: ListView(
                    children: packs.map((pack) => PackPreview(pack.packTitle, pack.packUser)).toList()
                  )
                )       
            
          ],
        ),
        bottomNavigationBar: BottomNav());
  }
}
