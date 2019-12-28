import 'package:flutter/material.dart';
import 'package:muhnee/routing/FadeRoute.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import 'package:muhnee/utilities/SignIn.dart';
import 'package:muhnee/utilities/SizeConfig.dart';
import '../../main.dart';
import 'package:google_fonts/google_fonts.dart';

Color componentColor = Colors.grey[600];
Color pageColor = Colors.white;
// Color componentColor = Color(0xff00e56d);
// Color pageColor = Color(0xfff2f7ea);
var amount = "";

class ExpensePage extends StatefulWidget {
  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xff424044),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TransactionAmountView(),
            // TransactionTypeSelector(),
            CustomKeyboard(),
          ],
        ),
      ),
    );
  }
}

class CustomKeyboard extends StatefulWidget {
  @override
  _CustomKeyboardState createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      width: SizeConfig.blockSizeHorizontal * 80,
      height: SizeConfig.blockSizeVertical * 35,
      child: Container(
        color: Color(0xff424044),
        child:  
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              KeyboardCell(cellValue: "1"),
              KeyboardCell(cellValue: "2"),
              KeyboardCell(cellValue: "3"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              KeyboardCell(cellValue: "4"),
              KeyboardCell(cellValue: "5"),
              KeyboardCell(cellValue: "6"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              KeyboardCell(cellValue: "7"),
              KeyboardCell(cellValue: "8"),
              KeyboardCell(cellValue: "9"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(Icons.first_page,  color: Colors.white),
              KeyboardCell(cellValue: "0"),
              Icon(Icons.check_circle_outline, size: 20, color: Colors.white),
            ],
          ),
        ],
      ),
      )
      
     
    );
  }
}

class KeyboardCell extends StatefulWidget {
  var cellValue;

  final Function() notifyParent;

  KeyboardCell({this.cellValue, this.notifyParent});

  @override
  _KeyboardCellState createState() => _KeyboardCellState();
}

class _KeyboardCellState extends State<KeyboardCell> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        child: Text(
          widget.cellValue,
          textAlign: TextAlign.center,
          style: GoogleFonts.kulimPark(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            textStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        onTap: () {
          setState(() {
            amount = amount + widget.cellValue;
          });
        },
      ),
    );
  }
}

// class TransactionTypeSelector extends StatefulWidget {
//   @override
//   _TransactionTypeSelectorState createState() =>
//       _TransactionTypeSelectorState();
// }

// class _TransactionTypeSelectorState extends State<TransactionTypeSelector> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.only(right: 44.0),
//           child: Icon(
//             Icons.blur_on,
//             color: componentColor,
//           ),
//         ),
//       ],
//     );
//   }
// }

class TransactionAmountView extends StatefulWidget {
  @override
  _TransactionAmountViewState createState() => _TransactionAmountViewState();
}

class _TransactionAmountViewState extends State<TransactionAmountView> {
  @override
  Widget build(BuildContext context) {
    return Text(amount);
  }
}
