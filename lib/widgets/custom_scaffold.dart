import 'package:flutter/material.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';

class ScaffoldWithBackground extends StatelessWidget {
  //final Widget child; , required this.child}
  const ScaffoldWithBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.fadedBackground,
      body: Column(
      //Stack(
    children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            color: MyColor.gradientBackground,
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   // height: 300,
          //   color: MyColor.fadedBackground,
          // ),
        ],
 // ),
      ),
    );
  }
}