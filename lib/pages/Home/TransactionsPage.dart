import 'package:flutter/material.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';

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
        child: Column(
          children: <Widget>[

            FutureBuilder<List>(
      future: tGetTransactions, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        List<Widget> children;

        if (snapshot.hasData) {
          children = <Widget>[

            //data pres
           
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[

            //error pres
           
          ];
        } else {
          children = <Widget>[

            //loading pres
           
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
    )





          ],
        )
      ),
    );
  }
}
