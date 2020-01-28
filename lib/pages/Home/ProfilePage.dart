import 'package:flutter/material.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import '../../utilities/FadeRoute.dart';
import '../../main.dart';
import '../../utilities/SignIn.dart';
import '../../utilities/SizeConfig.dart';

var profileInfo;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    profileInfo = getPhotoUrl();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                SignOutBtn(), 


               
               
              ]),
        ),
      ),
    );
  }
}

class SignOutBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: RaisedButton(
        child: Text("SignOut"),
        onPressed: () {
          signOutGoogle();
          Navigator.pushReplacement(
              context, FadeRouteBuilder(page: SplashScreen()));
        },
      ),
    );
  }
}
