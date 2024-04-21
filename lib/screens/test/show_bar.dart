import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:spendwise_tracker/const_config/color_config.dart';

class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  String? _selectedMonth1;
  String? _selectedMonth2;

  Stream<Map<String, Map<String, double>>> _getCategoryTotalsByMonthStream(String month1, String month2) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc('kcOCOXbxLIOC1lxqYMSGN3gQDX83')
        .collection('categories')
        .snapshots()
        .asyncMap((categoriesSnapshot) async {
      Map<String, Map<String, double>> categoryTotalsByMonth = {};

      for (QueryDocumentSnapshot categoryDoc in categoriesSnapshot.docs) {
        List<dynamic> expenseIDs = categoryDoc['expenseID'];

        for (dynamic expenseID in expenseIDs) {
          DocumentSnapshot expenseDoc = await FirebaseFirestore.instance
              .collection('Users')
              .doc('kcOCOXbxLIOC1lxqYMSGN3gQDX83') // Replace with actual UID
              .collection('expenses')
              .doc(expenseID)
              .get();

          Timestamp timestamp = expenseDoc['date'];
          DateTime date = timestamp.toDate();
          String monthYear = DateFormat('yyyy-MM').format(date);

          if (monthYear == month1 || monthYear == month2) {
            double expenseAmount = expenseDoc['amount'].toDouble(); // Convert to double

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

  List<charts.Series<OrdinalSales, String>> _createSeries(List<String> categories, Map<String, Map<String, double>> data) {
    List<charts.Series<OrdinalSales, String>> seriesList = [];
    for (String month in [_selectedMonth1!, _selectedMonth2!]) {
      List<OrdinalSales> salesData = [];
      for (String category in categories) {
        double total = data[category]?.containsKey(month) ?? false ? data[category]![month]! : 0.0;
        salesData.add(OrdinalSales(category, total));
      }
      seriesList.add(
        charts.Series<OrdinalSales, String>(
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
      // appBar: AppBar(
      //   title: Text(''),
      // ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedMonth1,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedMonth1 = value;
                    });
                  },
                  items: _buildMonthDropdownItems(),
                  decoration: InputDecoration(labelText: _selectedMonth1, labelStyle: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                ),
              ),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedMonth2,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedMonth2 = value;
                    });
                  },
                  items: _buildMonthDropdownItems(),
                  decoration: InputDecoration(labelText: _selectedMonth2, labelStyle: TextStyle(color: MyColor.lightBlue, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<Map<String, Map<String, double>>>(
              stream: _getCategoryTotalsByMonthStream(_selectedMonth1 ?? '', _selectedMonth2 ?? ''),
              builder: (BuildContext context, AsyncSnapshot<Map<String, Map<String, double>>> snapshot) {
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
                List<charts.Series<OrdinalSales, String>> seriesList = _createSeries(categories, categoryTotalsByMonth);



                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: charts.BarChart(
                    seriesList,
                    animate: true,
                    barGroupingType: charts.BarGroupingType.grouped,
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
      months.add(DateFormat('yyyy-MM').format(DateTime(now.year, now.month - i)));
    }
    return months;
  }
}

class OrdinalSales {
  final String category;
  final double total;

  OrdinalSales(this.category, this.total);
}
