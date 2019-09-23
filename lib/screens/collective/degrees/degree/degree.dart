import 'package:flutter/material.dart';

// Degree of Separation widget
class Degree extends StatelessWidget {
  const Degree(this.degree, this.changeDegree, this.degreeColor);

  final String degree;
  final Function changeDegree;
  final Color degreeColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeDegree(degree);
      },
      child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 40,
          // color: Colors.purple,
          color: Colors.transparent,
          child: Text(_generateRoman(),
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: degreeColor))),
    );
  }

  // Transform degree (i.e. 'one', 'two', 'three') to Roman numerals
  String _generateRoman() {
    if (degree == 'infinity') {
      return 'oo';
    } else if (degree == 'one') {
      return 'i';
    } else if (degree == 'two') {
      return 'ii';
    } else if (degree == 'three') {
      return 'iii';
    } else if (degree == 'four') {
      return 'iv';
    } else if (degree == 'five') {
      return 'v';
    } else if (degree == 'six') {
      return 'vi';
    } else {
      return '';
    }
  }
}
