import 'package:flutter/material.dart';

import '../../../custom_icons.dart';
import './../expression_open_channel/expression_open_channel.dart';

class ExpressionOpenBottom extends StatefulWidget {
  final expression;

  ExpressionOpenBottom(this.expression);

  @override
  State<StatefulWidget> createState() {
    return ExpressionOpenBottomState();
  }
}

class ExpressionOpenBottomState extends State<ExpressionOpenBottom> {

  @override
  Widget build(BuildContext context) {
    String timestamp = widget.expression.timestamp; 

    return Container(
        margin: EdgeInsets.only(top: 7.5),
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xffeeeeee), width: .5),
          ),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(timestamp + ' MINUTES AGO', style: TextStyle(fontSize: 10, color: Color(0xff555555))),
              Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Icon(CustomIcons.half_lotus, size: 14))
            ]),);
  }
}
