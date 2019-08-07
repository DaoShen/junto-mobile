
import 'package:flutter/material.dart';

import '../../../typography/palette.dart';

// This class renders a preview of a sphere
class SpherePreview extends StatelessWidget {
  final String sphereTitle;
  final String sphereMembers;
  final String sphereImage;
  final String sphereHandle;

  SpherePreview(this.sphereTitle, this.sphereMembers, this.sphereImage, this.sphereHandle);

  @override
  Widget build(BuildContext context) {
    return 
        Container(
          margin: EdgeInsets.only(left: 10.0),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipOval(
                    child: Image.asset(
                      sphereImage,
                      height: 45.0,
                      width: 45.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 65,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: .5, color: Color(0xffeeeeee)),
                      ),
                    ),
                    margin: EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(sphereTitle,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff333333),
                                fontWeight: FontWeight.w700)),
                        Text('/s/' + sphereHandle, 
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500))
                      ],
                    ),
                  )
                ],
              ),
            ],
          ));
  }
}
