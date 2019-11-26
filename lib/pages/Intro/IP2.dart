import 'package:flutter/material.dart';
import '../../utilities/FadeUpTransition.dart';
import '../../routing/FadeRoute.dart';
import '../MainApp/HomePage.dart';

class IP2 extends StatelessWidget {
  var controller;
  var passwordController;
  var nameController;
  var emailController;
  var delayAmount;

  IP2(
      {@required controller,
      @required passwordController,
      @required nameController,
      @required emailController,
      @required delayAmount});

  @override
  Widget build(BuildContext context) {
    // Page 2
    return Scaffold(
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
                      borderRadius: BorderRadius.all(Radius.circular(11.0))),
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
                      borderRadius: BorderRadius.all(Radius.circular(11.0))),
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
                      borderRadius: BorderRadius.all(Radius.circular(11.0))),
                  title: new Text("Missing Password "),
                  content: new Text("Please add password before continuing"),
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
                context,
                FadeRouteBuilder(
                    page: HomePage(userName: nameController.text)));
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
    );
  }
}
