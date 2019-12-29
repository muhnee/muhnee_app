import 'package:flutter/material.dart';
import 'package:muhnee/pages/HomePage/LeftPanel.dart';
import 'package:muhnee/routing/FadeRoute.dart';
import 'package:muhnee/utilities/FirestoreFunctions.dart';
import 'package:muhnee/utilities/SignIn.dart';
import 'package:muhnee/utilities/SizeConfig.dart';
import '../../main.dart';
import 'package:google_fonts/google_fonts.dart';

Color componentColor = Colors.black;
Color pageColor = Colors.grey[100];

var amount = "";

class ExpensePageSingleFile extends StatefulWidget {
  @override
  _ExpensePageSingleFileState createState() => _ExpensePageSingleFileState();
}

class _ExpensePageSingleFileState extends State<ExpensePageSingleFile> {
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
            Text(amount,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: componentColor,
                )),
            SelectorButtons(),
            CustomKeyboard(),
          ],
        ),
      ),
    );
  }

  Widget CustomKeyboard() {
    return SizedBox(
        width: SizeConfig.blockSizeHorizontal * 80,
        height: SizeConfig.blockSizeVertical * 35,
        child: Container(
          color: pageColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  KeyboardCell("1"),
                  KeyboardCell("2"),
                  KeyboardCell("3"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  KeyboardCell("4"),
                  KeyboardCell("5"),
                  KeyboardCell("6"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  KeyboardCell("7"),
                  KeyboardCell("8"),
                  KeyboardCell("9"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    child: SizedBox(
                      child: Icon(Icons.brightness_1,
                          size: 8, color: componentColor),
                      width: SizeConfig.blockSizeHorizontal * 15,
                    ),
                    onTap: () {
                      print("point");
                      setState(() {
                        amount += ".";
                      });
                    },
                  ),
                  KeyboardCell("0"),
                  GestureDetector(
                    child: SizedBox(
                      child: Icon(Icons.first_page, color: componentColor),
                      width: SizeConfig.blockSizeHorizontal * 15,
                    ),
                    onTap: () {
                      print("delete char");
                      setState(() {
                        amount = amount.substring(0, (amount.length - 1));
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget KeyboardCell(cellValue) {
    // return GestureDetector(
    //     child: SizedBox(
    //       width: SizeConfig.blockSizeHorizontal * 15,
    //       child: Center(
    //         child: Text(
    //           cellValue,
    //           textAlign: TextAlign.center,
    //           style: GoogleFonts.kulimPark(
    //             fontSize: 20,
    //             fontWeight: FontWeight.w600,
    //             textStyle: TextStyle(
    //               color: componentColor,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //     onTap: () {
    //       setState(() {
    //         amount += cellValue;
    //       });
    //     });

    return RaisedButton(

      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
        // side: BorderSide(color: pageColor)
),
      
      color: pageColor,
      elevation: 0,
      child: Text(
              cellValue,
              textAlign: TextAlign.center,
              style: GoogleFonts.kulimPark(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                textStyle: TextStyle(
                  color: componentColor,
                ),
              ),
            ),
      onPressed: (){

         setState(() {
            amount += cellValue;
          });

      },
    );


  }

  Widget SelectorButtons() {

    var btn1TextColor = Color(0xfff990bf);
    var btn1BaseColor = Color(0xfffddaea);

    var btn2TextColor = Color(0xffd4455b);
    var btn2BaseColor = Color(0xfff6d9dd);

    var btn3TextColor = Color(0xff4a5999);
    var btn3BaseColor = Color(0xffd9dcea);

    return SizedBox(
        width: SizeConfig.blockSizeHorizontal * 80,
        height: SizeConfig.blockSizeVertical * 5,
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  SelectorButtonSingle(btnValue: "Expense", width: 19, textColor: btn1TextColor, baseColor: btn1BaseColor,),
                  SelectorButtonSingle(btnValue: "Taxable", width: 25, textColor: btn2TextColor, baseColor: btn2BaseColor,),
                  SelectorButtonSingle(btnValue: "Upload", width: 19, textColor: btn3TextColor, baseColor: btn3BaseColor,),
                 
                 
                ],
              ),
            ],
          ),
        ));
  }
}


class SelectorButtonSingle extends StatefulWidget {

  var btnValue; 
  var width;
  var textColor; 
  var baseColor; 
  
  SelectorButtonSingle({@required this.btnValue, @required this.width, @required this.textColor, @required this.baseColor});
  

  @override
  _SelectorButtonSingleState createState() => _SelectorButtonSingleState();
}

class _SelectorButtonSingleState extends State<SelectorButtonSingle> {
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: SizeConfig.blockSizeHorizontal * widget.width,
      height: SizeConfig.blockSizeVertical * 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
          BoxShadow(
            color: widget.baseColor.withOpacity(0.25),
            blurRadius: 10.0,
          )
        ],
        ),
        child: Material(
          color: widget.baseColor,
          borderRadius: BorderRadius.circular(10.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            child: Center(
              child: Text(
                  widget.btnValue,
                  style: TextStyle(
                    color: widget.textColor,
                    letterSpacing: 1,
                    fontSize:12.5,
                    fontWeight: FontWeight.bold
                  ),
                ),
            ),
            onTap: () {
             
            },
          ),
        ),
      ),
    );


  }
}
