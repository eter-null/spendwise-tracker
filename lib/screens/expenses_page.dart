import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';
import 'package:spendwise_tracker/widgets/custom_buttons/rounded_blue_button.dart';
import '../services/notification_service.dart';
import '../services/utils/database_manipulation/expense_mod.dart';
import '../widgets/custom_modals/addExpenseModal.dart';
import '../widgets/custom_modals/editExpenseModal.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({Key? key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {

  Stream<List<Map<String, dynamic>>> _getExpensesStream() {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('expenses')
        .orderBy('date', descending: true) // Sort expenses by date, most recent first
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((doc) {
      final expense = doc.data() as Map<String, dynamic>;
      return {
        'id': doc.id,
        'amount': expense['amount'] as double,
        'date': (expense['date'] as Timestamp).toDate(),
        'categoryId': expense['categoryID'] as String,
      };
    }).toList());
  }

  Future<String> getCategoryName(String categoryId) async {
    final categoryDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('categories')
        .doc(categoryId)
        .get();
    return categoryDoc['name'] as String;
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
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomBackground(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.15,
              bottom: 30,
              left: 30,
              right: 30),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<List<Map<String, dynamic>>>(
                      stream: _getExpensesStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        final expenses = snapshot.data ?? [];
                        if (expenses.isEmpty) {
                          return Center(child: Text('No expenses found'));
                        }

                        return ListView.builder(
                          itemCount: expenses.length,
                          itemBuilder: (context, index) {
                            final expense = expenses[index]; // builds list with its index as expense id

                            return Column(
                              children: [
                                ListTile(
                                  leading: FutureBuilder<String>(
                                    future: getCategoryIcon(expense['categoryId'] as String),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        //print(snapshot.data!);
                                        return Image.asset(
                                          snapshot.data!, // category icon returned in snapshot
                                          width: 30,
                                          height: 30,
                                        );
                                      } else {
                                        return Icon(Icons.photo);
                                      }
                                    },
                                  ),
                                  title: FutureBuilder<String>(
                                    future: getCategoryName(expense['categoryId'] as String),
                                    builder: (context, snapshot) {
                                      return Text(snapshot.data ?? 'Category Name');
                                    },
                                  ),
                                  subtitle: Text(
                                    'BDT ${expense['amount'].toStringAsFixed(2)}\n'
                                        '${DateFormat('dd, MMMM yyyy').format(expense['date'] as DateTime)}',
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.all(5),
                                          foregroundColor: Colors.white,
                                          backgroundColor: MyColor
                                              .blueFadedBackground, // foreground
                                        ),
                                        onPressed: () {
                                          {
                                            showGeneralDialog(
                                              context: context,
                                              pageBuilder: (BuildContext
                                              buildContext,
                                                  Animation<double>
                                                  animation,
                                                  Animation<double>
                                                  secondaryAnimation) {
                                                return EditExpenseModal(
                                                  expenseID: expense['id'],
                                                  amount: expense['amount'].toDouble(),
                                                  categoryID: expense['categoryId'],
                                                  categoryName: '',
                                                  categoryIcon: FutureBuilder<String>(
                                                    future: getCategoryIcon(expense['categoryId'] as String),
                                                    builder: (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        print(snapshot.data);
                                                        return Text(snapshot.data.toString());
                                                      } else {
                                                        return Text('no icon');
                                                      }
                                                    },
                                                  ).toString(),
                                                );
                                              },
                                              barrierDismissible: true,
                                              barrierLabel: '',
                                              barrierColor: Colors.black
                                                  .withOpacity(0.5),
                                              transitionDuration: Duration(
                                                  milliseconds: 200),
                                              transitionBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                return FadeTransition(
                                                  opacity: CurvedAnimation(
                                                      parent: animation,
                                                      curve:
                                                      Curves.easeOut),
                                                  child: child,
                                                );
                                              },
                                            );
                                          }
                                        },
                                        icon: Icon(Icons.edit, size: 20),
                                        // child: Text('Edit'),
                                      ),
                                      IconButton(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.all(5),
                                          foregroundColor: Colors.white,
                                          backgroundColor: MyColor
                                              .blueFadedBackground, // foreground
                                        ),
                                        onPressed: () {
                                          deleteExpense(
                                              expense['id'],
                                              expense['categoryId']
                                          );
                                        },
                                        iconSize: 20,
                                        icon: Icon(Icons.delete),
                                        // child: Text('Edit'),
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: MyColor.blueFadedBackground,
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  RoundedBlueButton(
                    onClick: () {
                      {
                        showGeneralDialog(
                          context: context,
                          pageBuilder: (BuildContext buildContext,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return AddExpenseModal();
                          },
                          barrierDismissible: true,
                          barrierLabel: '',
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionDuration: Duration(milliseconds: 200),
                          transitionBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: CurvedAnimation(
                                  parent: animation, curve: Curves.easeOut),
                              child: child,
                            );
                          },
                        );
                      }
                    },
                    label: 'Add Expenses',
                    width: 200,
                  )
                ],
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            children: [
              SizedBox(height: 60),
              Text(
                'Expenses',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 0,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
