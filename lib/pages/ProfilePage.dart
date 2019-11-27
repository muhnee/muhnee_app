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
          ),

          //have the rest of the profile page here 

          Padding(
            padding: EdgeInsets.all(32.0),
            child: SettingsCell(),
          ), 

          Padding(
            padding: EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 32.0),
            child: SignoutCell(),
          )

          

        
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

class SettingsCell extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(16.0),
        color: Colors.grey[100],
        boxShadow: [BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
          ),]
      ),
    );
  }
}

class SignoutCell extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(16.0),
        color: Colors.red,
        boxShadow: [BoxShadow(
            color: Colors.red[100],
            blurRadius: 10.0,
          ),]
      ),
    );
  }
}