import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spendwise_tracker/screens/auth/login.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';
import '../const_config/text_config.dart';
import '../widgets/custom_buttons/rounded_blue_button.dart';
import '../widgets/custom_containers/label_amount_box.dart';
import '../widgets/custom_data_visual_widgets/custom_progress_bar.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';

import '../widgets/input_widgets/textfield_with_sidebar.dart';
import '../widgets/input_widgets/simple_blue_border_textfield.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});


  @override
  State<AddExpensePage> createState() => _AddExpensePage();
}


class _AddExpensePage extends State<AddExpensePage> {
  final formKey = GlobalKey<FormState>();
  final priceController = TextEditingController();
  final dateController = TextEditingController();
  final categoryIconPath = 'assets/images/goals.jpg'; //String;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          CustomBackground(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                        child: Row(
                          children: [
                            Image.asset(
                              categoryIconPath, // change l8r
                              width: 70,
                              height: 70,
                            ),
                            Text('Tax Token',
                            style: TextDesign().cardHeaderMedium,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10,),
                      TextFieldWithSidebar(controller: priceController, hintText: '50000', needValidation: false, errorMessage: '', fieldTitle: 'Price', sidebarLabel: 'BDT',),
                      SizedBox(height: 5,),
                      TextFieldWithSidebar(controller: dateController, hintText: 'dd/mm/yy',
                        needValidation: false, errorMessage: '', fieldTitle: 'Date', sidebarLabel: '',
                        sideBarIcon: Icons.calendar_month,
                        inputType: TextInputType.datetime,
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.allow(
                        //     RegExp(r'^\d*\.?\d*$'), // only numbers and a decimal point with any number of decimal places
                        //   ),
                        // ],
                      ),
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
                              label: 'CONFIRM',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ),
        ]
    );

  }
}