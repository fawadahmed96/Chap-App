import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatui/chat_page.dart';
import 'package:flutter/material.dart';
import 'custom_button.dart';
import 'registration_page.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  static const String id = 'MYHOMEPAGE';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> loginUser() async {
    final user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      Navigator.pushNamed(context, ChatPage.id);
    }
  }

  @override
  void initState() {
    super.initState();
    loginUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset(
                    "images/logo.png",
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
              ),
              SizedBox(
                width: 250.0,
                child: TyperAnimatedTextKit(
                    speed: Duration(milliseconds: 300),
                    onTap: () {
                      print("Tap Event");
                    },
                    text: [
                      "Instant Chat App",
                    ],
                    textStyle: TextStyle(
                        fontSize: 30.0,
                        fontFamily: "Bobbers",
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue),
                    textAlign: TextAlign.start,
                    alignment:
                        AlignmentDirectional.topStart // or Alignment.topLeft
                    ),
              ),
            ],
          ),
          CustomButton(
            text: "Log In",
            callback: () {
              Navigator.pushNamed(context, LoginPage.id);
            },
          ),
          CustomButton(
            text: "Register",
            callback: () {
              Navigator.pushNamed(context, RegistrationPage.id);
            },
          ),
        ],
      ),
    );
  }
}
