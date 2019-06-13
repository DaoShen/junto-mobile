
import 'package:flutter/material.dart';

import './preview_profile.dart';
import './preview_bottom.dart';
import './longform_preview/longform_preview.dart';
import './shortform_preview/shortform_preview.dart';
import './bullet_preview/bullet_preview.dart';
import './photo_preview/photo_preview.dart';
import './event_preview/event_preview.dart';
import './music_preview/music_preview.dart';
import '../../screens/expression_open/expression_open.dart';

/// Renders a concise overview of one given [Expression]. 
class ExpressionPreview extends StatelessWidget {

  final expression; 
  ExpressionPreview(this.expression);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          // expression preview profile 
          PreviewProfile('sunyata'),

          // open expression
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ExpressionOpen(expression)
              ));
            },
            // expression preview body
            child: _returnExpression(),
          ),
          
          // expression preview channels, resonation, and comments
          PreviewBottom(expression.time, expression.channelOne, expression.channelTwo, expression.channelThree)

        ],
      ),
    );
  }

  Widget _returnExpression() { 
    if (expression.expressionType == 'longform') {
      return LongformPreview(expression.title, expression.body);
    } else if(expression.expressionType == 'shortform') {
      return ShortformPreview(expression.shortformText);
    } else if(expression.expressionType == 'bullet') {
      return BulletPreview();
    } else if(expression.expressionType == 'photo') {
      return PhotoPreview(expression.image, expression.imageCaption);
    } else if(expression.expressionType == 'event') {
      return EventPreview(expression.title, expression.location, expression.image);
    } else if(expression.expressionType == 'music') {
      return MusicPreview();
    } else {
      return Container(width: 0, height: 0,);
    }
  }
   
}