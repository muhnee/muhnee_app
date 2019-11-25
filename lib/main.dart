import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './routing + transitions/FadeRoute.dart';
import './pages/IntroPage.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);

  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      canvasColor: Colors.white,
      primaryColor: Colors.white,
      fontFamily: 'Montserrat',
      appBarTheme: AppBarTheme(
        color: Colors.white,
      ),
    ),
    home: new SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);

    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(context, FadeRouteBuilder(page: IntroPage()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        body: new Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(1.0, 1.0),
          end: Alignment(-1.0, -1.0),
          stops: [0.1, 0.9],
          colors: [
            Color(0xffecf2d0),
            Color(0xfff6f8ec),
          ],
        ),
      ),
    //   child: new Stack(
    //     children: <Widget>[
    //       Container(
    //   alignment: Alignment.bottomLeft,
    //   padding: EdgeInsets.only(bottom: 40.0, left: 30.0),
    //   child: new Image.asset(
    //     'lib/assets/images/logoFull.png',
    //     height: 150,
    //   ),
    // ),
    //     ],
    //   ),
    ));
  }
}
