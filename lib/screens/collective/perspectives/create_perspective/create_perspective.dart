import 'package:flutter/material.dart';
import 'package:junto_beta_mobile/custom_icons.dart';
import 'package:junto_beta_mobile/screens/collective/perspectives/create_perspective/perspective_member_preview/perspective_member_preview.dart';
import 'package:junto_beta_mobile/typography/palette.dart';

class CreatePerspective extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: AppBar(
            automaticallyImplyLeading: false,
            brightness: Brightness.light,
            iconTheme: const IconThemeData(
              color: JuntoPalette.juntoSleek,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            titleSpacing: 0,
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      CustomIcons.back_arrow_left,
                      color: JuntoPalette.juntoSleek,
                      size: 24,
                    ),
                  ),
                  Text(
                    'create',
                    style:
                        TextStyle(color: const Color(0xff333333), fontSize: 14),
                  ),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: const Color(0xffeeeeee),
              ),
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                // padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: const Color(0xffeeeeee), width: 1),
                )),
                child: TextField(
                  buildCounter: (BuildContext context,
                          {int currentLength, int maxLength, bool isFocused}) =>
                      null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Name your perspective',
                  ),
                  style: TextStyle(fontSize: 17),
                  cursorColor: JuntoPalette.juntoGrey,
                  cursorWidth: 2,
                  maxLines: 1,
                  maxLength: 80,
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom:
                        BorderSide(color: const Color(0xffeeeeee), width: 1),
                  )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.search, size: 17),
                      SizedBox(width: 10),
                      Container(
                        width: MediaQuery.of(context).size.width * .75,
                        child: TextField(
                          buildCounter: (BuildContext context,
                                  {int currentLength,
                                  int maxLength,
                                  bool isFocused}) =>
                              null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Add members to your perspective',
                          ),
                          cursorColor: JuntoPalette.juntoGrey,
                          style: TextStyle(fontSize: 14),
                          cursorWidth: 2,
                          maxLines: 1,
                          maxLength: 80,
                        ),
                      )
                    ],
                  )),
              Expanded(
                  child: ListView(
                children: <Widget>[
                  PerspectiveMemberPreview(),
                  PerspectiveMemberPreview(),
                  PerspectiveMemberPreview(),
                ],
              ))
            ],
          ),
        ));
  }
}
