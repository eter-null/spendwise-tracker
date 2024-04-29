import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class GetDailyExpenses {
  // get daily spendings
  Stream<Map<DateTime, double>> dailyAmountStream(String month) {
    final DateFormat formatter = DateFormat('MMMM yyyy');
    final DateTime startDate = formatter.parse(month);
    final DateTime endDate = DateTime(startDate.year, startDate.month + 1); // + 1 to get the first day of next month

    return FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('expenses')
        .where('date', isGreaterThanOrEqualTo: startDate, isLessThan: endDate)
        .snapshots()
        .map((snapshot) {
      Map<DateTime, double> dailySpendingsMap = {};  // date = {amount}
      for (DocumentSnapshot doc in snapshot.docs) {
        DateTime date = doc['date'].toDate();
        double amount = doc['amount'].toDouble();
        // print(date);
        // print(amount);
        dailySpendingsMap.putIfAbsent(DateTime(date.year, date.month, date.day), () => 0.0);
        // parses through days of the month and adds date;month to the dictionary, if same dates have multiple amount it adds them together using dart map feature
        dailySpendingsMap[DateTime(date.year, date.month, date.day)] = dailySpendingsMap[DateTime(date.year, date.month, date.day)]! + amount;
        print(dailySpendingsMap);

      }
      return dailySpendingsMap;
    });
  }
}