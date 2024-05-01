import 'dart:io';

import 'package:flutter/material.dart';

import '../../const_config/color_config.dart';
import '../../services/utils/database_manipulation/category_mod.dart';
import '../custom_buttons/rounded_blue_button.dart';
import '../input_widgets/simple_blue_border_textfield.dart';


class AddCategoryModal extends StatefulWidget {
  const AddCategoryModal({Key? key}) : super(key: key);

  @override
  State<AddCategoryModal> createState() => _AddCategoryModalState();
}

class _AddCategoryModalState extends State<AddCategoryModal> {
  Map<String, String>? selectedIcon;
  final categoryNameController = TextEditingController();

  final List<Map<String, String>> icons = [
    'browser.png',
    'fast-food.png',
    'gas-pump.png',
    'grocery.png',
    'healthcare.png',
    'invoice.png',
    'loan.png',
    'medicine.png',
    'pet.png',
    'plant.png',
    'rent.png',
    'tax.png',
    'transportation.png',
    'more.png',
  ].map((imageName) {
    return {'path': 'assets/images/$imageName'};
  }).toList();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: MyColor.powderBlue,
      title: Text('Add Category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SimpleBlueBorderTextField(
            controller: categoryNameController,
            hintText: '',
            needValidation: false,
            errorMessage: '',
            initialVal: 'asdas',
          ),
          SizedBox(height: 20),
          DropdownButtonFormField<Map<String, String>>(
            decoration: InputDecoration(
              filled: true,
              fillColor: MyColor.slightGray,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
            hint: Text('Select Icon'),
            value: selectedIcon,
            onChanged: (Map<String, String>? newValue) {
              setState(() {
                selectedIcon = newValue;
              });
            },
            items: icons.map<DropdownMenuItem<Map<String, String>>>((Map<String, String> icon) {
              return DropdownMenuItem<Map<String, String>>(
                value: icon,
                child: Center(child: Image.asset(icon['path']!, width: 40, height: 40),),
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        RoundedBlueButton(
          onClick: () {
            String name = categoryNameController.text.trim();
            String iconPath = selectedIcon!['path']!;
            addCategory(name, iconPath);
            Navigator.of(context).pop();
          },
          label: 'Add',
          width: 30,
          backgroundColor: MyColor.yinminBlue,
        ),
      ],
    );
  }
}
