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

  PageController controller = PageController();

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      scrollDirection: Axis.vertical,
      children: <Widget>[

        //! this should be in 2 seperate pages 
        //Pages
        // IP1(controller: _controller, delayAmount: delayAmount),
       

        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(36.0, 0.0, 36.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ShowUp(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 32.0),
                        child: Text("Hi,",
                            style: TextStyle(
                              fontSize: 31.0,
                              color: Colors.black,
                            )),
                      ),
                      delay: delayAmount,
                    ),
                    ShowUp(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 32.0),
                        child: Text("Welcome to Muhn-ee.",
                            style: TextStyle(
                              fontSize: 28.0,
                              // fontFamily: "Montserrat",
                              color: Colors.black,
                            )),
                      ),
                      delay: delayAmount * 3,
                    ),
                    ShowUp(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 32.0),
                        child: Text(
                            "The simplest way to track you're daily spending.",
                            style: TextStyle(
                              fontSize: 28.0,
                              // fontFamily: "Montserrat",
                              color: Colors.black,
                            )),
                      ),
                      delay: delayAmount * 6,
                    ),

                    ShowUp(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 32.0),
                        child: _signInButton(),
                      ),
                      delay: delayAmount * 9,
                    ),


                  ],
                ),
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
        ),

      ],
    );
  }


  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().whenComplete(() {
          Navigator.pushReplacement(context, FadeRouteBuilder(page: HomePage()));
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  
}

