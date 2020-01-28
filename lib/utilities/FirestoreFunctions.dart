import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'dart:convert';

import 'package:muhnee/pages/Home/ExpensePageSingleFile.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final databaseReference = Firestore.instance;
String uid;

// uploads the list of a users categories
void uploadCategories(type, itemsList) async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  for (var item in itemsList)
    await databaseReference
        .collection("users")
        .document(uid)
        .collection("categories")
        .document(type)
        .collection("types")
        .document()
        .setData({
      'name': item,
    });

  print("uploadCategories executed");
}

// returns true if the user has been onboarded
Future<bool> isOnboarded() async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  var onBoardedRef =
      await databaseReference.collection("users").document(uid).get();
  var onBoarded = onBoardedRef.data["onboarded"];

  return onBoarded;
}

// uploads the users weekly savings goal amount
void uploadGoals(goalAmount) async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  await databaseReference.collection("users").document(uid).updateData({
    'weeklySavingsGoal': goalAmount,
  });

  print("goalAmount uploaded");
}

// sets the parameter "onboarded" to true once onboarded on mobile
void setOnboardedParam() async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  await databaseReference.collection("users").document(uid).updateData({
    'onboarded': true,
  });

  print("onboarded set to true");
}

//get the list of categories for a user
Future<List> getCategories(categoryType) async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  var results = [];

  var onBoardedRef = await databaseReference
      .collection("users")
      .document(uid)
      .collection("categories")
      .document(categoryType)
      .collection("types")
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f) => results.add(f.data["name"]));
  });

  return results;
}

// uploads transactions from every user
void uploadTransaction(uAmount, uTransactionType, uSelectedCategories,
    uIsTaxable, description, recurringDays) async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  var timeStamp = DateTime.now();

  var budgetYear =
      DateTime.now().year.toString() + "-" + DateTime.now().month.toString();

  await databaseReference
      .collection("users")
      .document(uid)
      .collection("budget")
      .document(budgetYear)
      .collection("transactions")
      .document()
      .setData({
    "amount": double.parse(uAmount),
    "type": uTransactionType,
    "category": uSelectedCategories,
    "taxDeductible": uIsTaxable,
    "description": description,
    "timestamp": timeStamp,
    "recurringDays": recurringDays
  });

  print("transaction uploaded");
}

// get all transactions for this last month
// Future<List> getMonthlyTransactions() async {
//   final FirebaseUser currentUser = await _auth.currentUser();
//   uid = currentUser.uid;

//   var budgetMonth =
//       DateTime.now().year.toString() + "-" + DateTime.now().month.toString();

//   var tRef = await databaseReference
//       .collection("users")
//       .document(uid)
//       .collection("budget")
//       .document(budgetMonth)
//       .collection("transactions")
//       .orderBy("timestamp", descending: true)
//       .getDocuments();

//   var tempList = tRef.documents;

//   var transactionList = tempList.map((DocumentSnapshot docSnapshot) {
//     return docSnapshot.data;
//   }).toList();

//   return transactionList;
// }

// gets an ordered list of weekly transactions from latest to last
Future<List> getWeeklyTransactions() async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  var budgetMonth =
      DateTime.now().year.toString() + "-" + DateTime.now().month.toString();
  var severDaysAgo = DateTime.now().subtract(Duration(days: 7));

  var tRef = await databaseReference
      .collection("users")
      .document(uid)
      .collection("budget")
      .document(budgetMonth)
      .collection("transactions")
      .where("timestamp", isGreaterThan: severDaysAgo)
      .orderBy("timestamp", descending: true)
      .getDocuments();

  var tempList = tRef.documents;

  var transactionList = tempList.map((DocumentSnapshot docSnapshot) {
    return docSnapshot.data;
  }).toList();

  return transactionList;
}

// gets the url of the users profile pic
Future<String> getPhotoUrl() async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  var snap = await databaseReference.collection("users").document(uid).get();

  var photoUrl = snap.data["photoURL"];

  return photoUrl;
}

// gets the users weekly savings goal
Future<dynamic> getProfileDescriptions() async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  var snap = await databaseReference.collection("users").document(uid).get();

  //var weeklySavingsGoal = snap.data["weeklySavingsGoal"];

  return snap.data;
}

// gets the categories and amounts of income or expense on that cat for the week
Future<dynamic> getCurrentSummaryforTransactions(
    transactionCategoryType) async {
  final HttpsCallable getCurrentSummaryforTransactionsFn =
      CloudFunctions.instance.getHttpsCallable(
    functionName: 'getCurrentSummaryforTransactionMobile',
  );

  dynamic response = await getCurrentSummaryforTransactionsFn
      .call(<String, dynamic>{
    'summaryType': 'week',
    'transactionType': transactionCategoryType
  });

  return response.data;

  //return json.decode(jsonEncode(response.data));
}

