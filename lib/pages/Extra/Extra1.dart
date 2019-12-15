import 'package:flutter/material.dart';

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