import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muhnee/utilities/SignIn.dart';
import './SignIn.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final databaseReference = Firestore.instance;
String uid;

void uploadExpenses(expenses) async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  await databaseReference
      .collection("users")
      .document(uid)
      .collection("categories")
      .document("expense")
      .setData({
    'expenseCategories': expenses,
  });

  print("uploadExpenses executed");
}

void uploadIncomes(incomes) async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  await databaseReference
      .collection("users")
      .document(uid)
      .collection("categories")
      .document("income")
      .setData({
    'incomeCategories': incomes,
  });

  print("uploadIncomes executed");
}

Future<bool> isOnboarded() async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  var onBoardedRef =
      await databaseReference.collection("users").document(uid).get();
  var onBoarded = onBoardedRef.data["onboarded"];

  return onBoarded;
}

userProfilePic() async {
  final FirebaseUser currentUser = await _auth.currentUser();
  String imageUrlFirebase = currentUser.photoUrl;

  return imageUrlFirebase;
}

void setOnboardedParam() async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  await databaseReference.collection("users").document(uid).setData({
    'onboarded': true,
  });

  print("onboarded set to true");
}
