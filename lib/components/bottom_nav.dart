
import 'package:flutter/material.dart';

import './../custom_icons.dart';
import './../pages/collective.dart';
import './../pages/spheres.dart';
import './../pages/pack.dart';
import './../pages/den.dart';

class BottomNav extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return 

          BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JuntoCollective() )); },
                  icon: Icon(CustomIcons.home), 
                  color: Colors.black), 
                title: Text('', style: TextStyle(color: Colors.black))),

              BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JuntoSpheres() )); },
                  icon: Icon(CustomIcons.home), 
                  color: Colors.black), 
                title: Text('', style: TextStyle(color: Colors.black))),

              BottomNavigationBarItem(
                icon: Icon(CustomIcons.home, color: Colors.black),
                title: Text('', style: TextStyle(color: Colors.black))),

              BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JuntoPack() )); },
                  icon: Icon(CustomIcons.home), 
                  color: Colors.black), 
                title: Text('', style: TextStyle(color: Colors.black))),

              BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JuntoDen() )); },
                  icon: Icon(CustomIcons.home), 
                  color: Colors.black), 
                title: Text('', style: TextStyle(color: Colors.black))),
          
            ]);
  }
}