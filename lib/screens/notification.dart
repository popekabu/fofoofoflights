import 'package:flutter/material.dart';
import 'package:fofoofoflights/config/palette.dart';

class UserNotifications extends StatelessWidget {
  const UserNotifications({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Palette.ffBlue),
        toolbarHeight: 40,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          "Notifications",
          style: TextStyle(
              fontSize: 30.0,
              letterSpacing: -3,
              fontFamily: "Poppins",
              color: Colors.blueAccent),
        ),
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Container(
              child: Column(
            children: [
              
            ],
          )),
        ),
      ),
    );
  }
}