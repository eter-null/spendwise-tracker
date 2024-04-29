import 'package:charts_flutter/flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GraphTest extends StatefulWidget {
  const GraphTest({Key? key}) : super(key: key);

  @override
  State<GraphTest> createState() => _GraphTestState();
}

class _GraphTestState extends State<GraphTest> {
  String? _selectedMonth;

  // get daily spendings
  Stream<Map<DateTime, double>> dailySpendingsStream(String month) {
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


  List<charts.Series<DailySpending, DateTime>> _createSeries(Map<DateTime, double> dailySpendingsMap) {
    final List<DailySpending> spendingsData = dailySpendingsMap.entries.map((entry) {
      // creating DailySpending object with the dailySpendingsMap
      // new DailySpending(DateTime(2023, 4, 21), 5000),
      return DailySpending(entry.key, entry.value);
    }).toList();

    // charts_flutter sample code format for creating chart
    return [
      charts.Series<DailySpending, DateTime>(
        id: 'Daily Spendings',
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        domainFn: (DailySpending spending, _) => spending.date,
        measureFn: (DailySpending spending, _) => spending.amount,
        data: spendingsData,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DropdownButtonFormField<String>(
            isExpanded: true,
            value: _selectedMonth,
            onChanged: (String? value) {
              setState(() {
                _selectedMonth = value;
              });
            },
            items: _buildMonthDropdownItems(),
          ),
          Expanded(
            child: StreamBuilder<Map<DateTime, double>>(
              stream: _selectedMonth != null ? dailySpendingsStream(_selectedMonth!) : null,
              builder: (BuildContext context, AsyncSnapshot<Map<DateTime, double>> snapshot) {
                if (_selectedMonth == null) {
                  return Center(child: Text('Please select a month'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                Map<DateTime, double>? dailySpendingsMap = snapshot.data;

                if (dailySpendingsMap == null || dailySpendingsMap.isEmpty) {
                  return Center(child: Text('No data available'));
                }

                List<charts.Series<DailySpending, DateTime>> seriesList = _createSeries(dailySpendingsMap);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: charts.TimeSeriesChart(
                    seriesList,
                    animate: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // last 12 months to dropdown
  List<DropdownMenuItem<String>> _buildMonthDropdownItems() {
    final List<String> months = _getMonths();
    return months.map((String month) {
      return DropdownMenuItem<String>(
        value: month,
        child: Text(month),
      );
    }).toList();
  }

  // get last 12 months
  List<String> _getMonths() {
    List<String> months = [];
    DateTime now = DateTime.now();
    for (int i = 0; i < 12; i++) {
      months.add(DateFormat('MMMM yyyy').format(DateTime(now.year, now.month - i)));
    }
    return months;
  }
}
// charts_flutter format to make chart
class DailySpending {
  final DateTime date;
  final double amount;

  DailySpending(this.date, this.amount);
}