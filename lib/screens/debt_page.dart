import 'package:flutter/material.dart';
import 'package:spendwise_tracker/screens/auth/login.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';
import '../widgets/custom_buttons/rounded_blue_button.dart';
import '../widgets/custom_containers/label_amount_box.dart';
import '../widgets/custom_data_visual_widgets/custom_progress_bar.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';

class DebtPage extends StatefulWidget {
  const DebtPage({super.key});

  @override
  State<DebtPage> createState() => _DebtPage();
}


class _DebtPage extends State<DebtPage> {
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          CustomBackground(
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Padding(padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        LabelAmountBox(
                          label: 'Lent',
                          amount: 1000,
                        ),
                        SizedBox(height: 15),
                        LabelAmountBox(
                          label: 'Borrow',
                          amount: 0,
                        ),
                        SizedBox(height: 150),

                        Text(
                          'You have no debts!',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: MyColor.lightBlue,
                              fontFamily: 'Roboto',
                              fontSize: 20
                          ),
                        ),


                        Text(
                          'April',
                          style: TextStyle(
                            // fontWeight: FontWeight.w800,
                            color: MyColor.lightBlue,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        SizedBox(height:20),
                        ProgressBar(startAmount: 0, endAmount: 0,),
                        // temp
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: RoundedBlueButton(
                                onClick: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Login()),
                                  );
                                },
                                label: 'ADD DEBT',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),)
              )
          ),
          Center(
              child: Column(
                children: [
                  SizedBox(height:80),
                  Text(
                    'BDT 0',
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
                    'Total Debt',
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