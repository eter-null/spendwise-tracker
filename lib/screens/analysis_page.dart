import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:spendwise_tracker/screens/dashboard.dart';
import 'package:spendwise_tracker/screens/test/show_bar.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spendwise_tracker/widgets/data_plotting/grouped_bar_chart.dart';
import '../../const_config/color_config.dart';
import '../../widgets/custom_buttons/rounded_blue_button.dart';
import '../widgets/custom_page/custom_pageview.dart';


class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPage();
}

class _AnalysisPage extends State<AnalysisPage> {
  String? selectedMonth1;
  String? selectedMonth2;

  final firebase = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          CustomBackground(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.11, bottom: 100, left: 30, right: 30),
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: CustomPageView(controller: controller,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          //dropdown 1
                                          child: DropdownButtonFormField<String>(
                                            isExpanded: true, // remove overflow
                                            value: selectedMonth1,
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectedMonth1 = value;
                                              });
                                            },
                                            items: _buildMonthDropdownItems(),
                                            decoration: InputDecoration(
                                              hintText: 'Select Month', // Add your hint text here
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(color: MyColor.yinminBlue),
                                              ),
                                              //prefixIcon: Icon(Icons.calendar_month, size: 20),
                                            ),
                                          ),
                                        ),

                                        SizedBox(width: 5),

                                        //dropdown 2
                                        Expanded(
                                          child: DropdownButtonFormField<String>(
                                            isExpanded: true, // remove overflow
                                            value: selectedMonth2,
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectedMonth2 = value;
                                              });
                                            },
                                            items: _buildMonthDropdownItems(),
                                            decoration: InputDecoration(
                                              hintText: 'Select Month',
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(color: MyColor.yinminBlue),
                                              ),
                                              //prefixIcon: Icon(Icons.calendar_month, size: 20),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height - 400,
                                      child: GroupedBarChart(month1: selectedMonth1, month2: selectedMonth2,),
                                    ),
                                  ],

                                ),
                                Center(child: Text('Line Chart'))
                              ],
                            )
                        ),
                      ],
                    ),
                  )
              )
          ),
        ]
    );
  }

  // get and map dropdown months
  List<DropdownMenuItem<String>> _buildMonthDropdownItems() {
    final List<String> months = _getMonths();
    return months.map((String month) {
      return DropdownMenuItem<String>(
        value: month,
        child: Text(month,
          style: TextStyle(fontSize: 15),
        ),

      );
    }).toList();
  }
  // get past 12 months
  List<String> _getMonths() {
    List<String> months = [];
    DateTime now = DateTime.now();
    for (int i = 0; i < 12; i++) {
      months.add(DateFormat('MMMM yyyy').format(DateTime(now.year, now.month - i)));
    }
    return months;
  }
}