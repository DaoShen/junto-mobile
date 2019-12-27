import 'package:flutter/material.dart';
import 'package:junto_beta_mobile/screens/sign_in/sign_in.dart';
import 'package:junto_beta_mobile/screens/welcome/sign_up_name.dart';
import 'package:junto_beta_mobile/screens/welcome/sign_up_username.dart';
import 'package:junto_beta_mobile/screens/welcome/sign_up_themes.dart';

class Welcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WelcomeState();
  }
}

class WelcomeState extends State<Welcome> {
  PageController _welcomeController;

  int _currentIndex;
  String name;
  String username;

  GlobalKey<SignUpNameState> signUpNameKey;
  GlobalKey<SignUpUsernameState> signUpUsernameKey;

  @override
  void initState() {
    super.initState();
    signUpNameKey = GlobalKey<SignUpNameState>();
    signUpUsernameKey = GlobalKey<SignUpUsernameState>();
    _currentIndex = 0;
    _welcomeController = PageController();
  }

  void _nextSignUpPage() {
    if (_currentIndex == 1) {
      setState(() {
        name = signUpNameKey.currentState.returnDetails();
      });
      if (name == '') {
        return;
      }
    } else if (_currentIndex == 2) {
      setState(() {
        username = signUpUsernameKey.currentState.returnDetails();
      });
      print(username);
      if (username == '') {
        return;
      }
    }

    // transition to next page of sign up flow
    _welcomeController.nextPage(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 400),
    );
    // increase current index by 1
    _currentIndex += 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: const <double>[0.2, 0.9],
              colors: <Color>[
                Theme.of(context).colorScheme.secondaryVariant,
                Theme.of(context).colorScheme.primaryVariant
              ],
            ),
          ),
        ),
        PageView(
            controller: _welcomeController,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              _welcomeMain(context),
              SignUpName(key: signUpNameKey),
              SignUpUsername(key: signUpUsernameKey),
              SignUpThemes()
            ]),
        _currentIndex != 0
            ? Positioned(
                bottom: MediaQuery.of(context).size.height * .05,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          _welcomeController.previousPage(
                            curve: Curves.easeIn,
                            duration: const Duration(milliseconds: 400),
                          );
                          setState(() {
                            _currentIndex -= 1;
                          });
                          print(_currentIndex);
                        },
                        child: Icon(
                          Icons.keyboard_arrow_up,
                          color: Colors.white30,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        _nextSignUpPage();
                      },
                      child: Icon(Icons.keyboard_arrow_down,
                          color: Colors.white, size: 24),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        _currentIndex != 0
            ? Positioned(
                top: MediaQuery.of(context).size.height * .08,
                left: 20,
                child: Image.asset(
                    'assets/images/junto-mobile__logo--white.png',
                    height: 45),
              )
            : const SizedBox(),
      ]),
    );
  }

  Widget _welcomeMain(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 120, bottom: 23),
              child: Image.asset(
                'assets/images/junto-mobile__logo--white.png',
                height: 69,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 45),
              child: const Text(
                'JUNTO',
                style: TextStyle(
                  letterSpacing: 1.7,
                  color: Colors.white,
                  fontSize: 45,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ]),
          Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: FlatButton(
                  onPressed: () {
                    _welcomeController.nextPage(
                      curve: Curves.easeIn,
                      duration: const Duration(milliseconds: 400),
                    );
                    Future.delayed(const Duration(milliseconds: 400), () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    });
                  },
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  color: Colors.transparent,
                  child: const Text(
                    'WELCOME TO THE PACK',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 120),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => SignIn(),
                      ),
                    );
                  },
                  child: const Text(
                    'SIGN IN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
