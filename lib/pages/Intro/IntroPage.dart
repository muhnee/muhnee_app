import 'package:flutter/material.dart';
import '../MainApp/HomePage.dart';
import '../../routing/FadeRoute.dart';
import '../../utilities/ShowUp.dart';
import '../../widgets/GoogleSignInBtn.dart';

class IntroPage extends StatelessWidget {

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
        // IP2(
        //     controller: _controller,
        //     nameController: nameController,
        //     emailController: emailController,
        //     passwordController: passwordController,
        //     delayAmount: delayAmount),

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
                        child: GoogleSignInBtn(),
                      ),
                      delay: delayAmount * 9,
                    ),


                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.nextPage(
                  duration: Duration(seconds: 1), curve: Curves.ease);
            },
            child: ShowUp(
              child: Icon(Icons.keyboard_arrow_down),
              delay: delayAmount * 11,
            ),
            elevation: 0,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
        ),

      ],
    );
  }
}


