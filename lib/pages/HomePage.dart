import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  var userName; 
  HomePage({@required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(userName),
    );
  }
}