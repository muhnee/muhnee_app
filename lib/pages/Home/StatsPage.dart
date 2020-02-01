import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'ExpensePageSingleFile.dart';

var incomeStats;
var expenseStats;
var curPageIndex;

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  void initState() {
    super.initState();
    // incomeStats = getIncomeStatsMonth();
    // expenseStats = getExpenseStatsMonth();
  }

  int curPageIndex = 0;

  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6),
        child: Text('Income', style: TextStyle(fontWeight: FontWeight.w600))),
    1: Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Text('Expenses', style: TextStyle(fontWeight: FontWeight.w600)),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: CupertinoSlidingSegmentedControl<int>(
              children: logoWidgets,
              onValueChanged: (int val) {
                setState(() {
                  curPageIndex = val;
                });
              },
              groupValue: curPageIndex,
            ),
          ),
          Expanded(
              child: FutureBuilder<List>(
            future: curPageIndex == 0 ? incomeStats : expenseStats,
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
                  Text("Income" + totalInc.toString()),
                  Text("Expenses" + totalExp.toString()),
                  Text("Net" + totalNet.toString()),
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
                      message: "Loading...", messageColor: Colors.grey[200])
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
