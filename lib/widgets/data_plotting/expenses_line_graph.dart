import 'package:charts_flutter/flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../services/utils/database_manipulation/daily_expenses.dart';

class ExpensesLineGraph extends StatefulWidget {
  final String? month;
  final dynamic databaseGetterClass; // use to instantiate different classes from other databases like daily expenses and earnings


  const ExpensesLineGraph({super.key, required this.month, required this.databaseGetterClass});

  @override
  State<ExpensesLineGraph> createState() => _ExpensesLineGraphState();

}

class _ExpensesLineGraphState extends State<ExpensesLineGraph> {

  // // instantiate the class to use
  // GetDailyExpenses dailyExpenses = GetDailyExpenses();

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
    return Expanded(
      child: StreamBuilder<Map<DateTime, double>>(
        stream: widget.month != null ? widget.databaseGetterClass.dailyAmountStream(widget.month!): null,
        builder: (BuildContext context, AsyncSnapshot<Map<DateTime, double>> snapshot) {
          if (widget.month == null) {
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
    );
  }
}

// charts_flutter format to make chart
class DailySpending {
  final DateTime date;
  final double amount;

  DailySpending(this.date, this.amount);
}
