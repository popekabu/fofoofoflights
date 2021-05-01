import 'package:flutter/material.dart';
import 'package:fofoofoflights/config/palette.dart';

class RoundButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;

  const RoundButton(
      {Key key, @required this.buttonText, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Palette.ffBlue,
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              onPressed: onPressed,
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )));
  }
}
