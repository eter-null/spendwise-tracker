import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> deleteCategory(String categoryId) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('categories')
      .doc(categoryId)
      .delete();
}

Future<void> updateCategory(String categoryId, String newName, String icon) async {

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('categories')
        .doc(categoryId)
        .update({
      'name': newName,
      'icon': icon,
        });
    print('Category name updated successfully');
}

Future<void> addCategory(String name, String icon) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('categories')
        .add(
        {
          'name': name,
          'icon': icon,
          'expenseID': [],
        }
    );
    print('Category name updated successfully');
}