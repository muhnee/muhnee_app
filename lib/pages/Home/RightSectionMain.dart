import 'package:flutter/material.dart';
import 'package:muhnee/utilities/SignIn.dart';

class RightSectionMain extends StatefulWidget {
  @override
  _RightSectionMainState createState() => _RightSectionMainState();
}

class _RightSectionMainState extends State<RightSectionMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          signOutGoogle();
        },
      ),
    );
  }
}
