import 'package:flutter/material.dart';
import 'package:muhnee/utilities/SizeConfig.dart';
import 'IncomePage.dart';
import 'LeftPanel.dart';
import './ExpensePage.dart';
import 'TransactionsPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
      child: Row(
        children: <Widget>[
          LeftPanel(pageViewController: pageViewController),
          //  LeftPanel(),
          
          Expanded(
            child: PageView(
              controller: pageViewController,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                ExpensePage(), 
                IncomePage(), 
                TransactionsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
