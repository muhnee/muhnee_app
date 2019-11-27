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
              children: <Widget>[
                ClipRRect(
                  borderRadius: new BorderRadius.circular(16.0),
                  child: Image.network(
                    imageUrl,
                    height: 100.0,
                    width: 100.0,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
