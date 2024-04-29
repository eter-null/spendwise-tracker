import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
// get totals by month from dropdown for firebase work
class GetTotalsByMonth {
    Stream<Map<String, Map<String, double>>> categoryTotalsByMonthStream(String month1, String month2) {
      // users > categories
      return FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('categories')
          .snapshots()
          .asyncMap((categoriesSnapshot) async {
        Map<String, Map<String, double>> categoryTotalsByMonth = {}; // <category name <date, amount>>

        for (QueryDocumentSnapshot categoryDoc in categoriesSnapshot.docs) {
          List<dynamic> expenseIDs = categoryDoc['expenseID']; // gets expenseID array vals

          for (dynamic expenseID in expenseIDs) {
            // goes to the gotten expenseID documents from the category array
            DocumentSnapshot expenseDoc = await FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .collection('expenses')
                .doc(expenseID)
                .get();

            // time conversion from expenseID date value and just using month and year
            Timestamp timestamp = expenseDoc['date'];
            DateTime date = timestamp.toDate();
            String monthYear = DateFormat('MMMM yyyy').format(date);

            // when iterating through the different expenseID docs if the dropdown selected month-year is found add the amount
            // of those expenseIDs to get the total of that month-year

            if (monthYear == month1 || monthYear == month2) { // if dropdown month-year is found
              double expenseAmount = expenseDoc['amount'].toDouble();

              categoryTotalsByMonth.putIfAbsent(categoryDoc['name'], () => {});

              categoryTotalsByMonth[categoryDoc['name']]!.update(
                monthYear,
                    (value) => value + expenseAmount,
                ifAbsent: () => expenseAmount,
              );
            }
          }
        }

        return categoryTotalsByMonth;
      });
    }
}
