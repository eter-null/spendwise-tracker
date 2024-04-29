import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:spendwise_tracker/screens/dashboard.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spendwise_tracker/widgets/data_plotting/grouped_bar_chart.dart';
import '../../const_config/color_config.dart';
import '../../widgets/custom_buttons/rounded_blue_button.dart';
import '../utils/database_manipulation/daily_earnings.dart';
import '../utils/database_manipulation/daily_expenses.dart';
import '../widgets/custom_page/custom_pageview.dart';
import '../widgets/data_plotting/expenses_line_graph.dart';



class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPage();
}

class _AnalysisPage extends State<AnalysisPage> {
  String? selectedBarMonth1;
  String? selectedBarMonth2;
  String? selectedlineMonth;


  final firebase = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          CustomBackground(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.09, bottom: 70, left: 30, right: 30),
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
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
                                            value: selectedBarMonth1,
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectedBarMonth1 = value;
                                              });
                                            },
                                            items: _buildMonthDropdownItems(),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: MyColor.slightGray,
                                              hintText: 'Select Month',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.circular(15), // Apply borderRadius here
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: MyColor.yinminBlue),
                                                borderRadius: BorderRadius.circular(15), // Apply borderRadius here
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
                                            value: selectedBarMonth2,
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectedBarMonth2 = value;
                                              });
                                            },
                                            items: _buildMonthDropdownItems(),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: MyColor.slightGray,
                                              hintText: 'Select Month',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.circular(15), // Apply borderRadius here
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: MyColor.yinminBlue),
                                                borderRadius: BorderRadius.circular(15), // Apply borderRadius here
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
                                      child: GroupedBarChart(month1: selectedBarMonth1, month2: selectedBarMonth2,),
                                    ),
                                  ],

                                ),
                                Column(
                                  children: [
                                    // dropdown
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        isExpanded: true,
                                        value: selectedlineMonth,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedlineMonth = value;
                                          });
                                        },
                                        items: _buildMonthDropdownItems(),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: MyColor.slightGray,
                                          hintText: 'Select Month',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(15), // Apply borderRadius here
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(15), // Apply borderRadius here
                                          ),
                                          //prefixIcon: Icon(Icons.calendar_month, size: 20),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 20,),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text('Daily Spendings',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'roboto',
                                            color: MyColor.skyBlue
                                          ),
                                        ),
                                        SizedBox(
                                            height: 260,
                                            child: ExpensesLineGraph(month: selectedlineMonth, databaseGetterClass: GetDailyExpenses())
                                        ),
                                        Text('Daily Income',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'roboto',
                                            color: MyColor.skyBlue
                                          ),
                                        ),
                                        SizedBox(
                                            height: 260,
                                            child: ExpensesLineGraph(month: selectedlineMonth, databaseGetterClass: GetDailyIncome())
                                        ),
                                      ],
                                    ),



                                  ],
                                )

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

  // last 12 months to dropdown
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