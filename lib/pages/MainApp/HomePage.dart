import 'package:flutter/material.dart';
import './CenterPage.dart';
import './LeftPage.dart';
import './RightPage.dart';

class HomePage extends StatelessWidget {
  var userName;
  HomePage({@required this.userName});

  @override
  Widget build(BuildContext context) {
    PageController _homePageController = PageController();

    return PageView(
      controller: _homePageController,
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        LeftPage(),
        CenterPage(
          userName: userName,
        ),
        RightPage(),
      ],
    );
  }
}
