import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({Key? key}) : super(key: key);

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedCategoryID;

  List<DropdownMenuItem<String>> _buildDropdownItems(List<Map<String, dynamic>> categories) {
    return categories.map((category) {
      return DropdownMenuItem<String>(
        value: category['id'],
        child: Text(category['name']),
      );
    }).toList();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addExpense() async {
    double amount = double.tryParse(_amountController.text.trim()) ?? 0.0;
    String? categoryID = _selectedCategoryID; // Use selected category ID

    if (amount > 0 && categoryID != null && _selectedDate != null) {
      Timestamp date = Timestamp.fromDate(_selectedDate!);

      DocumentReference expenseRef = await FirebaseFirestore.instance
          .collection('Users')
          .doc('kcOCOXbxLIOC1lxqYMSGN3gQDX83') // Replace with actual UID
          .collection('expenses')
          .add({
        'amount': amount,
        'date': date,
        'categoryID': categoryID,
      });

      // Update category's expenseIDs array
      await FirebaseFirestore.instance
          .collection('Users')
          .doc('kcOCOXbxLIOC1lxqYMSGN3gQDX83') // Replace with actual UID
          .collection('categories')
          .doc(categoryID)
          .update({
        'expenseID': FieldValue.arrayUnion([expenseRef.id]),
      });

      // Clear text fields after adding the expense
      _amountController.clear();
      setState(() {
        _selectedCategoryID = null; // Reset dropdown selection
        _selectedDate = null; // Reset date selection
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid amount, select a category, and choose a date')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedDate != null ? '${_selectedDate!.toLocal()}'.split(' ')[0] : 'Select Date'),
                    Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc('kcOCOXbxLIOC1lxqYMSGN3gQDX83') // Replace with actual UID
                  .collection('categories')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                List<Map<String, dynamic>> categories = snapshot.data!.docs.map((doc) {
                  return {'id': doc.id, 'name': doc['name']};
                }).toList();
                return DropdownButtonFormField<String>(
                  value: _selectedCategoryID,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedCategoryID = value;
                    });
                  },
                  items: _buildDropdownItems(categories),
                  decoration: InputDecoration(labelText: 'Category'),
                );
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addExpense,
              child: Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
