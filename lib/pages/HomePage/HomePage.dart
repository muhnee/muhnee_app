import 'package:flutter/material.dart';
import 'package:muhnee/utilities/SizeConfig.dart';
import 'IncomePage.dart';
import 'LeftPanel.dart';
import './ExpensePage.dart';
import 'ProfilePage.dart';
import 'TransactionsPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController pageViewController = PageController(initialPage: 3);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
      child: Row(
        children: <Widget>[
          LeftPanel(pageViewController: pageViewController),
          
          Expanded(
            child: PageView(
              controller: pageViewController,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                ProfilePage(),
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
