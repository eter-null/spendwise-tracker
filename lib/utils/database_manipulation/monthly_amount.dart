import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

Future<double?> calculateSummary(String selectedMonth, String type) async {
  final DateFormat formatter = DateFormat('MMMM yyyy');
  final DateTime startDate = formatter.parse(selectedMonth);
  final DateTime endDate = DateTime(startDate.year, startDate.month + 1); // + 1 to get the first day of next month

  double total = 0;

  if (type == 'expenses') {
    QuerySnapshot expenseSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('expenses')
        .where('date', isGreaterThanOrEqualTo: startDate, isLessThan: endDate)
        .get();

    expenseSnapshot.docs.forEach((expenseDoc) {
      total += (expenseDoc['amount'] ?? 0).toDouble();
    });

    print('Total Expenses for $selectedMonth: $total');
  } else if (type == 'income') {
    QuerySnapshot incomeSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('income')
        .where('date', isGreaterThanOrEqualTo: startDate, isLessThan: endDate)
        .get();

    incomeSnapshot.docs.forEach((incomeDoc) {
      total += (incomeDoc['amount'] ?? 0).toDouble();
    });

    print('Total Income for $selectedMonth: $total');
  }

  return total;
}
