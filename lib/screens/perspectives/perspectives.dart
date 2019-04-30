
import 'package:flutter/material.dart';

// typography
import './../../typography/palette.dart';

// app bar + bottom nav
import '../../components/appbar/appbar.dart';
import '../../components/bottom_nav/bottom_nav.dart';

// perspective view + model
import '../../models/perspective.dart';
import './perspective_preview.dart';
import '../../components/filter/filter_perspectives/filter_perspectives.dart';

class JuntoPerspectives extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _JuntoPerspectivesState();
  }
}

class _JuntoPerspectivesState extends State {

  List perspectives;

  @override
  void initState() {
    super.initState();

    perspectives = Perspective.fetchAll();
  }

  @override
  Widget build(BuildContext context) {  

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: JuntoAppBar.getJuntoAppBar('assets/images/junto-mobile__logo--den.png', 'PERSPECTIVES', JuntoPalette.juntoGrey),

        body: Column(
          children: <Widget>[        

            FilterPerspectives(),

            Expanded(

              child: ListView(
              children:               
                perspectives.map((perspective) => 
                PerspectivePreview(perspective.perspectiveTitle)).toList(),
            ))                
            
          ],
        ),

        bottomNavigationBar: BottomNav(),
    );
  }
}
