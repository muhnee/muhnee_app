import 'package:flutter/material.dart';
import '../utilities/ShowUp.dart';

class IntroPageExpense extends StatefulWidget {
  @override
  _IntroPageExpenseState createState() => _IntroPageExpenseState();
}

class _IntroPageExpenseState extends State<IntroPageExpense> {
  int delayAmount = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _showUpText(),
          _choiceCells(),
          ShowUp(
            child: Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Center(
                  child: _nextButton(),
                )),
            delay: delayAmount * 9,
          ),
        ],
      ),
    );
  }

  Widget _showUpText() {
    return Padding(
      padding: EdgeInsets.only(top: 54.0, left: 22.0, right: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ShowUp(
            child: Padding(
              padding: EdgeInsets.only(bottom: 33.0),
              child: Row(
                children: <Widget>[
                  Text("Firstly, ",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  Text("let's add some",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black,
                      )),
                ],
              ),
            ),
            delay: delayAmount,
          ),
          ShowUp(
            child: Padding(
              padding: EdgeInsets.only(bottom: 33.0),
              child: Text("categories to group",
                  style: TextStyle(
                    fontSize: 30.0,
                    // fontFamily: "Montserrat",
                    color: Colors.black,
                  )),
            ),
            delay: delayAmount * 3,
          ),
          ShowUp(
            child: Padding(
              padding: EdgeInsets.only(bottom: 33.0),
              child: Text("your expenses.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    // height: 2.0,
                    // fontFamily: "Montserrat",
                    color: Colors.black,
                  )),
            ),
            delay: delayAmount * 6,
          ),
        ],
      ),
    );
  }

  Widget _nextButton() {
    return SizedBox(
      width: 300,
      child: GestureDetector(
        onTap: () {
          // go to the next page
          //Navigator.pushReplacement(context, FadeRouteBuilder(page: IntroPageIncome()));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 40.0,
                ),
              ]),
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Next",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _choiceCells extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          Text("hello"), 
          Text("hello"), 
        ],
        );
  }
}
