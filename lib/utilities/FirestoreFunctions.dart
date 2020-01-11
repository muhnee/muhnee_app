import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:muhnee/pages/Home/ExpensePageSingleFile.dart';

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

  await databaseReference.collection("users").document(uid).updateData({
    'onboarded': true,
  });

  print("onboarded set to true");
}

Future<List> getExpenseCategories() async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  var onBoardedRef = await databaseReference
      .collection("users")
      .document(uid)
      .collection("categories")
      .document("expense")
      .get();
  var expenseCategories = onBoardedRef.data["expenseCategories"];

  return expenseCategories;
}

Future<List> getIncomeCategories() async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  var onBoardedRef = await databaseReference
      .collection("users")
      .document(uid)
      .collection("categories")
      .document("income")
      .get();
  var incomeCategories = onBoardedRef.data["incomeCategories"];

  return incomeCategories;
}

void uploadTransaction(uAmount, uTransactionType, uSelectedCategories,
    uIsTaxable, description) async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  var curDateTime = DateTime.now().toUtc().millisecondsSinceEpoch.toString();

  await databaseReference
      .collection("users")
      .document(uid)
      .collection("transactions")
      .document(curDateTime)
      .setData({
    "amount": uAmount,
    "type": uTransactionType,
    "category": uSelectedCategories,
    "taxDeductible": uIsTaxable,
    "description": description, 
    "timestamp" : curDateTime
  });

  print("transaction uploaded");
}

Future<List> getTransactions() async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  var tRef = await databaseReference
      .collection("users")
      .document(uid)
      .collection("transactions").orderBy("timestamp", descending: true).getDocuments();

  var tempList = tRef.documents;

  var transactionList = tempList.map((DocumentSnapshot docSnapshot) {
    return docSnapshot.data;
  }).toList();

  return transactionList;
}
