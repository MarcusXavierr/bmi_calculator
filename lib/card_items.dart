import 'package:bmi_calculator/constants.dart';
import 'package:flutter/material.dart';

class CardItems extends StatelessWidget {
  CardItems({this.icon, this.text});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          text,
          style: textLabelStyle,
        ),
      ],
    );
  }
}
