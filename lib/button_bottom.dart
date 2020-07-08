import 'package:flutter/material.dart';
import 'constants.dart';

class ButtonBottom extends StatelessWidget {
  ButtonBottom({this.text, this.onPressed});
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Center(
          child: Text(
            text,
            style: kLargeButtonTextStyle,
          ),
        ),
        color: buttonColor,
        height: 80.0,
        width: double.infinity,
      ),
    );
  }
}
