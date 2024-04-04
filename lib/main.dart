import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:spendwise_tracker/screens/landin_page1.dart';
import 'package:spendwise_tracker/screens/auth/sign_up.dart';
import 'package:spendwise_tracker/screens/auth/login.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';
import 'package:spendwise_tracker/widgets/custom_scaffold.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroductionScreens()
      // home: SignUp()
      // home: Login()
    );
    //IntroductionScreen();
    // MaterialApp(
    //   // title: 'Dashboard',
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(

    //     colorScheme: ColorScheme.fromSeed(seedColor: MyColor.gradientBackground),
    //     useMaterial3: true,
    //   ),
    //   home: Stack(
    //     children: [
    //         const ScaffoldWithBackground(),
    //         Container(
    //           alignment: Alignment.center,
    //           height:MediaQuery.of(context).size.height,
    //           padding: const EdgeInsets.all(10.0),
              
    //           margin: const EdgeInsets.only(top: 150, bottom: 50, left: 30, right: 30),
    //           width: MediaQuery.of(context).size.width,
        
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(20),
    //           ),
              
    //         ),
    //       ],
    //   ),
    // );
  }
}

