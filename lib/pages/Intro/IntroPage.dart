import 'package:flutter/material.dart';
import 'package:muhnee_app/pages/Intro/IP1.dart';
import 'package:muhnee_app/pages/Intro/IP2.dart';
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
        //Pages
        IP1(controller: _controller, delayAmount: delayAmount),
        IP2(
            controller: _controller,
            nameController: nameController,
            emailController: emailController,
            passwordController: passwordController,
            delayAmount: delayAmount),
      ],
    );
  }
}
