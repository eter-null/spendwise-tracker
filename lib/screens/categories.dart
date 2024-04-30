// import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// import 'package:flutter/widgets.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';
import 'package:spendwise_tracker/widgets/custom_buttons/rounded_blue_button.dart';
import '../services/utils/database_manipulation/category_mod.dart';
import '../widgets/custom_modals/addCategoryModal.dart';
import '../widgets/custom_modals/editCategoryModal.dart';
// import 'package:spendwise_tracker/widgets/custom_containers/label_amount_box.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomBackground(
          isNavbar: true,
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.15,
              bottom: 70,
              left: 30,
              right: 30),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection('categories')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (snapshot.data == null ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('No categories found'));
                      }
                      // scrollDirection: Axis.vertical,
                      // padding: EdgeInsets.all(5),
                      // children: [
                      return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          String categoryID = document.id;
                          String name = data['name'];
                          String icon = data['icon'];


                          // List<dynamic> expenseIDs = data['expenseID'] ?? [];
                          // List<Widget> expenseWidgets = expenseIDs.map((id) => Text(id)).toList();

                          return Material(
                            child: ListTile(
                              title: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // icon + name
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Image.asset(data['icon'],
                                                  width: 30, height: 30),
                                            ),
                                            Flexible(
                                              child: Text(
                                                data['name'],
                                                overflow: TextOverflow.ellipsis,
                                                // ... after txt overflow used w flexible
                                                style: TextStyle(
                                                  // height: 5,
                                                  fontWeight: FontWeight.bold,
                                                  // fontFamily: 'Roboto',
                                                  fontSize: 15,
                                                  color: Colors.blue[300],
                                                  decoration:
                                                      TextDecoration.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        width:
                                            data['name'].length <= 4 ? 35 : 8,
                                      ),

                                      //  btn
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // IconButton(
                                          //   style: TextButton.styleFrom(
                                          //     padding: EdgeInsets.all(5),
                                          //     foregroundColor: Colors.white,
                                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                                          //   ),
                                          //   onPressed: () {}, icon: Icon(Icons.add, size: 20),
                                          //   // child: Text('Edit'),
                                          // ),
                                          IconButton(
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.all(5),
                                              foregroundColor: Colors.white,
                                              backgroundColor: MyColor
                                                  .blueFadedBackground, // foreground
                                            ),
                                            onPressed: () {
                                              {
                                                showGeneralDialog(
                                                  context: context,
                                                  pageBuilder: (BuildContext
                                                          buildContext,
                                                      Animation<double>
                                                          animation,
                                                      Animation<double>
                                                          secondaryAnimation) {
                                                    return EditCategoryModal(categoryID: categoryID, categoryName: name, categoryIcon: icon);
                                                  },
                                                  barrierDismissible: true,
                                                  barrierLabel: '',
                                                  barrierColor: Colors.black
                                                      .withOpacity(0.5),
                                                  transitionDuration: Duration(
                                                      milliseconds: 200),
                                                  transitionBuilder: (context,
                                                      animation,
                                                      secondaryAnimation,
                                                      child) {
                                                    return FadeTransition(
                                                      opacity: CurvedAnimation(
                                                          parent: animation,
                                                          curve:
                                                              Curves.easeOut),
                                                      child: child,
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            icon: Icon(Icons.edit, size: 20),
                                            // child: Text('Edit'),
                                          ),
                                          IconButton(
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.all(5),
                                              foregroundColor: Colors.white,
                                              backgroundColor: MyColor
                                                  .blueFadedBackground, // foreground
                                            ),
                                            onPressed: () {
                                              deleteCategory(categoryID);
                                            },
                                            iconSize: 20,
                                            icon: Icon(Icons.delete),
                                            // child: Text('Edit'),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: MyColor.blueFadedBackground,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                RoundedBlueButton(
                  onClick: () {
                    {
                      showGeneralDialog(
                        context: context,
                        pageBuilder: (BuildContext buildContext,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return AddCategoryModal();
                        },
                        barrierDismissible: true,
                        barrierLabel: '',
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionDuration: Duration(milliseconds: 200),
                        transitionBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: CurvedAnimation(
                                parent: animation, curve: Curves.easeOut),
                            child: child,
                          );
                        },
                      );
                    }
                  },
                  label: 'Add Category',
                  width: 200,
                )
              ],
            ),
          ),
        ),
        Center(
          child: Column(
            children: [
              SizedBox(height: 80),
              Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 0,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
