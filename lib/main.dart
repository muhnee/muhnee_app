import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './pages/Home/HomePage.dart';
import './utilities/FadeRoute.dart';
import './pages/Intro/IntroPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
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

 // SystemChrome.setEnabledSystemUIOverlays([]);

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var uid;

  startTime() async {
    var _duration = Duration(seconds: 2);

    try {
      uid = await FirebaseAuth.instance.currentUser();
    } catch (e) {
      print(e);
    }

    if (uid != null) {
      return Timer(_duration, mainSignedIn);
    } else {
      return Timer(_duration, mainNotSignIn);
    }
  }

  void mainSignedIn() {
    Navigator.pushReplacement(context, FadeRouteBuilder(page: HomePage()));
  }

  void mainNotSignIn() {
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
            color: Color(0xff8e91f3),
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment(1.0, 1.0),
            //     end: Alignment(-1.0, -1.0),
            //     stops: [0.1, 0.9],
            //     colors: [
            //       Color(0xffecf2d0),
            //       Color(0xfff6f8ec),
            //     ],
            //   ),
            // ),
            child: Center(
              child: Text("muhnee",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  )),
            )
            //   new Stack(
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
