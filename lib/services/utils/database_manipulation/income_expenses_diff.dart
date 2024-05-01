import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../notification_service.dart';

Future<void> checkExpenseNotification() async {

  final userId = FirebaseAuth.instance.currentUser?.uid;
  final currentMonth = DateTime.now().month;
  final currentYear = DateTime.now().year;

  final incomeSnapshot = await FirebaseFirestore.instance
      .collection('Users')
      .doc(userId)
      .collection('income')
      .where('date', isGreaterThanOrEqualTo: DateTime(currentYear, currentMonth, 1))
      .where('date', isLessThan: DateTime(currentYear, currentMonth + 1, 1))
      .get();

  final expenseSnapshot = await FirebaseFirestore.instance
      .collection('Users')
      .doc(userId)
      .collection('expenses')
      .where('date', isGreaterThanOrEqualTo: DateTime(currentYear, currentMonth, 1))
      .where('date', isLessThan: DateTime(currentYear, currentMonth + 1, 1))
      .get();

  double totalIncome = 0;
  double totalExpenses = 0;

  incomeSnapshot.docs.forEach((doc) {
    totalIncome += doc['amount'] ?? 0;
  });

  expenseSnapshot.docs.forEach((doc) {
    totalExpenses += doc['amount'] ?? 0;
  });

  final percentageSpent = (totalExpenses / totalIncome) * 100;

  if (percentageSpent >= 60 && percentageSpent < 70) {
    NotificationService().showNotification(
      title: 'Warning',
      body: 'Your spending is 70% close to your income',
    );
  }
  else if (percentageSpent >= 70 && percentageSpent < 80) {
    NotificationService().showNotification(
      title: 'Warning',
      body: 'Your spending is 70% close to your income',
    );
  } else if (percentageSpent >= 80 && percentageSpent < 90) {
    NotificationService().showNotification(
      title: 'Warning',
      body: 'Your spending is 80% close to your income',
    );
  } else if (percentageSpent >= 90 && percentageSpent <= 100) {
    NotificationService().showNotification(
      title: 'Warning',
      body: 'Your spending is 90% close to your income',
    );
  }
}
