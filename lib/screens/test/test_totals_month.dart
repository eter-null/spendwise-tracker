import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MonthlySummary extends StatefulWidget {
  const MonthlySummary({Key? key}) : super(key: key);

  @override
  _MonthlySummaryState createState() => _MonthlySummaryState();
}

class _MonthlySummaryState extends State<MonthlySummary> {
  String? selectedMonth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              isExpanded: true,
              value: selectedMonth,
              onChanged: (String? value) {
                setState(() {
                  selectedMonth = value;
                });
              },
              items: _buildMonthDropdownItems(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Select Month',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (selectedMonth != null) {
                  _calculateSummary(selectedMonth!);
                }
              },
              child: Text('Calculate Summary'),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildMonthDropdownItems() {
    final List<String> months = _getMonths();
    return months.map((String month) {
      return DropdownMenuItem<String>(
        value: month,
        child: Text(month),
      );
    }).toList();
  }

  List<String> _getMonths() {
    List<String> months = [];
    DateTime now = DateTime.now();
    for (int i = 0; i < 12; i++) {
      months.add(DateFormat('MMMM yyyy').format(DateTime(now.year, now.month - i)));
    }
    return months;
  }

  void _calculateSummary(String selectedMonth) {
    final DateFormat formatter = DateFormat('MMMM yyyy');
    final DateTime startDate = formatter.parse(selectedMonth);
    final DateTime endDate = DateTime(startDate.year, startDate.month + 1); // + 1 to get the first day of next month
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('expenses')
        .where('date', isGreaterThanOrEqualTo: startDate, isLessThan: endDate)
        .get()
        .then((expenseSnapshot) {
      double totalExpenses = 0;
      expenseSnapshot.docs.forEach((expenseDoc) {
        totalExpenses += expenseDoc['amount'] ?? 0;
      });
      print('Total Expenses for $selectedMonth: $totalExpenses');
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('income')
        .where('date', isGreaterThanOrEqualTo: startDate, isLessThan: endDate)
        .get()
        .then((incomeSnapshot) {
      double totalIncome = 0;

      incomeSnapshot.docs.forEach((incomeDoc) {
        totalIncome += incomeDoc['amount'] ?? 0;
      });
      print('Total Income for $selectedMonth: $totalIncome');
    });
  }


}
