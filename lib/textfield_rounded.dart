import 'package:flutter/material.dart';

class TextFieldRounded extends StatelessWidget {
  final String text;
  final Function onChanged;
  final Function validate;
  final bool hidden;
  TextFieldRounded(
      {this.text,
      @required this.onChanged,
      @required this.hidden,
      this.validate});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        obscureText: hidden,
        onChanged: onChanged,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          hintText: text,
          hintStyle: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w100,
            color: Colors.blueGrey,
          ),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
