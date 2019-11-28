import 'package:flutter/material.dart';
import 'package:muhnee_app/routing/FadeRoute.dart';
import 'HomePage.dart';
import '../utilities/ShowUp.dart';
import '../utilities/SignIn.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int delayAmount = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _showUpText(),
          ShowUp(
            child: Padding(
                padding: EdgeInsets.only(bottom: 138.0),
                child: Center(
                  child: _signInButton(),
                )),
            delay: delayAmount * 9,
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     controller.nextPage(
      //         duration: Duration(seconds: 1), curve: Curves.ease);
      //   },
      //   child: ShowUp(
      //     child: Icon(Icons.keyboard_arrow_down),
      //     delay: delayAmount * 11,
      //   ),
      //   elevation: 0,
      //   foregroundColor: Colors.black,
      //   backgroundColor: Colors.white,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(16.0)),
      //   ),
      // ),
    );
  }

  Widget _showUpText() {
    return Padding(
      padding: EdgeInsets.only(top: 64.0, left: 22.0, right: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ShowUp(
            child: Padding(
              padding: EdgeInsets.only(bottom: 35.0),
              child: Text("Hi,",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                  )),
            ),
            delay: delayAmount,
          ),
          ShowUp(
            child: Padding(
              padding: EdgeInsets.only(bottom: 35.0),
              child: Text("Welcome to Muhnee",
                  style: TextStyle(
                    fontSize: 30.0,
                    // fontFamily: "Montserrat",
                    color: Colors.black,
                  )),
            ),
            delay: delayAmount * 3,
          ),
          ShowUp(
            child: Padding(
              padding: EdgeInsets.only(bottom: 32.0),
              child: Text("A simple way to track daily spending.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    // fontFamily: "Montserrat",
                    color: Colors.black,
                  )),
            ),
            delay: delayAmount * 6,
          ),
        ],
      ),
    );
  }

  Widget _signInButton() {
    return SizedBox(
      width: 300,
      child: GestureDetector(
        onTap: () {
          signInWithGoogle().whenComplete(() {
            Navigator.pushReplacement(
                context, FadeRouteBuilder(page: HomePage()));
          });
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 40.0,
                ),
              ]),
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 17.0),
                  child: Image(
                      image: AssetImage("lib/assets/images/google_icon.png"),
                      height: 30.0),
                ),
                Text(
                  "Sign in with Google",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _signInButton() {
  //   return OutlineButton(
  //     splashColor: Colors.grey,
  //     onPressed: () {
  //       signInWithGoogle().whenComplete(() {
  //         Navigator.pushReplacement(
  //             context, FadeRouteBuilder(page: HomePage()));
  //       });
  //     },
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  //     highlightElevation: 0,
  //     borderSide: BorderSide(color: Colors.grey),
  //     child: Padding(
  //       padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Image(
  //               image: AssetImage("lib/assets/images/google_icon.png"),
  //               height: 25.0),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 15),
  //             child: Text(
  //               'Sign in with Google',
  //               style: TextStyle(
  //                 fontFamily: 'Montserrat',
  //                 fontSize: 18,
  //                 color: Colors.grey,
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

}
