import 'package:flutter/material.dart';
import 'package:junto_beta_mobile/screens/create/bullet/bullet.dart';
import 'package:junto_beta_mobile/screens/create/create_actions/create_actions.dart';
import 'package:junto_beta_mobile/screens/create/create_bottom_nav.dart';
import 'package:junto_beta_mobile/screens/create/event/event.dart';
import 'package:junto_beta_mobile/screens/create/longform/longform.dart';
import 'package:junto_beta_mobile/screens/create/photo/photo.dart';
import 'package:junto_beta_mobile/screens/create/shortform/shortform.dart';
import 'package:junto_beta_mobile/typography/style.dart';

class JuntoCreate extends StatefulWidget {
  const JuntoCreate(this.expressionLayer);

  final String expressionLayer;

  @override
  State<StatefulWidget> createState() {
    return JuntoCreateState();
  }
}

class JuntoCreateState extends State<JuntoCreate> {
  String _expressionType = 'Longform';
  bool _longform = true;
  bool _shortform = false;
  bool _bullet = false;
  bool _photo = false;
  bool _events = false;

  bool _bottomNavVisible = true;

  void _toggleBottomNavVisibility() {
    if (_bottomNavVisible) {
      setState(() {
        _bottomNavVisible = false;
      });
    } else {
      setState(() {
        _bottomNavVisible = true;
      });
    }
  }

  // Build expression template based off state
  Widget _buildTemplate() {
    if (_longform) {
      return CreateLongform();
    } else if (_shortform) {
      return CreateShortform();
    } else if (_bullet) {
      return CreateBullet();
    } else if (_photo) {
      return CreatePhoto(_toggleBottomNavVisibility);
    } else if (_events) {
      return CreateEvent();
    } else {
      return Container();
    }
  }

  // Reset all values in state to false
  void _resetState() {
    setState(() {
      _longform = false;
      _shortform = false;
      _bullet = false;
      _photo = false;
      _events = false;
    });
  }

  /// Ask for user confirmation to switch between expressions if field is no
  /// empty
  void confirmSwitch() {}

  // Switch between different expression templates
  void switchTemplate(String templateType) {
    // Reset State
    _resetState();

    // Update expression type
    _expressionType = templateType;

    // Update state
    if (templateType == 'longform') {
      setState(() {
        _longform = true;
      });
    } else if (templateType == 'shortform') {
      setState(() {
        _shortform = true;
      });
    } else if (templateType == 'bullet') {
      setState(() {
        _bullet = true;
      });
    } else if (templateType == 'photo') {
      setState(() {
        _photo = true;
      });
    } else if (templateType == 'events') {
      setState(() {
        _events = true;
      });
    } else {
      print('not an expresion type');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(_expressionType,
                    textAlign: TextAlign.start,
                    style: JuntoStyles.lotusExpressionType),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) =>
                            CreateActions(widget.expressionLayer),
                      ),
                    );
                  },
                  child: const Text(
                    'next',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ),
          ),
          _buildTemplate(),
        ],
      ),
      bottomNavigationBar: CreateBottomNav(switchTemplate, _bottomNavVisible),
    );
  }
}
