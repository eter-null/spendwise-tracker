import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';
import 'package:spendwise_tracker/screens/add_income.dart';
import 'package:spendwise_tracker/screens/auth/login.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';
import 'package:spendwise_tracker/widgets/custom_containers/label_amount_box.dart';

class Dashboard extends StatefulWidget {

   const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

 final firestore=FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .collection('income');
  
  final firestore2=FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .collection('expenses');
  double totalIncome = 0.0;
  double totalExpense=0.0;

  @override
  void initState() {
    super.initState();
    calculateTotalIncomeAndExpense();
    // calculateTotalExpense();
  }

void calculateTotalIncomeAndExpense() async {

  final snapshot = await firestore.get();
    double income = 0.0;

    for (var doc in snapshot.docs) {
      if (doc.data().containsKey('amount')) {
        income += (doc['amount'] as num).toDouble();
      }
    }
  final snapshot2 = await firestore2.get();
    double expenses = 0.0;

    for (var doc2 in snapshot2.docs) {
      if (doc2.data().containsKey('amount')) {
        expenses += (doc2['amount'] as num).toDouble();
      }
    }
    setState(() {
      totalIncome = income;
      totalExpense = expenses;

    });
  }
  


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomBackground(
          isNavbar: true,
          child: Scaffold(
          
                  resizeToAvoidBottomInset: false,
                  body: Padding(padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Column(
                      children: [
                        
                        SizedBox(height: 20),
                        LabelAmountBox(
                          label: 'Total Spent',
                          amount: 2000,
                        ),
                        SizedBox(height: 30),
                        LabelAmountBox(
                          label: 'Total Expenses',
                          amount: totalExpense,
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: ()=>Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AddIncome()),
                                ),
                          style: ButtonStyle(backgroundColor:MaterialStatePropertyAll<Color>(MyColor.lightBlue)),
                          child: Text(
                          'Add Income',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: 20
                          ),
                        ),
                        )
                        
                        
                      ],
                    ),)
              )
        ),
        Center(
          child: Column(
            children: [
              SizedBox(height:80),
              Text(
                "BDT $totalIncome",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                  fontSize: 25,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  // height: 20,
                  ),
                  
              ),
              SizedBox(height: 5),
              Text(
                "Balance",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  // height: 15,
                ),
              ),
              ],
              )
               ),
        
        ]);
  }
}