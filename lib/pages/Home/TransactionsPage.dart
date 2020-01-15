import 'package:flutter/material.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import 'package:muhnee/utilities/SizeConfig.dart';
import 'ExpensePageSingleFile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';


var tGetTransactions;
var curPageIndex; 

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  void initState() {
    super.initState();
    tGetTransactions = getMonthlyTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: <Widget>[


          // Container(
          //   child: Text("TESTTESTTESTTESTTEST"), 
          //   color: Colors.blue,
          // ),

          BubbleBottomBar(
        opacity: 0.2,
        currentIndex: curPageIndex,
        onTap: changePage(),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 0,
        fabLocation: BubbleBottomBarFabLocation.center, //new
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
           
            BubbleBottomBarItem(backgroundColor: Colors.deepPurple, icon: Icon(Icons.access_time, color: Colors.black,), activeIcon: Icon(Icons.access_time, color: Colors.deepPurple,), title: Text("This week")),
            BubbleBottomBarItem(backgroundColor: Colors.indigo, icon: Icon(Icons.blur_on, color: Colors.black,), activeIcon: Icon(Icons.blur_on, color: Colors.indigo,), title: Text("Folders")),
        ],
      ),




          Expanded(
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
                              amountText: item["amount"].toString(),
                              type: item["type"],
                              //category: item["category"],
                              description: item["description"],
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
              }
              //else if (snapshot.data.length < 1) {
              //   children = <Widget>[
              //     NotificationCell(
              //       message: "Hmmm...Looks like you haven't recorded any transactions yet",
              //       messageColor: Colors.blue,
              //     )
              //   ];
              // }
              else {
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
        ],
      )),
    );
  }

  changePage(){
  setState(() {
    curPageIndex = 1;
  });
  
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
      @required this.description});

  @override
  _TransactionViewCellState createState() => _TransactionViewCellState();
}

class _TransactionViewCellState extends State<TransactionViewCell> {
  Color cellColor1;
  Color cellColor2;

  var cat; //! ISSUE IS THAT CAT IS AN ARRAY AND NOT A SINGLE ITEM
  var tax;

  @override
  Widget build(BuildContext context) {
    if (widget.type == "income") {
      cellColor1 = Color(0xff90cb46);
      cellColor2 = Color(0xff9ed45b);
    } else {
      cellColor1 = Color(0xffd01908);
      cellColor2 = Color(0xffe43524);
    }

    return Padding(
        padding:
            EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 1),
        child: SizedBox(
          height: SizeConfig.blockSizeVertical * 7,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(left: SizeConfig.blockSizeVertical * 1),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "\$ ",
                        style: GoogleFonts.varelaRound(
                          textStyle: TextStyle(
                              letterSpacing: .5,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                      Text(
                        widget.amountText,
                        style: GoogleFonts.varelaRound(
                          textStyle: TextStyle(
                              letterSpacing: .5,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                      ),

                      // Text(
                      //   "\$ ",
                      //   style: TextStyle(color: Colors.grey[100], fontSize: 20),
                      // ),
                      // Text(
                      //   widget.amountText,
                      //   style: TextStyle(
                      //       letterSpacing: .5,
                      //       color: Colors.grey[100],
                      //       fontSize: 30,
                      //       fontWeight: FontWeight.bold),
                      // ),
                    ],
                  ),
                ),
                Text(
                  widget.description,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ));
  }
}
