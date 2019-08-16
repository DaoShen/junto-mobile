import 'package:flutter/material.dart';
import 'package:junto_beta_mobile/components/expression_preview/longform_preview/longform_preview.dart';
import 'package:junto_beta_mobile/components/expression_preview/preview_bottom.dart';
import 'package:junto_beta_mobile/components/expression_preview/preview_profile.dart';
import 'package:junto_beta_mobile/components/expression_preview/shortform_preview/shortform_preview.dart';
import 'package:junto_beta_mobile/screens/expression_open/expression_open.dart';

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
          PreviewProfile(expression),

          // open expression
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExpressionOpen(expression),
                ),
              );
            },
            // expression preview body
            child: _returnExpression(),
          ),
          // expression preview channels, resonation, and comments
          PreviewBottom(expression)
        ],
      ),
    );
  }

  Widget _returnExpression() {
    if (expression.expression['entry']['expression_type'] == 'longform') {
      return LongformPreview(expression);
    } else if (expression.expression['entry']['expression_type'] ==
        'shortform') {
      return ShortformPreview(expression);
    } else {
      return Container();
    }
    // else if(expression.expression['entry']['expression_type'] == 'photoform') {
    //   return PhotoPreview(expression);
    // } else if(expression.expression['entry']['expression_type'] == 'eventform') {
    //   return EventPreview(expression);
    // } else {
    //   return Container(width: 0, height: 0,);
    // }
  }
}
