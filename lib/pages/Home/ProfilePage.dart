import 'package:flutter/material.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import '../../utilities/FadeRoute.dart';
import '../../main.dart';
import '../../utilities/SignIn.dart';
import '../../utilities/SizeConfig.dart';

var getPhoto;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    getPhoto = getPhotoUrl();
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
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14.0),
                      child: Image.network(
                        snapshot.data,
                        width: SizeConfig.blockSizeHorizontal * 13,
                        height: SizeConfig.blockSizeHorizontal * 13,
                      ),
                    ),
                    // Positioned.fill(
                    //   child: Material(
                    //     color: Colors.transparent,
                    //     child: InkWell(
                    //         borderRadius: BorderRadius.circular(14.0),
                    //         onTap: () {
                    //           widget.pageViewController.animateToPage(
                    //               widget.pageIndex,
                    //               duration: Duration(milliseconds: 800),
                    //               curve: Curves.easeInOutExpo);
                    //         }),
                    //   ),
                    // ),
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
                      borderRadius: BorderRadius.circular(14.0),
                      child: Image(
                        image: AssetImage(
                            'lib/assets/images/defaultProfilePic.png'),
                        width: SizeConfig.blockSizeHorizontal * 13,
                        height: SizeConfig.blockSizeHorizontal * 13,
                      ),
                    ),
                    // Positioned.fill(
                    //   child: Material(
                    //     color: Colors.transparent,
                    //     child: InkWell(
                    //         borderRadius: BorderRadius.circular(14.0),
                    //         onTap: () {
                    //           widget.pageViewController.animateToPage(
                    //               widget.pageIndex,
                    //               duration: Duration(milliseconds: 800),
                    //               curve: Curves.easeInOutExpo);
                    //         }),
                    //   ),
                    // ),
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
