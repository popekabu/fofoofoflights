import 'package:flutter/material.dart';

class RoundButton2 extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final Color textColor;
  final Color iconColor;
  final IconData buttonIcon;
  const RoundButton2(
      {
        Key key, 
        @required this.buttonText, 
        @required this.onPressed,
        @required this.iconColor,
        @required this.textColor,
        @required this.buttonIcon
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
            elevation: 1.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              onPressed: onPressed,
              child: Row(
                children: [
                  Icon(buttonIcon, color: iconColor,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      buttonText,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0, color: textColor),
                    ),
                  ),
                ],
              ),
            )));
  }
}
