import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fofoofoflights/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _fname, _lname, _email;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> addUser(fname, lname, phoneNum, email) {
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
    }).catchError((error){
      BotToast.closeAllLoading();
      BotToast.showSimpleNotification(
        title: "Please check your internet connection");
    });
        
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> passedData =
        ModalRoute.of(context).settings.arguments;
    String pdPhoneNum = passedData['userPhoneNumber'];
    print("USER PHONE NUMBER IN REGISTRATION=>" + pdPhoneNum);

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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      icon: new Icon(MdiIcons.arrowLeft),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      iconSize: 32.0,
                      color: Colors.grey),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0),
              child: Text("New Account Creation",
                  style: TextStyle(
                      fontSize: 23.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0),
              child: Text("Almost done, a few things left...",
                  style: TextStyle(fontSize: 20.0, color: Colors.black54),
                  textAlign: TextAlign.left),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FormInput(
                        hintText: "Full Name",
                        fontSize: 20,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Full Name cannot be empty";
                          }
                        },
                        onSaved: (String value) {
                          _fname = value;
                          print("Full Name is... => $_fname");
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                      child: FormInput(
                        hintText: "Email",
                        fontSize: 20,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          bool isValid = EmailValidator.validate(value);
                          if (isValid == false) {
                            return "Email address not valid";
                          }
                        },
                        onSaved: (String value) {
                          _email = value;
                          print("Email is... => $_email");
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RoundButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          _formKey.currentState.save();
                          addUser(_fname, _lname, pdPhoneNum, _email);
                        },
                        buttonText: "Continue",
                      ),
                    ),
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
      ),
    );
  }
}
