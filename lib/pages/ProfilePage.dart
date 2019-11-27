import 'package:flutter/material.dart';
import 'package:muhnee_app/utilities/SizeConfig.dart';
import 'IntroPage.dart';
import '../utilities/SignIn.dart';
import '../utilities/SizeConfig.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false, // Don't show the leading button
      ),
      body: Column(
        children: <Widget>[

          Padding(
            padding: EdgeInsets.only(left: 32.0, right: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: new BorderRadius.circular(16.0),
                  child: Image.network(
                    imageUrl,
                    height: 80.0,
                    width: 80.0,
                  ),
                ),
              TopText(),
              ],
            ),
          )

          //have the rest of the profile page here 


        ],
      ),
    );
  }
}



class TopText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //This is the top text
    return Padding(
      padding: EdgeInsets.fromLTRB(36.0, 0.0, 36.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Hello ",
                  style: TextStyle(
                    fontSize: 31.0,
                    color: Colors.black,
                  )),
              Text(name + '',
                  style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          Text("You're broke.",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              )),
        ],
      ),
    );
  }
}