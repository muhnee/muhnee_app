import 'package:flutter/material.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import 'package:muhnee/utilities/SizeConfig.dart';

import 'ExpensePageSingleFile.dart';
import 'package:google_fonts/google_fonts.dart';

var tGetTransactions;

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  void initState() {
    super.initState();
    tGetTransactions = getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: FutureBuilder<List>(
        future:
            tGetTransactions, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          List<Widget> children;

          if (snapshot.hasData) {
            children = <Widget>[
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
                          amountText: item["amount"],
                          type: item["type"],
                          //category: item["category"],
                        )
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
                message: "Loading...",
                messageColor: Colors.orange,
              )
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
    );
  }
}

class TransactionViewCell extends StatefulWidget {
  var amountText;
  var type;
  var category;
  var taxable;
  var description;

  TransactionViewCell(
      {@required this.amountText,
      @required this.type,
      this.category,
      this.taxable,
      this.description});

  @override
  _TransactionViewCellState createState() => _TransactionViewCellState();
}

class _TransactionViewCellState extends State<TransactionViewCell> {
  Color cellColor1;
  Color cellColor2;

  var cat;
  var tax;
  var desc;

  @override
  Widget build(BuildContext context) {
    if (widget.type == "Income") {
      cellColor1 = Color(0xffa5d15b);
      cellColor2 = Colors.green;
    } else {
      cellColor1 = Color(0xfffb3d4e);
      cellColor2 = Colors.red;
    }

    return Padding(
        padding:
            EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 1),
        child: SizedBox(
          height: SizeConfig.blockSizeVertical * 8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [cellColor1, cellColor2],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // Text(
                    //   "\$ ",
                    //   style: GoogleFonts.francoisOne(
                    //     textStyle: TextStyle(
                    //         letterSpacing: .5,
                    //         fontSize: 20,
                    //         color: Colors.white),
                    //   ),
                    // ),
                    // Text(
                    //   widget.amountText,
                    //   style: GoogleFonts.francoisOne(
                    //     textStyle: TextStyle(
                    //         letterSpacing: .5,
                    //         fontSize: 30,
                    //         color: Colors.white),
                    //   ),
                    // ),

                    Text(
                      "\$ ",
                      style: TextStyle(color: Colors.grey[100], fontSize: 20),
                    ),
                    Text(
                      widget.amountText,
                      style: TextStyle(
                          letterSpacing: .5,
                          color: Colors.grey[100],
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                // Text(
                //   widget.category,
                //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                // ),
              ],
            ),
          ),
        ));
  }
}
