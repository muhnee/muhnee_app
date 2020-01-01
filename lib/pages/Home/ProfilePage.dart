import 'package:flutter/material.dart';
import '../../utilities/FadeRoute.dart';
import '../../main.dart';
import '../../utilities/SignIn.dart';
import '../../utilities/SizeConfig.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: RaisedButton(
                child: Text("SignOut"),
                onPressed: () {
                  signOutGoogle();
                  Navigator.pushReplacement(
                      context, FadeRouteBuilder(page: SplashScreen()));
                },
              ),
            ),

            //put the page children in here...
          ],
        ),
      ),
    );
  }
}
