import 'package:flutter/material.dart';
import 'package:muhnee/routing/FadeRoute.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import 'package:muhnee/utilities/SignIn.dart';
import 'package:muhnee/utilities/SizeConfig.dart';
import '../../main.dart';

Color componentColor = Colors.grey[600];
Color pageColor = Colors.white;
// Color componentColor = Color(0xff00e56d);
// Color pageColor = Color(0xfff2f7ea);

class ExpensePage extends StatefulWidget {
  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: pageColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
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
      height: SizeConfig.blockSizeVertical * 40,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 1.25,
        padding: const EdgeInsets.fromLTRB(6, 6, 6, 0),
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        children: <Widget>[
          
          keyboardCell("1"),
          keyboardCell("2"),
          keyboardCell("3"),
          keyboardCell("4"),
          keyboardCell("5"),
          keyboardCell("6"),
          keyboardCell("7"),
          keyboardCell("8"),
          keyboardCell("9"),
          IconButton(
            icon: Icon(Icons.backspace, size: 23, color: componentColor),
            onPressed: () {},
          ),
          keyboardCell("0"),
          IconButton(
            icon: Icon(
              Icons.check_circle_outline,
              color: componentColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget keyboardCell(cellValue) {
    return Center(
      child: Text(
        cellValue,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
        ),
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
