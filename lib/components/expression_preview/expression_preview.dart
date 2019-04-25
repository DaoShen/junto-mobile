
import 'package:flutter/material.dart';

import './preview_profile.dart';
import './preview_bottom.dart';

// expression types
import './longform_preview.dart';
import './shortform_preview.dart';
import './bullet_preview.dart';
import './photo_preview.dart';
import './event_preview.dart';
import './music_preview.dart';
import './video_preview.dart';

import './channel_preview.dart';
/// Renders a concise overview of one given [Expression]. 
class ExpressionPreview extends StatelessWidget {

  final expression; 

  ExpressionPreview(this.expression);

  final String urk = 'sunyatax'; 

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
      return EventPreview();
    } else if(expression.expressionType == 'music') {
      return MusicPreview();
    } else if(expression.expressionType == 'video') {
      return VideoPreview();
    } else {
      return Container(width: 0, height: 0,);
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          // expression preview profile
          PreviewProfile(urk),

          // expression preview body
          _returnExpression(),
          
          // expression preview channels, resonation, and comments
          PreviewBottom(expression.time, expression.channelOne, expression.channelTwo, expression.channelThree)

        ],
      ),
    );
  }
}