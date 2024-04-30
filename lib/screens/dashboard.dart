import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';
import 'package:spendwise_tracker/screens/auth/login.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';
import 'package:spendwise_tracker/widgets/custom_containers/label_amount_box.dart';

class Dashboard extends StatelessWidget {

   const Dashboard({super.key});

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
                          amount: 500,
                        ),
                        SizedBox(height: 180),
                        ElevatedButton(
                          onPressed: (){}, 
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