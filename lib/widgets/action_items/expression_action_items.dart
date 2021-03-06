import 'dart:async' show Timer;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junto_beta_mobile/backend/backend.dart';
import 'package:junto_beta_mobile/backend/repositories.dart';
import 'package:junto_beta_mobile/models/expression.dart';
import 'package:junto_beta_mobile/models/models.dart';
import 'package:junto_beta_mobile/models/user_model.dart';
import 'package:junto_beta_mobile/screens/member/member.dart';
import 'package:junto_beta_mobile/utils/junto_overlay.dart';
import 'package:junto_beta_mobile/utils/utils.dart';
import 'package:junto_beta_mobile/widgets/dialogs/confirm_dialog.dart';
import 'package:junto_beta_mobile/widgets/dialogs/single_action_dialog.dart';
import 'package:junto_beta_mobile/widgets/dialogs/user_feedback.dart';
import 'package:junto_beta_mobile/widgets/previews/member_preview/member_preview.dart';
import 'package:provider/provider.dart';

class ExpressionActionItems extends StatelessWidget {
  const ExpressionActionItems({
    @required this.deleteExpression,
    @required this.expression,
    @required this.expressionOpen,
  });

  final ExpressionResponse expression;
  final ValueChanged<ExpressionResponse> deleteExpression;
  final bool expressionOpen;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataProvider>(
      builder: (BuildContext context, UserDataProvider data, Widget child) {
        return Container(
          color: Colors.transparent,
          child: Container(
            height: MediaQuery.of(context).size.height * .4,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 5,
                          width: MediaQuery.of(context).size.width * .1,
                          decoration: BoxDecoration(
                            color: Theme.of(context).dividerColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    data.userAddress == expression.creator.address
                        ? _myActionItems(context, expression)
                        : _memberActionItems(context)
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // show these action items if the expression was created by user
  Widget _myActionItems(
    BuildContext context,
    ExpressionResponse expressionResponse,
  ) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) => ConfirmDialog(
            buildContext: context,
            confirm: () {
              deleteExpression(expressionResponse);
              if (expressionOpen) {
                Navigator.pop(context);
              }
            },
            confirmationText:
                'Are you sure you want to delete this expression?',
          ),
        );
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      title: Row(
        children: <Widget>[
          Text('Delete Expression',
              style: Theme.of(context).textTheme.headline5),
        ],
      ),
    );
  }

  // show these action items if the expression belongs to another user
  Widget _memberActionItems(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.pop(context);
            // view den
            Navigator.push(
              context,
              CupertinoPageRoute<Widget>(
                builder: (BuildContext context) => JuntoMember(
                  profile: expression.creator,
                ),
              ),
            );
          },
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          title: Row(
            children: <Widget>[
              Text("View @${expression.creator.username}'s den",
                  style: Theme.of(context).textTheme.headline5),
            ],
          ),
        ),
      ],
    );
  }
}

class _AddEventMembers extends StatefulWidget {
  const _AddEventMembers({Key key, this.expressionResponse}) : super(key: key);

  // ignore: unused_element
  static Route<dynamic> route(ExpressionResponse expressionResponse) {
    return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) {
        return _AddEventMembers(
          expressionResponse: expressionResponse,
        );
      },
    );
  }

  final ExpressionResponse expressionResponse;

  @override
  __AddEventMembersState createState() => __AddEventMembersState();
}

class __AddEventMembersState extends State<_AddEventMembers>
    with AddUserToList<UserProfile> {
  TextEditingController _controller;
  SearchRepo _searchRepo;
  ExpressionRepo _expressionRepo;
  Timer debounce;
  String query;

  final ValueNotifier<List<UserProfile>> _selectedUsers =
      ValueNotifier<List<UserProfile>>(
    <UserProfile>[],
  );

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _searchRepo = Provider.of<SearchRepo>(context);
    _expressionRepo = Provider.of<ExpressionRepo>(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onDoneTap() async {
    try {
      JuntoLoader.showLoader(context);
      await _expressionRepo.addEventMember(
        widget.expressionResponse.address,
        _selectedUsers.value,
        'Member',
      );
      JuntoLoader.hide();
      await showFeedback(context, message: 'Member Added');
      Navigator.pop(context);
    } catch (error) {
      JuntoLoader.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) => const SingleActionDialog(
          dialogText: 'Hmm, something went wrong.',
        ),
      );
    }
  }

  void _onTextChange(String txt) {
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 350), () {
      setState(() => query = txt);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _SearchAppbar(
        onDoneTap: _onDoneTap,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _controller,
                onChanged: _onTextChange,
              ),
              const SizedBox(height: 12.0),
              _buildResultsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsList() {
    return FutureBuilder<QueryResults<UserProfile>>(
      future: _searchRepo.searchMembers(query),
      builder: (
        BuildContext context,
        AsyncSnapshot<QueryResults<UserProfile>> snapshot,
      ) {
        if (snapshot.hasError) {
          return Expanded(
            child: Container(
              child: Center(
                child: Text('Something wen wrong ${snapshot.error}'),
              ),
            ),
          );
        }
        if (snapshot.hasData &&
            snapshot.data.results.isEmpty &&
            !snapshot.hasError) {
          return Expanded(
            child: Container(
              child: const Center(
                child: Text('Your user is mysterious '),
              ),
            ),
          );
        }
        if (snapshot.hasData &&
            snapshot.data.results.isNotEmpty &&
            !snapshot.hasError) {
          return Expanded(
            child: ListView.builder(
                itemCount: snapshot.data.results.length,
                itemBuilder: (BuildContext context, int index) {
                  final UserProfile item = snapshot.data.results[index];
                  return ValueListenableBuilder<List<UserProfile>>(
                    valueListenable: _selectedUsers,
                    builder: (
                      BuildContext context,
                      List<UserProfile> value,
                      Widget child,
                    ) {
                      if (!value.contains(item)) {
                        return MemberPreview(
                          profile: item,
                        );
                      }
                      return Stack(
                        children: <Widget>[
                          MemberPreview(
                            profile: item,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 15.0,
                              width: 15.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(45.0),
                                color: Colors.greenAccent,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
          );
        }
        return Expanded(
          child: Container(
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

class _SearchAppbar extends StatelessWidget implements PreferredSizeWidget {
  const _SearchAppbar({Key key, this.onDoneTap}) : super(key: key);
  final VoidCallback onDoneTap;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      child: Material(
        color: Theme.of(context).appBarTheme.color,
        child: Row(
          children: <Widget>[
            const Align(
              alignment: Alignment.centerLeft,
              child: BackButton(),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: Text('Add event attendees',
                  style: Theme.of(context).textTheme.headline6),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: onDoneTap,
                child: Text(
                  'Done',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
          ],
        ),
      ),
    );
  }
}
