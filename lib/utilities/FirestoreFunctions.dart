import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:muhnee/utilities/SignIn.dart';
import './SignIn.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final databaseReference = Firestore.instance;
String uid;

void uploadExpenses(expenses) async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  await databaseReference.collection("users").document(uid).collection("categories").document("expense").setData({
    'expenseCategories': expenses,
  });

  print("uploadExpenses executed");
}

void uploadIncomes(incomes) async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  await databaseReference.collection("users").document(uid).collection("categories").document("income").setData({
    'incomeCategories': incomes,
  });


  print("uploadIncomes executed");
}
