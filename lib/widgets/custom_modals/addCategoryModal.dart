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
    {'path': 'assets/images/browser.png'},
    {'path': 'assets/images/gas-pump.png'},
    {'path': 'assets/images/fast-food.png'},
    {'path': 'assets/images/tax.png'},
    {'path': 'assets/images/grocery.png'},
    {'path': 'assets/images/healthcare.png'},
    {'path': 'assets/images/transportation.png'},
    {'path': 'assets/images/more.png'},
  ];

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
              fillColor: Colors.grey[200],
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
          label: 'Save',
          width: 30,
          backgroundColor: MyColor.yinminBlue,
        ),
      ],
    );
  }
}
