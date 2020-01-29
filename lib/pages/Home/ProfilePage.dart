import 'package:flutter/material.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import '../../utilities/FadeRoute.dart';
import '../../main.dart';
import '../../utilities/SignIn.dart';
import '../../utilities/SizeConfig.dart';

var getPhoto;
var getDescriptions;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    getPhoto = getPhotoUrl();
    getDescriptions = getProfileDescriptions();
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
                ProfileImgFuture(),
                ProfileDescriptions(),
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

class ProfileImgFuture extends StatelessWidget {
  const ProfileImgFuture({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getPhoto, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;

        if (snapshot.hasData) {
          children = <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                ),
                Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14.0),
                      child: Image.network(
                        snapshot.data,
                        width: SizeConfig.blockSizeHorizontal * 20,
                        height: SizeConfig.blockSizeHorizontal * 20,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ];
        } else {
          children = <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: new BorderRadius.circular(14.0),
                      child: Image(
                        image: AssetImage(
                            'lib/assets/images/defaultProfilePic.png'),
                        width: SizeConfig.blockSizeHorizontal * 20,
                        height: SizeConfig.blockSizeHorizontal * 20,
                      ),
                    )
                  ],
                ),
              ],
            ),
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
    );
  }
}

class ProfileDescriptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: getDescriptions, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        List<Widget> children;

        if (snapshot.hasData) {
          children = <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                ),
                TextElementMain(
                  text: "Name"),
                TextElement(
                  text: snapshot.data["displayName"],

                ),
                TextElement(
                  text: snapshot.data["email"],
                ),
                TextElement(
                  text: snapshot.data["monthlySavingsGoal"].toString(),
                ),
              ],
            ),
          ];
        } else {
          children = <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: new BorderRadius.circular(14.0),
                      child: Image(
                        image: AssetImage(
                            'lib/assets/images/defaultProfilePic.png'),
                        width: SizeConfig.blockSizeHorizontal * 20,
                        height: SizeConfig.blockSizeHorizontal * 20,
                      ),
                    )
                  ],
                ),
              ],
            ),
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
    );
  }
}

class TextElement extends StatelessWidget {
  var text;
  TextElement({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockSizeHorizontal * 5,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15.0,
          fontFamily: "SFPro",
          fontWeight: FontWeight.bold,
          // color: Color(0xff8e91f),
          //foreground: Paint()..shader = linearGradientPurple
        ),
      ),
    );
  }
}

class TextElementMain extends StatelessWidget {
  var text;
  TextElementMain({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockSizeHorizontal * 5,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 30.0,
          fontFamily: "SFPro",
          fontWeight: FontWeight.bold,
          color: Color(0xff496068),
          //foreground: Paint()..shader = linearGradientPurple
        ),
      ),
    );
  }
}
