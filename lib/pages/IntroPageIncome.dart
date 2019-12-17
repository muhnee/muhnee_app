import 'package:flutter/material.dart';
import 'package:muhnee_app/pages/IntroPage.dart';

class IntroPageIncome extends StatelessWidget {
  var name;
  IntroPageIncome({this.name});

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Text(name),
    );

  }
}