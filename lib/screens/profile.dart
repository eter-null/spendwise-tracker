import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:profile/profile.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';
import 'package:spendwise_tracker/screens/auth/login.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';
import 'package:spendwise_tracker/widgets/custom_containers/label_amount_box.dart';

class ProfilePage extends StatefulWidget {

   const ProfilePage({super.key});


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
    final FirebaseAuth auth = FirebaseAuth.instance;

  late User user;
  Future<void>getUserData()async{
    User userData=auth.currentUser!;
    user=userData;
  }
  @override
  void initState(){
    super.initState();
    getUserData();
  }
  signOut()async{
    await auth.signOut();
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context)=>Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomBackground(
          isNavbar: true,
          child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
                  floatingActionButton: FloatingActionButton(
                  onPressed: (){signOut();},
                  backgroundColor: MyColor.lightBlue,
                  child: Icon(Icons.logout_sharp,color: Colors.white,),
                  
            ),
                  resizeToAvoidBottomInset: false,
                  body: Padding(padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Center(
                          child: Profile(
                            imageUrl: 'https://img.freepik.com/premium-photo/view-three-dimensional-animated-cartoon-bird_23-2150946471.jpg',
                            phone_number: '',
                            designation: '',
                            website: '',
                            name: '',
                            email: user.email.toString(),
                          ),
                        ),
                        
                        
                        
                      ],
                    ),)
              )
        ),
        
        ]);
  }
}