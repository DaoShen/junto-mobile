import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:junto_beta_mobile/screens/member/member.dart';
import 'package:junto_beta_mobile/screens/welcome/welcome.dart';

/// Displays the user's DEN or "profile screen"
class JuntoDen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => JuntoDenState();
}

class JuntoDenState extends State<JuntoDen> {
  void noNav() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              // Den cover photo
              Container(
                constraints: const BoxConstraints.expand(height: 150),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage(
                        'assets/images/junto-mobile__stillmind.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Transform.translate(
                  offset: const Offset(0, 120),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: <Widget>[
                              ClipOval(
                                child: Image.asset(
                                  'assets/images/junto-mobile__eric.png',
                                  height: 60.0,
                                  width: 60.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                  color: Colors.transparent,
                  height: 30,
                  width: MediaQuery.of(context).size.width),
              Container(
                padding: const EdgeInsets.only(top: 10),
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Text(
                                'Eric Yang',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                'sunyata',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          Icon(Icons.edit, size: 14)
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: const Color(0xffeeeeee),
                            width: 1,
                          ),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        'to a mind that is still, the whole universe '
                        'surrenders',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    JuntoMember(),
                              ),
                            );
                          },
                        ),
                        RaisedButton(
                          onPressed: () async {
                            await FlutterSecureStorage().write(
                              key: 'isLogged'
                                  'In',
                              value: 'false',
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => Welcome(),
                              ),
                            );
                          },
                          color: const Color(0xff4968BF),
                          child: const Text(
                            'LOG OUT',
                            style: TextStyle(
                              // color: JuntoPalette.juntoBlue,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              100,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
