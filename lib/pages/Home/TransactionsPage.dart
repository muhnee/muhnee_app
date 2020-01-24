import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import 'package:muhnee/utilities/SizeConfig.dart';
import 'ExpensePageSingleFile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:intl/intl.dart';

var weeklyTransactions;
var monthlyTransactions;
var curPageIndex;

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  void initState() {
    super.initState();
    monthlyTransactions = getMonthlyTransactions();
    weeklyTransactions = getWeeklyTransactions();
  }

  //! used for week to month switch

  int curPageIndex = 0;

  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6),
        child:
            Text('this week', style: TextStyle(fontWeight: FontWeight.w600))),
    1: Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Text('this month', style: TextStyle(fontWeight: FontWeight.w600)),
    ),
  };

  @override
  Widget build(BuildContext context) {

    


    //Shader is for gradient text
    final Shader linearGradientRed = LinearGradient(
      colors: <Color>[Color(0xff90cb46), Color(0xff9ed45b)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    final Shader linearGradientGreen = LinearGradient(
      colors: <Color>[Color(0xffe52d27), Color(0xffff0844)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          // Padding(
          //   padding: EdgeInsets.only(bottom: 10, top: 10),
          //   child: CupertinoSlidingSegmentedControl<int>(

          //     children: logoWidgets,
          //     onValueChanged: (int val) {
          //       setState(() {
          //         curPageIndex = val;
          //       });
          //     },
          //     groupValue: curPageIndex,
          //   ),
          // ),

          Expanded(
              child: FutureBuilder<List>(
            future: curPageIndex == 0
                ? weeklyTransactions
                : monthlyTransactions, // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              List<Widget> children;

              if (snapshot.hasData) {
                var totalExp = 0.0;
                var totalInc = 0.0;
                var totalNet = 0.0;

                for (var item in snapshot.data)
                  item["type"] == "expense"
                      ? totalExp += item["amount"]
                      : totalInc += item["amount"];

                totalNet = totalInc - totalExp;

                children = <Widget>[
                  // Stats section

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "This week you've",
                        style: new TextStyle(
                          fontSize: 25.0,
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        "Spent: " + totalExp.toString(),
                        style: new TextStyle(
                            fontSize: 25.0,
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = linearGradientRed),
                      ),
                      Text(
                        "Saved: " + totalInc.toString(),
                        style: new TextStyle(
                            fontSize: 25.0,
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = linearGradientGreen),
                      ),

                      totalNet < 0
                          ? Text(
                              "Net: " + totalNet.toString(),
                              style: new TextStyle(
                                  fontSize: 25.0,
                                  fontFamily: "SFPro",
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader = linearGradientGreen),
                            )
                          : Text(
                              "Net: " + totalNet.toString(),
                              style: new TextStyle(
                                  fontSize: 25.0,
                                  fontFamily: "SFPro",
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader = linearGradientRed),
                            )

                    ],
                  ),

                  // ListView
                  Container(
                      child: Expanded(
                    child: ListView(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 5,
                        ),
                        children: [
                          for (var item in snapshot.data)
                            TransactionViewCell(
                                amountText: item["amount"].toString(),
                                type: item["type"],
                                category: item["category"],
                                description: item["description"],
                                timestamp: item["timestamp"])
                        ]),
                  ))
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  NotificationCell(
                    message: "Network Error",
                    messageColor: Colors.red,
                  )
                ];
              } else {
                children = <Widget>[
                  NotificationCell(
                      message: "Loading...", messageColor: Colors.grey)
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                ),
              );
            },
          )),
        ],
      )),
    );
  }
}

// Widget summaryRow(type, amount) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Text(
//         type + ": ",
//         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//       ),
//       type == "Income"
//           ? Text(
//               "\$ " + amount,
//               style: GoogleFonts.varelaRound(
//                 textStyle: TextStyle(
//                   letterSpacing: .5,
//                   fontSize: 16,
//                   color: Colors.green,
//                 ),
//               ),
//             )
//           : type == "Expenses"
//               ? Text(
//                   "\$ " + amount,
//                   style: GoogleFonts.varelaRound(
//                     textStyle: TextStyle(
//                       letterSpacing: .5,
//                       fontSize: 16,
//                       color: Colors.red,
//                     ),
//                   ),
//                 )
//               : Text(
//                   "\$ " + amount,
//                   style: GoogleFonts.varelaRound(
//                     textStyle: TextStyle(
//                       letterSpacing: .5,
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                   ),
//                 )
//     ],
//   );
// }

class TransactionViewCell extends StatefulWidget {
  var amountText;
  var type;
  var category;
  var taxable;
  var description;
  var timestamp;

  TransactionViewCell(
      {@required this.amountText,
      @required this.type,
      @required this.category,
      this.taxable,
      @required this.description,
      @required this.timestamp});

  @override
  _TransactionViewCellState createState() => _TransactionViewCellState();
}

class _TransactionViewCellState extends State<TransactionViewCell> {
  //Color cellColor1;
  Color cellColor2;

  var cat;
  var tax;

  @override
  Widget build(BuildContext context) {
    if (widget.type == "income") {
      //cellColor1 = Color(0xff90cb46);
      cellColor2 = Color(0xff9ed45b);
    } else {
      //cellColor1 = Color(0xffe52d27);
      cellColor2 = Color(0xffff0844);
    }

    return Padding(
        padding:
            EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 0.7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 1, bottom: 3),
              child: Text(
                DateFormat.MMMMEEEEd()
                    .format(widget.timestamp.toDate())
                    .toString(),
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 6.5,
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.grey[200],
                        Colors.grey[300]
                      ], //? [cellColor1, cellColor2],
                    ),
                    //color: Colors.grey[200],
                    //border: Border.all(color: cellColor2)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeVertical * 1),
                        child: Row(
                          children: <Widget>[

                            Text(
                              "\$ ",
                              style: 
                                 TextStyle(
                                    letterSpacing: .5,
                                    fontSize: 20,
                                    color: cellColor2,
                                    fontFamily: "SFPro", 
                                    fontWeight: FontWeight.w600),

                              
                            ),
                            Text(
                              widget.amountText,
                              style: 
                                TextStyle(
                                    letterSpacing: .5,
                                    fontSize: 25,
                                    color: cellColor2, 
                                    fontFamily: "SFPro", 
                                    fontWeight: FontWeight.w600,)
                            
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: SizeConfig.blockSizeHorizontal * 3),
                        child: Text(
                          widget.category,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  print("Transaction View Cell Pressed");
                },
              ),
            )
          ],
        ));
  }
}
