
import 'package:flutter/material.dart';

import './../../palette.dart';

class FilterChannelCollective extends StatelessWidget {
  String textValue = '';

  @override
  Widget build(BuildContext context) {

    return 
      // filter by channel
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
      );
  }
}



