import 'package:flutter/material.dart';
import '../../utilities/SizeConfig.dart';

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
      color: Colors.blue,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.red,
              width: SizeConfig.blockSizeHorizontal * 13,
              height: SizeConfig.blockSizeHorizontal * 13,
            )
          ],
        ),
      ),
    );
  }
}
