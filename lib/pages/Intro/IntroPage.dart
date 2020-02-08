import 'package:flutter/material.dart';
import '../Home/HomePage.dart';
import '../../utilities/FadeRoute.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import 'package:muhnee/utilities/SizeConfig.dart';
import '../../utilities/SignIn.dart';
import '../../utilities/ShowUp.dart';
import 'IntroPageExpense.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io' show Platform;
import 'package:device_info/device_info.dart';
import 'package:apple_sign_in/apple_sign_in_button.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int delayAmount = 500;

  bool supportsAppleSignIn = false;

  @override
  Widget initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getDeviceInfo();
    });
  }

  _getDeviceInfo() async {
    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var version = iosInfo.systemVersion;

      // We enable Apple Sign In if on iOS 13
      // TODO: update this to greater or equal to 13
      if (version.contains('13') == true) {
        supportsAppleSignIn = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    var signInButtons = <Widget>[_signInButton()];

    if (supportsAppleSignIn) {
      signInButtons.add(_signInWithAppleButton());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _showUpText(),
          Column(
            children: signInButtons,
          ),
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
          padding: EdgeInsets.only(bottom: 16.0),
          child: Center(
            child: SizedBox(
              width: 300,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 40.0,
                      ),
                    ]),
                child: Material(
                  borderRadius: BorderRadius.circular(6.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Padding(
                      padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 17.0),
                            child: Image(
                                image: AssetImage(
                                    "lib/assets/images/google_icon.png"),
                                height: 20.0),
                          ),
                          Text(
                            "Sign in with Google",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
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
                              height: SizeConfig.blockSizeVertical * 15,
                              child: SpinKitDoubleBounce(
                                color: Colors.white,
                                size: SizeConfig.blockSizeHorizontal * 8,
                              ),
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

                      //   signInWithGoogle().catchError((e) => print(e));

                      // isOnboarded()
                      //     .then((boolean) => boolean == true
                      //         ? Navigator.pushReplacement(
                      //             context, FadeRouteBuilder(page: HomePage()))
                      //         : Navigator.pushReplacement(context,
                      //             FadeRouteBuilder(page: IntroPageExpense())))
                      //     .catchError((e) => print(e));

                      //   var booleanOnboarded = isOnboarded();

                      //   await booleanOnboarded == true
                      //           ? Navigator.pushReplacement(
                      //               context, FadeRouteBuilder(page: HomePage()))
                      //           : Navigator.pushReplacement(context,
                      //               FadeRouteBuilder(page: IntroPageExpense()));
                    },
                  ),
                ),
              ),
            ),
          )),
      delay: delayAmount * 7,
    );
  }

  Widget _signInWithAppleButton() {
    return ShowUp(
      child: Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Center(
            child: SizedBox(
                width: 300,
                child: AppleSignInButton(
                  style: ButtonStyle.black,
                  type: ButtonType.continueButton,
                  onPressed: () {
                    signInWithApple()
                        .then((user) async => await isOnboarded()
                            ? Navigator.pushReplacement(
                                context, FadeRouteBuilder(page: HomePage()))
                            : Navigator.pushReplacement(context,
                                FadeRouteBuilder(page: IntroPageExpense())))
                        .catchError((e) => print(e));
                  },
                )),
          )),
      delay: delayAmount * 8,
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
