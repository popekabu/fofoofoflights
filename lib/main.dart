import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fofoofo Flights',
      theme: ThemeData(
        fontFamily: "Palanquin",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      initialRoute: '/',
      routes: {
        '/login': (context) => AfterSplash(),
        '/register': (context) => Register(),
        '/home': (context) => Home(),
        '/onboarding': (context) => OnBoarding(),
        '/profile': (context) => Profile(),
        '/notification': (context) => UserNotifications(),
        '/flightpref': (context) => FlightPref(),
        '/flights': (context) => SeeFlights()
      },
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String routeTo;

class _MyHomePageState extends State<MyHomePage> {
  _routeUser() async {
    print('Is New User Method called');
    SharedPreferences onBoardPref = await SharedPreferences.getInstance();
    if (onBoardPref.get("isNewUser") == null) {
      if (mounted) {
        setState(() {
          routeTo = "onboarding";
          onBoardPref.setString('isNewUser', "");
        });
      }
    } else {
      if (mounted) {
        setState(() {
          if (onBoardPref.get("phone_number") != null) {
            routeTo = "home";
            print("SHARED PREF DATA " + onBoardPref.get("phone_number"));
          } else {
            routeTo = "login";
            print("SHARED PREF DATA NO DATA");
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _routeUser();
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: routeTo == "onboarding"
            ? new OnBoarding()
            : routeTo == "login"
                ? new AfterSplash()
                : new Home(),
        title: new Text('Fofoofo Flights', style: TextStyle(fontSize: 30.0)),
        image: new Image.asset('assets/logo.png'),
        backgroundColor: Colors.white,
        loadingText: Text("Please wait..."),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.red);
  }
}
