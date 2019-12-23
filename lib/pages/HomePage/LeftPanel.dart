import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utilities/SizeConfig.dart';
import '../../utilities/SignIn.dart';
import '../../utilities/FirestoreFunctions.dart';
import 'HomePage.dart';

class LeftPanel extends StatefulWidget {
  PageController pageViewController;
  LeftPanel({@required this.pageViewController});

  @override
  _LeftPanelState createState() => _LeftPanelState();
}

class _LeftPanelState extends State<LeftPanel> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.blockSizeHorizontal * 20,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400],
            offset: const Offset(90.0, 0.0),
            spreadRadius: 0.0,
            blurRadius: 20.0,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ProfilePic(
                pageIndex: 0, pageViewController: widget.pageViewController),
            Expanded(
              flex: 10,
              child: Container(),
            ),
            PanelButton(
                itemValue: "+",
                fontSize: 27,
                cellHeight: 15,
                rotation: 0,
                pageIndex: 1,
                pageViewController: widget.pageViewController),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            PanelButton(
                itemValue: "-",
                fontSize: 27,
                cellHeight: 15,
                rotation: 0,
                pageIndex: 2,
                pageViewController: widget.pageViewController),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            PanelButton(
                itemValue: "Transactions",
                fontSize: 16,
                cellHeight: 22,
                rotation: 3,
                pageIndex: 3,
                pageViewController: widget.pageViewController),
            // Expanded(
            //   flex: 1,
            //   child: Container(),
            // ),
          ],
        ),
      ),
    );
  }
}

class ProfilePic extends StatefulWidget {
  var pageIndex;
  PageController pageViewController;

  ProfilePic({@required this.pageIndex, @required this.pageViewController});

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: SizeConfig.blockSizeVertical * 2,
        ),
        Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(14.0),
              child: Image.network(
                "https://lh3.googleusercontent.com/a-/AAuE7mDHyKXfGnaH4IJIvp11DTSxrotvC8W2P96VfsT5s8c",
                width: SizeConfig.blockSizeHorizontal * 13,
                height: SizeConfig.blockSizeHorizontal * 13,
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                    borderRadius: BorderRadius.circular(14.0),
                    onTap: () {

                      widget.pageViewController.animateToPage(widget.pageIndex,
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeInOutExpo);
                      
                    }),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PanelButton extends StatefulWidget {
  String itemValue;
  double fontSize;
  var cellHeight;
  var rotation;
  var pageIndex;
  PageController pageViewController;

  PanelButton({
    @required this.itemValue,
    @required this.fontSize,
    @required this.cellHeight,
    @required this.rotation,
    @required this.pageIndex,
    this.pageViewController,
  });

  @override
  _PanelButtonState createState() => _PanelButtonState();
}

class _PanelButtonState extends State<PanelButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal * 13,
      height: SizeConfig.blockSizeVertical * widget.cellHeight,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.0),
        ),
        child: Material(
          color: Color(0xff8e91f3).withOpacity(0.9),
          borderRadius: BorderRadius.circular(13.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(13.0),
            child: Center(
              child: RotatedBox(
                quarterTurns: widget.rotation,
                child: Text(
                  widget.itemValue,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: widget.fontSize,
                  ),
                ),
              ),
            ),
            onTap: () {
              widget.pageViewController.animateToPage(widget.pageIndex,
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeInOutExpo);
            },
          ),
        ),
      ),
    );
  }
}
