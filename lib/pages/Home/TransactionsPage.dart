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
  Color cellColor;
  var category;

  @override
  Widget build(BuildContext context) {
    widget.type == "Income"
        ? cellColor = Color(0xffa5d15b)
        : cellColor = Color(0xfffb3d4e);

    return Padding(
        padding:
            EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 1),
        child: SizedBox(
          height: SizeConfig.blockSizeVertical * 8,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: cellColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "\$ ",
                      style: GoogleFonts.francoisOne(
                        textStyle: TextStyle(
                            letterSpacing: .5,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                    Text(
                      widget.amountText,
                      style: GoogleFonts.francoisOne(
                        textStyle: TextStyle(
                            letterSpacing: .5,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.category,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ));
  }
}
