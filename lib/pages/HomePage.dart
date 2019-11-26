import 'package:flutter/material.dart';
import './CenterPage.dart';
import './LeftPage.dart';
import './RightPage.dart';
import 'IntroPage.dart';
import '../utilities/SignIn.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageController _homePageController = PageController(
      initialPage: 1,
      keepPage: false,
    );

    return PageView(
      controller: _homePageController,
      scrollDirection: Axis.horizontal,
      pageSnapping: true,
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        LeftPage(),
        CenterPage(
          userName: "Test",
        ),
        RightPage(),
      ],
    );
  }
}
