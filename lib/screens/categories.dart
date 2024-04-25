// import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// import 'package:flutter/widgets.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';
import 'package:spendwise_tracker/widgets/custom_back.dart';
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
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc('kcOCOXbxLIOC1lxqYMSGN3gQDX83') // Replace with actual UID
                .collection('categories_test')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No categories found'));
              }
              // scrollDirection: Axis.vertical,
              // padding: EdgeInsets.all(5),
              // children: [
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String categoryID = document.id;

                  // List<dynamic> expenseIDs = data['expenseID'] ?? [];
                  // List<Widget> expenseWidgets = expenseIDs.map((id) => Text(id)).toList();

                  return Material(
                    child: ListTile(
                      title: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // icon + name
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Image.asset(data['icon'],
                                          width: 30, height: 30),
                                    ),
                                    Flexible(
                                      child: Text(
                                      data['name'],
                                      overflow: TextOverflow.ellipsis, // ... after txt overflow used w flexible
                                      style: TextStyle(
                                        // height: 5,
                                        fontWeight: FontWeight.bold,
                                        // fontFamily: 'Roboto',
                                        fontSize: 15,
                                        color: Colors.blue[300],
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    )

                                  ],
                                ),
                              ),


                              SizedBox(
                                width: data['name'].length <= 4 ? 35 : 8,
                              ),

                              // btn group
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.all(5),
                                      foregroundColor: Colors.white,
                                      backgroundColor: MyColor
                                          .blueFadedBackground, // foreground
                                    ),
                                    onPressed: () {},
                                    icon: Icon(Icons.add, size: 20),
                                    // child: Text('Edit'),
                                  ),
                                  IconButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.all(5),
                                      foregroundColor: Colors.white,
                                      backgroundColor: MyColor
                                          .blueFadedBackground, // foreground
                                    ),
                                    onPressed: () {},
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
                                    onPressed: () {},
                                    iconSize: 20,
                                    icon: Icon(Icons.delete),
                                    // child: Text('Edit'),
                                  )
                              ],)
                            ],
                          ),
                          Divider(
                            color: MyColor.blueFadedBackground,
                          ),
                          // Row(
                          //   children: [
                          //     Container(
                          //       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),

                          //       child: Image.asset('assets/images/medicine.png', width: 30, height:30),

                          //     ),
                          //   Text("Medicine", style: TextStyle(
                          //     // height: 5,
                          //     fontWeight: FontWeight.bold,
                          //         // fontFamily: 'Roboto',
                          //         fontSize: 15,
                          //         color: Colors.blue[300],
                          //         decoration: TextDecoration.none,
                          //   ),),
                          //   SizedBox(width: 30,),
                          //   IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { }, icon: Icon(Icons.add, size: 20),
                          //   // child: Text('Edit'),
                          // ),
                          //   IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { }, icon: Icon(Icons.edit, size: 20),
                          //   // child: Text('Edit'),
                          // ),
                          // IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { },
                          //   iconSize: 20,
                          //   icon: Icon(Icons.delete),
                          //   // child: Text('Edit'),
                          // )
                          //   ],
                          // ),
                          // Divider(color: MyColor.blueFadedBackground,),
                          // Row(
                          //   children: [
                          //     Container(
                          //       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),

                          //       child: Image.asset('assets/images/browser.png', width: 30, height:30),

                          //     ),
                          //   Text("Internet", style: TextStyle(
                          //     // height: 5,
                          //     fontWeight: FontWeight.bold,
                          //         // fontFamily: 'Roboto',
                          //         fontSize: 15,
                          //         color: Colors.blue[300],
                          //         decoration: TextDecoration.none,
                          //   ),),
                          //   SizedBox(width: 30,),
                          //   IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { }, icon: Icon(Icons.add, size: 20),
                          //   // child: Text('Edit'),
                          // ),
                          //   IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { }, icon: Icon(Icons.edit, size: 20),
                          //   // child: Text('Edit'),
                          // ),
                          // IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { },
                          //   iconSize: 20,
                          //   icon: Icon(Icons.delete),
                          //   // child: Text('Edit'),
                          // )
                          //   ],
                          // ),
                          // Divider( color: MyColor.blueFadedBackground,),
                          // Row(
                          //   children: [
                          //     Container(
                          //       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),

                          //       child: Image.asset('assets/images/fast-food.png', width: 30, height:30),

                          //     ),
                          //   Text("Food", style: TextStyle(
                          //     // height: 5,
                          //     fontWeight: FontWeight.bold,
                          //         // fontFamily: 'Roboto',
                          //         fontSize: 15,
                          //         color: Colors.blue[300],
                          //         decoration: TextDecoration.none,
                          //   ),),
                          //   SizedBox(width: 65,),
                          //   IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { }, icon: Icon(Icons.add, size: 20),
                          //   // child: Text('Edit'),
                          // ),
                          //   IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { }, icon: Icon(Icons.edit, size: 20),
                          //   // child: Text('Edit'),
                          // ),
                          // IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { },
                          //   iconSize: 20,
                          //   icon: Icon(Icons.delete),
                          //   // child: Text('Edit'),
                          // )
                          //   ],
                          // ),
                          // Divider( color: MyColor.blueFadedBackground,),
                          // Row(
                          //   children: [
                          //     Container(
                          //       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),

                          //       child: Image.asset('assets/images/transportation.png', width: 30, height:30),

                          //     ),
                          //   Text("Transport", style: TextStyle(
                          //     // height: 5,
                          //     fontWeight: FontWeight.bold,
                          //         // fontFamily: 'Roboto',
                          //         fontSize: 15,
                          //         color: Colors.blue[300],
                          //         decoration: TextDecoration.none,
                          //   ),),
                          //   SizedBox(width: 20,),
                          //   IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { }, icon: Icon(Icons.add, size: 20),
                          //   // child: Text('Edit'),
                          // ),
                          //   IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { }, icon: Icon(Icons.edit, size: 20),
                          //   // child: Text('Edit'),
                          // ),
                          // IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { },
                          //   iconSize: 20,
                          //   icon: Icon(Icons.delete),
                          //   // child: Text('Edit'),
                          // )
                          //   ],
                          // ),
                          // Divider( color: MyColor.blueFadedBackground,),
                          // Row(
                          //   children: [
                          //     Container(
                          //       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),

                          //       child: Image.asset('assets/images/tax.png', width: 30, height:30),

                          //     ),
                          //   Text("Tax", style: TextStyle(
                          //     // height: 5,
                          //     fontWeight: FontWeight.bold,
                          //         // fontFamily: 'Roboto',
                          //         fontSize: 15,
                          //         color: Colors.blue[300],
                          //         decoration: TextDecoration.none,
                          //   ),),
                          //   SizedBox(width: 75,),
                          //   IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { }, icon: Icon(Icons.add, size: 20),
                          //   // child: Text('Edit'),
                          // ),
                          //   IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { }, icon: Icon(Icons.edit, size: 20),
                          //   // child: Text('Edit'),
                          // ),
                          // IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { },
                          //   iconSize: 20,
                          //   icon: Icon(Icons.delete),
                          //   // child: Text('Edit'),
                          // )
                          //   ],
                          // ),
                          // Divider( color: MyColor.blueFadedBackground,),
                          // Row(
                          //   children: [
                          //     Container(
                          //       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),

                          //       child: Image.asset('assets/images/gas-pump.png', width: 30, height:30),

                          //     ),
                          //   Text("Gas", style: TextStyle(
                          //     // height: 5,
                          //     fontWeight: FontWeight.bold,
                          //         // fontFamily: 'Roboto',
                          //         fontSize: 15,
                          //         color: Colors.blue[300],
                          //         decoration: TextDecoration.none,
                          //   ),),
                          //   SizedBox(width: 75,),
                          //   IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { }, icon: Icon(Icons.add, size: 20),
                          //   // child: Text('Edit'),
                          // ),
                          //   IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { }, icon: Icon(Icons.edit, size: 20),
                          //   // child: Text('Edit'),
                          // ),
                          // IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { },
                          //   iconSize: 20,
                          //   icon: Icon(Icons.delete),
                          //   // child: Text('Edit'),
                          // )
                          //   ],
                          // ),
                          // Divider( color: MyColor.blueFadedBackground,),
                          // Row(
                          //   children: [
                          //     Container(
                          //       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),

                          //       child: Image.asset('assets/images/healthcare.png', width: 30, height:30),

                          //     ),
                          //   Text("Health", style: TextStyle(
                          //     // height: 5,
                          //     fontWeight: FontWeight.bold,
                          //         // fontFamily: 'Roboto',
                          //         fontSize: 15,
                          //         color: Colors.blue[300],
                          //         decoration: TextDecoration.none,
                          //   ),),
                          //   SizedBox(width: 50,),
                          //   IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { }, icon: Icon(Icons.add, size: 20),
                          //   // child: Text('Edit'),
                          // ),
                          //   IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { }, icon: Icon(Icons.edit, size: 20),
                          //   // child: Text('Edit'),
                          // ),
                          // IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { },
                          //   iconSize: 20,
                          //   icon: Icon(Icons.delete),
                          //   // child: Text('Edit'),
                          // )
                          //   ],
                          // ),
                          // Divider( color: MyColor.blueFadedBackground,),
                          // Row(
                          //   children: [
                          //     Container(
                          //       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),

                          //       child: Image.asset('assets/images/more.png', width: 30, height:30),

                          //     ),
                          //   Text("More", style: TextStyle(
                          //     // height: 5,
                          //     fontWeight: FontWeight.bold,
                          //         // fontFamily: 'Roboto',
                          //         fontSize: 15,
                          //         color: Colors.blue[300],
                          //         decoration: TextDecoration.none,
                          //   ),),
                          //   SizedBox(width: 70,),
                          //   IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { }, icon: Icon(Icons.add, size: 20),
                          //   // child: Text('Edit'),
                          // ),
                          //   IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { }, icon: Icon(Icons.edit, size: 20),
                          //   // child: Text('Edit'),
                          // ),
                          // IconButton(
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.all(5),
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: MyColor.blueFadedBackground,// foreground
                          //   ),
                          //   onPressed: () { },
                          //   iconSize: 20,
                          //   icon: Icon(Icons.delete),
                          //   // child: Text('Edit'),
                          // )
                          //   ],
                          // ),
                          // Divider( color: MyColor.blueFadedBackground,),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),

        //adding center text
        // Scaffold(
        //       resizeToAvoidBottomInset: false,

        //       body: Padding(
        //         padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 10),
        //         // padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
        //       child:
        Center(
          child: Column(
            children: [
              SizedBox(height: 80),
              Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  // fontFamily: 'Roboto',
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 0,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),

        //)// children
        //)
      ],
    );
  }
}
//                 ],
//              ),
//               );
//             }
//           )
//            // ]
//           // : Center(child: CircularProgressIndicator()),
//         )
//       ]
//     );
//   }
// }
// child: Scaffold(
//   resizeToAvoidBottomInset: false,

//   body: Padding(
//     padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 10),
//     // padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
//   child:
//   Center(
//   child: Column(
//     children: [
//       SizedBox(height:80),

//       Text(
//             'Categories',
//             style: TextStyle(
//               fontWeight: FontWeight.w200,
//               // fontFamily: 'Roboto',
//               color: Colors.white,
//               fontSize: 25,
//               letterSpacing: 0,
//               decoration: TextDecoration.none,
//             ),
//           ),

//     ],
//   ),
// ),
//       ) ,
//  ),
//       ),
