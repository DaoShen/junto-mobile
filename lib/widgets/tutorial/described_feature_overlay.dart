import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:feature_discovery/feature_discovery.dart';

class JuntoDescribedFeatureOverlay extends StatelessWidget {
  const JuntoDescribedFeatureOverlay({
    this.icon,
    this.featureId,
    this.title,
    this.contentLocation = ContentLocation.below,
    this.learnMore = false,
    this.isLastFeature = false,
    this.child,
  });

  final dynamic icon;
  final String featureId;
  final String title;
  final ContentLocation contentLocation;
  final bool learnMore;
  final bool isLastFeature;
  final Widget child;

  _actionItemButton(BuildContext context, String name, Function onPressed) {
    return FlatButton(
      padding: const EdgeInsets.all(0),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DescribedFeatureOverlay(
      tapTarget: icon,
      featureId: featureId,
      backgroundColor: Theme.of(context).accentColor,
      contentLocation: contentLocation,
      overflowMode: OverflowMode.extendBackground,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      targetColor: Theme.of(context).backgroundColor,
      enablePulsingAnimation: false,
      description: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (learnMore)
            _actionItemButton(
              context,
              'Learn More',
              () {},
            ),
          if (!isLastFeature)
            _actionItemButton(
              context,
              'Next Feature',
              () async => FeatureDiscovery.completeCurrentStep(context),
            ),
          _actionItemButton(
            context,
            'Dismiss',
            () async => FeatureDiscovery.dismissAll(context),
          ),
        ],
      ),
      child: child,
    );
  }
}
