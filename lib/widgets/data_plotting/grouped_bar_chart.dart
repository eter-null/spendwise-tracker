import 'package:charts_flutter/flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:spendwise_tracker/const_config/color_config.dart';
import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';
import '../../utils/database_manipulation/totals_by_month.dart';



class GroupedBarChart extends StatefulWidget {
  final String? month1;
  final String? month2;


  const GroupedBarChart({super.key, required this.month1, required this.month2});

  @override
  State<GroupedBarChart> createState() => _GroupedBarChartState();
}

class _GroupedBarChartState extends State<GroupedBarChart> {

  // instantiate the class to use
  GetTotalsByMonth totalsByMonth = GetTotalsByMonth();

  List<charts.Series<CategorySpendings, String>> _createSeries(List<String> categories, Map<String, Map<String, double>> data) {
    List<charts.Series<CategorySpendings, String>> seriesList = [];
    for (String month in [widget.month1!, widget.month2!]) {
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
          //graph show
          Expanded(
            child: StreamBuilder<Map<String, Map<String, double>>>(
              stream: totalsByMonth.categoryTotalsByMonthStream(widget.month1 ?? '', widget.month2 ?? ''),
              builder: (BuildContext context, AsyncSnapshot<Map<String, Map<String, double>>> snapshot) {
                if (widget.month1 == null || widget.month2 == null) {
                  return Center(child: Text('Please select two months'));
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                Map<String, Map<String, double>>? categoryTotalsByMonth = snapshot.data;

                // show loading when calculating the totals where it might be null for a while
                if (categoryTotalsByMonth == null || categoryTotalsByMonth.isEmpty) {
                  // return Center(child: Text('No data available'));
                  return Center(child: CircularProgressIndicator());
                }

                List<String> categories = categoryTotalsByMonth.keys.toList();
                List<charts.Series<CategorySpendings, String>> seriesList = _createSeries(categories, categoryTotalsByMonth);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: charts.BarChart(
                    seriesList,
                    animate: true,
                    barGroupingType: charts.BarGroupingType.grouped,
                    // rotate the axis to prevent text overlap
                    domainAxis: charts.OrdinalAxisSpec(
                      renderSpec: charts.SmallTickRendererSpec(
                        labelRotation: 90,
                      ),
                    ),
                    // fix big blank space in bottom when using domain axis
                    layoutConfig: charts.LayoutConfig(
                      leftMarginSpec: charts.MarginSpec.defaultSpec,
                      topMarginSpec: charts.MarginSpec.defaultSpec,
                      rightMarginSpec: charts.MarginSpec.defaultSpec,
                      bottomMarginSpec: charts.MarginSpec.fixedPixel(0), // remove label text blank space accommodation
                    ),
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

}

class CategorySpendings {
  final String category;
  final double total;

  CategorySpendings(this.category, this.total);
}