import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junto_beta_mobile/app/custom_icons.dart';
import 'package:junto_beta_mobile/models/models.dart';
import 'package:junto_beta_mobile/utils/utils.dart';
import 'package:junto_beta_mobile/widgets/bottom_nav.dart';
import 'package:junto_beta_mobile/widgets/end_drawer/end_drawer.dart';
import 'package:junto_beta_mobile/widgets/utils/hide_fab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:junto_beta_mobile/screens/groups/groups_actions/groups_actions.dart';
import 'package:junto_beta_mobile/screens/groups/groups_actions/spheres/sphere_open/sphere_open.dart';
import 'package:junto_beta_mobile/screens/groups/groups_actions/packs/pack_open/pack_open.dart';

// This screen displays groups a member belongs two. Currently, there are two types of
// groups: spheres (communities) and packs (agent-centric communities)
class JuntoGroups extends StatefulWidget {
  const JuntoGroups({@required this.initialGroup});

  final Widget initialGroup;
  @override
  State<StatefulWidget> createState() {
    return JuntoGroupsState();
  }
}

class JuntoGroupsState extends State<JuntoGroups> with HideFab, ListDistinct {
  final ValueNotifier<bool> _isVisible = ValueNotifier<bool>(true);
  String _userAddress;

  Group _currentGroup;

  bool actionsVisible = false;

  dynamic _groupie;

  @override
  void initState() {
    super.initState();
    getUserInformation();
  }

  Future<void> getUserInformation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _userAddress = prefs.getString('user_id');

      _groupie = widget.initialGroup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _isVisible,
        builder: (BuildContext context, bool visible, Widget child) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: visible ? 1.0 : 0.0,
            child: child,
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: BottomNav(
              screen: 'groups',
              onTap: () {
                if (actionsVisible) {
                  setState(() {
                    actionsVisible = false;
                  });
                } else {
                  setState(() {
                    actionsVisible = true;
                  });
                }
              }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      endDrawer: const JuntoDrawer(screen: 'Groups', icon: CustomIcons.groups),
      body: Stack(
        children: <Widget>[
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: actionsVisible ? 0.0 : 1.0,
            child: _groupie,
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: actionsVisible ? 1.0 : 0.0,
            child: Visibility(
              visible: actionsVisible,
              child: JuntoGroupsActions(
                changeGroup: _changeGroup,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _changeGroup(Group group) {
    if (group.groupType == 'Pack') {
      setState(() {
        _groupie = PackOpen(pack: group);
      });
    }

    if (group.groupType == 'Sphere') {
      setState(() {
        _groupie = const SizedBox();
      });
      setState(() {
        _groupie = SphereOpen(
          group: group,
        );
      });
    }

    actionsVisible = false;
  }
}
