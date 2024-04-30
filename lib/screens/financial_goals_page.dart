import 'package:flutter/material.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';
import '../widgets/custom_containers/label_amount_box.dart';
import '../widgets/custom_data_visual_widgets/custom_progress_bar.dart';

class FinancialGoals extends StatefulWidget {
  const FinancialGoals({super.key});

  @override
  State<FinancialGoals> createState() => _FinancialGoals();
}


class _FinancialGoals extends State<FinancialGoals> {
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Stack(
        children:[
          CustomBackground(
              isNavbar: true,

              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Padding(padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        LabelAmountBox(
                          label: 'Goal',
                          amount: 2000,
                        ),
                        SizedBox(height: 15),
                        LabelAmountBox(
                          label: 'Saved',
                          amount: 500,
                        ),
                        SizedBox(height: 150),
                        Text(
                          'Goal Reached',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF72B4EC),
                            fontFamily: 'Roboto',
                            fontSize: 20
                          ),
                        ),
                        Text(
                          'May 14 - Jun 13',
                          style: TextStyle(
                            // fontWeight: FontWeight.w800,
                            color: Color(0xFF72B4EC),
                            fontFamily: 'Roboto',
                          ),
                        ),
                        SizedBox(height:20),
                        ProgressBar(startAmount: 500, endAmount: 2000,)
                      ],
                    ),)
              )
          ),
          Center(
              child: Column(
                children: [
                  SizedBox(height:80),
                  Text(
                    'BDT 15,000',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontSize: 25,
                      letterSpacing: 0,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(height:5),
                  Text(
                    'Balance',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontSize: 15,
                      letterSpacing: 0,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              )
          ),
        ]
    );

  }
}