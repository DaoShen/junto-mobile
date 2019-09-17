import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:junto_beta_mobile/providers/auth_provider/auth_provider.dart';
import 'package:junto_beta_mobile/screens/member/member.dart';
import 'package:junto_beta_mobile/screens/welcome/welcome.dart';
import 'package:junto_beta_mobile/custom_icons.dart';
import 'package:provider/provider.dart';
import 'package:junto_beta_mobile/palette.dart';
import 'package:junto_beta_mobile/styles.dart';

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
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .2,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: <double>[
                        0.1,
                        0.9
                      ],
                      colors: <Color>[
                        JuntoPalette.juntoSecondary,
                        JuntoPalette.juntoPrimary
                      ]),
                ),
              ),
              Transform.translate(
                offset: const Offset(0.0, -18.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // SizedBox(width: 20),
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                          border: Border.all(
                            width: 2.0,
                            color: Colors.white,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/junto-mobile__eric.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0.0, 9.0),
                        child: GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                          child: Icon(CustomIcons.more, size: 24),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(0.0, -18.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Eric Yang',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 10),
                      Text(
                          '"To a mind that is still, the whole universe surrenders."',
                          style: TextStyle(fontSize: 15)),
                      SizedBox(height: 10),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/junto-mobile__location.png',
                                    height: 17,
                                    color: JuntoPalette.juntoSleek,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    'Spirit',
                                    style: TextStyle(
                                      color: JuntoPalette.juntoSleek,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/junto-mobile__link.png',
                                    height: 17,
                                    color: JuntoPalette.juntoSleek,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    'junto.foundation',
                                    style: TextStyle(
                                        color: JuntoPalette.juntoPrimary),
                                  )
                                ],
                              ),
                            )
                          ]),
                    ],
                  ),
                ),
              ),

              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 15),
              //   decoration: BoxDecoration(
              //     border: Border(
              //       bottom: BorderSide(
              //         color: Color(0xffeeeeee),
              //         width: .75,
              //       ),
              //       top: BorderSide(color: Color(0xffeeeeee), width: .75),
              //     ),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: <Widget>[
              //       Container(
              //         width: MediaQuery.of(context).size.width * .5,
              //         alignment: Alignment.center,
              //         child: Text('EXPRESSIONS',
              //             style: TextStyle(
              //                 fontSize: 12, fontWeight: FontWeight.w700)),
              //       ),
              //       Container(
              //         width: MediaQuery.of(context).size.width * .5,
              //         alignment: Alignment.center,
              //         child: Text('DEN',
              //             style: TextStyle(
              //                 fontSize: 12, fontWeight: FontWeight.w700)),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
  }
}
