import 'package:flutter/material.dart';
import 'package:junto_beta_mobile/models/expression.dart';

/// Displays the given [image] and [imageCaption]
class PhotoPreview extends StatelessWidget {
  const PhotoPreview({
    Key key,
    @required this.expression,
  }) : super(key: key);

  final CentralizedExpressionResponse expression;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: MediaQuery.of(context).size.height * .3,
        child: expression.expressionData.image == 'test-image'
            ? SizedBox()
            : Image.asset('assets/images/' + expression.expressionData.image,
                fit: BoxFit.fitHeight),
      ),
    );
  }
}
