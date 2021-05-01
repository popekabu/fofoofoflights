import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:fofoofoflights/models/flights.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

class SeeFlights extends StatefulWidget {
  SeeFlights({Key key}) : super(key: key);

  @override
  _SeeFlightsState createState() => _SeeFlightsState();
}

class _SeeFlightsState extends State<SeeFlights> {
  String from, to;
  List<Flights> _flights;

   Future<List<Flights>> _getFlights() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     
     //FLIGHTS CONNECTION GOES HERE
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFlights().then((value){
      setState(() {
        _flights = value;
      });
    });
  }

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
          iconTheme: IconThemeData(
            color: Colors.blueAccent, //change your color here
          ),
          toolbarHeight: 40,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Text(
            "Available Flights",
            style: TextStyle(
                fontSize: 30.0,
                letterSpacing: -3,
                fontFamily: "Poppins",
                color: Colors.blueAccent),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: null == _flights ? 0 : _flights.length > 0
                ? ListView.builder(
                    itemCount: _flights.length,
                    itemBuilder: (BuildContext context, int index) {
                      Flights flights = _flights[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey[100],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          flights.groupedItineraryResponse.version,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                : Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.grey[100],
                              child: ListView.builder(
                                itemBuilder: (_, __) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 40,
                                          width: 40,
                                          child: CircleAvatar()),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: double.infinity,
                                              height: 10.0,
                                              color: Colors.white,
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2.0),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 10.0,
                                              color: Colors.white,
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2.0),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 10.0,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                itemCount: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ));
  }
}
