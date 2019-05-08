
import 'package:flutter/material.dart';

import '../../collective/collective.dart';

class SignUpFour extends StatefulWidget {
  final firstName;
  final lastName;
  final username;
  final password;

  SignUpFour(this.firstName, this.lastName, this.username, this.password);

  @override
  State<StatefulWidget> createState() {

    return SignUpFourState();
  }
}

class SignUpFourState extends State<SignUpFour> {
  static TextEditingController bioController = TextEditingController();
  var bio = '';
  var profilePicture = '';

  @override
  Widget build(BuildContext context) {
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

            child: 
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .10 + 18),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: 
                  Column(      
                    crossAxisAlignment: CrossAxisAlignment.start,        
                    children: <Widget> [
                      Container(                
                        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .17),
                        child: Text('We are almost done! Feel free to upload a photo and write a brief bio of who you are',
                          style: TextStyle(color: Colors.white, fontSize: 27)
                        )
                      ),   

                      Container(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 36),
                              child: 
                                TextField(
                                  controller: bioController,
                                  onChanged: (text) {
                                    setState(() {
                                      bio = text;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,                 
                                      labelStyle: TextStyle(color: Colors.green),
                                      hintText: 'A LITTLE BIT ABOUT MYSELF...',
                                      hintStyle: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
                                      fillColor: Colors.white,
                                  ),
                                  style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500)
                                )
                            ),
                          ]
                        )
                      )                
                  ],)
              )
          ),

          Positioned(
            top: MediaQuery.of(context).size.height * .05,
            left: 20,
            child: Image.asset(
              'assets/images/junto-mobile__logo--white.png',
              height: 36,
              )
          ), 

          Positioned(
            bottom: MediaQuery.of(context).size.height * .05,
            right: 20,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 17),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_left, color: Colors.white, size: 27),
                    ),
                ),
              
                GestureDetector(
                  onTap: () {
                    if(widget.firstName != '' && widget.lastName != '' && 
                    widget.username != '' && widget.password != '') {    

                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => JuntoCollective()
                      ));
                    }
                  },
                  child: Icon(Icons.arrow_right, color: Colors.white, size: 22),
                ),                ],
            )
          ),                            
        ])
    
    );      
  }
}