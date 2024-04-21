import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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

  final firebase = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          CustomBackground(
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: CustomPageView(controller: controller,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: Container(
                                    child: Testing()
                                  )
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
}