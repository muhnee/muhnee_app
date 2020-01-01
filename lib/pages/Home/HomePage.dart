import 'package:flutter/material.dart';
import 'package:muhnee/utilities/SizeConfig.dart';
import 'ExpensePageSingleFile.dart';
import 'LeftPanel.dart';
import 'ProfilePage.dart';
import 'TransactionsPage.dart';

var imageUrlFirebase;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageViewController = PageController(initialPage: 2);

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
                ExpensePageSingleFile(),

                //IncomePage(),
                TransactionsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
