import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:junto_beta_mobile/models/models.dart';
import 'package:junto_beta_mobile/backend/backend.dart';
import 'package:junto_beta_mobile/utils/junto_exception.dart'
    show JuntoException;
import 'package:provider/provider.dart';
import 'package:junto_beta_mobile/screens/collective/collective_actions/create_perspective.dart';

class JuntoPerspectives extends StatefulWidget {
  const JuntoPerspectives({this.userProfile});

  final UserData userProfile;
  @override
  State<StatefulWidget> createState() {
    return JuntoPerspectivesState();
  }
}

class JuntoPerspectivesState extends State<JuntoPerspectives> {
  String _userAddress;
  UserData _userProfile;

  @override
  void initState() {
    super.initState();

    getUserInformation();
  }

  Future<void> getUserInformation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> decodedUserData =
        jsonDecode(prefs.getString('user_data'));

    setState(() {
      _userAddress = prefs.getString('user_id');
      _userProfile = UserData.fromMap(decodedUserData);
    });
  }

  Future<List<CentralizedPerspective>> _fetchUserPerspectives(String address) {
    try {
      return Provider.of<UserRepo>(context).getUserPerspective(_userAddress);
    } on JuntoException catch (error) {
      debugPrint('error fethcing perspectives ${error.errorCode}');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 150,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Theme.of(context).backgroundColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Perspectives',
                      style: Theme.of(context).textTheme.display1),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => CreatePerspective()));
                    },
                    child: Icon(Icons.add),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Container(
            //   height: 50,
            //   color: Theme.of(context).backgroundColor,
            //   child: Row(
            //     children: <Widget>[
            //       Container(
            //           padding: const EdgeInsets.all(10),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             color: const Color(0xff555555),
            //           ),
            //           child: Text(
            //             'All',
            //             style: TextStyle(
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.w700,
            //                 color: Colors.white,
            //                 decoration: TextDecoration.none),
            //           ))
            //     ],
            //   ),
            // ),
            Expanded(
                child: ListView(
              padding: const EdgeInsets.all(0),
              children: <Widget>[
                _buildPerspective('JUNTO'),
                FutureBuilder<List<CentralizedPerspective>>(
                  future: _fetchUserPerspectives(_userAddress),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<CentralizedPerspective>> snapshot,
                  ) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Container(
                        child: const Text(
                          'hmm, something is up...',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return ListView(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          children: snapshot.data
                              .map((CentralizedPerspective perspective) {
                            if (perspective.name != 'Connections') {
                              return _buildPerspective(perspective.name);
                            } else {
                              return const SizedBox();
                            }
                          }).toList());
                    }
                    return Container();
                  },
                ),
              ],
            ))
          ]),
    );
  }

  Widget _buildPerspective(String perspective) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor, width: .75),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/junto-mobile__binoculars.png',
              height: 17, color: Theme.of(context).primaryColor),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(perspective, style: Theme.of(context).textTheme.subhead),
                Text(
                  'Expressions from everyone in Junto. Filter by degrees of separation.',
                  style: Theme.of(context).textTheme.body2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
