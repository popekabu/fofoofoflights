import 'package:flutter/material.dart';
import 'package:fofoofoflights/config/palette.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FlightPref extends StatefulWidget {
  @override
  _FlightPrefState createState() => _FlightPrefState();
}

class _FlightPrefState extends State<FlightPref> {
  String from, to;

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> passedData =
        ModalRoute.of(context).settings.arguments;
    from = passedData['whereFrom'];
    print("FROM =>" + from);
    to = passedData['whereTo'];
    print("TO =>" + to);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Palette.ffBlue),
        toolbarHeight: 40,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          "Preferences",
          style: TextStyle(
              fontSize: 30.0,
              letterSpacing: -3,
              fontFamily: "Poppins",
              color: Colors.blueAccent),
        ),
        actions: [
          IconButton(
              icon: Icon(MdiIcons.bell, color: Palette.ffBlue),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/notification', (Route<dynamic> route) => true);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
        )
      ),
    );
  }
}
