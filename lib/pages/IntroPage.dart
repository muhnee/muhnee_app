import 'package:flutter/material.dart';
import '../routing/FadeRoute.dart';
import 'dart:async';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int delayAmount = 500;

    PageController _controller = PageController();

    TextEditingController nameController = new TextEditingController();
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();

    return PageView(
      controller: _controller,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        //Page 1
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
                        child: Text("Hello,",
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
                        child:
                            Text("Welcome to Arlo, a simple gratitude tracker.",
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 28.0,
                                  //fontFamily: "Montserrat",
                                  color: Colors.black,
                                )),
                      ),
                      delay: delayAmount * 3,
                    ),
                    ShowUp(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 32.0),
                        child: Text(
                            "Spend a few minutes everyday to reflect on the good that we encountered today.",
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 28.0,
                              //fontFamily: "Montserrat",
                              color: Colors.black,
                            )),
                      ),
                      delay: delayAmount * 6,
                    ),
                    ShowUp(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 32.0),
                        child: Text(
                            "Life can be hard sometimes, but it's important to remember the positives too.",
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 28.0,
                              //fontFamily: "Montserrat",
                              color: Colors.black,
                            )),
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
              _controller.nextPage(
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

        // Page 2
        Scaffold(
          appBar: AppBar(
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 64.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ShowUp(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Let's start with a few details",
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 30.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    delay: delayAmount * 3,
                  ),
                  ShowUp(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Name',
                        ),
                        style: TextStyle(fontSize: 20.0),
                        controller: nameController,
                      ),
                    ),
                    delay: delayAmount * 6,
                  ),
                  ShowUp(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Email'),
                        style: TextStyle(fontSize: 20.0),
                        controller: emailController,
                      ),
                    ),
                    delay: delayAmount * 7,
                  ),
                  ShowUp(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Password'),
                        style: TextStyle(fontSize: 20.0),
                        controller: passwordController,
                      ),
                    ),
                    delay: delayAmount * 8,
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //TODO : This should really be a reusable component

              if (nameController.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      title: new Text("Missing Name"),
                      content: new Text("Please add name before continuing"),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else if (emailController.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      title: new Text("Missing Email"),
                      content: new Text("Please add email before continuing"),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else if (passwordController.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      title: new Text("Missing Password "),
                      content:
                          new Text("Please add password before continuing"),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                Navigator.pushReplacement(
                    context, FadeRouteBuilder(page: HomeScreen(userName: nameController.text)));
              }
            },
            child: ShowUp(
              child: Icon(Icons.keyboard_arrow_down),
              delay: delayAmount * 9,
            ),
            elevation: 0,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
        ),

        //Page 3
      ],
    );
  }
}

//fade up animation
class ShowUp extends StatefulWidget {
  final Widget child;
  final int delay;

  ShowUp({@required this.child, this.delay});

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}
