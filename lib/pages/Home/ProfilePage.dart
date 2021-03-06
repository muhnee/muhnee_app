import 'package:flutter/material.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import '../../utilities/FadeRoute.dart';
import '../../main.dart';
import '../../utilities/SignIn.dart';
import '../../utilities/SizeConfig.dart';
import 'ExpensePageSingleFile.dart';

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
        // child: Container(
        //   child: ListView(
        //       shrinkWrap: true,
        //       scrollDirection: Axis.vertical,
        //       children: [
        //         //ProfileImgFuture(),
        //         ProfileDescriptions(),
        //         SizedBox(
        //           height: SizeConfig.blockSizeVertical * 3,
        //         ),
        //         SignOutBtn(),
        //       ]),
        // ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(children: <Widget>[
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1.5,
              ),
              ProfileDescriptions(),
            ]),
            Column(children: <Widget>[
              SignOutBtn(),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
            ]),
          ],
        ),
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
            NotificationCell(
                message: "Loading...", messageColor: Colors.grey[600])
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
    var name;
    var email;
    var savingsGoal;

    return FutureBuilder<dynamic>(
      future: getDescriptions, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        List<Widget> children;

        if (snapshot.hasData) {
          snapshot.data["displayName"] != null
              ? name = snapshot.data["displayName"]
              : name = "Apple User";
          snapshot.data["email"] != null
              ? email = snapshot.data["email"]
              : email = "Email";
          savingsGoal = "\$" + snapshot.data["monthlySavingsGoal"].toString();

          children = <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                ),
                TextElement(
                  text: name,
                  size: 40,
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                TextElementGrey(
                  text: "Email:",
                  size: 18,
                ),
                TextElement(
                  text: email,
                  size: 18,
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                TextElementGrey(
                  text: "Your monthly savings goal:",
                  size: 18,
                ),
                TextElement(
                  text: savingsGoal,
                  size: 18,
                ),
              ],
            ),
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            NotificationCell(
              message: "Network Error",
              messageColor: Colors.red,
            )
          ];
        } else {
          children = <Widget>[
            NotificationCell(
                message: "Loading...", messageColor: Colors.grey[600])
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
  double size;
  TextElement({@required this.text, @required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockSizeHorizontal * 5,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          fontFamily: "SFPro",
          fontWeight: FontWeight.bold,
          color: Color(0xff1d1c1f),
          // foreground: Paint()..shader = linearGradientPurple
        ),
      ),
    );
  }
}

class TextElementGrey extends StatelessWidget {
  var text;
  double size;
  TextElementGrey({@required this.text, @required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockSizeHorizontal * 5,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          fontFamily: "SFPro",
          fontWeight: FontWeight.bold,
          color: Colors.grey[400],
          //foreground: Paint()..shader = linearGradientPurple
        ),
      ),
    );
  }
}

class SignOutBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 142.0),
        child: Center(
          child: SizedBox(
            width: SizeConfig.blockSizeHorizontal * 65,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 40.0,
                      ),
                    ]),
                child: Material(
                  borderRadius: BorderRadius.circular(15.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15.0),
                    onTap: () {
                      signOutGoogle();
                      Navigator.pushReplacement(
                          context, FadeRouteBuilder(page: SplashScreen()));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Signout",
                              style: TextStyle(
                                  color: Color(0xff1d1c1f),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ));
  }
}
