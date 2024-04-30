import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';
import 'package:spendwise_tracker/screens/auth/login.dart';
import 'package:spendwise_tracker/screens/auth/sign_up.dart';
import 'package:spendwise_tracker/screens/dashboard.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';
import 'package:spendwise_tracker/widgets/custom_scaffold.dart';
// import 'package:spendwise_tracker/widgets/custom_scaffold.dart';

class IntroductionScreens extends StatelessWidget {
  IntroductionScreens({super.key});
  final imagePath=["assets/images/goals.jpg","assets/images/stats.png","assets/images/debt.png"];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ScaffoldWithBackground(),
        Padding(
          padding: const EdgeInsets.only(left:20, right:20, top:80,bottom:60),
          child: IntroductionScreen(
            pages: <PageViewModel>[
              PageViewModel(
                title: 'Spendwise Tracker',
                body: 'Manage your expenses, invomes and spend wisely according to your budget.',
                image: buildImage("assets/images/budget.png"),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Goals',
                body: 'You can reach your financial goals more quickly and easily.',
                image: buildImage("assets/images/goals.jpg"),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Statistics',
                body: 'You can track your expense statistics to make prompt decisions.',
                image: buildImage("assets/images/stats.png"),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Debts',
                body: 'You can keep record of your debts to aboid forgetfulness and other issues.',
                image: buildImage("assets/images/debt.jpg"),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Privacy and Security',
                body: 'Your data is safe and secure and you can use the app without any worry.',
                image: buildImage("assets/images/debt.jpg"),
                decoration: getPageDecoration(),
              ),
            ],
            onDone: () {
              // if (kDebugMode) {
              // print("Done clicked");
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignUp()));
              // }
            },
            scrollPhysics: const ClampingScrollPhysics(),
            showDoneButton: true,
            showNextButton: true,
            showSkipButton: true,
            skip: const Text(
              "Skip",
              style: TextStyle(color: MyColor.gradientBackground, fontWeight: FontWeight.w600),
            ),
            next: const Text(
              "Next",
              style: TextStyle(color: MyColor.gradientBackground, fontWeight: FontWeight.w600),
            ),
            done: const Text(
              "Done",
              style: TextStyle(color: MyColor.gradientBackground,fontWeight: FontWeight.w600),
            ),
            dotsDecorator: getDotsDecorator(),
          ),
        ),
        // Scaffold(
        //   appBar: AppBar(),
        //    body:

        // ),
      ],
    );
  }

  Widget buildImage(String? imagePath) {
    if (imagePath != null && imagePath.isNotEmpty) {
      return Center(
        child: Image.asset(
          imagePath,
          width: 450,
          height: 200,
        ),
      );
    } else {
      // Placeholder widget when image path is null or empty
      return const Placeholder(
        fallbackWidth: 450,
        fallbackHeight: 200,
      );
    }
  }

  PageDecoration getPageDecoration() {
    return PageDecoration(
      boxDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color:Colors.white,
      ),
      imagePadding: EdgeInsets.only(top: 50),
      imageFlex: 2,
      // pageColor: Colors.white,
      bodyPadding: EdgeInsets.only(top: 8, left: 20, right: 20),
      titlePadding: EdgeInsets.only(top: 15),
      bodyTextStyle: TextStyle(color: MyColor.fadedText, fontSize: 15),
      titleTextStyle: TextStyle(color: MyColor.gradientBackground, fontWeight: FontWeight.w700, fontSize: 20),
    );
  }

  DotsDecorator getDotsDecorator() {
    return const DotsDecorator(
      spacing: EdgeInsets.symmetric(horizontal: 2),
      activeColor: MyColor.gradientBackground,
      color: MyColor.fadedBackground,
      activeSize: Size(12, 5),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
    );
  }
}