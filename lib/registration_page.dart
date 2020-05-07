import 'package:chatui/chat_page.dart';
import 'package:chatui/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'textfield_rounded.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'REGISTRATION';
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  Future<void> registerUser() async {
    setState(() {
      showSpinner = true;
    });
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        Navigator.pushNamed(context, ChatPage.id);
      }
    } on PlatformException catch (error) {
      showToast(error.message,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    } catch (e) {
      showToast(e.toString(),
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    } finally {
      setState(() {
        showSpinner = false;
      });
    }

//    FirebaseUser userCredentials = result.user;
//    print(userCredentials.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instant Chap App"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Hero(
                tag: "logo",
                child: Container(
                  child: Image.asset("images/logo.png"),
                ),
              ),
            ),
            TextFieldRounded(
              hidden: false,
              text: 'Enter User id',
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFieldRounded(
              hidden: true,
              text: 'Enter Password',
              onChanged: (input) {
                password = input;
              },
            ),
            CustomButton(
              text: "Register",
              callback: () async {
                await registerUser();
              },
            ),
            SizedBox(
              height: 80.0,
            ),
          ],
        ),
      ),
    );
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}
