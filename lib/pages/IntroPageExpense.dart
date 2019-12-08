import 'package:flutter/material.dart';
import 'package:muhnee_app/routing/FadeRoute.dart';
import '../utilities/ShowUp.dart';
import '../utilities/SignIn.dart';

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

          // Expanded(
          //   child: SizedBox(
          //     width: 350,
          //     child: _expensesCells(),
          //   ),
          // ),

          _expCells(),

          ShowUp(
            child: Padding(
                padding: EdgeInsets.only(bottom: 142.0),
                child: Center(
                  child: _nextButton(),
                )),
            delay: delayAmount * 6,
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
              padding: EdgeInsets.only(bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
              padding: EdgeInsets.only(bottom: 15.0),
              child: Text("categories to group",
                  style: TextStyle(
                    fontSize: 30.0,
                    // fontFamily: "Montserrat",
                    color: Colors.black,
                  )),
            ),
            delay: delayAmount * 2,
          ),
          ShowUp(
            child: Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Text("your expenses.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    // height: 2.0,
                    // fontFamily: "Montserrat",
                    color: Colors.black,
                  )),
            ),
            delay: delayAmount * 4,
          ),
        ],
      ),
    );
  }

  Widget _nextButton() {
    return SizedBox(
      width: 150,
      child: GestureDetector(
        onTap: () {
          // Navigator.pushReplacement(
          //     context, FadeRouteBuilder(page: IntroPageIncome()));
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
            padding: EdgeInsets.only(top: 15.0, bottom: 0.0),
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

//! Keep this code - great to use for grid view builder in future
// class _expensesCells extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var functions = [
//       "Food",
//       "Clothing",
//       "Rent",
//       "Fuel",
//       "Tech",
//       "Drinks",
//       "Coffee",
//       "Activities",
//       "Alcohol",
//     ];

//     return GridView.count(
//       crossAxisCount: 3,
//       //padding: EdgeInsets.symmetric(horizontal: 50.0),

//       childAspectRatio: 1 / 1,
//       mainAxisSpacing: 0.0,
//       //crossAxisSpacing: 0.0,
//       children: <Widget>[
//         //for(String i in functions) Cards(title:i, page: SingleFunction(), curve: 15.0,),

//         for (String i in functions)
//           _eachCell(
//             expenseType: i,
//           )
//       ],
//     );
//   }
// }

// class _eachCell extends StatelessWidget {
//   var expenseType;
//   _eachCell({this.expenseType});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SizedBox(
//         width: 91,
//         height: 35,
//         child: Container(
//           child: Center(
//             child: Text(
//               expenseType,
//               style: TextStyle(fontSize: 15.0),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           decoration: BoxDecoration(
//             color: Color(0xffDEDEDE),
//             borderRadius: BorderRadius.circular(50.0),
//           ),
//         ),
//       ),
//     );
//   }
// }

//! keep this code ^^^

class _expCells extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 52.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Row 1
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SingleExpCell(
                  expenseType: "Food",
                ),
                SingleExpCell(
                  expenseType: "Clothing",
                ),
                SingleExpCell(
                  expenseType: "Rent",
                ),
              ],
            ),
          ),

          //Row 2
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SingleExpCell(
                  expenseType: "Fuel",
                ),
                SingleExpCell(
                  expenseType: "Tech",
                ),
                SingleExpCell(
                  expenseType: "Drinks",
                ),
              ],
            ),
          ),

          //Row 3
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SingleExpCell(
                  expenseType: "Coffee",
                ),
                SingleExpCell(
                  expenseType: "Activities",
                ),
                SingleExpCell(
                  expenseType: "Alcohol",
                ),
              ],
            ),
          ),

          //Row 4
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 250,
                  height: 40,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      style: new TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Custom...'),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffDEDEDE),
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                ),
              ],

              


            ),
          ),
        ],
      ),
    );
  }
}

class SingleExpCell extends StatelessWidget {
  var expenseType;

  SingleExpCell({this.expenseType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 91,
      height: 37,
      child: Center(
        child: Text(
          expenseType,
          style: TextStyle(
              fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
      ),
      decoration: BoxDecoration(
        color: Color(0xffDEDEDE),
        borderRadius: BorderRadius.circular(50.0),
      ),
    );
  }
}
