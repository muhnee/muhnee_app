import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  var userName;
  HomePage({@required this.userName});

  @override
  Widget build(BuildContext context) {
    //return SafeArea(

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false, // Don't show the leading button
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Adds a blur user profile button on the top right of the page
            // IconButton(
            //     icon: Icon(
            //       Icons.blur_on,
            //       color: Colors.black,
            //       size: 30.0,
            //     ),
            //     onPressed: () {}),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[

          //This is the top text
          Padding(
            padding: EdgeInsets.fromLTRB(36.0, 0.0, 36.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Hello ",
                        style: TextStyle(
                          fontSize: 31.0,
                          color: Colors.black,
                        )),
                    Text(userName + ',',
                        style: TextStyle(
                            fontSize: 32.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                Text("You're broke",
                    style: TextStyle(
                      fontSize: 26.0,
                      color: Colors.black,
                    )),
              ],
            ),
          ),

          


        ],
      ),
    );
    //);
  }
}
