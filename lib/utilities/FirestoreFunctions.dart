import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:muhnee_app/utilities/SignIn.dart';
import './SignIn.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final databaseReference = Firestore.instance;
String uid;

// Future getUID() async {
//   final FirebaseUser currentUser = await _auth.currentUser();
//   uid = currentUser.uid;
// }


void addToExpense() async {

  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  await databaseReference.collection("MobileUsers")
      .document(uid)
      .setData({
        'val1': 'test',
        'val2': 'testInfo'
      });

  print("addToExpense executed");

  // DocumentReference ref = await databaseReference.collection("books")
  //     .add({
  //       'title': 'Flutter in Action',
  //       'description': 'Complete Programming Guide to learn Flutter'
  //     });
  // print(ref.documentID);
}
