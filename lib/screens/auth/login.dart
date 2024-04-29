import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';
import 'package:spendwise_tracker/widgets/input_widgets/blue_border_password_textfield.dart';
import '../../const_config/color_config.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/utils/validator.dart';
import '../../widgets/custom_buttons/rounded_blue_button.dart';
import '../../widgets/input_widgets/simple_blue_border_textfield.dart';
import '../dashboard.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final firebase = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          CustomBackground(
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 60, 0, 35),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Color(0xFF72B4EC),
                                fontSize: 30,
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SimpleBlueBorderTextField(
                            controller: emailController,
                            hintText: 'johndoe@gmail.com',
                            needValidation: true,
                            errorMessage: '',
                            borderThickness: 2,
                            borderRadius: BorderRadius.circular(30),
                            validatorClass: ValidatorClass().validateEmail,
                            suffixIcon: Icons.email,
                          ),
                          SizedBox(height: 20,),
                          BlueBorderPasswordTextField(
                            password: passwordController,
                            hintText: '••••••••••••••',
                            errorMessage: 'Incorrect password',
                            borderThickness: 2,
                            borderRadius: BorderRadius.circular(30),
                            borderColor: MyColor.powderBlue,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 50),
                                child: RoundedBlueButton(
                                  onClick: ()async {
                                    FocusScope.of(context).unfocus();
                                    if(formKey.currentState!.validate())
                                    {
                                      await auth.signInWithEmailAndPassword(
                                          email: emailController.text.trim(),
                                          password: passwordController.text.trim()
                                      ).then((value) {
                                        if(value.user != null)
                                        {
                                          // showSnackBar(
                                          //     context: context,
                                          //     title: "Successful",
                                          //     height: 200,
                                          //     message: "Welcome to Spendwise Tracker",
                                          //     failureMessage: false
                                          // );
                                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Dashboard()), (route) => false);
                                        }
                                        else
                                        {
                                          // showSnackBar(
                                          //     context: context,
                                          //     title: "Error",
                                          //     height: 200,
                                          //     message: "Please try again later",
                                          //     failureMessage: true
                                          // );
                                        }
                                      });
                                    }
                                  },
                                  label: 'LOGIN',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              )
          ),
          Center(
              child: Column(
                children: const [
                  SizedBox(height:80),
                  Text(
                    'Spendwise Tracker',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontSize: 30,
                      letterSpacing: 0,
                      decoration: TextDecoration.none,
                    ),
                  ),

                ],
              )
          ),
        ]
    );
  }
}
