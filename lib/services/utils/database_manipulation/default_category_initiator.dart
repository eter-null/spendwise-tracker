import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseInitializer {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  static Future<void> initializeDefaultCategories() async {
    // Create a reference to the categories collection
    CollectionReference categoriesRef = _instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).collection('categories');

    // Define the default categories
    List<Map<String, dynamic>> defaultCategories = [
      {'name': 'Browser', 'icon': 'assets/images/browser.png', 'expenseID': []},
      {'name': 'Gas', 'icon': 'assets/images/gas-pump.png', 'expenseID': []},
      {'name': 'Fast Food', 'icon': 'assets/images/fast-food.png', 'expenseID': []},
      {'name': 'Tax', 'icon': 'assets/images/tax.png', 'expenseID': []},
      {'name': 'Grocery', 'icon': 'assets/images/grocery.png', 'expenseID': []},
      {'name': 'Health', 'icon': 'assets/images/healthcare.png', 'expenseID': []},
      {'name': 'Transport', 'icon': 'assets/images/transportation.png', 'expenseID': []},
      {'name': 'More', 'icon': 'assets/images/more.png', 'expenseID': []},
    ];

    // Add default categories to the database
    defaultCategories.forEach((category) async {
      await categoriesRef.add(category);
    });
  }
}
