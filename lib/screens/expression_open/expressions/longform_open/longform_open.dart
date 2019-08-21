import 'package:flutter/material.dart';
import 'package:junto_beta_mobile/models/expression.dart';

class LongformOpen extends StatelessWidget {
  const LongformOpen(this.longformExpression);

  final ExpressionResult longformExpression;

  @override
  Widget build(BuildContext context) {
    final String longformTitle =
        longformExpression.result[0].expression.expressionContent['title'];
    final String longformBody =
        longformExpression.result[0].expression.expressionContent['body'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 5),
            child: Text(
              longformTitle,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  height: 1.1),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              longformBody,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 15, height: 1.2),
            ),
          ),
        ],
      ),
    );
  }
}
