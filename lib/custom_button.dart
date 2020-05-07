import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  static const String id = 'CUSTOMPAGE';
  final String text;
  final VoidCallback callback;

  CustomButton({@required this.text, @required this.callback});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Material(
        color: Colors.blueGrey,
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20.0),
        child: MaterialButton(
          onPressed: callback,
          minWidth: 150.0,
          child: Text(text),
        ),
      ),
    );
  }
}
