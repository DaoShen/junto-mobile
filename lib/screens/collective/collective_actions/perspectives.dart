import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:junto_beta_mobile/backend/backend.dart';
import 'package:junto_beta_mobile/models/models.dart';
import 'package:junto_beta_mobile/screens/collective/collective_actions/create_perspective.dart';
import 'package:junto_beta_mobile/screens/collective/collective_actions/edit_perspective.dart';
import 'package:junto_beta_mobile/widgets/dialogs/single_action_dialog.dart';
import 'package:junto_beta_mobile/widgets/dialogs/confirm_dialog.dart';
import 'package:junto_beta_mobile/utils/junto_exception.dart'
    show JuntoException;
import 'package:junto_beta_mobile/utils/junto_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JuntoPerspectives extends StatefulWidget {
  const JuntoPerspectives({this.userProfile, this.changePerspective});

  final UserData userProfile;
  final ValueChanged<PerspectiveModel> changePerspective;

  @override
  State<StatefulWidget> createState() {
    return JuntoPerspectivesState();
  }
}

class JuntoPerspectivesState extends State<JuntoPerspectives> {
  String _userAddress;

  Future<List<PerspectiveModel>> getPerspectives;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshPerspectives();
  }

  Future<void> getUserInformation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userAddress = prefs.getString('user_id');
    });
  }

  Future<List<PerspectiveModel>> _fetchUserPerspectives(String address) async {
    try {
      return await Provider.of<UserRepo>(context, listen: false)
          .getUserPerspective(_userAddress);
    } on JuntoException catch (error) {
      debugPrint('error fethcing perspectives ${error.errorCode}');
      showDialog(
        context: context,
        builder: (BuildContext context) => SingleActionDialog(
          dialogText: error.message,
        ),
      );
      return null;
    }
  }

  Future<void> _refreshPerspectives() async {
    try {
      await getUserInformation();
      setState(() {
        getPerspectives = _fetchUserPerspectives(_userAddress);
      });
    } on JuntoException catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => SingleActionDialog(
          dialogText: error.message,
        ),
      );
    }
  }

  Future<void> _deletePerspective(perspective) async {
    print(perspective);
    try {
      JuntoLoader.showLoader(context);
      await Provider.of<UserRepo>(context, listen: false)
          .deletePerspective(perspective.address);
      _refreshPerspectives();
      JuntoLoader.hide();
      Navigator.pop(context);
    } catch (error) {
      print(error);
      JuntoLoader.hide();
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
                    style: Theme.of(context).textTheme.headline4),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute<dynamic>(
                        builder: (BuildContext context) => CreatePerspective(
                            refreshPerspectives: _refreshPerspectives),
                      ),
                    );
                  },
                  child: Icon(Icons.add,
                      size: 24, color: Theme.of(context).primaryColor),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
              child: ListView(
            padding: const EdgeInsets.all(0),
            children: <Widget>[
              _buildPerspective(
                const PerspectiveModel(
                  address: null,
                  name: 'JUNTO',
                  about: null,
                  creator: null,
                  createdAt: null,
                  isDefault: true,
                  userCount: null,
                  users: null,
                ),
              ),
              if (_userAddress != null)
                FutureBuilder<List<PerspectiveModel>>(
                  future: getPerspectives,
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<PerspectiveModel>> snapshot,
                  ) {
                    if (snapshot.hasError) {
                      return Container(
                        child: const Text(
                          'hmm, something is up...',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          // display Subscriptions perspective first
                          ListView(
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            children: snapshot.data
                                .map((PerspectiveModel perspective) {
                              if (perspective.isDefault == true) {
                                return GestureDetector(
                                  child: _buildPerspective(perspective),
                                );
                              } else {
                                return const SizedBox();
                              }
                            }).toList(),
                          ),
                          // display rest of perspectives
                          ListView(
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            children: snapshot.data.map(
                              (PerspectiveModel perspective) {
                                if (perspective.name != 'Connections' &&
                                    perspective.name != 'Subscriptions') {
                                  return GestureDetector(
                                    child: _buildPerspective(perspective),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ).toList(),
                          )
                        ],
                      );
                    }
                    return Container();
                  },
                ),
            ],
          ))
        ],
      ),
    );
  }

  Widget _buildPerspective(PerspectiveModel perspective) {
    return GestureDetector(
      onTap: () => widget.changePerspective(perspective),
      child: Slidable(
        enabled: !perspective.isDefault,
        actionPane: const SlidableDrawerActionPane(),
        actionExtentRatio: 0.2,
        secondaryActions: <Widget>[
          IconSlideAction(
            color: Theme.of(context).dividerColor,
            iconWidget: Icon(Icons.edit,
                size: 15, color: Theme.of(context).primaryColor),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute<dynamic>(
                  builder: (BuildContext context) => EditPerspective(
                      perspective: perspective,
                      refreshPerspectives: _refreshPerspectives),
                ),
              );
            },
          ),
          IconSlideAction(
              color: Colors.red,
              iconWidget: Icon(Icons.delete, size: 15, color: Colors.white),
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => ConfirmDialog(
                    confirmationText:
                        'Are you sure you want to delete this perspective?',
                    confirm: () {
                      _deletePerspective(perspective);
                    },
                  ),
                );
              }),
        ],
        key: Key(perspective.address),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              bottom:
                  BorderSide(color: Theme.of(context).dividerColor, width: .75),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 45.0,
                width: 45.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: const <double>[0.2, 0.9],
                    colors: <Color>[
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset('assets/images/junto-mobile__binoculars.png',
                    height: 15, color: Colors.white),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(perspective.name,
                        style: Theme.of(context).textTheme.subtitle1),
                    if (perspective.name == 'JUNTO')
                      Text(
                        'Expressions from everyone in Junto.',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    if (perspective.name == 'Connections')
                      Text(
                        'Expressions from people you are connected with.',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    if (perspective.name == 'Subscriptions')
                      Text(
                        'Expressions from specific people you\'re subscribed to.',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    if (perspective.name != 'JUNTO' &&
                        perspective.name != 'Connections' &&
                        perspective.name != 'Subscriptions' &&
                        perspective.about != null)
                      Text(
                        perspective.about,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
