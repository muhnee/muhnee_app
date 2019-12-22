import 'package:flutter/material.dart';
import 'package:muhnee/pages/HomePage/HomePage.dart';
import 'package:muhnee/routing/FadeRoute.dart';
import 'package:muhnee/utilities/SignIn.dart';

import '../../main.dart';

class ExpensePage extends StatefulWidget {

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Padding(
        padding: EdgeInsets.only(top: 30),
        child:  RaisedButton(
        child: Text("SignOut"),
        onPressed: (){
          signOutGoogle();
           Navigator.pushReplacement(context, FadeRouteBuilder(page: SplashScreen()));

        },
      ),
      )
     
    );
  }
}