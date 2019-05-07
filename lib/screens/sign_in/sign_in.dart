
import 'package:flutter/material.dart';

import '../collective/collective.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0.1, 0.9],
                colors: [
                  Color(0xff5E54D0),
                  Color(0xff307FAB)
                ]
              )
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.symmetric(horizontal: 45),
                  child: 
                    TextField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                          ),
                          labelStyle: TextStyle(color: Colors.green),
                          hintText: 'USERNAME',
                          hintStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                          fillColor: Colors.white,
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500)
                    )
                ),

                Container(
                  margin: EdgeInsets.only(bottom: 40),                  
                  padding: EdgeInsets.symmetric(horizontal: 45),
                  child: 
                    TextField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                          ),
                          labelStyle: TextStyle(color: Colors.green),
                          hintText: 'PASSWORD',
                          hintStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                          fillColor: Colors.white,
                      ),

                      style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500)

                    )
                ),       

                Container(
                  child: 
                    RaisedButton(                      
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => JuntoCollective()
                        ));
                      },  
                      padding: EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 20
                      ),                        
                      // color: Colors.white,  
                      color: Color(0xff4968BF),
                      child: Text('SIGN IN', 
                        style: TextStyle(
                          // color: JuntoPalette.juntoBlue, 
                          color: Colors.white, 
                          fontWeight: FontWeight.w700,
                          fontSize: 14)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))
                    )                  
                )                                         
            ],)
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            )
          )
        ])
    
    );      
  }
}