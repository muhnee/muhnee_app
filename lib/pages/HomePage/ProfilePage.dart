import 'package:flutter/material.dart';
import 'package:muhnee/routing/FadeRoute.dart';
import '../../utilities/SignIn.dart';
import '../../utilities/SizeConfig.dart';
import '../IntroPage.dart';

class ProfilePage extends StatefulWidget {
  
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[

            //put the page children in here...

          ],
        ),
      ),
    );
  }
}

