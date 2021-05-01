import 'dart:async';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fofoofoflights/config/palette.dart';
import 'package:fofoofoflights/models/cities.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String whereFrom;
  String whereTo;
  List<Cities> citiesList = [];
  List<Cities> filteredCitiesList = [];
  String _currentAddress;

  _getToken() async {
    try {
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization':
            'Basic VmpFNk1ubDVZV3MxY1hOb2MzZHNaemwwY2pwRVJWWkRSVTVVUlZJNlJWaFU6VkdnNE5FNXZZMEU='
      };
      var request = http.Request('POST',
          Uri.parse('https://api-crt.cert.havail.sabre.com/v2/auth/token'));
      request.body = '''grant_type=client_credentials''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      print("Access Token: " + data['access_token']);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', data['access_token']);

    } on SocketException catch (e) {
      print(e);
      BotToast.closeAllLoading();
      BotToast.showSimpleNotification(
          title: "Please check your internet connection");
    } on Error catch (e) {
      print('General Error: $e');
      BotToast.closeAllLoading();
      BotToast.showSimpleNotification(
          title: "Error Occurred, contact Fofoofo Flights Team");
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    _getToken();
    _determinePosition().then((value) async {
      double longValue = value.longitude;
      double latValue = value.latitude;
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latValue, longValue);
      if (mounted) {
        setState(() {
          _currentAddress = placemarks[0].locality;
        });
      }
      print(_currentAddress);
    });
    _getCities().then((data) {
      setState(() {
        filteredCitiesList = citiesList = data;
      });
    });
  }

  _filterCitiesList(value) {
    setState(() {
      filteredCitiesList = citiesList
          .where((cities) =>
              cities.city.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  Future<List<Cities>> _getCities() async {
    try {
      var headers = {
        'Authorization': 'Bearer T1RLAQJk3oJ16eTyi3lPirve4YxGvTVS1xAL60jbu/MQ0Sfzo/M4u0BCAADQSZYfpp' +
            'Bi0d1KxuaLKLK9azLJuREBrIfCjs2Ng2I7Gd0IMYkiQ4X/E0SN5hOv9gj2BOZG5V/5+1g' +
            'd8mFLd8RNnRNbRy6JLLNKQnDRGXWY/LGptSJ5EmqJ2ARiqBhUCsv/3Htna36xmqM1qC9V' +
            'xAEP2jh0PhcoJrCdkT3XqRukQkUd5PitJClSc87uDxCFknj+YMwol8ien7yWvkR6lWkKPDB+' +
            'QOMY0Ab9BX8PASRUC2MBEo9/CPx3SmwYpRgYW6Dwuylk+Wyd66dFjl8uw45/rQ**'
      };
      var request = http.Request(
          'GET',
          Uri.parse(
              'https://airlabs.co/api/v6/cities?api_key=b63b7180-bf33-4bd0-aded-b600b10f937c'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        // print("FROM NET =>" + await response.stream.bytesToString());
        Map<String, dynamic> jsonData =
            jsonDecode(await response.stream.bytesToString());

        for (var u in jsonData['response']) {
          Cities cities = Cities(u["name"], u["code"]);
          // print(cities.city);
          citiesList.add(cities);
        }
      } else {
        BotToast.showSimpleNotification(
            title: "Problem occurred, please try again!");
      }
    } on Exception catch (_) {
      BotToast.showSimpleNotification(
          title: "Please check your internet connection");
    }
    print(citiesList.length);
    return citiesList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: IconButton(
            icon: Icon(MdiIcons.account, color: Palette.ffBlue),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/profile', (Route<dynamic> route) => true,
                  arguments: {'location': _currentAddress});
            }),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          "Home",
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
          height: MediaQuery.of(context).size.height,
          decoration: new BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Palette.ffBlue,
                Palette.ffOrange,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Book with peace of mind",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                "We're here for you with the latest travel info. Search flights affordably only on Fofoofo Flights.",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                          ],
                        ),
                      ),
                      Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.only(
                              bottomLeft: const Radius.circular(8.0),
                              bottomRight: const Radius.circular(8.0),
                              topLeft: const Radius.circular(8.0),
                              topRight: const Radius.circular(8.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Icon(MdiIcons.mapMarkerCircle,
                                  //       color: Colors.grey),
                                  // ),
                                  Expanded(
                                    child: DropdownSearch<Cities>(
                                      searchBoxDecoration: InputDecoration(
                                        icon: Icon(MdiIcons.mapMarkerCircle,
                                            color: Colors.grey),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black54),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                      ),
                                      items: citiesList,
                                      showSearchBox: true,
                                      mode: Mode.BOTTOM_SHEET,
                                      label: "Where from?",
                                      onFind: (String filter) =>
                                          _filterCitiesList(filter),
                                      itemAsString: (Cities u) => u.city,
                                      onChanged: (Cities data) {
                                        print("WHERE FROM: " + data.cityCode);
                                        whereFrom = data.cityCode;

                                        if (whereTo == null ||
                                            whereFrom == null) {
                                          print(
                                              "Where to or Where from is not stated");
                                        } else {
                                          print("CONDITIONS ARE ALL SATISFIED");
                                          Navigator.of(context).pushNamed(
                                              '/flightpref',
                                              arguments: {
                                                'whereTo': whereTo,
                                                'whereFrom': whereFrom
                                              });
                                        }
                                      },
                                    ),

                                    // child: FormInput2(
                                    //   hintText: "Where from?",
                                    // ),
                                  ),
                                ],
                              )
                            ],
                          )),
                      Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.only(
                              bottomLeft: const Radius.circular(8.0),
                              bottomRight: const Radius.circular(8.0),
                              topLeft: const Radius.circular(8.0),
                              topRight: const Radius.circular(8.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Icon(MdiIcons.airplaneTakeoff,
                                  //       color: Colors.grey),
                                  // ),
                                  Expanded(
                                    child: DropdownSearch<Cities>(
                                        searchBoxDecoration: InputDecoration(
                                          icon: Icon(MdiIcons.mapMarkerCircle,
                                              color: Colors.grey),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black54),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                        ),
                                        showSearchBox: true,
                                        items: citiesList,
                                        mode: Mode.BOTTOM_SHEET,
                                        label: "Where to fly?",
                                        onFind: (String filter) =>
                                            _filterCitiesList(filter),
                                        itemAsString: (Cities u) => u.city,
                                        onChanged: (Cities data) {
                                          print(
                                              "WHERE TO FLY: " + data.cityCode);
                                          whereTo = data.cityCode;

                                          if (whereTo == null ||
                                              whereFrom == null) {
                                            print(
                                                "Where to or Where from is not stated");
                                          } else {
                                            print(
                                                "CONDITIONS ARE ALL SATISFIED");
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    '/flightpref',
                                                    (Route<dynamic> route) =>
                                                        true,
                                                    arguments: {
                                                  'whereTo': whereTo,
                                                  'whereFrom': whereFrom
                                                });
                                          }
                                        }),
                                  )

                                  // FormInput2(hintText: "Where to fly")),
                                ],
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(15.0),
                        topRight: const Radius.circular(15.0),
                      )),
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(MdiIcons.binoculars),
                              ),
                              Text("Explore ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins')),
                            ],
                          ),
                        ),
                        GridView.count(
                          primary: false,
                          padding: const EdgeInsets.all(8.0),
                          crossAxisCount: 3,
                          childAspectRatio: 0.80,
                          mainAxisSpacing: 1.0,
                          crossAxisSpacing: 1.0,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(
                                    "https://images.unsplash.com/photo-1550604602-7fae1adbe912?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=755&q=80"),
                                child: Text(
                                  "Los Angeles",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(
                                      "https://images.unsplash.com/photo-1516844113229-18646a422956?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=749&q=80"),
                                  child: Text(
                                    "Las Vegas",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(
                                    "https://images.unsplash.com/photo-1598797246294-7620e33a632f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=667&q=80"),
                                child: Text(
                                  "New York",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(
                                    "https://images.unsplash.com/photo-1500021804447-2ca2eaaaabeb?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80"),
                                child: Text(
                                  "Accra",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(
                                    "https://images.unsplash.com/photo-1518563172008-e56c5dfbaef6?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80"),
                                child: Text("Lagos",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(
                                    "https://images.unsplash.com/photo-1561576722-c6bccfb931c0?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=750&q=80"),
                                child: Text(
                                  "Wash. DC",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(
                                    "https://images.unsplash.com/photo-1550604602-7fae1adbe912?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=755&q=80"),
                                child: Text(
                                  "Sydney",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(
                                    "https://images.unsplash.com/photo-1533417479565-6e21cba3fadb?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=500&q=80"),
                                child: Text(
                                  "Ouagadougou",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(
                                    "https://images.unsplash.com/photo-1562595410-2cb999af24b5?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=626&q=80"),
                                child: Text(
                                  "Memphis",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                          shrinkWrap: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Made with ❤️ from Fofoofo Tech"),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
