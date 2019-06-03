
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../components/appbar/appbar.dart';
import './../../components/bottom_nav/bottom_nav.dart';
import './mypack__preview/mypack__preview.dart';
import './pack_preview.dart';
import '../../scoped_models/scoped_user.dart';
import './../../typography/palette.dart';

class JuntoPack extends StatelessWidget {
  void noNav() {
    return ;
  }  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
        appBar: JuntoAppBar.getJuntoAppBar('assets/images/junto-mobile__logo--pack.png', 
        'PACKS', JuntoPalette.juntoPurple, JuntoPalette.juntoPurpleLight, noNav),

        body:          
          ListView(
            children: <Widget>[
                          
              MyPackPreview(),
              
              ScopedModelDescendant<ScopedUser>(
                builder: (context, child, model) =>               
                ListView(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    children: model.packs.map((pack) => PackPreview(pack.packTitle, pack.packUser)).toList()
                  )     
              )         
            ],
          ),
        bottomNavigationBar: BottomNav('pack'));
  }
}
