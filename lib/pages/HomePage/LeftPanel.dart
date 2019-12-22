import 'package:flutter/material.dart';
import '../../utilities/SizeConfig.dart';
import '../../utilities/SignIn.dart';

class LeftPanel extends StatefulWidget {
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
        // color: Colors.transparent,
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
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ProfilePic(),
            PanelButton(
              itemValue: "+",
              fontSize: 27,
              cellHeight: 15,
              rotation: 0,
            ),
            PanelButton(
              itemValue: "-",
              fontSize: 27,
              cellHeight: 15,
              rotation: 0,
            ),
            PanelButton(
              itemValue: "Transactions",
              fontSize: 16,
              cellHeight: 22,
              rotation: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: SizeConfig.blockSizeVertical * 2,
        ),
        ClipRRect(
          borderRadius: new BorderRadius.circular(14.0),
          child: Image.network(
            imageUrl,
            width: SizeConfig.blockSizeHorizontal * 13,
            height: SizeConfig.blockSizeHorizontal * 13,
          ),
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
  PanelButton(
      {@required this.itemValue,
      @required this.fontSize,
      @required this.cellHeight,
      @required this.rotation});

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
              print("pressed");
            },
          ),
        ),
      ),
    );
  }
}
