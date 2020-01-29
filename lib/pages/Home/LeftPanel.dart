import 'package:flutter/material.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import '../../utilities/SizeConfig.dart';

var getPhoto;

class LeftPanel extends StatefulWidget {
  PageController pageViewController;
  LeftPanel({@required this.pageViewController});

  @override
  _LeftPanelState createState() => _LeftPanelState();
}

class _LeftPanelState extends State<LeftPanel> {
  @override
  void initState() {
    super.initState();
    getPhoto = getPhotoUrl();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.blockSizeHorizontal * 20,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            offset: const Offset(90.0, 330.0), //(90.0, 0)
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
              flex: 13,
              child: Container(),
            ),
            PanelButton(
                itemValue: "Add",
                fontSize: 16,
                cellHeight: 15, //18
                rotation: 3,
                pageIndex: 1,
                pageViewController: widget.pageViewController),
            Expanded(
              flex: 1,
              child: Container(),
            ),

            // PanelButton(
            //     itemValue: "-",
            //     fontSize: 27,
            //     cellHeight: 15,
            //     rotation: 0,
            //     pageIndex: 2,
            //     pageViewController: widget.pageViewController),
            // Expanded(
            //   flex: 1,
            //   child: Container(),
            // ),
            PanelButton(
                itemValue: "Transactions",
                fontSize: 16,
                cellHeight: 25, //18
                rotation: 3,
                pageIndex: 2,
                pageViewController: widget.pageViewController),
            Expanded(
              flex: 1,
              child: Container(),
            ),

            //! Stats Page Disabled
            // PanelButton(
            //     itemValue: "Statistics",
            //     fontSize: 16,
            //     cellHeight: 18, //25
            //     rotation: 3,
            //     pageIndex: 3,
            //     pageViewController: widget.pageViewController),
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
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(14.0),
                            onTap: () {
                              widget.pageViewController.animateToPage(
                                  widget.pageIndex,
                                  duration: Duration(milliseconds: 800),
                                  curve: Curves.easeInOutExpo);
                            }),
                      ),
                    ),
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
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(14.0),
                            onTap: () {
                              widget.pageViewController.animateToPage(
                                  widget.pageIndex,
                                  duration: Duration(milliseconds: 800),
                                  curve: Curves.easeInOutExpo);
                            }),
                      ),
                    ),
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10.0,
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topRight,
            //   end: Alignment.bottomLeft,
            //   colors: [Color(0xff8e91f3), Color(0xff977aee)],
            // ),
            color: Color(0xff8e91f3).withOpacity(0.9),
            borderRadius: BorderRadius.circular(13.0),
          ),

          // color: Color(0xff8e91f3).withOpacity(0.9),

          // borderRadius: BorderRadius.circular(13.0),
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
                    fontWeight: FontWeight.w600,
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
