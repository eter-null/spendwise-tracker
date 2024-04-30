import 'package:flutter/material.dart';
import 'package:spendwise_tracker/screens/auth/login.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';
import '../widgets/custom_buttons/rounded_blue_button.dart';
import '../widgets/custom_containers/label_amount_box.dart';
import '../widgets/custom_data_visual_widgets/custom_progress_bar.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';

import '../widgets/input_widgets/simple_blue_border_textfield.dart';

class NewExpensesPage extends StatefulWidget {
  const NewExpensesPage({super.key});


  @override
  State<NewExpensesPage> createState() => _NewExpensesPage();
}


class _NewExpensesPage extends State<NewExpensesPage> {
  final formKey = GlobalKey<FormState>();
  final itemNameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();

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
                      controller: itemNameController,
                      hintText: 'sad',
                      needValidation: false,
                      errorMessage: '2asd',
                      fieldTitle: 'Item',
                      borderThickness: 2,
                      borderColor: MyColor.powderBlue,
                    ),
                    SimpleBlueBorderTextField(
                      controller: priceController,
                      hintText: 'sad',
                      needValidation: false,
                      errorMessage: '2asd',
                      fieldTitle: 'Price',
                      borderThickness: 2,
                      borderColor: MyColor.powderBlue,
                    ),
                    SimpleBlueBorderTextField(
                      controller: quantityController,
                      hintText: 'sad',
                      needValidation: false,
                      errorMessage: '2asd',
                      fieldTitle: 'Quantity',
                      borderThickness: 2,
                      borderColor: MyColor.powderBlue,
                    ),
                  ],
                ),
              )
          ),
        ]
    );

  }
}