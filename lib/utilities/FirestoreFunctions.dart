import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
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

void uploadGoals(goalAmount) async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  await databaseReference.collection("users").document(uid).updateData({
    'weeklySavingsGoal': goalAmount,
  });

  print("goalAmount uploaded");
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
    uIsTaxable, description, recurringDays) async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  //var timeStamp = DateFormat('dd MMMM yyyy').format(DateTime.now()).toString() + " at " + DateFormat('hh:mm:ss').format(DateTime.now()).toString()

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

Future<List> getMonthlyTransactions() async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  var budgetMonth =
      DateTime.now().year.toString() + "-" + DateTime.now().month.toString();

  var tRef = await databaseReference
      .collection("users")
      .document(uid)
      .collection("budget")
      .document(budgetMonth)
      .collection("transactions")
      .orderBy("timestamp", descending: true)
      .getDocuments();

  var tempList = tRef.documents;

  var transactionList = tempList.map((DocumentSnapshot docSnapshot) {
    return docSnapshot.data;
  }).toList();

  return transactionList;
}

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

Future<String> getPhotoUrl() async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  var snap = await databaseReference.collection("users").document(uid).get();

  var photoUrl = snap.data["photoURL"];

  return photoUrl;
}

Future<int> getWeeklySavingsGoal() async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  var snap = await databaseReference.collection("users").document(uid).get();

  var weeklySavingsGoal = snap.data["weeklySavingsGoal"];

  return weeklySavingsGoal;
}



// Future<String> getProfileInfo() async {
//   final FirebaseUser currentUser = await _auth.currentUser();
//   uid = currentUser.uid;

//   var budgetMonth =
//       DateTime.now().year.toString() + "-" + DateTime.now().month.toString();
//   var severDaysAgo = DateTime.now().subtract(Duration(days: 7));

//   var tRef = await databaseReference
//       .collection("users")
//       .document(uid)
//       .collection("budget")
//       .document(budgetMonth)
//       .collection("transactions")
//       .where("timestamp", isGreaterThan: severDaysAgo)
//       .orderBy("timestamp", descending: true)
//       .getDocuments();

//   var tempList = tRef.documents;

//   var transactionList = tempList.map((DocumentSnapshot docSnapshot) {
//     return docSnapshot.data;
//   }).toList();

//   return "test";
// }


Future<List> getCurrentSummaryforTransactions(transactionCategoryType) async {
  final FirebaseUser currentUser = await _auth.currentUser();
  uid = currentUser.uid;

  final HttpsCallable getCurrentSummaryforTransactionsFn = CloudFunctions.instance.getHttpsCallable(
    functionName: 'YOUR_CALLABLE_FUNCTION_NAME',
);

dynamic response = await getCurrentSummaryforTransactionsFn.call(<String, dynamic>{
    'summaryType': 'week',
    'transactionType': transactionCategoryType
});

  var categoryInfo = response.map((DocumentSnapshot docSnapshot) {
    return docSnapshot.data;
  }).toList();

  return categoryInfo;
}