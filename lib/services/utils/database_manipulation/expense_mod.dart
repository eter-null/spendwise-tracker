import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> deleteExpense(String expenseId) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('expenses')
      .doc(expenseId)
      .delete();
}

Future<void> updateExpense(String expenseId, String categoryId, double amount, DateTime date) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('expenses')
      .doc(expenseId)
      .update({
    'categoryID': categoryId,
    'amount': amount,
    'date': date,
  });
}

Future<void> addExpense(String categoryId, double amount, DateTime date) async {

    DocumentReference expenseRef = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('expenses')
        .add({
      'categoryID': categoryId,
      'amount': amount,
      'date': Timestamp.fromDate(date),
    });

    // also put in category's expenseIDs array
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('categories')
        .doc(categoryId)
        .update({
      'expenseID': FieldValue.arrayUnion([expenseRef.id]),
    });



}
