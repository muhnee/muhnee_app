import 'package:flutter/material.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import '../../utilities/FadeRoute.dart';
import '../../main.dart';
import '../../utilities/SignIn.dart';
import '../../utilities/SizeConfig.dart';
import 'ExpensePageSingleFile.dart';

var profileInfo;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    profileInfo = getProfileInfo();
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
                FutureBuilder<String>(
                  future:
                      profileInfo, // a previously-obtained Future<String> or null
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    List<Widget> children;

                    if (snapshot.hasData) {
                      children = <Widget>[


                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(10.0),
                        //   child: Image.network(
                        //     snapshot.data,
                        //     width: SizeConfig.blockSizeHorizontal * 25,
                        //     height: SizeConfig.blockSizeHorizontal * 25,
                        //   ),
                        // ),

                        // data
                      ];
                    } else if (snapshot.hasError) {
                      children = <Widget>[
                        NotificationCell(
                          message: "Network Error",
                          messageColor: Colors.red,
                        ),
                        SignOutBtn(),
                      ];
                    } else {
                      children = <Widget>[
                        NotificationCell(
                          message: "Loading...",
                          messageColor: Colors.grey,
                        ),
                        SignOutBtn(),
                      ];
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: children,
                      ),
                    );
                  },
                ),
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
