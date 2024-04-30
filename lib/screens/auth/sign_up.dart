import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:spendwise_tracker/screens/auth/login.dart';
import 'package:spendwise_tracker/screens/dashboard.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../const_config/color_config.dart';
import '../../services/utils/validator.dart';
import '../../widgets/custom_buttons/rounded_blue_button.dart';
import '../../widgets/input_widgets/blue_border_password_textfield.dart';
import '../../widgets/input_widgets/simple_blue_border_textfield.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final firebase = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          CustomBackground(
            isNavbar: false,
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
                              'Sign Up',
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
                            controller: usernameController,
                            hintText: 'John Doe',
                            needValidation: false,
                            errorMessage: '',
                            borderThickness: 2,
                            borderRadius: BorderRadius.circular(30),
                            suffixIcon: Icons.person,
                          ),
                          SizedBox(height: 20,),
                          SimpleBlueBorderTextField(
                            controller: emailController,
                            hintText: 'johndoe@gmail.com',
                            needValidation: true,
                            validatorClass: ValidatorClass().validateEmail,
                            errorMessage: 'Incorrect Email',
                            borderThickness: 2,
                            borderRadius: BorderRadius.circular(30),
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
                          SizedBox(height: 20,),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Already have an account?   ',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF95C7F1),
                                  letterSpacing: 0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Login()),
                                  );
                                },
                                child: Text(
                                  'Login here.',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF2397FB),
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),

                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 50),
                                child: RoundedBlueButton(
                                  onClick: () async{
                                    FocusScope.of(context).unfocus();
                                    if(formKey.currentState!.validate())
                                    {
                                      await auth.createUserWithEmailAndPassword(
                                          email: emailController.text.trim(),        // trim to remove unneeded spaces at the end
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
                                  label: 'CONTINUE',
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
