import 'package:flutter/material.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';

import '../../services/utils/database_manipulation/category_mod.dart';
import '../custom_buttons/rounded_blue_button.dart';
import '../input_widgets/simple_blue_border_textfield.dart';

class EditCategoryModal extends StatefulWidget {
  final String categoryID;
  final String categoryName;
  final String categoryIcon;

  const EditCategoryModal({
    Key? key,
    required this.categoryID,
    required this.categoryName,
    required this.categoryIcon,
  }) : super(key: key);

  @override
  State<EditCategoryModal> createState() => _EditCategoryModalState();
}

class _EditCategoryModalState extends State<EditCategoryModal> {
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
  void initState() {
    super.initState();
    categoryNameController.text = widget.categoryName;
    selectedIcon = icons.firstWhere(
          (icon) => icon['path'] == widget.categoryIcon,
      orElse: () => {'path': ''}, // get empty map if no matching icon is found
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Category'),
      surfaceTintColor: MyColor.powderBlue,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SimpleBlueBorderTextField(
            controller: categoryNameController, hintText: '', needValidation: false, errorMessage: '',
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
            updateCategory(widget.categoryID, name, iconPath);
            Navigator.of(context).pop();
          },
          label: 'Save',
          width: 30,
          backgroundColor: MyColor.yinminBlue,
        ),
      ],
    );
  }
}
