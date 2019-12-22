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
          children: <Widget>[
            ProfilePic(),
          ],
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: new BorderRadius.circular(14.0),
      child: Image.network(
        imageUrl,
        width: SizeConfig.blockSizeHorizontal * 13,
        height: SizeConfig.blockSizeHorizontal * 13,
      ),
    );
  } 
}
