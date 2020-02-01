import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muhnee/pages/Home/HomePage.dart';
import 'package:muhnee/utilities/FadeRoute.dart';
import 'package:muhnee/utilities/ShowUp.dart';
import 'package:muhnee/utilities/SizeConfig.dart';

class IntroPageFinal extends StatefulWidget {
  @override
  _IntroPageFinalState createState() => _IntroPageFinalState();
}

class _IntroPageFinalState extends State<IntroPageFinal> {
  int delayAmount = 500;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body:
          // ListView(
          //   children: <Widget>[
          Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.,
        children: <Widget>[
          _showUpText(),
          SizedBox(
            height: 100,
          ),
          _signInButton(),
        ],
      ),
      //   ],
      // ),
    );

    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   appBar: AppBar(
    //     automaticallyImplyLeading: false,
    //     elevation: 0,
    //   ),
    //   body: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     children: <Widget>[

    //       _showUpText(),
    //       SizedBox(height: 230,),
    //       _signInButton(),
    //     ],
    //   ),
    // );
  }

  //should try to simplify this
  Widget _showUpText() {
    return Padding(
      padding: EdgeInsets.only(top: 54.0, left: 22.0, right: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ShowUpTextSingle(
            bottomPadding: 33.0,
            lineText: "You're all setup!",
            delayAmount: delayAmount * 2,
          ),
          ShowUpTextSingle(
            bottomPadding: 5.0,
            lineText: "Tap below to get",
            delayAmount: delayAmount * 3,
          ),
          ShowUpTextSingle(
            bottomPadding: 15.0,
            lineText: "started",
            delayAmount: delayAmount * 4,
          ),
        ],
      ),
    );
  }

  Widget _signInButton() {
    return ShowUp(
      child: Padding(
          padding: EdgeInsets.only(bottom: 142.0),
          child: Center(
            child: SizedBox(
              width: 225,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 40.0,
                      ),
                    ]),
                child: Material(
                  borderRadius: BorderRadius.circular(21.0),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(21.0),
                      child: Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Center(
                            child: Text(
                              "Let's Begin",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          )),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            FadeRouteBuilder(
                              page: HomePage(),
                            ));
                      }),
                ),
              ),
            ),
          )),
      delay: delayAmount * 6,
    );
  }
}

class ShowUpTextSingle extends StatelessWidget {
  var bottomPadding;
  var lineText;
  var delayAmount;

  ShowUpTextSingle(
      {@required this.bottomPadding,
      @required this.delayAmount,
      @required this.lineText});

  @override
  Widget build(BuildContext context) {
    return ShowUp(
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Text(lineText,
            style: TextStyle(
              fontSize: 29.0,
              color: Colors.black,
            )),
      ),
      delay: delayAmount,
    );
  }
}
