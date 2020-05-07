import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'registration_page.dart';
import 'chat_page.dart';
import 'login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        RegistrationPage.id: (context) => RegistrationPage(),
        LoginPage.id: (context) => LoginPage(),
        ChatPage.id: (context) => ChatPage(),
      },
    );
  }
}
