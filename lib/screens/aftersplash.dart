import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fofoofoflights/widgets/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AfterSplash extends StatefulWidget {
  @override
  _AfterSplashState createState() => _AfterSplashState();
}

class _AfterSplashState extends State<AfterSplash> {
  String _selCC, _phoneNum, contNum;
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> addUser(fname, phoneNum, email) {
    BotToast.showLoading();
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users.add({
      'full_name': fname,
      'phone_number': phoneNum,
      'email': email
    }).then((value) async {
      BotToast.closeAllLoading();
      final prefs = await SharedPreferences.getInstance();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      prefs.setString('phone_number', phoneNum);
      prefs.setString('full_name', fname);
      prefs.setString('email', email);
      BotToast.showSimpleNotification(title: "Account Creation Successful 🎉");
    }).catchError((error) {
      BotToast.closeAllLoading();
      BotToast.showSimpleNotification(
          title: "Please check your internet connection");
    });
  }

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print("NAME => " + authResult.user.displayName);
      String fname = authResult.user.displayName;
      print("EMAIL => " + authResult.user.email);
      String email = authResult.user.email;
      print("CONTACT NUM => " + authResult.user.phoneNumber);
      if(authResult.user.phoneNumber == null){
        contNum = "N/A";
      }
      addUser(fname, contNum, email);
    } on PlatformException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  Future sendOTPUser(countryC, phone, context) async {
    BotToast.showLoading();
    Firebase.initializeApp();
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      phoneNumber: countryC + phone,
      timeout: Duration(seconds: 120),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();
        BotToast.closeAllLoading();
      },
      verificationFailed: (FirebaseAuthException exception) {
        BotToast.closeAllLoading();
        print("VERIFICATION FAILED $exception");
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        BotToast.closeAllLoading();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                title: Text(
                  "We've sent you an SMS Code. Please check your inbox for your SMS Code",
                  style: TextStyle(fontSize: 18.0),
                ),
                content: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: TextField(
                          style: TextStyle(fontSize: 20),
                          cursorColor: Colors.black,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          controller: _codeController,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              labelStyle: TextStyle(color: Colors.black),
                              filled: false),
                        ),
                      )
                    ],
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        icon: Icon(MdiIcons.send),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          final code = _codeController.text.trim();
                          AuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: verificationId,
                                  smsCode: code);
                          try {
                            UserCredential result =
                                await _auth.signInWithCredential(credential);
                            User user = result.user;
                            if (user != null || user == null) {
                              print('VERIFICATION  => $countryC$phone');
                              //check if user with phone number exist in database and then route user
                              final QuerySnapshot result =
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .where('phone_number',
                                          isEqualTo: '$countryC$phone')
                                      .get();

                              final List<DocumentSnapshot> documents =
                                  result.docs;
                              if (documents.length > 0) {
                                //exists
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/home', (Route<dynamic> route) => false);
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString(
                                    'phone_number', '$countryC$phone');
                                prefs.setString("full_name",
                                    documents[0].get("full_name"));
                                prefs.setString(
                                    "email", documents[0].get("email"));
                              } else {
                                //not exists
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/register', (Route<dynamic> route) => true,
                                    arguments: {
                                      "userPhoneNumber": '$_selCC$_phoneNum'
                                    });
                              }
                            }
                          } on Exception catch (e) {
                            print("EXCEPTION E $e");
                            if (e.toString().contains(
                                "[firebase_auth/invalid-verification-code]")) {
                              BotToast.showSimpleNotification(
                                  title:
                                      "Verification Code is wrong, Try Again!");
                            } else {
                              BotToast.showSimpleNotification(
                                  title: "Problem Occurred, try again");
                            }
                          }
                        }),
                  )
                ],
              );
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: null,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: new Icon(MdiIcons.closeCircle),
                        onPressed: () {
                          var dialog = CustomAlertDialog(
                              title: "Fofoofo Flights",
                              message: "Are you sure you want to exit?",
                              positiveBtnText: "Yes",
                              onPostivePressed: () {
                                exit(0);
                              },
                              negativeBtnText: "No");

                          showDialog(
                              context: context,
                              builder: (BuildContext context) => dialog);
                        },
                        iconSize: 32.0,
                        color: Colors.grey),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                child: Text("Welcome Back",
                    style: TextStyle(
                        fontSize: 23.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                child: Text(
                    "Kindly provide your phone number to get set up right away!",
                    style: TextStyle(fontSize: 20.0, color: Colors.black54),
                    textAlign: TextAlign.left),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CountryCodePicker(
                                textStyle: TextStyle(fontSize: 20.0),
                                onInit: (code) => _selCC = code.dialCode,
                                onChanged: (code) => _selCC = code.dialCode,
                                initialSelection: 'GH',
                                favorite: ['+233', 'GH'],
                                showCountryOnly: false,
                                showOnlyCountryWhenClosed: false,
                                alignLeft: false,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: FormInput(
                                    hintText: "0244 11 22 33",
                                    fontSize: 20,
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value.isEmpty || value.length < 10) {
                                        return "Phone number is invalid";
                                      }
                                    },
                                    onSaved: (String value) {
                                      _phoneNum = value;
                                      print("Phone Number is... => $_phoneNum");
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: RoundButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _formKey.currentState.save();
                            sendOTPUser(_selCC, _phoneNum, context);
                          },
                          buttonText: "Continue",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child:
                                  Container(height: 0.5, color: Colors.black45),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("OR"),
                            ),
                            Expanded(
                              child:
                                  Container(height: 0.5, color: Colors.black45),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: RoundButton2(
                            iconColor: Colors.red,
                            buttonText: "Login with Gmail",
                            buttonIcon: MdiIcons.gmail,
                            textColor: Colors.black,
                            onPressed: () {
                              signInWithGoogle();
                            }),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      //   child: RoundButton2(
                      //       iconColor: Colors.blue,
                      //       buttonText: "Login with Facebook",
                      //       buttonIcon: MdiIcons.facebook,
                      //       textColor: Colors.black,
                      //       onPressed: () {}),
                      // )
                    ],
                  )),
              Align(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Made with ❤️ from Fofoofo Tech"),
                ),
              ),
            ],
          ),
        ));
  }
}
