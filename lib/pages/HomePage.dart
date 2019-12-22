import 'package:flutter/material.dart';
import 'package:muhnee/utilities/SizeConfig.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
      child: Row(
        children: <Widget>[
          LeftPanel(),
          Expanded(
            child: Container(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class LeftPanel extends StatefulWidget {
  @override
  _LeftPanelState createState() => _LeftPanelState();
}

class _LeftPanelState extends State<LeftPanel> {
  @override
  Widget build(BuildContext context) {
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
