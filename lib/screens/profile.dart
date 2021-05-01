import 'package:flutter/material.dart';
import 'package:fofoofoflights/config/palette.dart';
import 'package:fofoofoflights/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String fname, lname, fullName, email, phoneNum;

  _getSharedPrefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        fname = prefs.getString("full_name");
        email = prefs.getString("email");
        phoneNum = prefs.getString("phone_number");
      });
    }
  }

  _removeSharedPrefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> passedData =
        ModalRoute.of(context).settings.arguments;
    String pdLocation = passedData['location'];

    _getSharedPrefData();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Palette.ffBlue),
        toolbarHeight: 40,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
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
            child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 70.0),
                  child: Container(
                      height: 180,
                      decoration: new BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Palette.ffBlue,
                              Colors.grey,
                            ],
                          ),
                          borderRadius: new BorderRadius.only(
                            bottomLeft: const Radius.circular(30.0),
                            bottomRight: const Radius.circular(30.0),
                          ))),
                ),
                Positioned(
                  top: 50.0,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Card(
                      
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 12,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset("assets/logo.png",
                                height: 128, width: 128, color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: FaIcon(FontAwesomeIcons.userTie),
                                    ),
                                    Text("$fname",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: FaIcon(FontAwesomeIcons.envelopeOpenText),
                                    ),
                                    Text("$email",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: FaIcon(FontAwesomeIcons.mapMarkerAlt),
                                    ), 
                                    Text(pdLocation,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(MdiIcons.accountSettings),
                            Text("Account Menu",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text("About your profile and more",
                            style: TextStyle(fontSize: 15, color: Colors.grey))
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        height: 60.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(MdiIcons.history),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("History",
                                    style: TextStyle(fontSize: 18.0)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        height: 60.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(MdiIcons.email),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Change Account Email",
                                    style: TextStyle(fontSize: 18.0)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Image.asset("assets/logo.png", height: 64),
                                  Text("Have any problems or concern? \n ",
                                      style: TextStyle(fontSize: 18)),
                                  TextButton(
                                      onPressed: () => launch(
                                          "mailto:support@fofoofogroup.com"),
                                      child: new Text(
                                        "Email us: support@fofoofogroup.com",
                                        style: TextStyle(fontSize: 18),
                                      )),
                                  Text("All Rights Reserved \n"),
                                  Text("(c) 2021 \n")
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        height: 60.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(MdiIcons.help),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Report a Problem",
                                    style: TextStyle(fontSize: 18.0)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      var dialog = CustomAlertDialog(
                          title: "Fofoofo Flight",
                          message: "Are you sure you want to log out ?",
                          onPostivePressed: () {
                            _removeSharedPrefData();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/login', (Route<dynamic> route) => false);
                          },
                          negativeBtnText: "No, Thank you",
                          positiveBtnText: 'Yes');
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => dialog);
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        height: 60.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(MdiIcons.exitRun),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Log out",
                                    style: TextStyle(fontSize: 18.0)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Made with ❤️ from Fofoofo Tech"),
            ))
          ],
        )),
      ),
    );
  }
}
