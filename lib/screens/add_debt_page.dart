import 'package:flutter/material.dart';
import 'package:spendwise_tracker/screens/auth/login.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';
import '../widgets/custom_buttons/rounded_blue_button.dart';
import '../widgets/custom_containers/label_amount_box.dart';
import '../widgets/custom_data_visual_widgets/custom_progress_bar.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';

import '../widgets/input_widgets/textfield_with_sidebar.dart';
import '../widgets/input_widgets/simple_blue_border_textfield.dart';

class AddDebtPage extends StatefulWidget {
  const AddDebtPage({super.key});


  @override
  State<AddDebtPage> createState() => _AddDebtPage();
}


class _AddDebtPage extends State<AddDebtPage> {
  final formKey = GlobalKey<FormState>();
  final debtNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          CustomBackground(
              isNavbar: true,
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Column(
                    children: [
                      SimpleBlueBorderTextField(
                        controller: debtNameController,
                        hintText: 'sad',
                        needValidation: false,
                        errorMessage: '2asd',
                        fieldTitle: 'asd',
                        borderThickness: 2,
                        borderColor: MyColor.powderBlue,
                      ),
                      SizedBox(height: 20,),

                      TextFormField(
                        controller: debtNameController,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0,
                          ),
                          hintStyle: TextStyle(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF83C2F8),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColor.lightBlue,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0,
                        ),
                        minLines: null,

                      ),
                      TextFieldWithSidebar(controller: TextEditingController(), hintText: '', needValidation: false, errorMessage: '', fieldTitle: 'Date', sidebarLabel: '', sideBarIcon: Icons.calendar_month,viewOnly: true,),



                    ],


                  ),
              )
          ),
        ]
    );

  }
}