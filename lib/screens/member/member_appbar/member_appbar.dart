import 'package:flutter/material.dart';
import 'package:junto_beta_mobile/custom_icons.dart';
import 'package:junto_beta_mobile/typography/palette.dart';

/// Takes the member's handle as an un-named param.
class MemberAppbar extends StatelessWidget {
  const MemberAppbar(this.memberHandle);

  /// User's handle to be displayed
  final String memberHandle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: JuntoPalette.juntoSleek),
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  CustomIcons.back_arrow_left,
                  color: JuntoPalette.juntoSleek,
                  size: 24,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Text(
                      '@' + memberHandle,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: const Color(0xffeeeeee),
                ),
              ),
            ),
          ),
        )
        // bottom:
        // PreferredSize(
        //     preferredSize: Size.fromHeight(1),
        //     child: Container(
        //       height: 1,
        //       decoration: BoxDecoration(
        //         gradient: LinearGradient(
        //             begin: Alignment.centerLeft,
        //             end: Alignment.centerRight,
        //             stops: [
        //               0.1,
        //               0.9
        //             ],
        //             colors: [
        //               JuntoPalette.juntoBlue,
        //               JuntoPalette.juntoPurple
        //             ]),
        //       ),
        //     )),
        );
  }
}
