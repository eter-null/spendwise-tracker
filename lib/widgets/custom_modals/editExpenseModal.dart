import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../const_config/color_config.dart';
import '../../services/utils/database_manipulation/expense_mod.dart';
import '../custom_buttons/rounded_blue_button.dart';
import '../input_widgets/textfield_with_sidebar.dart';

class EditExpenseModal extends StatefulWidget {
  final String expenseID;
  final double amount;
  final String categoryID;
  final String categoryName;
  final String categoryIcon;


  const EditExpenseModal({super.key, required this.expenseID, required this.amount, required this.categoryID, required this.categoryName, required this.categoryIcon});

  @override
  State<EditExpenseModal> createState() => _EditExpenseModalState();
}

class _EditExpenseModalState extends State<EditExpenseModal> {
  final TextEditingController amountController = TextEditingController();
  DateTime? selectedDate;
  String? selectedCategoryID;
  String? selectedIcon;


  List<DropdownMenuItem<String>> buildDropdownItems(
      List<Map<String, dynamic>> categories) {
    return categories.map((category) {
      return DropdownMenuItem<String>(
        value: category['id'],
        child: Row(
          children: [
            Image.asset(category['icon'], width: 40, height: 40),
            Text(category['name']),
          ],
        ),
      );
    }).toList();
  }

  Future<String> getCategoryIcon(String categoryId) async {
    final categoryDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('categories')
        .doc(categoryId)
        .get();
    //print(categoryDoc['icon'] as String);
    return categoryDoc['icon'] as String;
  }

  @override
  void initState() {
    super.initState();
    amountController.text = widget.amount.toString();
    getCategoryIcon(widget.categoryID).then((icon) {
      setState(() {
        selectedIcon = icon;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Expense'),
      surfaceTintColor: MyColor.powderBlue,
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFieldWithSidebar(
              controller: amountController,
              //keyboardType: TextInputType.number,
              hintText: '',
              needValidation: false,
              errorMessage: '',
              fieldTitle: 'Amount',
              sidebarLabel: 'BDT',
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .collection('categories')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                List<Map<String, dynamic>> categories =
                snapshot.data!.docs.map((doc) {
                  return {'id': doc.id, 'name': doc['name'], 'icon' :doc['icon']};
                }).toList();
                return DropdownButtonFormField<String>(

                  value: selectedCategoryID,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategoryID = newValue;
                    });
                  },
                  items: buildDropdownItems(categories),
                  decoration: InputDecoration(
                    labelText: "Category",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        RoundedBlueButton(
          onClick: () {
            updateExpense(
              widget.expenseID!,
              selectedCategoryID!,
              double.tryParse(amountController.text.trim()) ?? 0.0,
            ); // use double.tryParse(amountController.text.trim()) ?? 0.0,
            Navigator.of(context).pop();
          },
          label: 'Save',
          width: 40,
          backgroundColor: MyColor.yinminBlue,
        ),

      ],
    );
  }
}
