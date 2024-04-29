import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class GetDailyIncome {
  // get daily spendings
  Stream<Map<DateTime, double>> dailyAmountStream(String month) {
    final DateFormat formatter = DateFormat('MMMM yyyy');
    final DateTime startDate = formatter.parse(month);
    final DateTime endDate = DateTime(startDate.year, startDate.month + 1); // + 1 to get the first day of next month

    return FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('income')
        .where('date', isGreaterThanOrEqualTo: startDate, isLessThan: endDate)
        .snapshots()
        .map((snapshot) {
      Map<DateTime, double> dailyIncomeMap = {};  // date = {amount}
      for (DocumentSnapshot doc in snapshot.docs) {
        DateTime date = doc['date'].toDate();
        double amount = doc['amount'].toDouble();
        // print(date);
        // print(amount);
        dailyIncomeMap.putIfAbsent(DateTime(date.year, date.month, date.day), () => 0.0);
        // parses through days of the month and adds date;month to the dictionary, if same dates have multiple amount it adds them together using dart map feature
        dailyIncomeMap[DateTime(date.year, date.month, date.day)] = dailyIncomeMap[DateTime(date.year, date.month, date.day)]! + amount;
        print(dailyIncomeMap);

      }
      return dailyIncomeMap;
    });
  }
}