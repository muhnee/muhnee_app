import 'package:flutter/material.dart';
import 'package:muhnee/pages/HomePage/HomePage.dart';
import 'package:muhnee/routing/FadeRoute.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import 'package:muhnee/utilities/SizeConfig.dart';
import '../utilities/ShowUp.dart';
import '../utilities/SignIn.dart';
import 'IntroPageExpense.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _showUpText(),
          _signInButton(),
        ],
      ),
    );
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
            lineText: "Hi",
            delayAmount: delayAmount * 2,
          ),
          ShowUpTextSingle(
            bottomPadding: 33.0,
            lineText: "Welcome to Muhnee",
            delayAmount: delayAmount * 3,
          ),
          ShowUpTextSingle(
            bottomPadding: 15.0,
            lineText: "A simple way to track",
            delayAmount: delayAmount * 4,
          ),
          ShowUpTextSingle(
            bottomPadding: 0.0,
            lineText: "daily spending",
            delayAmount: delayAmount * 5,
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
              width: 300,
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
                child: Material(
                  borderRadius: BorderRadius.circular(23.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(23.0),
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 17.0),
                            child: Image(
                                image: AssetImage(
                                    "lib/assets/images/google_icon.png"),
                                height: 30.0),
                          ),
                          Text(
                            "Sign in with Google",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () async {
                      // signInWithGoogle().whenComplete(() {
                      //   Navigator.pushReplacement(
                      //       context, FadeRouteBuilder(page: IntroPageExpense()));
                      // });

                      //! the below shows the object returned after a successful auth
                      //signInWithGoogle().then((user) => print(user)).catchError((e) => print(e));

                      // signInWithGoogle()
                      //     .then((user) => Navigator.pushReplacement(context,
                      //         FadeRouteBuilder(page: IntroPageExpense())))
                      //     .catchError((e) => print(e));

                      showDialog(
                        
                        context: context,
                        barrierDismissible: true,
                      
                        builder: (BuildContext context) {
                          return Dialog(
                            
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            child: SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 10,
                              height: SizeConfig.blockSizeVertical*15,
                              child: SpinKitDoubleBounce(color: Colors.white, size: SizeConfig.blockSizeHorizontal *8,),
                            ),
                            
                            
                          );
                        },
                      );
                      signInWithGoogle()
                          .then((user) async => await isOnboarded()
                              ? Navigator.pushReplacement(
                                  context, FadeRouteBuilder(page: HomePage()))
                              : Navigator.pushReplacement(context,
                                  FadeRouteBuilder(page: IntroPageExpense())))
                          .catchError((e) => print(e));

                      // if (await isOnboarded()){
                      //   Navigator.pushReplacement(context, FadeRouteBuilder(page: HomePage()));
                      // } else {
                      //   Navigator.pushReplacement(context, FadeRouteBuilder(page: IntroPageExpense()));
                      // }
                    },
                  ),
                ),
              ),
            ),
          )),
      delay: delayAmount * 7,
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
              fontSize: 30.0,
              color: Colors.black,
            )),
      ),
      delay: delayAmount,
    );
  }
}
