import 'package:flutter/material.dart';
import 'package:junto_beta_mobile/models/expression.dart';
import 'package:junto_beta_mobile/palette.dart';
import 'package:junto_beta_mobile/styles.dart';

class LongformPreview extends StatelessWidget {
  const LongformPreview({
    Key key,
    @required this.expression,
  }) : super(key: key);

  final Expression expression;

  @override
  Widget build(BuildContext context) {
    final String expressionBody =
        expression.expression.expressionContent['body'];
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: JuntoStyles.horizontalPadding,
        vertical: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitle(),
          Text(expressionBody,
              textAlign: TextAlign.left,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: JuntoStyles.longformPreviewBody),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    final String expressionTitle =
        expression.expression.expressionContent['title'];
    if (expressionTitle != '') {
      return Container(
        child: Text(expressionTitle,
            textAlign: TextAlign.left, style: JuntoStyles.longformPreviewTitle),
      );
    } else {
      return const SizedBox();
    }
  }
}
