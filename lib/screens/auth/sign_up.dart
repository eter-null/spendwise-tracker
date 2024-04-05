import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spendwise_tracker/screens/auth/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final firebase = FirebaseFirestore.instance;

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final List<Widget> randomAvatar = <Widget>[];
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    resizeToAvoidBottomInset: false,
    body: Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF78BFFC), Color(0xFF254662)],
                  stops: [0, 1],
                  begin: AlignmentDirectional(0, -1),
                  end: AlignmentDirectional(0, 1),
                ),
              ),
            ),
          ],
        ),

        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 85, 0, 20),
              child: Text(
                'Spendwise Tracker',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 30,
                  letterSpacing: 0,
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 0.65),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                        child: TextFormField(
                          controller: TextEditingController(),
                          focusNode: FocusNode(),
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0,
                            ),
                            hintText: 'John Doe',
                            hintStyle: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFFAABBDC),
                              letterSpacing: 0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF72B4EC),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).errorColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).errorColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            suffixIcon: Icon(
                              Icons.person,
                              color: Color(0xFF83C2F8),
                            ),
                          ),
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            letterSpacing: 0,
                          ),
                          minLines: null,
                          // validator: _model.textController1Validator.asValidator(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                        child: TextFormField(
                          controller: TextEditingController(),
                          focusNode: FocusNode(),
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0,
                            ),
                            hintText: 'johndoe@gmail.com',
                            hintStyle: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFFAABBDC),
                              letterSpacing: 0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF72B4EC),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).errorColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).errorColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            suffixIcon: Icon(
                              Icons.email,
                              color: Color(0xFF83C2F8),
                            ),
                          ),
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            letterSpacing: 0,
                          ),
                          minLines: null,
                          //validator: _model.textController2Validator.asValidator(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                        child: TextFormField(
                          controller: TextEditingController(),
                          focusNode: FocusNode(),
                          autofocus: false,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 14,
                              letterSpacing: 0,
                            ),
                            hintText: '••••••••••••••',
                            hintStyle: TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xFFAABBDC),
                              fontSize: 14,
                              letterSpacing: 0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF72B4EC),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).errorColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).errorColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              focusNode: FocusNode(skipTraversal: true),
                              child: Icon(
                                _obscureText ? Icons.lock : Icons.lock_open_outlined,
                                color: Color(0xFF83C2F8),
                                size: 25,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            letterSpacing: 0,
                          ),
                          minLines: null,
                          //validator: _model.textController3Validator.asValidator(context),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, MediaQuery.of(context).size.height * 0.15),
                          child: Row(
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
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 40),
                        child: ElevatedButton(
                          onPressed: () {
                            print('?');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF72B4EC)),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                            ),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            elevation: MaterialStateProperty.all<double>(3),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: Center(
                              child: Text(
                                'CONTINUE',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.white,
                                  fontSize: 11,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    )
    );
  }
}
