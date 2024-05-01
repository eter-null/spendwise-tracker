import 'package:charts_flutter/flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:spendwise_tracker/const_config/color_config.dart';
import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';
import '../../services/utils/database_manipulation/totals_by_two_month.dart';

class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  String? _selectedMonth1;
  String? _selectedMonth2;

  Stream<Map<String, Map<String, double>>> categoryTotalsByMonthStream(String month1, String month2) {
    // users > categories
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('categories')
        .snapshots()
        .asyncMap((categoriesSnapshot) async {
      Map<String, Map<String, double>> categoryTotalsByMonth = {}; // dictionary for String

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
          print(expenseID);
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

  List<charts.Series<CategorySpendings, String>> _createSeries(List<String> categories, Map<String, Map<String, double>> data) {
    List<charts.Series<CategorySpendings, String>> seriesList = [];
    for (String month in [_selectedMonth1!, _selectedMonth2!]) {
      List<CategorySpendings> salesData = [];
      for (String category in categories) {
        double total = data[category]?.containsKey(month) ?? false ? data[category]![month]! : 0.0;
        salesData.add(CategorySpendings(category, total));
      }
      seriesList.add(
        charts.Series<CategorySpendings, String>(
          id: month,
          domainFn: (sales, _) => sales.category,
          measureFn: (sales, _) => sales.total,
          data: salesData,
          labelAccessorFn: (sales, _) => '${sales.total}',
        ),
      );
    }
    return seriesList;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // drop down
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                //dropdown 1
                child: DropdownButtonFormField<String>(
                  isExpanded: true, // remove overflow
                  value: _selectedMonth1,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedMonth1 = value;
                    });
                  },
                  items: _buildMonthDropdownItems(),
                ),
              ),

              //dropdown 2
              Expanded(
                child: DropdownButtonFormField<String>(
                  isExpanded: true, // remove overflow
                  value: _selectedMonth2,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedMonth2 = value;
                    });
                  },
                  items: _buildMonthDropdownItems(),
                ),
              ),
            ],
          ),

          //graph show
          Expanded(
            child: StreamBuilder<Map<String, Map<String, double>>>(
              stream: categoryTotalsByMonthStream(_selectedMonth1 ?? '', _selectedMonth2 ?? ''),
              builder: (BuildContext context, AsyncSnapshot<Map<String, Map<String, double>>> snapshot) {
                if (_selectedMonth1 == null || _selectedMonth2 == null) {
                  return Center(child: Text('Please select two months'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                Map<String, Map<String, double>>? categoryTotalsByMonth = snapshot.data;

                if (categoryTotalsByMonth == null || categoryTotalsByMonth.isEmpty) {
                  return Center(child: Text('No data available'));
                }

                List<String> categories = categoryTotalsByMonth.keys.toList();
                List<charts.Series<CategorySpendings, String>> seriesList = _createSeries(categories, categoryTotalsByMonth);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: charts.BarChart(
                    seriesList,
                    animate: true,
                    domainAxis: charts.OrdinalAxisSpec(
                      renderSpec: charts.SmallTickRendererSpec(
                        labelRotation: 45, // Rotate the labels for better visibility
                      ),
                    ),
                    barGroupingType: charts.BarGroupingType.grouped,
                    behaviors: [
                      charts.SeriesLegend(
                        position: charts.BehaviorPosition.top,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
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
}

// graph
class CategorySpendings {
  final String category;
  final double total;

  CategorySpendings(this.category, this.total);
}
