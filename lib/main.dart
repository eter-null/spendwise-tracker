// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:spendwise_tracker/screens/add_debt_page.dart';
import 'package:spendwise_tracker/screens/add_expense_page.dart';
import 'package:spendwise_tracker/screens/analysis_page.dart';
import 'package:spendwise_tracker/screens/categories.dart';
import 'package:spendwise_tracker/screens/dashboard.dart';
import 'package:spendwise_tracker/screens/debt_page.dart';
import 'package:spendwise_tracker/screens/expenses_page.dart';
import 'package:spendwise_tracker/screens/financial_goals_page.dart';
import 'package:spendwise_tracker/screens/landin_page1.dart';
import 'package:spendwise_tracker/screens/auth/sign_up.dart';
import 'package:spendwise_tracker/screens/auth/login.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';
import 'package:spendwise_tracker/screens/new_expenses_page.dart';
import 'package:spendwise_tracker/screens/test/datetest.dart';
import 'package:spendwise_tracker/screens/test/graph_tst.dart';
import 'package:spendwise_tracker/screens/test/notifs_tst.dart';
import 'package:spendwise_tracker/screens/test/show_bar.dart';
import 'package:spendwise_tracker/screens/test/test.dart';
import 'package:spendwise_tracker/screens/test/test2.dart';
import 'package:spendwise_tracker/screens/test/test2addc.dart';
import 'package:spendwise_tracker/screens/test/test2adde.dart';
import 'package:spendwise_tracker/screens/test/test2viewc.dart';
import 'package:spendwise_tracker/screens/test/test2viewe.dart';
import 'package:spendwise_tracker/screens/test/test_totals_month.dart';
import 'package:spendwise_tracker/screens/test/testcat.dart';
import 'package:spendwise_tracker/services/utils/database_manipulation/default_category_initiator.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';
import 'package:spendwise_tracker/widgets/custom_modals/addCategoryModal.dart';
import 'package:spendwise_tracker/widgets/custom_scaffold.dart';

import 'package:spendwise_tracker/services/notification_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await Firebase.initializeApp();
  // DatabaseInitializer.initializeDefaultCategories();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroductionScreens()
      // home: DebtPage()
      // home: AddDebtPage()
      // home: AddExpensePage()
      // home: NewExpensesPage()
      // home: FinancialGoals()
      // home: Dashboard()
      // home: SignUp()
      // home: Login()
      // home: AnalysisPage()
      // home: AddExpensePage(),
      // home: Categories(),
      // home: AddCategoryModal(),
      // home: ExpensesPage(),


      // home: ViewCategories()
      // home: ViewExpense()
      // home: AddCategory()
      // home: AddExpenses()
      // home: Testing()
      // home: Test2()
      // home: DateTest(),
      // home: GraphTest(),
      // home: MonthlySummary()
      // home: MyHomePage(title: 'lol'),

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

