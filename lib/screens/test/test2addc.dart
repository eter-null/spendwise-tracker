import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _iconController = TextEditingController();

  void _addCategory() async {
    String name = _nameController.text.trim();
    String icon = _iconController.text.trim();

    if (name.isNotEmpty && icon.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc('kcOCOXbxLIOC1lxqYMSGN3gQDX83') // Replace with actual UID
          .collection('categories')
          .add(
          {
        'name': name,
        'icon': icon,
        'expenseID': [], // Initialize with an empty array for expense IDs
      }
      );

      // Clear text fields after adding the category
      _nameController.clear();
      _iconController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Please enter both name and icon for the category')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Category Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _iconController,
              decoration: InputDecoration(labelText: 'Category Icon'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addCategory,
              child: Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }
}
