import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';
import 'package:spendwise_tracker/screens/auth/login.dart';
import 'package:spendwise_tracker/screens/dashboard.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';
import 'package:spendwise_tracker/widgets/custom_containers/label_amount_box.dart';
import 'package:spendwise_tracker/widgets/input_widgets/textfield_with_sidebar.dart';
class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}
class _AddIncomeState extends State<AddIncome> {
  final formKey = GlobalKey<FormState>();
  CollectionReference incomes=FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .collection('income');
  final amountController = TextEditingController();
  DateTime? selectedDate;
  String? selectedIncomeID;

  final user=FirebaseAuth.instance.currentUser!;
  
  
  
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
                        TextFieldWithSidebar(
                          controller: amountController,
                          needValidation: false,
                          errorMessage: '',
                          hintText: '5000',
                          sidebarLabel: 'BDT',
                          fieldTitle: 'Amount',
                        ),
                        SizedBox(height: 180),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Dashboard()),
                                );
                              }, 
                              style: ButtonStyle(backgroundColor:MaterialStatePropertyAll<Color>(MyColor.lightBlue)),
                              child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 20
                              ),
                            ),
                            ),
                            SizedBox(width: 60,),
                            ElevatedButton(
                              onPressed: () =>
                              
                              // async{
                              //   await incomes.add{
                              //     'amount':amountController,
                              //     'date':DateTime.now()};
                                
                            
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Dashboard()),
                                ),
                        
                              
                              style: ButtonStyle(backgroundColor:MaterialStatePropertyAll<Color>(MyColor.lightBlue)),
                              child: Text(
                              'Submit',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 20
                              ),
                            ),
                            ),
                            
                          ],
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
                "BDT 15,000",
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
