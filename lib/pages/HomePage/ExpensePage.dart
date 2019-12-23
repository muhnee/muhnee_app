import 'package:flutter/material.dart';
import 'package:muhnee/routing/FadeRoute.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
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
      body: SafeArea(
        child: Column(
          children: <Widget>[

              Padding(
        padding: EdgeInsets.only(top: 30),
        child:  RaisedButton(
        child: Text("SignOut"),
        onPressed: (){
          signOutGoogle();
           Navigator.pushReplacement(context, FadeRouteBuilder(page: SplashScreen()));

        },
      ),
      ),

      Padding(
        padding: EdgeInsets.only(top: 30),
        child:  RaisedButton(
        child: Text("get data"),
        onPressed: () async {

          print(

          await isOnboarded());
          

        },
      ),
      )

          


          ],
        ),
      ),
    );

    
  }
}

  // Padding(
  //       padding: EdgeInsets.only(top: 30),
  //       child:  RaisedButton(
  //       child: Text("SignOut"),
  //       onPressed: (){
  //         signOutGoogle();
  //          Navigator.pushReplacement(context, FadeRouteBuilder(page: SplashScreen()));

  //       },
  //     ),
  //     )