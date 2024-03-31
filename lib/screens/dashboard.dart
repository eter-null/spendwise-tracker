import 'package:flutter/material.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        
        CustomBackground(child: Text("HELLO")),
        Center(
          child: Column(
            children: [
              SizedBox(height:80),
              Text(
                "BDT 15,000",
                style: TextStyle(
                  fontWeight: FontWeight.w200,
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