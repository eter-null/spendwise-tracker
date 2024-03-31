import 'package:flutter/material.dart';
import 'package:spendwise_tracker/widgets/custom_scaffold.dart';

import '../const_config/color_config.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;
  const CustomBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: MyColor.gradientBackground),
        useMaterial3: true,
      ),
      home: Stack(
        children: [
            const ScaffoldWithBackground(),
            Container(
              alignment: Alignment.center,
              height:MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(10.0),
              
              margin: const EdgeInsets.only(top: 150, bottom: 50, left: 30, right: 30),
              width: MediaQuery.of(context).size.width,
        
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: child,
            ),
          ],
      ),
    );
  }
}