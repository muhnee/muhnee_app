import 'package:flutter/material.dart';
import 'package:muhnee/utilities/SizeConfig.dart';

import 'LeftPanel.dart';

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

